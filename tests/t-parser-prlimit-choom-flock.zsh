#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: prlimit, choom, cpulimit, flock — resource limits and file locks.
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
# prlimit
#==============================================================

@test 'pcf: prlimit --as=unlimited --core=0 --cpu=soft:hard git' {
    _assert_tail_git 'prlimit --as=unlimited --core=0 --cpu=soft:hard git'
}

@test 'pcf: prlimit -p self --rss=1048576 git' {
    _assert_tail_git 'prlimit -p self --rss=1048576 git'
}

@test 'pcf: prlimit --nofile=4096:8192 --nproc=unlimited git' {
    _assert_tail_git 'prlimit --nofile=4096:8192 --nproc=unlimited git'
}

@test 'pcf: sudo prlimit --nofile=2048 git' {
    _assert_tail_git 'sudo prlimit --nofile=2048 git'
}

@test 'pcf: env -i prlimit --stack=8388608 git' {
    _assert_tail_git 'env -i prlimit --stack=8388608 git'
}

#==============================================================
# choom
#==============================================================

@test 'pcf: choom -p 1 -n -500 git' {
    _assert_tail_git 'choom -p 1 -n -500 git'
}

@test 'pcf: choom -n 1000 -- git' {
    _assert_tail_git 'choom -n 1000 -- git'
}

@test 'pcf: choom -n -100 -- git' {
    _assert_tail_git 'choom -n -100 -- git'
}

#==============================================================
# cpulimit
#==============================================================

@test 'pcf: cpulimit -l 25 -p 1234 -e firefox -z git' {
    _assert_tail_git 'cpulimit -l 25 -p 1234 -e firefox -z git'
}

@test 'pcf: cpulimit -vi -l 50 -e git git' {
    _assert_tail_git 'cpulimit -vi -l 50 -e git git'
}

@test 'pcf: cpulimit -l 10 git' {
    _assert_tail_git 'cpulimit -l 10 git'
}

#==============================================================
# flock
#==============================================================

@test 'pcf: flock -s /tmp/shared.lck git' {
    _assert_tail_git 'flock -s /tmp/shared.lck git'
}

@test 'pcf: flock -x -w 2 /tmp/exclusive.lck git' {
    _assert_tail_git 'flock -x -w 2 /tmp/exclusive.lck git'
}

@test 'pcf: flock -n -o /tmp/n git' {
    _assert_tail_git 'flock -n -o /tmp/n git'
}

@test 'pcf: flock -u /tmp/u git' {
    _assert_tail_git 'flock -u /tmp/u git'
}

#==============================================================
# Cross stacks
#==============================================================

@test 'pcf: nice -n 10 choom -n 100 cpulimit -l 10 git' {
    _assert_tail_git 'nice -n 10 choom -n 100 cpulimit -l 10 git'
}

@test 'pcf: timeout 30 prlimit --nofile=1024 git' {
    _assert_tail_git 'timeout 30 prlimit --nofile=1024 git'
}

@test 'pcf: sudo -u nobody choom -n 0 git' {
    _assert_tail_git 'sudo -u nobody choom -n 0 git'
}

@test 'pcf: flock -s /tmp/a prlimit --cpu=60 git' {
    _assert_tail_git 'flock -s /tmp/a prlimit --cpu=60 git'
}

@test 'pcf: cpulimit -l 20 flock -x /tmp/b git' {
    _assert_tail_git 'cpulimit -l 20 flock -x /tmp/b git'
}

@test 'pcf: env FOO=bar prlimit --data=hard git' {
    _assert_tail_git 'env FOO=bar prlimit --data=hard git'
}

@test 'pcf: nocorrect choom -n -50 git' {
    _assert_tail_git 'nocorrect choom -n -50 git'
}

@test 'pcf: command -p cpulimit -l 5 git' {
    _assert_tail_git 'command -p cpulimit -l 5 git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'pcf: prlimit --nofile=1024 git show -s' {
    _assert_tail_str 'prlimit --nofile=1024 git show -s' 'git show -s'
}

@test 'pcf: flock /tmp/l git diff --cached' {
    _assert_tail_str 'flock /tmp/l git diff --cached' 'git diff --cached'
}

@test 'pcf: idempotent prlimit --memlock=65536 git' {
    zpwrExpandParseWords 'prlimit --memlock=65536 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'prlimit --memlock=65536 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'pcf: idempotent choom cpulimit git' {
    zpwrExpandParseWords 'choom -n 0 cpulimit -l 25 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'choom -n 0 cpulimit -l 25 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
