#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: bwrap, fakeroot, systemd-run, capsh, valgrind, unbuffer, chronic, daemonize (deep flags + stacks).
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
# bwrap
#==============================================================

@test 'svc: bwrap --ro-bind / / git' {
    _assert_tail_git 'bwrap --ro-bind / / git'
}

@test 'svc: bwrap --bind /a /b --ro-bind /c /d git' {
    _assert_tail_git 'bwrap --bind /a /b --ro-bind /c /d git'
}

@test 'svc: bwrap --setenv FOO bar --clearenv git' {
    _assert_tail_git 'bwrap --setenv FOO bar --clearenv git'
}

@test 'svc: bwrap --overlay /r /w /d git' {
    _assert_tail_git 'bwrap --overlay /r /w /d git'
}

@test 'svc: bwrap --tmpfs /tmp --proc /proc git' {
    _assert_tail_git 'bwrap --tmpfs /tmp --proc /proc git'
}

@test 'svc: bwrap --unshare-pid --new-session git' {
    _assert_tail_git 'bwrap --unshare-pid --new-session git'
}

@test 'svc: bwrap --share-net --die-with-parent git' {
    _assert_tail_git 'bwrap --share-net --die-with-parent git'
}

@test 'svc: bwrap --chmod 0755 /x git' {
    _assert_tail_git 'bwrap --chmod 0755 /x git'
}

#==============================================================
# fakeroot
#==============================================================

@test 'svc: fakeroot git' {
    _assert_tail_git 'fakeroot git'
}

@test 'svc: fakeroot -u git' {
    _assert_tail_git 'fakeroot -u git'
}

@test 'svc: fakeroot -l /lib -- git' {
    _assert_tail_git 'fakeroot -l /lib -- git'
}

@test 'svc: fakeroot -b /tmp -- git' {
    _assert_tail_git 'fakeroot -b /tmp -- git'
}

@test 'svc: fakeroot -s save -u git' {
    _assert_tail_git 'fakeroot -s save -u git'
}

@test 'svc: fakeroot -l /lib -b /tmp git' {
    _assert_tail_git 'fakeroot -l /lib -b /tmp git'
}

#==============================================================
# systemd-run
#==============================================================

@test 'svc: systemd-run -t git' {
    _assert_tail_git 'systemd-run -t git'
}

@test 'svc: systemd-run -dGqt -u unit git' {
    _assert_tail_git 'systemd-run -dGqt -u unit git'
}

@test 'svc: systemd-run -p Prop=val -t git' {
    _assert_tail_git 'systemd-run -p Prop=val -t git'
}

@test 'svc: systemd-run --scope -- git' {
    _assert_tail_git 'systemd-run --scope -- git'
}

@test 'svc: systemd-run -M --quiet git' {
    _assert_tail_git 'systemd-run -M --quiet git'
}

#==============================================================
# capsh
#==============================================================

@test 'svc: capsh --drop=cap_sys_admin -- git' {
    _assert_tail_git 'capsh --drop=cap_sys_admin -- git'
}

@test 'svc: capsh --print -- git' {
    _assert_tail_git 'capsh --print -- git'
}

@test 'svc: capsh --mode=CAP git' {
    _assert_tail_git 'capsh --mode=CAP git'
}

@test 'svc: capsh --has-no-new-privs git' {
    _assert_tail_git 'capsh --has-no-new-privs git'
}

#==============================================================
# valgrind / unbuffer / chronic
#==============================================================

@test 'svc: valgrind -q --tool=memcheck -- git' {
    _assert_tail_git 'valgrind -q --tool=memcheck -- git'
}

@test 'svc: valgrind --track-origins=yes git' {
    _assert_tail_git 'valgrind --track-origins=yes git'
}

@test 'svc: valgrind -d git' {
    _assert_tail_git 'valgrind -d git'
}

@test 'svc: unbuffer -p git' {
    _assert_tail_git 'unbuffer -p git'
}

@test 'svc: unbuffer git' {
    _assert_tail_git 'unbuffer git'
}

@test 'svc: chronic -v git' {
    _assert_tail_git 'chronic -v git'
}

@test 'svc: chronic -- git' {
    _assert_tail_git 'chronic -- git'
}

#==============================================================
# daemonize
#==============================================================

@test 'svc: daemonize -u www git' {
    _assert_tail_git 'daemonize -u www git'
}

@test 'svc: daemonize -c /tmp -u www -p /run/x.pid git' {
    _assert_tail_git 'daemonize -c /tmp -u www -p /run/x.pid git'
}

@test 'svc: daemonize -e /tmp/e.log -o /tmp/o.log git' {
    _assert_tail_git 'daemonize -e /tmp/e.log -o /tmp/o.log git'
}

#==============================================================
# stacks with sudo / env / phase-1
#==============================================================

@test 'svc: sudo bwrap --ro-bind / / git' {
    _assert_tail_git 'sudo bwrap --ro-bind / / git'
}

@test 'svc: env -i fakeroot git' {
    _assert_tail_git 'env -i fakeroot git'
}

@test 'svc: fakeroot systemd-run -t git' {
    _assert_tail_git 'fakeroot systemd-run -t git'
}

@test 'svc: nocorrect systemd-run -t git' {
    _assert_tail_git 'nocorrect systemd-run -t git'
}

@test 'svc: command valgrind -q git' {
    _assert_tail_git 'command valgrind -q git'
}

@test 'svc: nice -n 0 chronic git' {
    _assert_tail_git 'nice -n 0 chronic git'
}

#==============================================================
# multi-word tail + idempotency
#==============================================================

@test 'svc: bwrap --ro-bind / / git status' {
    _assert_tail_str 'bwrap --ro-bind / / git status' 'git status'
}

@test 'svc: systemd-run -t git log -1' {
    _assert_tail_str 'systemd-run -t git log -1' 'git log -1'
}

@test 'svc: idempotent fakeroot git' {
    zpwrExpandParseWords 'fakeroot git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'fakeroot git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'svc: idempotent bwrap --ro-bind / / git' {
    zpwrExpandParseWords 'bwrap --ro-bind / / git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'bwrap --ro-bind / / git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
