#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: systemd-run, firejail, sem, bwrap, daemonize, fakechroot, nocache, ccache — flags and container-ish stacks.
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
# systemd-run — property / unit / wait / scope
#==============================================================

@test 'sdsem: systemd-run -q --wait git' {
    _assert_tail_git 'systemd-run -q --wait git'
}

@test 'sdsem: systemd-run -t -p Restart=always git' {
    _assert_tail_git 'systemd-run -t -p Restart=always git'
}

@test 'sdsem: systemd-run --unit=name.service git' {
    _assert_tail_git 'systemd-run --unit=name.service git'
}

@test 'sdsem: systemd-run -G git' {
    _assert_tail_git 'systemd-run -G git'
}

@test 'sdsem: systemd-run -S git' {
    _assert_tail_git 'systemd-run -S git'
}

@test 'sdsem: systemd-run -H +PAM git' {
    _assert_tail_git 'systemd-run -H +PAM git'
}

@test 'sdsem: systemd-run -r --pty git' {
    _assert_tail_git 'systemd-run -r --pty git'
}

@test 'sdsem: systemd-run -d -G git' {
    _assert_tail_git 'systemd-run -d -G git'
}

@test 'sdsem: systemd-run -E VAR=val -E PATH=/bin git' {
    _assert_tail_git 'systemd-run -E VAR=val -E PATH=/bin git'
}

@test 'sdsem: systemd-run -M mycontainer git' {
    _assert_tail_git 'systemd-run -M mycontainer git'
}

@test 'sdsem: systemd-run --scope -p CPUAccounting=yes git' {
    _assert_tail_git 'systemd-run --scope -p CPUAccounting=yes git'
}

#==============================================================
# sem — GNU parallel job server
#==============================================================

@test 'sdsem: sem -j=4 git' {
    _assert_tail_git 'sem -j=4 git'
}

@test 'sdsem: sem --fg git' {
    _assert_tail_git 'sem --fg git'
}

@test 'sdsem: sem --linebuffer git' {
    _assert_tail_git 'sem --linebuffer git'
}

@test 'sdsem: sem -P 8 -- systemd-run -t git' {
    _assert_tail_git 'sem -P 8 -- systemd-run -t git'
}

#==============================================================
# firejail — long options and --
#==============================================================

@test 'sdsem: firejail --private --net=none -- git' {
    _assert_tail_git 'firejail --private --net=none -- git'
}

@test 'sdsem: firejail --profile=/etc/firejail/git.profile git' {
    _assert_tail_git 'firejail --profile=/etc/firejail/git.profile git'
}

@test 'sdsem: firejail --x11=xephyr git' {
    _assert_tail_git 'firejail --x11=xephyr git'
}

@test 'sdsem: sudo firejail --private git' {
    _assert_tail_git 'sudo firejail --private git'
}

@test 'sdsem: env -i firejail --noprofile git' {
    _assert_tail_git 'env -i firejail --noprofile git'
}

#==============================================================
# bwrap — bind mounts
#==============================================================

@test 'sdsem: bwrap --dev-bind /dev /dev --ro-bind / / git' {
    _assert_tail_git 'bwrap --dev-bind /dev /dev --ro-bind / / git'
}

@test 'sdsem: bwrap --tmpfs /tmp --proc /proc git' {
    _assert_tail_git 'bwrap --tmpfs /tmp --proc /proc git'
}

@test 'sdsem: bwrap --unshare-net --die-with-parent git' {
    _assert_tail_git 'bwrap --unshare-net --die-with-parent git'
}

#==============================================================
# daemonize + wrappers
#==============================================================

@test 'sdsem: daemonize -a -c /tmp systemd-run -t git' {
    _assert_tail_git 'daemonize -a -c /tmp systemd-run -t git'
}

@test 'sdsem: daemonize -E /tmp/e.log firejail --private git' {
    _assert_tail_git 'daemonize -E /tmp/e.log firejail --private git'
}

#==============================================================
# fakechroot / nocache / ccache
#==============================================================

@test 'sdsem: fakechroot -b /base -d /dbg git' {
    _assert_tail_git 'fakechroot -b /base -d /dbg git'
}

@test 'sdsem: fakechroot -e /list git' {
    _assert_tail_git 'fakechroot -e /list git'
}

@test 'sdsem: nocache -- ccache git' {
    _assert_tail_git 'nocache -- ccache git'
}

@test 'sdsem: ccache -C git' {
    _assert_tail_git 'ccache -C git'
}

@test 'sdsem: ccache -z git' {
    _assert_tail_git 'ccache -z git'
}

@test 'sdsem: ccache -M 2G git' {
    _assert_tail_git 'ccache -M 2G git'
}

@test 'sdsem: ccache -o debug=true git' {
    _assert_tail_git 'ccache -o debug=true git'
}

@test 'sdsem: ccache -X compiler git' {
    _assert_tail_git 'ccache -X compiler git'
}

@test 'sdsem: ccache distcc git' {
    _assert_tail_git 'ccache distcc git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'sdsem: systemd-run -t git log -p' {
    _assert_tail_str 'systemd-run -t git log -p' 'git log -p'
}

@test 'sdsem: firejail --private git diff --stat' {
    _assert_tail_str 'firejail --private git diff --stat' 'git diff --stat'
}

@test 'sdsem: idempotent systemd-run -M c1 git' {
    zpwrExpandParseWords 'systemd-run -M c1 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'systemd-run -M c1 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'sdsem: idempotent sem -j=2 bwrap --ro-bind / / git' {
    zpwrExpandParseWords 'sem -j=2 bwrap --ro-bind / / git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sem -j=2 bwrap --ro-bind / / git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
