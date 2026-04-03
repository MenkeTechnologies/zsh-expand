#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Command-tail invariants for assignments, wrappers, --, and common prefixes.
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
# Assignments before / inside prefix chains
#==============================================================

@test 'tail: PATH=/usr/bin sudo git' {
    _assert_tail_git 'PATH=/usr/bin sudo git'
}

@test 'tail: sudo PATH=/usr/bin git' {
    _assert_tail_git 'sudo PATH=/usr/bin git'
}

@test 'tail: env FOO=bar BAZ=qux git' {
    _assert_tail_git 'env FOO=bar BAZ=qux git'
}

@test 'tail: env -i GOPATH=/go CC=gcc git' {
    _assert_tail_git 'env -i GOPATH=/go CC=gcc git'
}

@test 'tail: LANG=C LC_ALL=C sudo -E git' {
    _assert_tail_git 'LANG=C LC_ALL=C sudo -E git'
}

@test 'tail: doas -u ops env FOO=bar git' {
    _assert_tail_git 'doas -u ops env FOO=bar git'
}

#==============================================================
# chroot / flock / timeout / runuser
#==============================================================

@test 'tail: chroot /nr git' {
    _assert_tail_git 'chroot /nr git'
}

@test 'tail: chroot -- /nr git' {
    _assert_tail_git 'chroot -- /nr git'
}

@test 'tail: flock -w 5 /tmp/l git' {
    _assert_tail_git 'flock -w 5 /tmp/l git'
}

@test 'tail: flock -eFnosux -c cmd -w 10 /tmp/l git' {
    _assert_tail_git 'flock -eFnosux -c cmd -w 10 /tmp/l git'
}

@test 'tail: timeout 30 git' {
    _assert_tail_git 'timeout 30 git'
}

@test 'tail: timeout -k 5 30 git' {
    _assert_tail_git 'timeout -k 5 30 git'
}

@test 'tail: runuser -u nobody git' {
    _assert_tail_git 'runuser -u nobody git'
}

@test 'tail: runuser -u u -c cmd git' {
    _assert_tail_git 'runuser -u u -c cmd git'
}

#==============================================================
# su / stdbuf / nice / ionice / nohup
#==============================================================

@test 'tail: su root git' {
    _assert_tail_git 'su root git'
}

@test 'tail: su -l root git' {
    _assert_tail_git 'su -l root git'
}

@test 'tail: su -c cmd root git' {
    _assert_tail_git 'su -c cmd root git'
}

@test 'tail: stdbuf -oL -e0 git' {
    _assert_tail_git 'stdbuf -oL -e0 git'
}

@test 'tail: nice -n -10 git' {
    _assert_tail_git 'nice -n -10 git'
}

@test 'tail: nice -n 10 -- nohup git' {
    _assert_tail_git 'nice -n 10 -- nohup git'
}

@test 'tail: ionice -c 2 -n 7 git' {
    _assert_tail_git 'ionice -c 2 -n 7 git'
}

@test 'tail: nohup git' {
    _assert_tail_git 'nohup git'
}

@test 'tail: sudo nohup git' {
    _assert_tail_git 'sudo nohup git'
}

#==============================================================
# -- end-of-options
#==============================================================

@test 'tail: sudo -E -- git' {
    _assert_tail_git 'sudo -E -- git'
}

@test 'tail: sudo -- git' {
    _assert_tail_git 'sudo -- git'
}

@test 'tail: env -- git' {
    _assert_tail_git 'env -- git'
}

@test 'tail: strace -f -- git' {
    _assert_tail_git 'strace -f -- git'
}

@test 'tail: ltrace -c -- git' {
    _assert_tail_git 'ltrace -c -- git'
}

@test 'tail: watch -n 1 git' {
    _assert_tail_git 'watch -n 1 git'
}

@test 'tail: dbus-run-session -- git' {
    _assert_tail_git 'dbus-run-session -- git'
}

@test 'tail: eatmydata -- git' {
    _assert_tail_git 'eatmydata -- git'
}

#==============================================================
# nsenter / numactl / prlimit / setsid / chrt / taskset / caffeinate
#==============================================================

@test 'tail: nsenter -t 1 -m -n git' {
    _assert_tail_git 'nsenter -t 1 -m -n git'
}

@test 'tail: numactl -C 0 git' {
    _assert_tail_git 'numactl -C 0 git'
}

@test 'tail: prlimit --nofile=4096 git' {
    _assert_tail_git 'prlimit --nofile=4096 git'
}

@test 'tail: setsid -f git' {
    _assert_tail_git 'setsid -f git'
}

@test 'tail: chrt -f 5 git' {
    _assert_tail_git 'chrt -f 5 git'
}

@test 'tail: taskset -c 0 git' {
    _assert_tail_git 'taskset -c 0 git'
}

@test 'tail: caffeinate -i git' {
    _assert_tail_git 'caffeinate -i git'
}

#==============================================================
# Proxies / misc wrappers
#==============================================================

@test 'tail: torify git' {
    _assert_tail_git 'torify git'
}

@test 'tail: proxychains4 -q git' {
    _assert_tail_git 'proxychains4 -q git'
}

@test 'tail: rlwrap -a git' {
    _assert_tail_git 'rlwrap -a git'
}

@test 'tail: chronic -v git' {
    _assert_tail_git 'chronic -v git'
}

@test 'tail: unbuffer -p git' {
    _assert_tail_git 'unbuffer -p git'
}

#==============================================================
# Multi-word command tail
#==============================================================

@test 'tail: sudo git status' {
    _assert_tail_str 'sudo git status' 'git status'
}

@test 'tail: env -i git log --oneline' {
    _assert_tail_str 'env -i git log --oneline' 'git log --oneline'
}

#==============================================================
# Idempotent parse (cache must not leak between identical parses)
#==============================================================

@test 'idempotent: sudo -u nobody env -i git twice' {
    zpwrExpandParseWords 'sudo -u nobody env -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sudo -u nobody env -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'idempotent: ltrace -n 1 -w 2 git twice' {
    zpwrExpandParseWords 'ltrace -n 1 -w 2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'ltrace -n 1 -w 2 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
