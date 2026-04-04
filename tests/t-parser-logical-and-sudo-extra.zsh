#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: `&&` / `;` tails, sudo/doas/runuser, screen/tmux/script — live parser.
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

    function _assert_tail_str() {
        zpwrExpandParseWords "$1"
        zpwrExpandRegexMatchOnCommandPosition
        assert $state equals 0
        assert "$ZPWR_EXPAND_PRE_EXPAND" same_as "$2"
    }

    function _assert_tail_git() {
        _assert_tail_str "$1" 'git'
    }
}

#==============================================================
# Logical AND / semicolon — rhs command position
#==============================================================

@test 'las: cd /repo && git status' {
    _assert_tail_str 'cd /repo && git status' 'git status'
}

@test 'las: true && git diff' {
    _assert_tail_str 'true && git diff' 'git diff'
}

@test 'las: make all; git push' {
    _assert_tail_str 'make all; git push' 'git push'
}

@test 'las: export PATH=/x; git' {
    _assert_tail_git 'export PATH=/x; git'
}

@test 'las: builtin cd /x && git pull' {
    _assert_tail_str 'builtin cd /x && git pull' 'git pull'
}

@test 'las: module load git && git' {
    _assert_tail_git 'module load git && git'
}

@test 'las: leading || git status' {
    _assert_tail_str '|| git status' 'git status'
}

@test 'las: cd x || git clone . y' {
    _assert_tail_str 'cd x || git clone . y' 'git clone . y'
}

#==============================================================
# sudo / doas / runuser
#==============================================================

@test 'las: sudo git' {
    _assert_tail_git 'sudo git'
}

@test 'las: env sudo git' {
    _assert_tail_git 'env sudo git'
}

@test 'las: nice sudo git' {
    _assert_tail_git 'nice sudo git'
}

@test 'las: flock /x sudo git' {
    _assert_tail_git 'flock /x sudo git'
}

@test 'las: sudo -u git -H git' {
    _assert_tail_git 'sudo -u git -H git'
}

@test 'las: sudo -u deploy -g staff git' {
    _assert_tail_git 'sudo -u deploy -g staff git'
}

@test 'las: sudo -g docker git' {
    _assert_tail_git 'sudo -g docker git'
}

@test 'las: sudo -E -P git' {
    _assert_tail_git 'sudo -E -P git'
}

@test 'las: sudo -n git' {
    _assert_tail_git 'sudo -n git'
}

@test 'las: sudo -i git' {
    _assert_tail_git 'sudo -i git'
}

@test 'las: sudo -s git' {
    _assert_tail_git 'sudo -s git'
}

@test 'las: sudo --preserve-env=PATH git' {
    _assert_tail_str 'sudo --preserve-env=PATH git' '--preserve-env=PATH git'
}

@test 'las: doas -C /etc/doas.conf git' {
    _assert_tail_git 'doas -C /etc/doas.conf git'
}

@test 'las: doas -n git' {
    _assert_tail_git 'doas -n git'
}

@test 'las: runuser -u nobody -- git' {
    _assert_tail_git 'runuser -u nobody -- git'
}

#==============================================================
# script / screen / tmux / background
#==============================================================

@test 'las: stdbuf -oL script -q -c git /dev/null' {
    _assert_tail_str 'stdbuf -oL script -q -c git /dev/null' 'script -q -c git /dev/null'
}

@test 'las: screen -dmS s git status' {
    _assert_tail_str 'screen -dmS s git status' 'screen -dmS s git status'
}

@test 'las: tmux new-session git status' {
    _assert_tail_str 'tmux new-session git status' 'tmux new-session git status'
}

@test 'las: nohup git status &' {
    _assert_tail_str 'nohup git status &' 'git status &'
}

@test 'las: setsid git status &' {
    _assert_tail_str 'setsid git status &' 'git status &'
}

#==============================================================
# Debuggers / perf (full tail preserved)
#==============================================================

@test 'las: gdb -q -batch -ex run --args git status' {
    _assert_tail_str 'gdb -q -batch -ex run --args git status' 'gdb -q -batch -ex run --args git status'
}

@test 'las: lldb -o run -- git' {
    _assert_tail_str 'lldb -o run -- git' 'lldb -o run -- git'
}

@test 'las: perf script -g git' {
    _assert_tail_str 'perf script -g git' 'perf script -g git'
}

#==============================================================
# Misc tails
#==============================================================

@test 'las: git status || true' {
    _assert_tail_str 'git status || true' 'true'
}

@test 'las: op run -- git status' {
    _assert_tail_str 'op run -- git status' 'op run -- git status'
}

@test 'las: runcon u:r:s0 git' {
    _assert_tail_str 'runcon u:r:s0 git' 'u:r:s0 git'
}

#==============================================================
# sudo under trace / schedulers / prlimit
#==============================================================

@test 'las: sudo -E env git' {
    _assert_tail_git 'sudo -E env git'
}

@test 'las: sudo -H -u root git' {
    _assert_tail_git 'sudo -H -u root git'
}

@test 'las: sudo -- git' {
    _assert_tail_git 'sudo -- git'
}

@test 'las: doas -u www git' {
    _assert_tail_git 'doas -u www git'
}

@test 'las: strace -f sudo git' {
    _assert_tail_git 'strace -f sudo git'
}

@test 'las: timeout 1 sudo git' {
    _assert_tail_git 'timeout 1 sudo git'
}

@test 'las: ionice -c2 sudo git' {
    _assert_tail_git 'ionice -c2 sudo git'
}

@test 'las: prlimit --rss=unlimited sudo git' {
    _assert_tail_git 'prlimit --rss=unlimited sudo git'
}

#==============================================================
# sudo after `&&` / `;` and under sandbox wrappers
#==============================================================

@test 'las: cd / && sudo git' {
    _assert_tail_git 'cd / && sudo git'
}

@test 'las: true; sudo git' {
    _assert_tail_git 'true; sudo git'
}

@test 'las: env x=1 && sudo -n git' {
    _assert_tail_git 'env x=1 && sudo -n git'
}

@test 'las: bwrap --bind / / sudo git' {
    _assert_tail_git 'bwrap --bind / / sudo git'
}

@test 'las: systemd-run sudo git' {
    _assert_tail_git 'systemd-run sudo git'
}

@test 'las: torify sudo git' {
    _assert_tail_git 'torify sudo git'
}

@test 'las: fakeroot sudo git' {
    _assert_tail_git 'fakeroot sudo git'
}

@test 'las: pkexec sudo git' {
    _assert_tail_git 'pkexec sudo git'
}

#==============================================================
# Idempotency
#==============================================================

@test 'las: idempotent sudo -n git' {
    zpwrExpandParseWords 'sudo -n git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sudo -n git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'las: idempotent cd /r && git status' {
    zpwrExpandParseWords 'cd /r && git status'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
    zpwrExpandParseWords 'cd /r && git status'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}
