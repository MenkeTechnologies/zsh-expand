#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: regression tests for the _noeq `=`-word filter in
#####          zpwrExpandParseWords — a trailing `--flag=value`
#####          token must NOT become lastword_lbuffer, and the
#####          fallback must skip through multiple `=`-bearing
#####          tokens to the prior real word.
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    # reset config to defaults so local env vars do not leak into tests
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
}

#==============================================================
# trailing --flag=value must be excluded from lastword candidacy
#
# The `_noeq=("${(@)lpartAry:#*=*}")` filter strips every token
# containing `=`. Alias expansion fires on lastword_lbuffer, so a
# trailing `--color=auto` MUST resolve back to the prior real word
# (`diff`), never become the expansion target itself. A regression
# that only strips LEADING assignments would wrongly pick the flag.
#==============================================================

@test 'parseWords: trailing --flag=value falls back to prior subcommand' {
    zpwrExpandParseWords "git diff --color=auto"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'diff'
}

@test 'parseWords: trailing --flag=value after bare command falls back to command' {
    zpwrExpandParseWords "ls --color=auto"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'ls'
}

#==============================================================
# multiple consecutive `=`-bearing trailing tokens are all skipped
# so the fallback walks past more than one of them.
#==============================================================

@test 'parseWords: two trailing flag=value tokens skip to first real arg' {
    zpwrExpandParseWords "git log --oneline --color=always"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as '--oneline'
}

@test 'parseWords: leading assignment and trailing flag=value both excluded' {
    zpwrExpandParseWords "FOO=bar make --jobs=4"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'make'
}

#==============================================================
# every token contains `=` — _noeq is empty, the `:-''` default
# guards against an out-of-range `_noeq[-1]` on an empty array.
#==============================================================

@test 'parseWords: sole assignment word yields empty lastword via default guard' {
    zpwrExpandParseWords "FOO=bar"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
}
