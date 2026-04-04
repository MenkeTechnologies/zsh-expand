#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Deep stacks for setpriv, xvfb-run, runcon, pkexec — flags and cross-wrapper chains.
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
# setpriv — long options and short flags
#==============================================================

@test 'privxvfb: setpriv --nnp --reset-env git' {
    _assert_tail_git 'setpriv --nnp --reset-env git'
}

@test 'privxvfb: setpriv --bounding-set=+all git' {
    _assert_tail_git 'setpriv --bounding-set=+all git'
}

@test 'privxvfb: setpriv --apparmor-profile=/usr/bin/git-profile git' {
    _assert_tail_git 'setpriv --apparmor-profile=/usr/bin/git-profile git'
}

@test 'privxvfb: setpriv -d -V git' {
    _assert_tail_git 'setpriv -d -V git'
}

@test 'privxvfb: setpriv --keep-groups --init-groups git' {
    _assert_tail_git 'setpriv --keep-groups --init-groups git'
}

@test 'privxvfb: setpriv --pdeathsig=KILL git' {
    _assert_tail_git 'setpriv --pdeathsig=KILL git'
}

@test 'privxvfb: setpriv --inh-caps=-all --ambient-caps=cap_net_bind_service git' {
    _assert_tail_git 'setpriv --inh-caps=-all --ambient-caps=cap_net_bind_service git'
}

@test 'privxvfb: setpriv --selinux-label=system_u:system_r:httpd_t:s0 git' {
    _assert_tail_git 'setpriv --selinux-label=system_u:system_r:httpd_t:s0 git'
}

@test 'privxvfb: setpriv --securebits=+noroot git' {
    _assert_tail_git 'setpriv --securebits=+noroot git'
}

@test 'privxvfb: setpriv --groups=0,1,2 git' {
    _assert_tail_git 'setpriv --groups=0,1,2 git'
}

#==============================================================
# xvfb-run — log file, auth, screen args, server opts
#==============================================================

@test 'privxvfb: xvfb-run -e /tmp/xvfb.err -a git' {
    _assert_tail_git 'xvfb-run -e /tmp/xvfb.err -a git'
}

@test 'privxvfb: xvfb-run -f /tmp/Xauthority -a git' {
    _assert_tail_git 'xvfb-run -f /tmp/Xauthority -a git'
}

@test 'privxvfb: xvfb-run -s "-screen 0 1024x768x24" -a git' {
    _assert_tail_git 'xvfb-run -s "-screen 0 1024x768x24" -a git'
}

@test 'privxvfb: xvfb-run -n 99 -p tcp git' {
    _assert_tail_git 'xvfb-run -n 99 -p tcp git'
}

@test 'privxvfb: xvfb-run -w 5 -l git' {
    _assert_tail_git 'xvfb-run -w 5 -l git'
}

@test 'privxvfb: xvfb-run -a env -i PATH=/usr/bin git' {
    _assert_tail_git 'xvfb-run -a env -i PATH=/usr/bin git'
}

@test 'privxvfb: xvfb-run -f /tmp/xauth -e /tmp/log -a git' {
    _assert_tail_git 'xvfb-run -f /tmp/xauth -e /tmp/log -a git'
}

#==============================================================
# runcon — SELinux user/role/type/range
#==============================================================

@test 'privxvfb: runcon -u deploy -r role_t -t type_t git' {
    _assert_tail_git 'runcon -u deploy -r role_t -t type_t git'
}

@test 'privxvfb: runcon -u u1 -r r1 -t t1 -l s0:c0 git' {
    _assert_tail_git 'runcon -u u1 -r r1 -t t1 -l s0:c0 git'
}

@test 'privxvfb: runcon -c cat -u u -r r git' {
    _assert_tail_str 'runcon -c cat -u u -r r git' 'cat -u u -r r git'
}

#==============================================================
# pkexec — long options
#==============================================================

@test 'privxvfb: pkexec --user admin git' {
    _assert_tail_git 'pkexec --user admin git'
}

@test 'privxvfb: pkexec --disable-internal-agent git' {
    _assert_tail_git 'pkexec --disable-internal-agent git'
}

@test 'privxvfb: pkexec env HOME=/tmp git' {
    _assert_tail_git 'pkexec env HOME=/tmp git'
}

#==============================================================
# Cross-wrapper: sudo / env / strace / eatmydata / torify
#==============================================================

@test 'privxvfb: sudo setpriv --nnp --reset-env git' {
    _assert_tail_git 'sudo setpriv --nnp --reset-env git'
}

@test 'privxvfb: sudo xvfb-run -a setpriv --clear-groups git' {
    _assert_tail_git 'sudo xvfb-run -a setpriv --clear-groups git'
}

@test 'privxvfb: env -i DISPLAY=:0 xvfb-run -a git' {
    _assert_tail_git 'env -i DISPLAY=:0 xvfb-run -a git'
}

@test 'privxvfb: xvfb-run -a sudo -u nobody git' {
    _assert_tail_git 'xvfb-run -a sudo -u nobody git'
}

@test 'privxvfb: eatmydata strace -f git' {
    _assert_tail_git 'eatmydata strace -f git'
}

@test 'privxvfb: torify -v eatmydata git' {
    _assert_tail_git 'torify -v eatmydata git'
}

@test 'privxvfb: torify xvfb-run -a eatmydata git' {
    _assert_tail_git 'torify xvfb-run -a eatmydata git'
}

@test 'privxvfb: setpriv --reuid=1000 xvfb-run -a git' {
    _assert_tail_git 'setpriv --reuid=1000 xvfb-run -a git'
}

@test 'privxvfb: runcon -u u -r r -t t pkexec --user admin git' {
    _assert_tail_git 'runcon -u u -r r -t t pkexec --user admin git'
}

@test 'privxvfb: pkexec xvfb-run -a git' {
    _assert_tail_git 'pkexec xvfb-run -a git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'privxvfb: sudo xvfb-run -a git status' {
    _assert_tail_str 'sudo xvfb-run -a git status' 'git status'
}

@test 'privxvfb: setpriv --nnp -- git log -1' {
    _assert_tail_str 'setpriv --nnp -- git log -1' 'git log -1'
}

@test 'privxvfb: xvfb-run -a env -i git diff' {
    _assert_tail_str 'xvfb-run -a env -i git diff' 'git diff'
}

@test 'privxvfb: idempotent sudo setpriv xvfb-run git' {
    zpwrExpandParseWords 'sudo setpriv --nnp xvfb-run -a git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sudo setpriv --nnp xvfb-run -a git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'privxvfb: idempotent torify eatmydata strace git' {
    zpwrExpandParseWords 'torify eatmydata strace -f git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'torify eatmydata strace -f git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
