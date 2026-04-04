#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: sg(1) group switches with env, sudo, chroot, schedulers, and namespaces.
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
# sg — phase-1 and common wrappers
#==============================================================

@test 'sgk: env sg docker git' {
    _assert_tail_git 'env sg docker git'
}

@test 'sgk: sudo -E sg audio git' {
    _assert_tail_git 'sudo -E sg audio git'
}

@test 'sgk: sudo -u nobody sg docker git' {
    _assert_tail_git 'sudo -u nobody sg docker git'
}

@test 'sgk: chroot /j sg kvm git' {
    _assert_tail_git 'chroot /j sg kvm git'
}

@test 'sgk: sudo chroot /c sg grp git' {
    _assert_tail_git 'sudo chroot /c sg grp git'
}

@test 'sgk: timeout 2 sg plugdev git' {
    _assert_tail_git 'timeout 2 sg plugdev git'
}

@test 'sgk: nice -n 0 sg users git' {
    _assert_tail_git 'nice -n 0 sg users git'
}

@test 'sgk: command -p sg staff git' {
    _assert_tail_git 'command -p sg staff git'
}

@test 'sgk: nocorrect sg video git' {
    _assert_tail_git 'nocorrect sg video git'
}

@test 'sgk: stdbuf -oL sg tty git' {
    _assert_tail_git 'stdbuf -oL sg tty git'
}

@test 'sgk: exec sg docker git' {
    _assert_tail_git 'exec sg docker git'
}

@test 'sgk: env FOO=bar sg kvm git' {
    _assert_tail_git 'env FOO=bar sg kvm git'
}

@test 'sgk: env -i sg kvm git' {
    _assert_tail_git 'env -i sg kvm git'
}

@test 'sgk: doas sg wheel git' {
    _assert_tail_git 'doas sg wheel git'
}

@test 'sgk: sg lp git' {
    _assert_tail_git 'sg lp git'
}

#==============================================================
# sg — ordering with flock, chroot, su, runuser
#==============================================================

@test 'sgk: flock /l sg kvm git' {
    _assert_tail_git 'flock /l sg kvm git'
}

@test 'sgk: sg kvm chroot /r git' {
    _assert_tail_git 'sg kvm chroot /r git'
}

@test 'sgk: runuser -u u sg docker git' {
    _assert_tail_git 'runuser -u u sg docker git'
}

@test 'sgk: su -l root sg audio git' {
    _assert_tail_git 'su -l root sg audio git'
}

@test 'sgk: sg docker sg audio git' {
    _assert_tail_git 'sg docker sg audio git'
}

#==============================================================
# sg — sched / NUMA / limits / namespaces
#==============================================================

@test 'sgk: setsid sg docker git' {
    _assert_tail_git 'setsid sg docker git'
}

@test 'sgk: ionice -c2 sg audio git' {
    _assert_tail_git 'ionice -c2 sg audio git'
}

@test 'sgk: chrt -f 99 sg kvm git' {
    _assert_tail_git 'chrt -f 99 sg kvm git'
}

@test 'sgk: taskset -c 0 sg users git' {
    _assert_tail_git 'taskset -c 0 sg users git'
}

@test 'sgk: numactl -N 0 sg audio git' {
    _assert_tail_git 'numactl -N 0 sg audio git'
}

@test 'sgk: prlimit --nofile=64 sg staff git' {
    _assert_tail_git 'prlimit --nofile=64 sg staff git'
}

@test 'sgk: setpriv --nnp sg docker git' {
    _assert_tail_git 'setpriv --nnp sg docker git'
}

@test 'sgk: nsenter -t 1 -n sg audio git' {
    _assert_tail_git 'nsenter -t 1 -n sg audio git'
}

@test 'sgk: unshare -U sg kvm git' {
    _assert_tail_git 'unshare -U sg kvm git'
}

#==============================================================
# sg — sandbox / proxy / macOS
#==============================================================

@test 'sgk: bwrap --dev-bind / / sg docker git' {
    _assert_tail_git 'bwrap --dev-bind / / sg docker git'
}

@test 'sgk: fakeroot sg kvm git' {
    _assert_tail_git 'fakeroot sg kvm git'
}

@test 'sgk: eatmydata sg kvm git' {
    _assert_tail_git 'eatmydata sg kvm git'
}

@test 'sgk: torify sg audio git' {
    _assert_tail_git 'torify sg audio git'
}

@test 'sgk: caffeinate -i sg docker git' {
    _assert_tail_git 'caffeinate -i sg docker git'
}

#==============================================================
# Multi-word tails, --, idempotency
#==============================================================

@test 'sgk: sg docker git log -n 1' {
    _assert_tail_str 'sg docker git log -n 1' 'git log -n 1'
}

@test 'sgk: sg -- docker git (group docker; tail is two words)' {
    _assert_tail_str 'sg -- docker git' 'docker git'
}

@test 'sgk: idempotent sg docker git' {
    zpwrExpandParseWords 'sg docker git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sg docker git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
