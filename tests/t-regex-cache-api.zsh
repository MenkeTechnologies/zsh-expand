#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandRegexMatchOnCommandPosition — manual cache (skip parser) used by external callers
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
}

#==============================================================
# Manual partition + cache — zpwrExpandParserFindCommandPosition must not run
# (see zpwrExpandLib.zsh: cachedRegexMatched == true skips parser)
#==============================================================

@test 'regex cache: synthetic tail used when partition and cache preset' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo git)
    ZPWR_VARS[cachedRegexMatched]=true
    ZPWR_VARS[cachedRegexMatch]='__synthetic_tail__'
    ZPWR_EXPAND_PRE_EXPAND=()
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as '__synthetic_tail__'
}

@test 'regex cache: correct mode reads same cachedRegexMatch without re-parsing' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env python)
    ZPWR_VARS[cachedRegexMatched]=true
    ZPWR_VARS[cachedRegexMatch]='python -V'
    ZPWR_EXPAND_PRE_EXPAND=()
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_CORRECT" same_as 'python -V'
}

@test 'regex cache: expand mode after manual correct call still uses cache' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice cmd)
    ZPWR_VARS[cachedRegexMatched]=true
    ZPWR_VARS[cachedRegexMatch]='cmd'
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'cmd'
}
