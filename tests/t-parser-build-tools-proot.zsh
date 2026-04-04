#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: ccache, distcc, nocache, trickle, faketime, proot, fakechroot, linux32, setarch (build / jail helpers).
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
# ccache
#==============================================================

@test 'bt: ccache git' {
    _assert_tail_git 'ccache git'
}

@test 'bt: ccache -C git' {
    _assert_tail_git 'ccache -C git'
}

@test 'bt: ccache -z git' {
    _assert_tail_git 'ccache -z git'
}

@test 'bt: ccache -M 2G git' {
    _assert_tail_git 'ccache -M 2G git'
}

@test 'bt: ccache -o compiler_check= git' {
    _assert_tail_git 'ccache -o compiler_check= git'
}

@test 'bt: ccache -X clang git' {
    _assert_tail_git 'ccache -X clang git'
}

#==============================================================
# distcc (optional -j; numeric slot may stay in tail)
#==============================================================

@test 'bt: distcc git' {
    _assert_tail_git 'distcc git'
}

@test 'bt: distcc -j git' {
    _assert_tail_git 'distcc -j git'
}

@test 'bt: distcc -j 16 git tail' {
    _assert_tail_str 'distcc -j 16 git' '16 git'
}

@test 'bt: ccache distcc -j 8 git tail' {
    _assert_tail_str 'ccache distcc -j 8 git' '8 git'
}

#==============================================================
# nocache
#==============================================================

@test 'bt: nocache git' {
    _assert_tail_git 'nocache git'
}

@test 'bt: nocache -n 2 git' {
    _assert_tail_git 'nocache -n 2 git'
}

@test 'bt: nocache -n 0 git' {
    _assert_tail_git 'nocache -n 0 git'
}

@test 'bt: nocache ccache git' {
    _assert_tail_git 'nocache ccache git'
}

#==============================================================
# trickle / faketime
#==============================================================

@test 'bt: trickle -d 100 git' {
    _assert_tail_git 'trickle -d 100 git'
}

@test 'bt: trickle -u 50 -d 50 git' {
    _assert_tail_git 'trickle -u 50 -d 50 git'
}

@test 'bt: trickle -s git' {
    _assert_tail_git 'trickle -s git'
}

@test 'bt: faketime 2020-01-01 git' {
    _assert_tail_git 'faketime 2020-01-01 git'
}

@test 'bt: faketime -f /etc/faketimerc git' {
    _assert_tail_git 'faketime -f /etc/faketimerc git'
}

@test 'bt: faketime -m 0 git' {
    _assert_tail_git 'faketime -m 0 git'
}

#==============================================================
# proot / fakechroot / linux32 / setarch
#==============================================================

@test 'bt: proot -0 git' {
    _assert_tail_git 'proot -0 git'
}

@test 'bt: proot -r /jail git' {
    _assert_tail_git 'proot -r /jail git'
}

@test 'bt: proot -b /a:/b git' {
    _assert_tail_git 'proot -b /a:/b git'
}

@test 'bt: fakechroot git' {
    _assert_tail_git 'fakechroot git'
}

@test 'bt: fakechroot -l /lib git' {
    _assert_tail_git 'fakechroot -l /lib git'
}

@test 'bt: linux32 -R git' {
    _assert_tail_git 'linux32 -R git'
}

@test 'bt: setarch x86_64 -R git' {
    _assert_tail_git 'setarch x86_64 -R git'
}

@test 'bt: linux32 setarch i386 -R git' {
    _assert_tail_git 'linux32 setarch i386 -R git'
}

@test 'bt: fakechroot -s -l /lib git' {
    _assert_tail_git 'fakechroot -s -l /lib git'
}

@test 'bt: ccache -h git' {
    _assert_tail_git 'ccache -h git'
}

@test 'bt: distcc --show-hosts git tail' {
    _assert_tail_str 'distcc --show-hosts git' '--show-hosts git'
}

#==============================================================
# stacks (sudo / env / nice)
#==============================================================

@test 'bt: sudo ccache env CC=gcc git' {
    _assert_tail_git 'sudo ccache env CC=gcc git'
}

@test 'bt: env -i PATH=/usr/bin ccache git' {
    _assert_tail_git 'env -i PATH=/usr/bin ccache git'
}

@test 'bt: nice -n 5 trickle git' {
    _assert_tail_git 'nice -n 5 trickle git'
}

@test 'bt: nocorrect ccache distcc git' {
    _assert_tail_git 'nocorrect ccache distcc git'
}

@test 'bt: command ccache git' {
    _assert_tail_git 'command ccache git'
}

@test 'bt: time -p faketime 2020-01-01 git' {
    _assert_tail_git 'time -p faketime 2020-01-01 git'
}

@test 'bt: sudo proot -0 git' {
    _assert_tail_git 'sudo proot -0 git'
}

@test 'bt: sudo trickle git' {
    _assert_tail_git 'sudo trickle git'
}

@test 'bt: NOHUP ccache git' {
    _assert_tail_git 'NOHUP ccache git'
}

@test 'bt: env -i fakechroot git' {
    _assert_tail_git 'env -i fakechroot git'
}

@test 'bt: rlwrap ccache git' {
    _assert_tail_git 'rlwrap ccache git'
}

#==============================================================
# multi-word tail + idempotency
#==============================================================

@test 'bt: ccache git status --short' {
    _assert_tail_str 'ccache git status --short' 'git status --short'
}

@test 'bt: trickle -d 10 git log -1' {
    _assert_tail_str 'trickle -d 10 git log -1' 'git log -1'
}

@test 'bt: idempotent ccache git' {
    zpwrExpandParseWords 'ccache git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'ccache git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'bt: idempotent proot -r /j git' {
    zpwrExpandParseWords 'proot -r /j git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'proot -r /j git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
