#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: cpulimit, chronic, daemonize, proxychains4, sem, tsocks, catchsegv, unbuffer, distcc.
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
# cpulimit
#==============================================================

@test 'cds: cpulimit -l 50 -p 1234 git' {
    _assert_tail_git 'cpulimit -l 50 -p 1234 git'
}

@test 'cds: cpulimit -viz -e firefox -l 25 git' {
    _assert_tail_git 'cpulimit -viz -e firefox -l 25 git'
}

@test 'cds: nocorrect cpulimit -l 1 git' {
    _assert_tail_git 'nocorrect cpulimit -l 1 git'
}

@test 'cds: eatmydata -- cpulimit -l 5 git' {
    _assert_tail_git 'eatmydata -- cpulimit -l 5 git'
}

@test 'cds: sudo cpulimit -l 10 chronic -v git' {
    _assert_tail_git 'sudo cpulimit -l 10 chronic -v git'
}

@test 'cds: runuser -u u cpulimit -l 2 git' {
    _assert_tail_git 'runuser -u u cpulimit -l 2 git'
}

@test 'cds: bwrap --dev-bind / / cpulimit -l 1 git' {
    _assert_tail_git 'bwrap --dev-bind / / cpulimit -l 1 git'
}

#==============================================================
# chronic
#==============================================================

@test 'cds: chronic -e git' {
    _assert_tail_git 'chronic -e git'
}

@test 'cds: chronic -v git' {
    _assert_tail_git 'chronic -v git'
}

@test 'cds: stdbuf -oL chronic -v git' {
    _assert_tail_git 'stdbuf -oL chronic -v git'
}

@test 'cds: fakeroot chronic -v git' {
    _assert_tail_git 'fakeroot chronic -v git'
}

#==============================================================
# daemonize
#==============================================================

@test 'cds: daemonize -c /tmp -o /l/log -e /e/err -l /l/pid git' {
    _assert_tail_git 'daemonize -c /tmp -o /l/log -e /e/err -l /l/pid git'
}

@test 'cds: daemonize -a -u nobody git' {
    _assert_tail_git 'daemonize -a -u nobody git'
}

@test 'cds: daemonize -- git' {
    _assert_tail_git 'daemonize -- git'
}

@test 'cds: env daemonize -c /var git' {
    _assert_tail_git 'env daemonize -c /var git'
}

@test 'cds: doas daemonize -c /r git' {
    _assert_tail_git 'doas daemonize -c /r git'
}

#==============================================================
# proxychains4 / tsocks / torify
#==============================================================

@test 'cds: proxychains4 -q -f /etc/pc.conf git' {
    _assert_tail_git 'proxychains4 -q -f /etc/pc.conf git'
}

@test 'cds: proxychains4 -f /etc/pc.conf git' {
    _assert_tail_git 'proxychains4 -f /etc/pc.conf git'
}

@test 'cds: nice -n 0 proxychains4 git' {
    _assert_tail_git 'nice -n 0 proxychains4 git'
}

@test 'cds: torify proxychains4 git' {
    _assert_tail_git 'torify proxychains4 git'
}

@test 'cds: tsocks git' {
    _assert_tail_git 'tsocks git'
}

@test 'cds: tsocks proxychains4 git' {
    _assert_tail_git 'tsocks proxychains4 git'
}

#==============================================================
# sem
#==============================================================

@test 'cds: sem -j 4 git' {
    _assert_tail_git 'sem -j 4 git'
}

@test 'cds: sem --sticky git' {
    _assert_tail_git 'sem --sticky git'
}

@test 'cds: sem -j 2 -P prefix git' {
    _assert_tail_git 'sem -j 2 -P prefix git'
}

@test 'cds: sem --fg -- git' {
    _assert_tail_git 'sem --fg -- git'
}

@test 'cds: flock /x sem -j 2 git' {
    _assert_tail_git 'flock /x sem -j 2 git'
}

@test 'cds: chroot /j sem -j 1 git' {
    _assert_tail_git 'chroot /j sem -j 1 git'
}

@test 'cds: setpriv --nnp sem -j 1 git' {
    _assert_tail_git 'setpriv --nnp sem -j 1 git'
}

@test 'cds: timeout 5 sem -j 1 cpulimit -l 5 git' {
    _assert_tail_git 'timeout 5 sem -j 1 cpulimit -l 5 git'
}

#==============================================================
# unbuffer / distcc / catchsegv
#==============================================================

@test 'cds: unbuffer -p git' {
    _assert_tail_git 'unbuffer -p git'
}

@test 'cds: unbuffer git' {
    _assert_tail_git 'unbuffer git'
}

@test 'cds: distcc git' {
    _assert_tail_git 'distcc git'
}

@test 'cds: distcc -j 8 git (parser keeps job count in tail)' {
    _assert_tail_str 'distcc -j 8 git' '8 git'
}

@test 'cds: catchsegv git' {
    _assert_tail_git 'catchsegv git'
}

@test 'cds: pkexec --user u cpulimit -l 2 git' {
    _assert_tail_git 'pkexec --user u cpulimit -l 2 git'
}

#==============================================================
# Multi-word tails, idempotency
#==============================================================

@test 'cds: cpulimit -l 50 git log --oneline' {
    _assert_tail_str 'cpulimit -l 50 git log --oneline' 'git log --oneline'
}

@test 'cds: chronic git status -sb' {
    _assert_tail_str 'chronic git status -sb' 'git status -sb'
}

@test 'cds: idempotent cpulimit -l 10 git' {
    zpwrExpandParseWords 'cpulimit -l 10 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'cpulimit -l 10 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'cds: idempotent sem -j 2 git' {
    zpwrExpandParseWords 'sem -j 2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sem -j 2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
