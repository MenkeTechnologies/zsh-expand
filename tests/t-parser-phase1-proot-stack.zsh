#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Phase-1 keyword chains with proot, faketime, trickle, linux32, setarch.
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
# Phase-1 keyword stacks
#==============================================================

@test 'p1p: nocorrect time -p command -p builtin eval noglob coproc git' {
    _assert_tail_git 'nocorrect time -p command -p builtin eval noglob coproc git'
}

@test 'p1p: command -p env -i nice -n 10 git' {
    _assert_tail_git 'command -p env -i nice -n 10 git'
}

@test 'p1p: exec -a mygit git' {
    _assert_tail_git 'exec -a mygit git'
}

@test 'p1p: exec -c -a argv0 git' {
    _assert_tail_git 'exec -c -a argv0 git'
}

@test 'p1p: time -v nocorrect git' {
    _assert_tail_git 'time -v nocorrect git'
}

@test 'p1p: builtin command -p sudo -u root git' {
    _assert_tail_git 'builtin command -p sudo -u root git'
}

@test 'p1p: noglob coproc git' {
    _assert_tail_git 'noglob coproc git'
}

@test 'p1p: eval noglob builtin git' {
    _assert_tail_git 'eval noglob builtin git'
}

@test 'p1p: coproc time -p git' {
    _assert_tail_git 'coproc time -p git'
}

@test 'p1p: nocorrect builtin eval git' {
    _assert_tail_git 'nocorrect builtin eval git'
}

@test 'p1p: command -p command -p git' {
    _assert_tail_git 'command -p command -p git'
}

@test 'p1p: time -p builtin eval noglob git' {
    _assert_tail_git 'time -p builtin eval noglob git'
}

@test 'p1p: nocorrect command -p git' {
    _assert_tail_git 'nocorrect command -p git'
}

#==============================================================
# proot / faketime / trickle
#==============================================================

@test 'p1p: faketime 2024-01-01 12:00:00 proot -0 git' {
    _assert_tail_git "faketime '2024-01-01 12:00:00' proot -0 git"
}

@test 'p1p: proot -b /bin:/bin -r /jail git' {
    _assert_tail_git 'proot -b /bin:/bin -r /jail git'
}

@test 'p1p: proot -q qemu-x86_64 git' {
    _assert_tail_git 'proot -q qemu-x86_64 git'
}

@test 'p1p: proot -w /work -R /rootfs git' {
    _assert_tail_git 'proot -w /work -R /rootfs git'
}

@test 'p1p: trickle -d 10 -u 10 faketime now git' {
    _assert_tail_git "trickle -d 10 -u 10 faketime 'now' git"
}

@test 'p1p: faketime -m 0 git' {
    _assert_tail_git 'faketime -m 0 git'
}

@test 'p1p: nice -n -5 faketime 2020-01-01 git' {
    _assert_tail_git "nice -n -5 faketime '2020-01-01' git"
}

#==============================================================
# linux32 / setarch
#==============================================================

@test 'p1p: linux32 -R setarch i386 -R git' {
    _assert_tail_git 'linux32 -R setarch i386 -R git'
}

@test 'p1p: setarch linux32 -v -R git' {
    _assert_tail_git 'setarch linux32 -v -R git'
}

@test 'p1p: linux32 -v git' {
    _assert_tail_git 'linux32 -v git'
}

#==============================================================
# Cross stacks
#==============================================================

@test 'p1p: sudo proot -0 git' {
    _assert_tail_git 'sudo proot -0 git'
}

@test 'p1p: env -i linux32 -R git' {
    _assert_tail_git 'env -i linux32 -R git'
}

@test 'p1p: time -p proot -r /j git' {
    _assert_tail_git 'time -p proot -r /j git'
}

@test 'p1p: command -p faketime -f /etc/faketimerc git' {
    _assert_tail_git 'command -p faketime -f /etc/faketimerc git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'p1p: time -p git log -1 --oneline' {
    _assert_tail_str 'time -p git log -1 --oneline' 'git log -1 --oneline'
}

@test 'p1p: proot -0 git status -s' {
    _assert_tail_str 'proot -0 git status -s' 'git status -s'
}

@test 'p1p: idempotent command -p env -i git' {
    zpwrExpandParseWords 'command -p env -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'command -p env -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'p1p: idempotent nocorrect time -p git' {
    zpwrExpandParseWords 'nocorrect time -p git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'nocorrect time -p git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
