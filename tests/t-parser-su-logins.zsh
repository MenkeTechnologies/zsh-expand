#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: su(1) / runuser(1) login shells and stacks with sudo/doas/phase-1.
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
# su — basic
#==============================================================

@test 'su: su admin git' {
    _assert_tail_git 'su admin git'
}

@test 'su: su - git' {
    _assert_tail_git 'su - git'
}

@test 'su: su -l root git' {
    _assert_tail_git 'su -l root git'
}

@test 'su: su -l -m deploy git' {
    _assert_tail_git 'su -l -m deploy git'
}

@test 'su: su -p -g staff root git' {
    _assert_tail_git 'su -p -g staff root git'
}

@test 'su: su -g wheel admin git' {
    _assert_tail_git 'su -g wheel admin git'
}

@test 'su: su -c cmd root git' {
    _assert_tail_git 'su -c cmd root git'
}

@test 'su: su -c "whoami" nobody git' {
    _assert_tail_git 'su -c "whoami" nobody git'
}

@test 'su: su -flmpPT -c cmd -s /bin/bash -g wheel -G docker -w 1,2 root git' {
    _assert_tail_git 'su -flmpPT -c cmd -s /bin/bash -g wheel -G docker -w 1,2 root git'
}

@test 'su: su -flmpPT -c /bin/sh -g wheel -G docker -s /bin/zsh -w /tmp/a root git' {
    _assert_tail_git 'su -flmpPT -c /bin/sh -g wheel -G docker -s /bin/zsh -w /tmp/a root git'
}

#==============================================================
# su after sudo / doas / env
#==============================================================

@test 'su: sudo su - git' {
    _assert_tail_git 'sudo su - git'
}

@test 'su: sudo -u admin su -l deploy git' {
    _assert_tail_git 'sudo -u admin su -l deploy git'
}

@test 'su: sudo -kE -u root su -l nobody git' {
    _assert_tail_git 'sudo -kE -u root su -l nobody git'
}

@test 'su: doas -u root su - git' {
    _assert_tail_git 'doas -u root su - git'
}

@test 'su: doas -Lns -u _www su -l deploy git' {
    _assert_tail_git 'doas -Lns -u _www su -l deploy git'
}

@test 'su: env -i su -l root git' {
    _assert_tail_git 'env -i su -l root git'
}

@test 'su: ENV -i su -p admin git' {
    _assert_tail_git 'ENV -i su -p admin git'
}

#==============================================================
# su after phase-1 keywords
#==============================================================

@test 'su: nocorrect su -l root git' {
    _assert_tail_git 'nocorrect su -l root git'
}

@test 'su: command su -p admin git' {
    _assert_tail_git 'command su -p admin git'
}

@test 'su: command -p su -l root git' {
    _assert_tail_git 'command -p su -l root git'
}

@test 'su: time -p su -c cmd root git' {
    _assert_tail_git 'time -p su -c cmd root git'
}

@test 'su: noglob su admin git' {
    _assert_tail_git 'noglob su admin git'
}

#==============================================================
# su with nice / nohup / rlwrap
#==============================================================

@test 'su: nice -n 5 su -l root git' {
    _assert_tail_git 'nice -n 5 su -l root git'
}

@test 'su: NOHUP su - git' {
    _assert_tail_git 'NOHUP su - git'
}

@test 'su: rlwrap su -l deploy git' {
    _assert_tail_git 'rlwrap su -l deploy git'
}

#==============================================================
# runuser (same flag family as su in parser)
#==============================================================

@test 'su: runuser -u nobody git' {
    _assert_tail_git 'runuser -u nobody git'
}

@test 'su: runuser -l -u deploy git' {
    _assert_tail_git 'runuser -l -u deploy git'
}

@test 'su: runuser -u u su -l root git' {
    _assert_tail_git 'runuser -u u su -l root git'
}

@test 'su: sudo runuser -u www-data git' {
    _assert_tail_git 'sudo runuser -u www-data git'
}

#==============================================================
# sg (group) — parser consumes group word
#==============================================================

@test 'su: sg docker git' {
    _assert_tail_git 'sg docker git'
}

@test 'su: sudo sg audio git' {
    _assert_tail_git 'sudo sg audio git'
}

#==============================================================
# chroot + su stacks
#==============================================================

@test 'su: chroot /jail su -l root git' {
    _assert_tail_git 'chroot /jail su -l root git'
}

@test 'su: chroot -- /srv su deploy git' {
    _assert_tail_git 'chroot -- /srv su deploy git'
}

#==============================================================
# Multi-word tail + idempotency
#==============================================================

@test 'su: su -l root git log -1' {
    _assert_tail_str 'su -l root git log -1' 'git log -1'
}

@test 'su: sudo su - git status --short' {
    _assert_tail_str 'sudo su - git status --short' 'git status --short'
}

@test 'su: idempotent su -l deploy git' {
    zpwrExpandParseWords 'su -l deploy git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'su -l deploy git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'su: idempotent runuser -u u git' {
    zpwrExpandParseWords 'runuser -u u git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'runuser -u u git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# su under other wrappers (timeout, strace, sched, …)
#==============================================================

@test 'su: timeout 5 su -l root git' {
    _assert_tail_git 'timeout 5 su -l root git'
}

@test 'su: strace -f su - git' {
    _assert_tail_git 'strace -f su - git'
}

@test 'su: ionice -c 2 su admin git' {
    _assert_tail_git 'ionice -c 2 su admin git'
}

@test 'su: watch -n 1 su - git' {
    _assert_tail_git 'watch -n 1 su - git'
}

@test 'su: flock /tmp/x su -l root git' {
    _assert_tail_git 'flock /tmp/x su -l root git'
}

@test 'su: taskset -c 0 su deploy git' {
    _assert_tail_git 'taskset -c 0 su deploy git'
}

@test 'su: setsid su - git' {
    _assert_tail_git 'setsid su - git'
}

@test 'su: caffeinate -i su -l admin git' {
    _assert_tail_git 'caffeinate -i su -l admin git'
}

@test 'su: stdbuf -oL su -l root git' {
    _assert_tail_git 'stdbuf -oL su -l root git'
}

@test 'su: unshare -r su - git' {
    _assert_tail_git 'unshare -r su - git'
}

@test 'su: chrt -f 10 su - root git tail is root git' {
    _assert_tail_str 'chrt -f 10 su - root git' 'root git'
}
