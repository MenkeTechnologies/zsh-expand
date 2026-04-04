#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Case-insensitive command wrappers (phase-2 lower= matching).
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
# sudo / SUDO / SuDo
#==============================================================

@test 'case: SUDO git' {
    _assert_tail_git 'SUDO git'
}

@test 'case: sUdO -u root git' {
    _assert_tail_git 'sUdO -u root git'
}

@test 'case: SUDO -kE -u Admin git' {
    _assert_tail_git 'SUDO -kE -u Admin git'
}

@test 'case: SuDo -ABbE -g wheel -u deploy git' {
    _assert_tail_git 'SuDo -ABbE -g wheel -u deploy git'
}

#==============================================================
# doas / DoAs
#==============================================================

@test 'case: DoAs -u ops git' {
    _assert_tail_git 'DoAs -u ops git'
}

@test 'case: dOaS -Lns -u _www git' {
    _assert_tail_git 'dOaS -Lns -u _www git'
}

@test 'case: DOAS -C /etc/doas.conf -u root git' {
    _assert_tail_git 'DOAS -C /etc/doas.conf -u root git'
}

#==============================================================
# env / ENV / eNv
#==============================================================

@test 'case: ENV -i git' {
    _assert_tail_git 'ENV -i git'
}

@test 'case: eNv -0iv -C /tmp git' {
    _assert_tail_git 'eNv -0iv -C /tmp git'
}

@test 'case: EnV FOO=bar BAZ=qux git' {
    _assert_tail_git 'EnV FOO=bar BAZ=qux git'
}

@test 'case: env -a argv0 git' {
    _assert_tail_git 'env -a argv0 git'
}

#==============================================================
# nice / Nice / nIcE
#==============================================================

@test 'case: Nice -n 10 git' {
    _assert_tail_git 'Nice -n 10 git'
}

@test 'case: nIcE -n -5 git' {
    _assert_tail_git 'nIcE -n -5 git'
}

@test 'case: NICE -- git' {
    _assert_tail_git 'NICE -- git'
}

#==============================================================
# time / TIME / TiMe (phase-2 path for mixed case)
#==============================================================

@test 'case: TIME -v git' {
    _assert_tail_git 'TIME -v git'
}

@test 'case: TiMe -plv git' {
    _assert_tail_git 'TiMe -plv git'
}

@test 'case: tImE -p git' {
    _assert_tail_git 'tImE -p git'
}

#==============================================================
# nohup / NOHUP / nOhUp
#==============================================================

@test 'case: NOHUP git' {
    _assert_tail_git 'NOHUP git'
}

@test 'case: nOhUp git' {
    _assert_tail_git 'nOhUp git'
}

@test 'case: NoHuP -- git' {
    _assert_tail_git 'NoHuP -- git'
}

#==============================================================
# rlwrap / RLWRAP
#==============================================================

@test 'case: RLWRAP -a git' {
    _assert_tail_git 'RLWRAP -a git'
}

@test 'case: rLwRaP -f /dict -s 100 git' {
    _assert_tail_git 'rLwRaP -f /dict -s 100 git'
}

@test 'case: RlWrAp -- git' {
    _assert_tail_git 'RlWrAp -- git'
}

#==============================================================
# Cross-wrapper stacks (mixed case)
#==============================================================

@test 'case: SUDO eNv -i git' {
    _assert_tail_git 'SUDO eNv -i git'
}

@test 'case: SUDO eNv -i nIcE -n 0 git' {
    _assert_tail_git 'SUDO eNv -i nIcE -n 0 git'
}

@test 'case: rLwRaP -a sUdO git' {
    _assert_tail_git 'rLwRaP -a sUdO git'
}

@test 'case: nIcE -n 10 -- nOhUp git' {
    _assert_tail_git 'nIcE -n 10 -- nOhUp git'
}

@test 'case: TiMe -v DoAs -u wheel git' {
    _assert_tail_git 'TiMe -v DoAs -u wheel git'
}

@test 'case: ENV -i SUDO -E git' {
    _assert_tail_git 'ENV -i SUDO -E git'
}

@test 'case: sUdO -u nobody RLWRAP -a git' {
    _assert_tail_git 'sUdO -u nobody RLWRAP -a git'
}

@test 'case: Nice -n 5 NOHUP TiMe -p git' {
    _assert_tail_git 'Nice -n 5 NOHUP TiMe -p git'
}

@test 'case: dOaS -u root eNv PATH=/usr/bin git' {
    _assert_tail_git 'dOaS -u root eNv PATH=/usr/bin git'
}

#==============================================================
# With phase-1 keywords (lowercase builtins stay case-sensitive)
#==============================================================

@test 'case: nocorrect SUDO git' {
    _assert_tail_git 'nocorrect SUDO git'
}

@test 'case: builtin sUdO git' {
    _assert_tail_git 'builtin sUdO git'
}

@test 'case: command -p ENV -i git' {
    _assert_tail_git 'command -p ENV -i git'
}

#==============================================================
# Multi-word tail
#==============================================================

@test 'case: SUDO git status' {
    _assert_tail_str 'SUDO git status' 'git status'
}

@test 'case: eNv -i git log --oneline' {
    _assert_tail_str 'eNv -i git log --oneline' 'git log --oneline'
}

#==============================================================
# Idempotency
#==============================================================

@test 'case: idempotent SUDO -u root git' {
    zpwrExpandParseWords 'SUDO -u root git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'SUDO -u root git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'case: idempotent ENV -i git' {
    zpwrExpandParseWords 'ENV -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'ENV -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'case: SuDo -n git' {
    _assert_tail_git 'SuDo -n git'
}

@test 'case: sUdO -l git' {
    _assert_tail_git 'sUdO -l git'
}

@test 'case: SUDO -H -i git' {
    _assert_tail_git 'SUDO -H -i git'
}

@test 'case: DoAs -s git' {
    _assert_tail_git 'DoAs -s git'
}

@test 'case: eNv -u DISPLAY -u TERM git' {
    _assert_tail_git 'eNv -u DISPLAY -u TERM git'
}

@test 'case: ENV -- git' {
    _assert_tail_git 'ENV -- git'
}

@test 'case: Nice -19 git' {
    _assert_tail_git 'Nice -19 git'
}

@test 'case: NOHUP SUDO git' {
    _assert_tail_git 'NOHUP SUDO git'
}

@test 'case: RLWRAP -a ENV -i git' {
    _assert_tail_git 'RLWRAP -a ENV -i git'
}

@test 'case: TiMe -v sUdO strace -f git' {
    _assert_tail_git 'TiMe -v sUdO strace -f git'
}

@test 'case: SUDO timeout 5 git' {
    _assert_tail_git 'SUDO timeout 5 git'
}

@test 'case: sUdO ionice -c 2 git' {
    _assert_tail_git 'sUdO ionice -c 2 git'
}

@test 'case: dOaS Nice -n 0 git' {
    _assert_tail_git 'dOaS Nice -n 0 git'
}
