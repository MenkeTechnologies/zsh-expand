#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: chroot, flock, su, runuser — login helpers and lock+chroot stacks.
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
# chroot
#==============================================================

@test 'cfr: chroot /jail env -i git' {
    _assert_tail_git 'chroot /jail env -i git'
}

@test 'cfr: chroot -- /srv/var env FOO=bar git' {
    _assert_tail_git 'chroot -- /srv/var env FOO=bar git'
}

@test 'cfr: chroot /j nice -n 5 git' {
    _assert_tail_git 'chroot /j nice -n 5 git'
}

@test 'cfr: env -i chroot /x git' {
    _assert_tail_git 'env -i chroot /x git'
}

@test 'cfr: nocorrect chroot /c git' {
    _assert_tail_git 'nocorrect chroot /c git'
}

#==============================================================
# flock + chroot
#==============================================================

@test 'cfr: flock /x chroot /y git' {
    _assert_tail_git 'flock /x chroot /y git'
}

@test 'cfr: chroot /a flock /b git' {
    _assert_tail_git 'chroot /a flock /b git'
}

@test 'cfr: flock -s /l chroot /r git' {
    _assert_tail_git 'flock -s /l chroot /r git'
}

@test 'cfr: sudo flock /l chroot /r git' {
    _assert_tail_git 'sudo flock /l chroot /r git'
}

#==============================================================
# runuser
#==============================================================

@test 'cfr: runuser -u nobody -l git' {
    _assert_tail_git 'runuser -u nobody -l git'
}

@test 'cfr: runuser -u u -m -p git' {
    _assert_tail_git 'runuser -u u -m -p git'
}

@test 'cfr: runuser -u www-data -g nogroup git' {
    _assert_tail_git 'runuser -u www-data -g nogroup git'
}

@test 'cfr: runuser -w 1,2 -u u git' {
    _assert_tail_git 'runuser -w 1,2 -u u git'
}

@test 'cfr: sudo chroot /j runuser -u git git' {
    _assert_tail_git 'sudo chroot /j runuser -u git git'
}

@test 'cfr: nice -n 0 runuser -u nobody git' {
    _assert_tail_git 'nice -n 0 runuser -u nobody git'
}

@test 'cfr: command -p runuser -u u git' {
    _assert_tail_git 'command -p runuser -u u git'
}

@test 'cfr: runuser -f -l -u deploy git' {
    _assert_tail_git 'runuser -f -l -u deploy git'
}

@test 'cfr: chroot /j runuser -u www git' {
    _assert_tail_git 'chroot /j runuser -u www git'
}

@test 'cfr: runuser -u u -- git' {
    _assert_tail_git 'runuser -u u -- git'
}

#==============================================================
# su
#==============================================================

@test 'cfr: su -s /bin/bash -g wheel -G docker deploy git' {
    _assert_tail_git 'su -s /bin/bash -g wheel -G docker deploy git'
}

@test 'cfr: su -l -p deploy git' {
    _assert_tail_git 'su -l -p deploy git'
}

@test 'cfr: su -f -m root git' {
    _assert_tail_git 'su -f -m root git'
}

@test 'cfr: su -P -T deploy git' {
    _assert_tail_git 'su -P -T deploy git'
}

@test 'cfr: timeout 1 su -c cmd nobody git' {
    _assert_tail_git 'timeout 1 su -c cmd nobody git'
}

@test 'cfr: su -g staff -G audio nobody git' {
    _assert_tail_git 'su -g staff -G audio nobody git'
}

@test 'cfr: su -w 1,2 deploy git' {
    _assert_tail_git 'su -w 1,2 deploy git'
}

@test 'cfr: env chroot /x git' {
    _assert_tail_git 'env chroot /x git'
}

@test 'cfr: sudo -E chroot /j git' {
    _assert_tail_git 'sudo -E chroot /j git'
}

@test 'cfr: chroot /j su deploy git' {
    _assert_tail_git 'chroot /j su deploy git'
}

@test 'cfr: chroot /j su -c cmd deploy git' {
    _assert_tail_git "chroot /j su -c cmd deploy git"
}

@test 'cfr: timeout 5 chroot /c git' {
    _assert_tail_git 'timeout 5 chroot /c git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'cfr: chroot /j git log -n 1' {
    _assert_tail_str 'chroot /j git log -n 1' 'git log -n 1'
}

@test 'cfr: runuser -u u git show --stat' {
    _assert_tail_str 'runuser -u u git show --stat' 'git show --stat'
}

@test 'cfr: chroot /j runuser -u u git log -n 1' {
    _assert_tail_str 'chroot /j runuser -u u git log -n 1' 'git log -n 1'
}

@test 'cfr: flock -s /l chroot /r git log' {
    _assert_tail_str 'flock -s /l chroot /r git log' 'git log'
}

@test 'cfr: idempotent flock chroot git' {
    zpwrExpandParseWords 'flock /tmp/l chroot /r git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'flock /tmp/l chroot /r git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'cfr: idempotent runuser -u nobody git' {
    zpwrExpandParseWords 'runuser -u nobody git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'runuser -u nobody git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
