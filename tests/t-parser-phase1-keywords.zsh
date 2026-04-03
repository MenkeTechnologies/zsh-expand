#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Phase-1 shell keyword/builtin chain (nocorrect, time, command, exec, etc.).
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
# Single phase-1 keywords
#==============================================================

@test 'phase1: nocorrect git' {
    _assert_tail_git 'nocorrect git'
}

@test 'phase1: builtin git' {
    _assert_tail_git 'builtin git'
}

@test 'phase1: eval git' {
    _assert_tail_git 'eval git'
}

@test 'phase1: noglob git' {
    _assert_tail_git 'noglob git'
}

@test 'phase1: coproc git' {
    _assert_tail_git 'coproc git'
}

@test 'phase1: - git (dash builtin)' {
    _assert_tail_git '- git'
}

#==============================================================
# time [-plv]
#==============================================================

@test 'phase1: time git' {
    _assert_tail_git 'time git'
}

@test 'phase1: time -p git' {
    _assert_tail_git 'time -p git'
}

@test 'phase1: time -l git' {
    _assert_tail_git 'time -l git'
}

@test 'phase1: time -v git' {
    _assert_tail_git 'time -v git'
}

@test 'phase1: time -plv git' {
    _assert_tail_git 'time -plv git'
}

#==============================================================
# command [-p]
#==============================================================

@test 'phase1: command git' {
    _assert_tail_git 'command git'
}

@test 'phase1: command -p git' {
    _assert_tail_git 'command -p git'
}

#==============================================================
# exec -c/-l/-a
#==============================================================

@test 'phase1: exec git' {
    _assert_tail_git 'exec git'
}

@test 'phase1: exec -c git' {
    _assert_tail_git 'exec -c git'
}

@test 'phase1: exec -l git' {
    _assert_tail_git 'exec -l git'
}

@test 'phase1: exec -cl git' {
    _assert_tail_git 'exec -cl git'
}

@test 'phase1: exec -a myapp git' {
    _assert_tail_git 'exec -a myapp git'
}

@test 'phase1: exec -cl -a wrapper git' {
    _assert_tail_git 'exec -cl -a wrapper git'
}

#==============================================================
# Assignments before phase-1 keywords
#==============================================================

@test 'phase1: VAR=1 nocorrect git' {
    _assert_tail_git 'VAR=1 nocorrect git'
}

@test 'phase1: PATH=/bin command -p git' {
    _assert_tail_git 'PATH=/bin command -p git'
}

@test 'phase1: FOO=bar time -v git' {
    _assert_tail_git 'FOO=bar time -v git'
}

#==============================================================
# Phase-1 stacks (no wrappers)
#==============================================================

@test 'phase1: nocorrect builtin git' {
    _assert_tail_git 'nocorrect builtin git'
}

@test 'phase1: builtin eval git' {
    _assert_tail_git 'builtin eval git'
}

@test 'phase1: nocorrect time -p command -p git' {
    _assert_tail_git 'nocorrect time -p command -p git'
}

@test 'phase1: nocorrect time -p command -p builtin eval noglob git' {
    _assert_tail_git 'nocorrect time -p command -p builtin eval noglob git'
}

@test 'phase1: eval noglob builtin git' {
    _assert_tail_git 'eval noglob builtin git'
}

#==============================================================
# Phase-1 then phase-2 wrappers
#==============================================================

@test 'phase1: time sudo git' {
    _assert_tail_git 'time sudo git'
}

@test 'phase1: time -p sudo -u root git' {
    _assert_tail_git 'time -p sudo -u root git'
}

@test 'phase1: nocorrect sudo git' {
    _assert_tail_git 'nocorrect sudo git'
}

@test 'phase1: command sudo git' {
    _assert_tail_git 'command sudo git'
}

@test 'phase1: builtin sudo -u nobody git' {
    _assert_tail_git 'builtin sudo -u nobody git'
}

@test 'phase1: eval env -i git' {
    _assert_tail_git 'eval env -i git'
}

@test 'phase1: noglob nice -n 10 git' {
    _assert_tail_git 'noglob nice -n 10 git'
}

@test 'phase1: exec -c sudo git' {
    _assert_tail_git 'exec -c sudo git'
}

@test 'phase1: time -v env FOO=bar git' {
    _assert_tail_git 'time -v env FOO=bar git'
}

#==============================================================
# Multi-word command tail (phase-1 then non-alias command)
#==============================================================

@test 'phase1: nocorrect echo hello' {
    _assert_tail_str 'nocorrect echo hello' 'echo hello'
}

@test 'phase1: time -p command -p ls -la' {
    _assert_tail_str 'time -p command -p ls -la' 'ls -la'
}

@test 'phase1: builtin git log' {
    _assert_tail_str 'builtin git log' 'git log'
}

#==============================================================
# Idempotent parse
#==============================================================

@test 'phase1: double parse nocorrect time -p git' {
    zpwrExpandParseWords 'nocorrect time -p git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'nocorrect time -p git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'phase1: double parse exec -a x git' {
    zpwrExpandParseWords 'exec -a x git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'exec -a x git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# Phase-1 with longer sudo/env chains
#==============================================================

@test 'phase1: nocorrect time -v sudo -kE -u admin env -i git' {
    _assert_tail_git 'nocorrect time -v sudo -kE -u admin env -i git'
}

@test 'phase1: command -p doas -u wheel git' {
    _assert_tail_git 'command -p doas -u wheel git'
}

@test 'phase1: builtin strace -f git' {
    _assert_tail_git 'builtin strace -f git'
}

@test 'phase1: noglob ltrace -c git' {
    _assert_tail_git 'noglob ltrace -c git'
}

@test 'phase1: eval timeout 5 git' {
    _assert_tail_git 'eval timeout 5 git'
}

@test 'phase1: coproc nohup git' {
    _assert_tail_git 'coproc nohup git'
}

@test 'phase1: - nice -n 0 git' {
    _assert_tail_git '- nice -n 0 git'
}

@test 'phase1: time -p rlwrap -a git' {
    _assert_tail_git 'time -p rlwrap -a git'
}
