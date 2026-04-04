#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: watch, ionice, chrt, taskset, caffeinate, setsid prefix parsing.
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
# watch
#==============================================================

@test 'sched: watch git' {
    _assert_tail_git 'watch git'
}

@test 'sched: watch -n 1 git' {
    _assert_tail_git 'watch -n 1 git'
}

@test 'sched: watch -bdCcefgprtwx git' {
    _assert_tail_git 'watch -bdCcefgprtwx git'
}

@test 'sched: watch -n 2 -q 5 -s /dir git' {
    _assert_tail_git 'watch -n 2 -q 5 -s /dir git'
}

@test 'sched: watch -t git' {
    _assert_tail_git 'watch -t git'
}

@test 'sched: watch -- git' {
    _assert_tail_git 'watch -- git'
}

@test 'sched: sudo watch -n 1 git' {
    _assert_tail_git 'sudo watch -n 1 git'
}

@test 'sched: env -i watch -d git' {
    _assert_tail_git 'env -i watch -d git'
}

#==============================================================
# ionice
#==============================================================

@test 'sched: ionice git' {
    _assert_tail_git 'ionice git'
}

@test 'sched: ionice -t git' {
    _assert_tail_git 'ionice -t git'
}

@test 'sched: ionice -c 2 -n 7 git' {
    _assert_tail_git 'ionice -c 2 -n 7 git'
}

@test 'sched: ionice -c 1 -n 0 git' {
    _assert_tail_git 'ionice -c 1 -n 0 git'
}

@test 'sched: sudo ionice -c 2 git' {
    _assert_tail_git 'sudo ionice -c 2 git'
}

#==============================================================
# chrt
#==============================================================

@test 'sched: chrt -f 10 git' {
    _assert_tail_git 'chrt -f 10 git'
}

@test 'sched: chrt -adepRv 10 git' {
    _assert_tail_git 'chrt -adepRv 10 git'
}

@test 'sched: chrt -d -D 1000 -P 2000 -T 500 10 git' {
    _assert_tail_git 'chrt -d -D 1000 -P 2000 -T 500 10 git'
}

@test 'sched: chrt -r 20 git' {
    _assert_tail_git 'chrt -r 20 git'
}

@test 'sched: nice -n 5 chrt -f 1 git' {
    _assert_tail_git 'nice -n 5 chrt -f 1 git'
}

#==============================================================
# taskset
#==============================================================

@test 'sched: taskset -c 0-3 git' {
    _assert_tail_git 'taskset -c 0-3 git'
}

@test 'sched: taskset -c 0,1 git' {
    _assert_tail_git 'taskset -c 0,1 git'
}

@test 'sched: taskset 0xff git' {
    _assert_tail_git 'taskset 0xff git'
}

@test 'sched: sudo taskset -c 0 git' {
    _assert_tail_git 'sudo taskset -c 0 git'
}

#==============================================================
# caffeinate
#==============================================================

@test 'sched: caffeinate git' {
    _assert_tail_git 'caffeinate git'
}

@test 'sched: caffeinate -dimsu git' {
    _assert_tail_git 'caffeinate -dimsu git'
}

@test 'sched: caffeinate -t 60 -w 1234 git' {
    _assert_tail_git 'caffeinate -t 60 -w 1234 git'
}

@test 'sched: nohup caffeinate -i git' {
    _assert_tail_git 'nohup caffeinate -i git'
}

#==============================================================
# setsid
#==============================================================

@test 'sched: setsid git' {
    _assert_tail_git 'setsid git'
}

@test 'sched: setsid -cfw git' {
    _assert_tail_git 'setsid -cfw git'
}

@test 'sched: setsid -f git' {
    _assert_tail_git 'setsid -f git'
}

@test 'sched: sudo setsid -f git' {
    _assert_tail_git 'sudo setsid -f git'
}

#==============================================================
# Cross-stack chains
#==============================================================

@test 'sched: nice -n 10 ionice -c 1 chrt -f 5 taskset -c 0 git' {
    _assert_tail_git 'nice -n 10 ionice -c 1 chrt -f 5 taskset -c 0 git'
}

@test 'sched: timeout 30 watch -n 1 git' {
    _assert_tail_git 'timeout 30 watch -n 1 git'
}

@test 'sched: ionice -c 2 caffeinate -i git' {
    _assert_tail_git 'ionice -c 2 caffeinate -i git'
}

@test 'sched: setsid -f ionice -n 7 git' {
    _assert_tail_git 'setsid -f ionice -n 7 git'
}

@test 'sched: sudo nice -n 0 chrt -f 99 taskset -c 0-3 git' {
    _assert_tail_git 'sudo nice -n 0 chrt -f 99 taskset -c 0-3 git'
}

@test 'sched: nocorrect ionice -c 2 git' {
    _assert_tail_git 'nocorrect ionice -c 2 git'
}

@test 'sched: time -v chrt -f 5 git' {
    _assert_tail_git 'time -v chrt -f 5 git'
}

#==============================================================
# Multi-word tail
#==============================================================

@test 'sched: watch -n 1 git log' {
    _assert_tail_str 'watch -n 1 git log' 'git log'
}

@test 'sched: ionice -c 2 git diff' {
    _assert_tail_str 'ionice -c 2 git diff' 'git diff'
}

#==============================================================
# Idempotency
#==============================================================

@test 'sched: idempotent watch -n 5 git' {
    zpwrExpandParseWords 'watch -n 5 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'watch -n 5 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'sched: idempotent ionice -c 2 git' {
    zpwrExpandParseWords 'ionice -c 2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'ionice -c 2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'sched: watch -C git' {
    _assert_tail_git 'watch -C git'
}

@test 'sched: watch -g git' {
    _assert_tail_git 'watch -g git'
}

@test 'sched: ionice -n 0 git' {
    _assert_tail_git 'ionice -n 0 git'
}

@test 'sched: chrt -f 42 git' {
    _assert_tail_git 'chrt -f 42 git'
}

@test 'sched: taskset -pc 0xffffffff git' {
    _assert_tail_git 'taskset -pc 0xffffffff git'
}

@test 'sched: caffeinate -m git' {
    _assert_tail_git 'caffeinate -m git'
}

@test 'sched: rlwrap -a watch -n 1 git' {
    _assert_tail_git 'rlwrap -a watch -n 1 git'
}

@test 'sched: strace -f ionice -c 2 git' {
    _assert_tail_git 'strace -f ionice -c 2 git'
}

@test 'sched: timeout 5 chrt -f 1 git' {
    _assert_tail_git 'timeout 5 chrt -f 1 git'
}
