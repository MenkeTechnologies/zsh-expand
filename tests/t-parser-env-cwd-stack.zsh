#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: env -C (working-directory) stacks — command position tails.
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

    function _assert_tail_str() {
        zpwrExpandParseWords "$1"
        zpwrExpandRegexMatchOnCommandPosition
        assert $state equals 0
        assert "$ZPWR_EXPAND_PRE_EXPAND" same_as "$2"
    }

    function _assert_tail_git() {
        _assert_tail_str "$1" 'git'
    }
}

#==============================================================
# env -C … git → tail git
#==============================================================

@test 'ecw: env -C /repo git' {
    _assert_tail_git 'env -C /repo git'
}

@test 'ecw: sudo -E env -C /tmp git' {
    _assert_tail_git 'sudo -E env -C /tmp git'
}

@test 'ecw: doas env -C /x git' {
    _assert_tail_git 'doas env -C /x git'
}

@test 'ecw: nice -n 0 env -C /r git' {
    _assert_tail_git 'nice -n 0 env -C /r git'
}

@test 'ecw: torify env -C /t git' {
    _assert_tail_git 'torify env -C /t git'
}

@test 'ecw: bwrap --bind / / env -C /repo git' {
    _assert_tail_git 'bwrap --bind / / env -C /repo git'
}

@test 'ecw: systemd-run -p WorkingDirectory=/w env -C /c git' {
    _assert_tail_git 'systemd-run -p WorkingDirectory=/w env -C /c git'
}

@test 'ecw: flock /l env -C /d git' {
    _assert_tail_git 'flock /l env -C /d git'
}

@test 'ecw: stdbuf -i0 env -C /s git' {
    _assert_tail_git 'stdbuf -i0 env -C /s git'
}

@test 'ecw: timeout 5 env -C /q git' {
    _assert_tail_git 'timeout 5 env -C /q git'
}

@test 'ecw: ionice -c2 env -C /a git' {
    _assert_tail_git 'ionice -c2 env -C /a git'
}

@test 'ecw: chrt -f 1 env -C /b git' {
    _assert_tail_git 'chrt -f 1 env -C /b git'
}

@test 'ecw: taskset -c 0 env -C /c git' {
    _assert_tail_git 'taskset -c 0 env -C /c git'
}

@test 'ecw: setsid env -C /d git' {
    _assert_tail_git 'setsid env -C /d git'
}

@test 'ecw: nocorrect env -C /e git' {
    _assert_tail_git 'nocorrect env -C /e git'
}

@test 'ecw: command env -C /f git' {
    _assert_tail_git 'command env -C /f git'
}

@test 'ecw: env -i env -C /g git' {
    _assert_tail_git 'env -i env -C /g git'
}

@test 'ecw: sudo -u nobody env -C /h git' {
    _assert_tail_git 'sudo -u nobody env -C /h git'
}

@test 'ecw: runuser -u u env -C /i git' {
    _assert_tail_git 'runuser -u u env -C /i git'
}

@test 'ecw: sg group env -C /j git' {
    _assert_tail_git 'sg group env -C /j git'
}

@test 'ecw: prlimit --rss=unlimited env -C /k git' {
    _assert_tail_git 'prlimit --rss=unlimited env -C /k git'
}

@test 'ecw: unshare -U env -C /l git' {
    _assert_tail_git 'unshare -U env -C /l git'
}

@test 'ecw: eatmydata env -C /m git' {
    _assert_tail_git 'eatmydata env -C /m git'
}

@test 'ecw: fakeroot env -C /n git' {
    _assert_tail_git 'fakeroot env -C /n git'
}

@test 'ecw: strace -f env -C /o git' {
    _assert_tail_git 'strace -f env -C /o git'
}

@test 'ecw: ltrace -n 2 env -C /p git' {
    _assert_tail_git 'ltrace -n 2 env -C /p git'
}

@test 'ecw: rlwrap env -C /q git' {
    _assert_tail_git 'rlwrap env -C /q git'
}

@test 'ecw: chronic env -C /r git' {
    _assert_tail_git 'chronic env -C /r git'
}

@test 'ecw: cpulimit -l 10 env -C /s git' {
    _assert_tail_git 'cpulimit -l 10 env -C /s git'
}

#==============================================================
# Multi-word tails after env -C
#==============================================================

@test 'ecw: env -C /repo git status' {
    _assert_tail_str 'env -C /repo git status' 'git status'
}

@test 'ecw: sudo env -C /x git diff' {
    _assert_tail_str 'sudo env -C /x git diff' 'git diff'
}

@test 'ecw: env -C /y git -c advice.statusHints=false status' {
    _assert_tail_str 'env -C /y git -c advice.statusHints=false status' 'git -c advice.statusHints=false status'
}

#==============================================================
# Containers / remotes — full tail preserved
#==============================================================

@test 'ecw: docker exec -it c1 env -C /app git' {
    _assert_tail_str 'docker exec -it c1 env -C /app git' 'docker exec -it c1 env -C /app git'
}

@test 'ecw: kubectl exec pod -n ns -- env -C /w git' {
    _assert_tail_str 'kubectl exec pod -n ns -- env -C /w git' 'kubectl exec pod -n ns -- env -C /w git'
}

@test 'ecw: lxc exec c1 -- env -C /z git' {
    _assert_tail_str 'lxc exec c1 -- env -C /z git' 'lxc exec c1 -- env -C /z git'
}

@test 'ecw: incus exec c1 -- env -C /z git status' {
    _assert_tail_str 'incus exec c1 -- env -C /z git status' 'incus exec c1 -- env -C /z git status'
}

#==============================================================
# git -C stays in tail (different from env -C)
#==============================================================

@test 'ecw: git -C /repo status' {
    _assert_tail_str 'git -C /repo status' 'git -C /repo status'
}

#==============================================================
# Idempotency
#==============================================================

@test 'ecw: idempotent env -C /repo git' {
    zpwrExpandParseWords 'env -C /repo git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'env -C /repo git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'ecw: idempotent sudo env -C /tmp git status' {
    zpwrExpandParseWords 'sudo env -C /tmp git status'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
    zpwrExpandParseWords 'sudo env -C /tmp git status'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}
