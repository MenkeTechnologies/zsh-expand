#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: dbus session helpers, torify, eatmydata, distcc, pkexec, torsocks, proxychains4, sem.
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
# dbus-run-session
#==============================================================

@test 'dbus: dbus-run-session --config-file /etc/dbus.conf git' {
    _assert_tail_git 'dbus-run-session --config-file /etc/dbus.conf git'
}

@test 'dbus: dbus-run-session --config-file=/etc/foo.conf git' {
    _assert_tail_git 'dbus-run-session --config-file=/etc/foo.conf git'
}

@test 'dbus: dbus-run-session --dbus-daemon=/usr/bin/dbus-daemon -- git' {
    _assert_tail_git 'dbus-run-session --dbus-daemon=/usr/bin/dbus-daemon -- git'
}

@test 'dbus: dbus-run-session --config-file /x --dbus-daemon /usr/bin/dbus-daemon git' {
    _assert_tail_git 'dbus-run-session --config-file /x --dbus-daemon /usr/bin/dbus-daemon git'
}

@test 'dbus: dbus-run-session --dbus-daemon /usr/bin/dbus-daemon git' {
    _assert_tail_git 'dbus-run-session --dbus-daemon /usr/bin/dbus-daemon git'
}

@test 'dbus: nocorrect dbus-run-session --config-file /x git' {
    _assert_tail_git 'nocorrect dbus-run-session --config-file /x git'
}

@test 'dbus: command dbus-run-session --config-file /x git' {
    _assert_tail_git 'command dbus-run-session --config-file /x git'
}

@test 'dbus: fakeroot dbus-run-session git' {
    _assert_tail_git 'fakeroot dbus-run-session git'
}

#==============================================================
# dbus-launch
#==============================================================

@test 'dbus: dbus-launch --exit-with-session git' {
    _assert_tail_git 'dbus-launch --exit-with-session git'
}

@test 'dbus: dbus-launch --exit-with-session --config-file=foo.conf git' {
    _assert_tail_git 'dbus-launch --exit-with-session --config-file=foo.conf git'
}

@test 'dbus: dbus-launch --sh-syntax --close-stderr git' {
    _assert_tail_git 'dbus-launch --sh-syntax --close-stderr git'
}

@test 'dbus: dbus-launch --session git' {
    _assert_tail_git 'dbus-launch --session git'
}

@test 'dbus: dbus-launch -- git' {
    _assert_tail_git 'dbus-launch -- git'
}

@test 'dbus: dbus-launch --exit-with-session -- git' {
    _assert_tail_git 'dbus-launch --exit-with-session -- git'
}

@test 'dbus: command dbus-launch --exit-with-session git' {
    _assert_tail_git 'command dbus-launch --exit-with-session git'
}

#==============================================================
# eatmydata + torify
#==============================================================

@test 'proxy: eatmydata git' {
    _assert_tail_git 'eatmydata git'
}

@test 'proxy: eatmydata -- git' {
    _assert_tail_git 'eatmydata -- git'
}

@test 'proxy: eatmydata -- torify git' {
    _assert_tail_git 'eatmydata -- torify git'
}

@test 'proxy: eatmydata torify git' {
    _assert_tail_git 'eatmydata torify git'
}

@test 'proxy: eatmydata torify -v sudo git' {
    _assert_tail_git 'eatmydata torify -v sudo git'
}

@test 'proxy: eatmydata tsocks git' {
    _assert_tail_git 'eatmydata tsocks git'
}

@test 'proxy: torify git' {
    _assert_tail_git 'torify git'
}

@test 'proxy: torify -v git' {
    _assert_tail_git 'torify -v git'
}

@test 'proxy: torify -v env -i git' {
    _assert_tail_git 'torify -v env -i git'
}

@test 'proxy: torify sudo -u nobody git' {
    _assert_tail_git 'torify sudo -u nobody git'
}

#==============================================================
# distcc (optional -j only; numeric job count stays in tail)
#==============================================================

@test 'proxy: distcc git' {
    _assert_tail_git 'distcc git'
}

@test 'proxy: distcc -j git' {
    _assert_tail_git 'distcc -j git'
}

@test 'proxy: distcc -j 8 git tail is 8 git' {
    _assert_tail_str 'distcc -j 8 git' '8 git'
}

@test 'proxy: ccache distcc -j git' {
    _assert_tail_git 'ccache distcc -j git'
}

#==============================================================
# pkexec
#==============================================================

@test 'proxy: pkexec git' {
    _assert_tail_git 'pkexec git'
}

@test 'proxy: pkexec -u admin git' {
    _assert_tail_git 'pkexec -u admin git'
}

@test 'proxy: pkexec --user admin git' {
    _assert_tail_git 'pkexec --user admin git'
}

@test 'proxy: pkexec --disable-internal-agent git' {
    _assert_tail_git 'pkexec --disable-internal-agent git'
}

@test 'proxy: pkexec --keep-cwd git' {
    _assert_tail_git 'pkexec --keep-cwd git'
}

@test 'proxy: pkexec env HOME=/tmp git' {
    _assert_tail_git 'pkexec env HOME=/tmp git'
}

#==============================================================
# torsocks
#==============================================================

@test 'proxy: torsocks git' {
    _assert_tail_git 'torsocks git'
}

@test 'proxy: torsocks -a 127.0.0.1 -P 9050 git' {
    _assert_tail_git 'torsocks -a 127.0.0.1 -P 9050 git'
}

@test 'proxy: torsocks -diq6 git' {
    _assert_tail_git 'torsocks -diq6 git'
}

@test 'proxy: torsocks sudo git' {
    _assert_tail_git 'torsocks sudo git'
}

@test 'proxy: torsocks proxychains4 git' {
    _assert_tail_git 'torsocks proxychains4 git'
}

#==============================================================
# proxychains4, sem, tsocks, catchsegv
#==============================================================

@test 'proxy: proxychains4 git' {
    _assert_tail_git 'proxychains4 git'
}

@test 'proxy: proxychains4 -q git' {
    _assert_tail_git 'proxychains4 -q git'
}

@test 'proxy: proxychains4 -f /etc/pc.conf git' {
    _assert_tail_git 'proxychains4 -f /etc/pc.conf git'
}

@test 'proxy: sem -j 4 git' {
    _assert_tail_git 'sem -j 4 git'
}

@test 'proxy: sem -P 4 git' {
    _assert_tail_git 'sem -P 4 git'
}

@test 'proxy: sem -P 4 -- git' {
    _assert_tail_git 'sem -P 4 -- git'
}

@test 'proxy: tsocks git' {
    _assert_tail_git 'tsocks git'
}

@test 'proxy: catchsegv git' {
    _assert_tail_git 'catchsegv git'
}

@test 'proxy: tsocks catchsegv git' {
    _assert_tail_git 'tsocks catchsegv git'
}

#==============================================================
# Multi-word tail + idempotency
#==============================================================

@test 'proxy: torify sudo git status' {
    _assert_tail_str 'torify sudo git status' 'git status'
}

@test 'proxy: dbus-run-session --config-file /x git log --oneline' {
    _assert_tail_str 'dbus-run-session --config-file /x git log --oneline' 'git log --oneline'
}

@test 'proxy: idempotent eatmydata torify git' {
    zpwrExpandParseWords 'eatmydata torify git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'eatmydata torify git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'proxy: idempotent pkexec env -i git' {
    zpwrExpandParseWords 'pkexec env -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'pkexec env -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
