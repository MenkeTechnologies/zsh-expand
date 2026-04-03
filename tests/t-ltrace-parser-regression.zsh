#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Regression and matrix tests for ltrace prefix parsing (CI: linux + mac).
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
}

#==============================================================
# Historical CI failure: -n must consume its numeric argument before -w.
#==============================================================

@test 'ltrace: -n consumes indent so tail is git (regression)' {
    _assert_tail_git 'ltrace -L -l libfoo -A 10 -n 2 -w 3 git'
}

@test 'ltrace: -n 0 -w 99' {
    _assert_tail_git 'ltrace -n 0 -w 99 git'
}

@test 'ltrace: combo then -n then -w' {
    _assert_tail_git 'ltrace -bcC -n 1 -w 80 git'
}

@test 'ltrace: -l then -n' {
    _assert_tail_git 'ltrace -l libc.so.6 -n 4 git'
}

@test 'ltrace: -- stops prefix' {
    zpwrExpandParseWords 'ltrace -f -- git status'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}

@test 'ltrace: -D -e -F matrix' {
    local line
    for line in \
        'ltrace -D 0xff -e malloc git' \
        'ltrace -F /etc/ltrace.conf -e open git' \
        'ltrace -s 128 -u nobody -o /tmp/o git' \
        'ltrace -p 1 -w 4 -n 2 git' \
        'ltrace -T -t -r git' \
        'ltrace -V -h git' \
        'ltrace -i -S git' \
        'ltrace -x dlopen -x malloc git' \
        'ltrace -C -c git' \
        'ltrace -a 40 -A 5 git'
    do
        _assert_tail_git "$line"
    done
}

@test 'ltrace: long chains still resolve git' {
    local line
    for line in \
        'ltrace -L -l libfoo -A 10 -n 2 -w 3 -s 256 -u root git' \
        'ltrace -bcCfhiLrStTV -D 0xff git' \
        'ltrace -n 1 -n 2 -w 3 git'
    do
        _assert_tail_git "$line"
    done
}

@test 'ltrace: sudo-wrapped' {
    _assert_tail_git 'sudo ltrace -n 2 -w 4 git'
}

@test 'ltrace: env-wrapped' {
    _assert_tail_git 'env -i PATH=/usr/bin ltrace -n 1 git'
}

@test 'ltrace: nice nohup chain' {
    _assert_tail_git 'nice -n 5 nohup ltrace -n 3 git'
}

@test 'strace: still parses after ltrace-style numeric flags (neighbor)' {
    _assert_tail_git 'strace -e trace=network -s 256 git'
}

@test 'ltrace: -o file consumes path' {
    _assert_tail_git 'ltrace -o /tmp/ltrace.log git'
}

@test 'ltrace: -p pid' {
    _assert_tail_git 'ltrace -p 1234 git'
}

@test 'ltrace: -b sym' {
    _assert_tail_git 'ltrace -b malloc git'
}

@test 'ltrace: multiple -e filters' {
    zpwrExpandParseWords 'ltrace -e malloc -e free git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
