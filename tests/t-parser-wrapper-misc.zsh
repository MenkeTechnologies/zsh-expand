#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Misc command wrappers (sandboxing, fake root, build helpers, dbus, etc.).
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
# Display / privilege / sandbox
#==============================================================

@test 'misc: xvfb-run -a git' {
    _assert_tail_git 'xvfb-run -a git'
}

@test 'misc: xvfb-run -a env -i git' {
    _assert_tail_git 'xvfb-run -a env -i git'
}

@test 'misc: pkexec -u admin git' {
    _assert_tail_git 'pkexec -u admin git'
}

@test 'misc: pkexec env HOME=/tmp git' {
    _assert_tail_git 'pkexec env HOME=/tmp git'
}

@test 'misc: runcon -u user -r role -t type git' {
    _assert_tail_git 'runcon -u user -r role -t type git'
}

@test 'misc: runcon -- git' {
    _assert_tail_git 'runcon -- git'
}

@test 'misc: setpriv --reuid=1000 git' {
    _assert_tail_git 'setpriv --reuid=1000 git'
}

@test 'misc: setpriv --clear-groups git' {
    _assert_tail_git 'setpriv --clear-groups git'
}

@test 'misc: capsh --drop=cap_net_raw -- git' {
    _assert_tail_git 'capsh --drop=cap_net_raw -- git'
}

@test 'misc: bwrap --ro-bind / / git' {
    _assert_tail_git 'bwrap --ro-bind / / git'
}

@test 'misc: proot -0 git' {
    _assert_tail_git 'proot -0 git'
}

@test 'misc: proot -r /jail git' {
    _assert_tail_git 'proot -r /jail git'
}

@test 'misc: fakechroot git' {
    _assert_tail_git 'fakechroot git'
}

@test 'misc: linux32 -R git' {
    _assert_tail_git 'linux32 -R git'
}

@test 'misc: setarch i386 -R git' {
    _assert_tail_git 'setarch i386 -R git'
}

#==============================================================
# Process / job control helpers
#==============================================================

@test 'misc: chpst -u www git' {
    _assert_tail_git 'chpst -u www git'
}

@test 'misc: chpst -e /env -u www git' {
    _assert_tail_git 'chpst -e /env -u www git'
}

@test 'misc: cgexec -g cpu:grp git' {
    _assert_tail_git 'cgexec -g cpu:grp git'
}

@test 'misc: cgexec --sticky -g cpu:a git' {
    _assert_tail_git 'cgexec --sticky -g cpu:a git'
}

@test 'misc: sem -j 4 git' {
    _assert_tail_git 'sem -j 4 git'
}

@test 'misc: sem -j 4 -- systemd-run -t git' {
    _assert_tail_git 'sem -j 4 -- systemd-run -t git'
}

@test 'misc: systemd-run -t git' {
    _assert_tail_git 'systemd-run -t git'
}

@test 'misc: systemd-run -dGqt -u unit git' {
    _assert_tail_git 'systemd-run -dGqt -u unit git'
}

@test 'misc: firejail --private git' {
    _assert_tail_git 'firejail --private git'
}

@test 'misc: firejail -c cmd --private git' {
    _assert_tail_git 'firejail -c cmd --private git'
}

@test 'misc: daemonize -u www git' {
    _assert_tail_git 'daemonize -u www git'
}

@test 'misc: fakeroot git' {
    _assert_tail_git 'fakeroot git'
}

@test 'misc: fakeroot -u git' {
    _assert_tail_git 'fakeroot -u git'
}

#==============================================================
# Build / cache / throttle
#==============================================================

@test 'misc: ccache git' {
    _assert_tail_git 'ccache git'
}

@test 'misc: distcc git' {
    _assert_tail_git 'distcc git'
}

@test 'misc: ccache distcc git' {
    _assert_tail_git 'ccache distcc git'
}

@test 'misc: nocache -n 2 git' {
    _assert_tail_git 'nocache -n 2 git'
}

@test 'misc: nocache fakechroot git' {
    _assert_tail_git 'nocache fakechroot git'
}

@test 'misc: trickle -d 100 git' {
    _assert_tail_git 'trickle -d 100 git'
}

@test 'misc: faketime 2020-01-01 git' {
    _assert_tail_git 'faketime 2020-01-01 git'
}

#==============================================================
# Debug / wrap
#==============================================================

@test 'misc: valgrind --tool=memcheck git' {
    _assert_tail_git 'valgrind --tool=memcheck git'
}

@test 'misc: valgrind -q -- git' {
    _assert_tail_git 'valgrind -q -- git'
}

@test 'misc: chronic -v git' {
    _assert_tail_git 'chronic -v git'
}

@test 'misc: unbuffer -p git' {
    _assert_tail_git 'unbuffer -p git'
}

#==============================================================
# Network / session
#==============================================================

@test 'misc: eatmydata torify git' {
    _assert_tail_git 'eatmydata torify git'
}

@test 'misc: torify sudo git' {
    _assert_tail_git 'torify sudo git'
}

@test 'misc: proxychains4 -q -f /etc/pc.conf git' {
    _assert_tail_git 'proxychains4 -q -f /etc/pc.conf git'
}

@test 'misc: catchsegv git' {
    _assert_tail_git 'catchsegv git'
}

@test 'misc: tsocks git' {
    _assert_tail_git 'tsocks git'
}

@test 'misc: dbus-run-session --config-file /etc/dbus.conf git' {
    _assert_tail_git 'dbus-run-session --config-file /etc/dbus.conf git'
}

@test 'misc: dbus-launch --exit-with-session git' {
    _assert_tail_git 'dbus-launch --exit-with-session git'
}

#==============================================================
# Multi-word tail + idempotency
#==============================================================

@test 'misc: sudo xvfb-run -a git status' {
    _assert_tail_str 'sudo xvfb-run -a git status' 'git status'
}

@test 'misc: idempotent fakeroot git twice' {
    zpwrExpandParseWords 'fakeroot git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'fakeroot git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'misc: idempotent systemd-run -t git twice' {
    zpwrExpandParseWords 'systemd-run -t git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'systemd-run -t git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
