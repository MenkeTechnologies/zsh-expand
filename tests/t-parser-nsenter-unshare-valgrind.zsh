#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: nsenter, unshare, numactl, valgrind, doas — flags and cross-wrapper stacks.
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
# nsenter
#==============================================================

@test 'nsvg: nsenter -t 1 -F -U git' {
    _assert_tail_git 'nsenter -t 1 -F -U git'
}

@test 'nsvg: nsenter -t 555 -m -n -u -i git' {
    _assert_tail_git 'nsenter -t 555 -m -n -u -i git'
}

@test 'nsvg: nsenter -t 2 -r -C git' {
    _assert_tail_git 'nsenter -t 2 -r -C git'
}

@test 'nsvg: sudo nsenter -t 1 -m -n git' {
    _assert_tail_git 'sudo nsenter -t 1 -m -n git'
}

#==============================================================
# numactl — short flags only (GNU long opts stay in tail)
#==============================================================

@test 'nsvg: numactl -N 0 -m 0 git' {
    _assert_tail_git 'numactl -N 0 -m 0 git'
}

@test 'nsvg: numactl -- git' {
    _assert_tail_git 'numactl -- git'
}

@test 'nsvg: numactl -C 0-3 -i 0 git' {
    _assert_tail_git 'numactl -C 0-3 -i 0 git'
}

@test 'nsvg: numactl -absHl git' {
    _assert_tail_git 'numactl -absHl git'
}

#==============================================================
# unshare — user namespace and fork
#==============================================================

@test 'nsvg: unshare -r --fork git' {
    _assert_tail_git 'unshare -r --fork git'
}

@test 'nsvg: unshare --map-root-user --mount-proc=/tmp/proc git' {
    _assert_tail_git 'unshare --map-root-user --mount-proc=/tmp/proc git'
}

@test 'nsvg: unshare --user --fork git' {
    _assert_tail_git 'unshare --user --fork git'
}

@test 'nsvg: env -i unshare -m git' {
    _assert_tail_git 'env -i unshare -m git'
}

#==============================================================
# valgrind — tool and leak / XML
#==============================================================

@test 'nsvg: valgrind --tool=callgrind --simulate-cache=yes git' {
    _assert_tail_git 'valgrind --tool=callgrind --simulate-cache=yes git'
}

@test 'nsvg: valgrind --xml=yes --xml-file=/tmp/vg.xml git' {
    _assert_tail_git 'valgrind --xml=yes --xml-file=/tmp/vg.xml git'
}

@test 'nsvg: valgrind --leak-check=full --show-leak-kinds=all git' {
    _assert_tail_git 'valgrind --leak-check=full --show-leak-kinds=all git'
}

@test 'nsvg: valgrind --fair-sched=yes git' {
    _assert_tail_git 'valgrind --fair-sched=yes git'
}

@test 'nsvg: valgrind -d -q git' {
    _assert_tail_git 'valgrind -d -q git'
}

#==============================================================
# doas
#==============================================================

@test 'nsvg: doas -s -C /etc/doas.conf git' {
    _assert_tail_git 'doas -s -C /etc/doas.conf git'
}

@test 'nsvg: doas -n -u root git' {
    _assert_tail_git 'doas -n -u root git'
}

@test 'nsvg: env -i PATH=/usr/bin doas -n git' {
    _assert_tail_git 'env -i PATH=/usr/bin doas -n git'
}

@test 'nsvg: sudo -u nobody doas -n git' {
    _assert_tail_git 'sudo -u nobody doas -n git'
}

#==============================================================
# fakeroot + valgrind
#==============================================================

@test 'nsvg: fakeroot -b /tmp/foo -l /tmp/lib valgrind -q git' {
    _assert_tail_git 'fakeroot -b /tmp/foo -l /tmp/lib valgrind -q git'
}

@test 'nsvg: fakeroot -i /tmp/env valgrind git' {
    _assert_tail_git 'fakeroot -i /tmp/env valgrind git'
}

#==============================================================
# Cross-wrapper stacks
#==============================================================

@test 'nsvg: sudo valgrind -q nsenter -t 1 -m git' {
    _assert_tail_git 'sudo valgrind -q nsenter -t 1 -m git'
}

@test 'nsvg: numactl -C 0-3 nsenter -t 1 -n git' {
    _assert_tail_git 'numactl -C 0-3 nsenter -t 1 -n git'
}

@test 'nsvg: doas -u root valgrind --tool=memcheck git' {
    _assert_tail_git 'doas -u root valgrind --tool=memcheck git'
}

@test 'nsvg: choom -n -1000 valgrind -q git' {
    _assert_tail_git 'choom -n -1000 valgrind -q git'
}

@test 'nsvg: nsenter -t 1 -m unshare -n git' {
    _assert_tail_git 'nsenter -t 1 -m unshare -n git'
}

@test 'nsvg: timeout 60 valgrind -q git' {
    _assert_tail_git 'timeout 60 valgrind -q git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'nsvg: valgrind -q git status --short' {
    _assert_tail_str 'valgrind -q git status --short' 'git status --short'
}

@test 'nsvg: nsenter -t 1 -m git diff --stat' {
    _assert_tail_str 'nsenter -t 1 -m git diff --stat' 'git diff --stat'
}

@test 'nsvg: idempotent numactl -N 0 git' {
    zpwrExpandParseWords 'numactl -N 0 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'numactl -N 0 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'nsvg: idempotent sudo valgrind nsenter git' {
    zpwrExpandParseWords 'sudo valgrind -q nsenter -t 2 -m git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sudo valgrind -q nsenter -t 2 -m git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
