#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: rlwrap, ionice, chrt, taskset, watch — extra flags and deep stacks.
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    ZPWR_EXPAND_QUOTE_DOUBLE=false
    ZPWR_EXPAND_QUOTE_SINGLE=false
    ZPWR_EXPAND_SECOND_POSITION=false
    ZPWR_EXPAND_NATIVE=false
    ZPWR_EXPAND_PRE_EXEC_NATIVE=false
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=false
    ZPWR_EXPAND_TO_HISTORY=false
    ZPWR_CORRECT=false
    ZPWR_CORRECT_EXPAND=false
    ZPWR_EXPAND_SUFFIX=false
    ZPWR_TRACE=false

    function _assert_tail_git() {
        zpwrExpandParseWords "$1"
        zpwrExpandRegexMatchOnCommandPosition
        assert $state equals 0
        assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    }

    function _assert_tail_str() {
        zpwrExpandParseWords "$1"
        zpwrExpandRegexMatchOnCommandPosition
        assert $state equals 0
        assert "$ZPWR_EXPAND_PRE_EXPAND" same_as "$2"
    }
}

#==============================================================
# rlwrap
#==============================================================

@test 'riw: rlwrap -a -N -f /c git' {
    _assert_tail_git 'rlwrap -a -N -f /c git'
}

@test 'riw: rlwrap -z filter git' {
    _assert_tail_git 'rlwrap -z filter git'
}

@test 'riw: rlwrap -H /h git' {
    _assert_tail_git 'rlwrap -H /h git'
}

@test 'riw: sudo rlwrap git' {
    _assert_tail_git 'sudo rlwrap git'
}

@test 'riw: flock /x rlwrap git' {
    _assert_tail_git 'flock /x rlwrap git'
}

@test 'riw: stdbuf -i0 rlwrap git' {
    _assert_tail_git 'stdbuf -i0 rlwrap git'
}

@test 'riw: prlimit --rss=unlimited rlwrap git' {
    _assert_tail_git 'prlimit --rss=unlimited rlwrap git'
}

@test 'riw: runuser -u u rlwrap git' {
    _assert_tail_git 'runuser -u u rlwrap git'
}

@test 'riw: setpriv --nnp rlwrap git' {
    _assert_tail_git 'setpriv --nnp rlwrap git'
}

@test 'riw: nocorrect rlwrap git' {
    _assert_tail_git 'nocorrect rlwrap git'
}

#==============================================================
# ionice
#==============================================================

@test 'riw: ionice -c2 -n0 git' {
    _assert_tail_git 'ionice -c2 -n0 git'
}

@test 'riw: ionice -t git' {
    _assert_tail_git 'ionice -t git'
}

@test 'riw: env ionice -c1 git' {
    _assert_tail_git 'env ionice -c1 git'
}

@test 'riw: nice -n 5 ionice -c3 git' {
    _assert_tail_git 'nice -n 5 ionice -c3 git'
}

@test 'riw: setsid ionice -c2 git' {
    _assert_tail_git 'setsid ionice -c2 git'
}

@test 'riw: numactl -m 0 ionice -c1 git' {
    _assert_tail_git 'numactl -m 0 ionice -c1 git'
}

@test 'riw: unshare -U ionice -c2 git' {
    _assert_tail_git 'unshare -U ionice -c2 git'
}

@test 'riw: eatmydata ionice -c2 git' {
    _assert_tail_git 'eatmydata ionice -c2 git'
}

@test 'riw: cpulimit -l 5 ionice git' {
    _assert_tail_git 'cpulimit -l 5 ionice git'
}

#==============================================================
# chrt / taskset
#==============================================================

@test 'riw: chrt -b 0 git' {
    _assert_tail_git 'chrt -b 0 git'
}

@test 'riw: chrt -r 50 git' {
    _assert_tail_git 'chrt -r 50 git'
}

@test 'riw: pkexec --user u chrt -f 1 git' {
    _assert_tail_git 'pkexec --user u chrt -f 1 git'
}

@test 'riw: fakeroot chrt -r 10 git' {
    _assert_tail_git 'fakeroot chrt -r 10 git'
}

@test 'riw: taskset -pc 0-3 git' {
    _assert_tail_git 'taskset -pc 0-3 git'
}

@test 'riw: taskset -a -c 0,1 git' {
    _assert_tail_git 'taskset -a -c 0,1 git'
}

@test 'riw: sem -j 1 taskset -c 0 git' {
    _assert_tail_git 'sem -j 1 taskset -c 0 git'
}

#==============================================================
# watch
#==============================================================

@test 'riw: watch -d -n 0.5 git' {
    _assert_tail_git 'watch -d -n 0.5 git'
}

@test 'riw: watch -x git' {
    _assert_tail_git 'watch -x git'
}

@test 'riw: timeout 1 watch -n1 git' {
    _assert_tail_git 'timeout 1 watch -n1 git'
}

@test 'riw: doas watch -n2 git' {
    _assert_tail_git 'doas watch -n2 git'
}

@test 'riw: torify watch -n1 git' {
    _assert_tail_git 'torify watch -n1 git'
}

@test 'riw: bwrap --dev-bind / / watch git' {
    _assert_tail_git 'bwrap --dev-bind / / watch git'
}

@test 'riw: chroot /j watch git' {
    _assert_tail_git 'chroot /j watch git'
}

@test 'riw: nsenter -t 1 -n watch git' {
    _assert_tail_git 'nsenter -t 1 -n watch git'
}

#==============================================================
# Multi-word tails, idempotency
#==============================================================

@test 'riw: rlwrap git log -1' {
    _assert_tail_str 'rlwrap git log -1' 'git log -1'
}

@test 'riw: watch -g -c "git status" git' {
    _assert_tail_str 'watch -g -c "git status" git' '"git status" git'
}

@test 'riw: watch git diff --stat' {
    _assert_tail_str 'watch git diff --stat' 'git diff --stat'
}

@test 'riw: idempotent rlwrap git' {
    zpwrExpandParseWords 'rlwrap git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'rlwrap git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'riw: idempotent ionice -c2 git' {
    zpwrExpandParseWords 'ionice -c2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'ionice -c2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'riw: idempotent watch -n1 git' {
    zpwrExpandParseWords 'watch -n1 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'watch -n1 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
