#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: chpst, cgexec, trickle — deep flags and cgroup-adjacent stacks.
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
# chpst — runit process supervision helpers
#==============================================================

@test 'cct: chpst -v -u www -U www -e /env -/ /root -n 1 git' {
    _assert_tail_git 'chpst -v -u www -U www -e /env -/ /root -n 1 git'
}

@test 'cct: chpst -l /var/lock -L /var/lock2 -m 200000 -d 100000 git' {
    _assert_tail_git 'chpst -l /var/lock -L /var/lock2 -m 200000 -d 100000 git'
}

@test 'cct: chpst -o 3 -p 2 -f 4000 -c 5000 -t 10 git' {
    _assert_tail_git 'chpst -o 3 -p 2 -f 4000 -c 5000 -t 10 git'
}

@test 'cct: chpst -V -P -0 -1 -2 git' {
    _assert_tail_git 'chpst -V -P -0 -1 -2 git'
}

@test 'cct: chpst -- git' {
    _assert_tail_git 'chpst -- git'
}

@test 'cct: chpst -u deploy -b argv0 git' {
    _assert_tail_git 'chpst -u deploy -b argv0 git'
}

#==============================================================
# cgexec — libcgroup
#==============================================================

@test 'cct: cgexec -g cpu:grp git' {
    _assert_tail_git 'cgexec -g cpu:grp git'
}

@test 'cct: cgexec --sticky -h git' {
    _assert_tail_git 'cgexec --sticky -h git'
}

@test 'cct: cgexec -g memory:limit --sticky git' {
    _assert_tail_git 'cgexec -g memory:limit --sticky git'
}

@test 'cct: sudo cgexec -g cpu:0 git' {
    _assert_tail_git 'sudo cgexec -g cpu:0 git'
}

#==============================================================
# trickle — bandwidth shaper
#==============================================================

@test 'cct: trickle -v -s -d 20 -u 30 git' {
    _assert_tail_git 'trickle -v -s -d 20 -u 30 git'
}

@test 'cct: trickle -w 512 -t 2 -l /var/run -n /net -P /pc git' {
    _assert_tail_git 'trickle -w 512 -t 2 -l /var/run -n /net -P /pc git'
}

@test 'cct: trickle -- git' {
    _assert_tail_git 'trickle -- git'
}

@test 'cct: trickle -h git' {
    _assert_tail_git 'trickle -h git'
}

@test 'cct: trickle -V git' {
    _assert_tail_git 'trickle -V git'
}

#==============================================================
# Cross stacks
#==============================================================

@test 'cct: sudo chpst -u nobody cgexec -g cpu:0 git' {
    _assert_tail_git 'sudo chpst -u nobody cgexec -g cpu:0 git'
}

@test 'cct: nice -n 1 chpst -u x trickle -d 1 git' {
    _assert_tail_git 'nice -n 1 chpst -u x trickle -d 1 git'
}

@test 'cct: timeout 5 chpst -e /e git' {
    _assert_tail_git 'timeout 5 chpst -e /e git'
}

@test 'cct: env -i PATH=/bin chpst -u www git' {
    _assert_tail_git 'env -i PATH=/bin chpst -u www git'
}

@test 'cct: trickle -d 5 sudo -u nobody git' {
    _assert_tail_git 'trickle -d 5 sudo -u nobody git'
}

@test 'cct: cgexec -g cpu:a chpst -u u git' {
    _assert_tail_git 'cgexec -g cpu:a chpst -u u git'
}

@test 'cct: chpst -u www nice -n 10 git' {
    _assert_tail_git 'chpst -u www nice -n 10 git'
}

@test 'cct: nocorrect chpst -u www git' {
    _assert_tail_git 'nocorrect chpst -u www git'
}

@test 'cct: command -p trickle -d 1 git' {
    _assert_tail_git 'command -p trickle -d 1 git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'cct: chpst -u www git log -n 3' {
    _assert_tail_str 'chpst -u www git log -n 3' 'git log -n 3'
}

@test 'cct: trickle -d 10 git diff --stat' {
    _assert_tail_str 'trickle -d 10 git diff --stat' 'git diff --stat'
}

@test 'cct: idempotent cgexec -g cpu:grp git' {
    zpwrExpandParseWords 'cgexec -g cpu:grp git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'cgexec -g cpu:grp git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'cct: idempotent chpst -u u trickle git' {
    zpwrExpandParseWords 'chpst -u u trickle -d 1 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'chpst -u u trickle -d 1 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
