#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: firejail, nocache, ccache, systemd-run, dbus-run-session, dbus-launch — flags and stacks.
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
# firejail
#==============================================================

@test 'fsd: firejail --private git' {
    _assert_tail_git 'firejail --private git'
}

@test 'fsd: firejail --noprofile --quiet git' {
    _assert_tail_git 'firejail --noprofile --quiet git'
}

@test 'fsd: firejail -c /etc/jail.profile git' {
    _assert_tail_git 'firejail -c /etc/jail.profile git'
}

@test 'fsd: firejail --trace git' {
    _assert_tail_git 'firejail --trace git'
}

@test 'fsd: firejail --private=dir git' {
    _assert_tail_git 'firejail --private=dir git'
}

@test 'fsd: firejail --build /b git (path consumed with --build)' {
    _assert_tail_str 'firejail --build /b git' '/b git'
}

@test 'fsd: env firejail --quiet git' {
    _assert_tail_git 'env firejail --quiet git'
}

@test 'fsd: timeout 5 firejail git' {
    _assert_tail_git 'timeout 5 firejail git'
}

@test 'fsd: bwrap --dev-bind / / firejail git' {
    _assert_tail_git 'bwrap --dev-bind / / firejail git'
}

@test 'fsd: doas firejail --quiet git' {
    _assert_tail_git 'doas firejail --quiet git'
}

@test 'fsd: torify firejail git' {
    _assert_tail_git 'torify firejail git'
}

@test 'fsd: runuser -u u firejail git' {
    _assert_tail_git 'runuser -u u firejail git'
}

@test 'fsd: pkexec --user u firejail git' {
    _assert_tail_git 'pkexec --user u firejail git'
}

#==============================================================
# nocache / ccache
#==============================================================

@test 'fsd: nocache -n 2 git' {
    _assert_tail_git 'nocache -n 2 git'
}

@test 'fsd: nocache git' {
    _assert_tail_git 'nocache git'
}

@test 'fsd: fakeroot nocache git' {
    _assert_tail_git 'fakeroot nocache git'
}

@test 'fsd: setpriv --nnp nocache git' {
    _assert_tail_git 'setpriv --nnp nocache git'
}

@test 'fsd: nice -n 0 nocache firejail git' {
    _assert_tail_git 'nice -n 0 nocache firejail git'
}

@test 'fsd: ccache -s git' {
    _assert_tail_git 'ccache -s git'
}

@test 'fsd: ccache -C git' {
    _assert_tail_git 'ccache -C git'
}

@test 'fsd: ccache -M 2G git' {
    _assert_tail_git 'ccache -M 2G git'
}

@test 'fsd: ccache -o compiler=clang++ git' {
    _assert_tail_git 'ccache -o compiler=clang++ git'
}

@test 'fsd: ccache distcc git' {
    _assert_tail_git 'ccache distcc git'
}

@test 'fsd: nocache ccache git' {
    _assert_tail_git 'nocache ccache git'
}

@test 'fsd: eatmydata ccache git' {
    _assert_tail_git 'eatmydata ccache git'
}

@test 'fsd: flock /l ccache git' {
    _assert_tail_git 'flock /l ccache git'
}

@test 'fsd: sem -j 2 ccache git' {
    _assert_tail_git 'sem -j 2 ccache git'
}

#==============================================================
# systemd-run
#==============================================================

@test 'fsd: systemd-run -t -p User=u git' {
    _assert_tail_git 'systemd-run -t -p User=u git'
}

@test 'fsd: systemd-run --scope git' {
    _assert_tail_git 'systemd-run --scope git'
}

@test 'fsd: systemd-run -M machine. -qt git' {
    _assert_tail_git 'systemd-run -M machine. -qt git'
}

@test 'fsd: systemd-run -d -G -t git' {
    _assert_tail_git 'systemd-run -d -G -t git'
}

@test 'fsd: sudo systemd-run -u unit git' {
    _assert_tail_git 'sudo systemd-run -u unit git'
}

@test 'fsd: stdbuf -oL systemd-run -t git' {
    _assert_tail_git 'stdbuf -oL systemd-run -t git'
}

@test 'fsd: chroot /j systemd-run -t git' {
    _assert_tail_git 'chroot /j systemd-run -t git'
}

#==============================================================
# dbus-run-session / dbus-launch
#==============================================================

@test 'fsd: dbus-run-session -- git' {
    _assert_tail_git 'dbus-run-session -- git'
}

@test 'fsd: dbus-run-session --config-file /x.conf git' {
    _assert_tail_git 'dbus-run-session --config-file /x.conf git'
}

@test 'fsd: dbus-launch git' {
    _assert_tail_git 'dbus-launch git'
}

@test 'fsd: dbus-launch --exit-with-session git' {
    _assert_tail_git 'dbus-launch --exit-with-session git'
}

#==============================================================
# Multi-word tails, idempotency
#==============================================================

@test 'fsd: firejail git diff --stat' {
    _assert_tail_str 'firejail git diff --stat' 'git diff --stat'
}

@test 'fsd: systemd-run -p CPUQuota=50% git status -sb' {
    _assert_tail_str 'systemd-run -p CPUQuota=50% git status -sb' 'git status -sb'
}

@test 'fsd: idempotent firejail --quiet git' {
    zpwrExpandParseWords 'firejail --quiet git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'firejail --quiet git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'fsd: idempotent systemd-run -t git' {
    zpwrExpandParseWords 'systemd-run -t git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'systemd-run -t git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
