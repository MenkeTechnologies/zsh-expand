#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Backslash- and quote-stripped wrapper words (_zpwr_bare) in phase-2 parser.
##### One literal backslash via hex 0x5c — avoids backslash-letter escape sequences in test source text.
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

    # One backslash char without $'…' or \\e in source (zunit lexer-safe).
    typeset -g _ZEXP_BS
    IFS= read -r _ZEXP_BS <<'EOM'
\
EOM

    function _bs() {
        print -rn "$_ZEXP_BS"
    }

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
# sudo / doas / env (leading backslash)
#==============================================================

@test 'bs: sudo word backslash' {
    _assert_tail_git "$(_bs)sudo git"
}

@test 'bs: sudo -u root backslash' {
    _assert_tail_git "$(_bs)sudo -u root git"
}

@test 'bs: sudo -kE -u nobody backslash' {
    _assert_tail_git "$(_bs)sudo -kE -u nobody git"
}

@test 'bs: doas backslash' {
    _assert_tail_git "$(_bs)doas git"
}

@test 'bs: doas -u ops backslash' {
    _assert_tail_git "$(_bs)doas -u ops git"
}

@test 'bs: env -i backslash' {
    _assert_tail_git "$(_bs)env -i git"
}

@test 'bs: env -u PATH backslash' {
    _assert_tail_git "$(_bs)env -u PATH git"
}

@test 'bs: SUDO mixed case backslash' {
    _assert_tail_git "$(_bs)SUDO git"
}

@test 'bs: eNv mixed case backslash' {
    _assert_tail_git "$(_bs)eNv -i git"
}

#==============================================================
# nice / time / nohup / rlwrap / timeout / strace
#==============================================================

@test 'bs: nice -n backslash' {
    _assert_tail_git "$(_bs)nice -n 5 git"
}

@test 'bs: time -p backslash' {
    _assert_tail_git "$(_bs)time -p git"
}

@test 'bs: nohup backslash' {
    _assert_tail_git "$(_bs)nohup git"
}

@test 'bs: nohup -- backslash' {
    _assert_tail_git "$(_bs)nohup -- git"
}

@test 'bs: rlwrap backslash' {
    _assert_tail_git "$(_bs)rlwrap git"
}

@test 'bs: rlwrap -a backslash' {
    _assert_tail_git "$(_bs)rlwrap -a git"
}

@test 'bs: timeout 5 backslash' {
    _assert_tail_git "$(_bs)timeout 5 git"
}

@test 'bs: strace -f backslash' {
    _assert_tail_git "$(_bs)strace -f git"
}

@test 'bs: ltrace -c backslash' {
    _assert_tail_git "$(_bs)ltrace -c git"
}

#==============================================================
# stacks (all backslash-prefixed wrappers)
#==============================================================

@test 'bs: stack sudo env' {
    _assert_tail_git "$(_bs)sudo $(_bs)env -i git"
}

@test 'bs: stack sudo strace nice' {
    _assert_tail_git "$(_bs)sudo $(_bs)strace -f $(_bs)nice -n 0 git"
}

@test 'bs: stack nice nohup' {
    _assert_tail_git "$(_bs)nice -n 10 $(_bs)nohup git"
}

@test 'bs: stack env sudo' {
    _assert_tail_git "$(_bs)env -i $(_bs)sudo -u root git"
}

#==============================================================
# phase-1 + backslash wrappers
#==============================================================

@test 'bs: nocorrect sudo backslash' {
    _assert_tail_git "nocorrect $(_bs)sudo git"
}

@test 'bs: command sudo backslash' {
    _assert_tail_git "command $(_bs)sudo git"
}

@test 'bs: command -p sudo backslash' {
    _assert_tail_git "command -p $(_bs)sudo git"
}

@test 'bs: time -p env backslash' {
    _assert_tail_git "time -p $(_bs)env -i git"
}

@test 'bs: noglob doas backslash' {
    _assert_tail_git "noglob $(_bs)doas git"
}

@test 'bs: builtin nice backslash' {
    _assert_tail_git "builtin $(_bs)nice -n 1 git"
}

#==============================================================
# quoted wrapper spellings (bare strips quotes)
#==============================================================

@test 'bs: double-quote sudo' {
    _assert_tail_git '"sudo" git'
}

@test 'bs: double-quote sudo -u root' {
    _assert_tail_git '"sudo" -u root git'
}

@test "bs: single-quote sudo" {
    _assert_tail_git "'sudo' git"
}

@test 'bs: double-quote env -i' {
    _assert_tail_git '"env" -i git'
}

@test 'bs: double-quote doas -u' {
    _assert_tail_git '"doas" -u x git'
}

@test 'bs: nocorrect double-quote sudo' {
    _assert_tail_git 'nocorrect "sudo" git'
}

@test 'bs: command double-quote env' {
    _assert_tail_git 'command "env" -i git'
}

#==============================================================
# command word backslash (tail is literal \git — no alias match)
#==============================================================

@test 'bs: command -p git backslash tail' {
    _assert_tail_str "command -p $(_bs)git" "$(_bs)git"
}

@test 'bs: sudo git backslash tail' {
    _assert_tail_str "sudo $(_bs)git" "$(_bs)git"
}

@test 'bs: git only backslash' {
    _assert_tail_str "$(_bs)git" "$(_bs)git"
}

#==============================================================
# mixed normal + backslash in one chain
#==============================================================

@test 'bs: sudo then env backslash' {
    _assert_tail_git "sudo $(_bs)env -i git"
}

@test 'bs: env then sudo backslash' {
    _assert_tail_git "env -i $(_bs)sudo -u root git"
}

@test 'bs: sudo git status multiword' {
    _assert_tail_str "$(_bs)sudo git status" 'git status'
}

@test 'bs: double-quote sudo git log' {
    _assert_tail_str '"sudo" git log -1' 'git log -1'
}

#==============================================================
# idempotency
#==============================================================

@test 'bs: idempotent sudo backslash' {
    zpwrExpandParseWords "$(_bs)sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords "$(_bs)sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'bs: idempotent double-quote env' {
    zpwrExpandParseWords '"env" -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords '"env" -i git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
