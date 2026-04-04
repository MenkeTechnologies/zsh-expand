#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandLastWordAtCommandPosAndExpand when cached tail is multi-word
#####          (arg position — no alias expansion; NEED_TO_ADD_SPACECHAR set)
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
# Multi-word tail: parser yields 2+ words — no second-pos alias expand
#==============================================================

@test 'api: multi-word PRE_EXPAND + SPACE — buffer unchanged, NEED_TO_ADD_SPACECHAR true' {
    alias __zapi_mw1='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER='ltrace -f -- __zapi_mw1 foo'
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert $(( $#ZPWR_EXPAND_PRE_EXPAND > 1 )) equals 1
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as 'ltrace -f -- __zapi_mw1 foo'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_mw1
}

@test 'api: multi-word PRE_EXPAND + ENTER — early return leaves buffer unchanged' {
    alias __zapi_mw2='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=false
    LBUFFER='ltrace -f -- __zapi_mw2 foo'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert $(( $#ZPWR_EXPAND_PRE_EXPAND > 1 )) equals 1
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[ENTER_KEY]}"
    assert "$LBUFFER" same_as 'ltrace -f -- __zapi_mw2 foo'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_mw2
}

@test 'api: multi-word PRE_EXPAND + external_api — LBUFFER unchanged' {
    alias __zapi_mw3='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER='ltrace -f -- __zapi_mw3 foo'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert $(( $#ZPWR_EXPAND_PRE_EXPAND > 1 )) equals 1
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor external_api "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as 'ltrace -f -- __zapi_mw3 foo'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_mw3
}

@test 'api: multi-word PRE_EXPAND does not set LAST_WORD_WAS_AT_COMMAND (arg tail)' {
    alias __zapi_mw4='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER='ltrace -f -- __zapi_mw4 foo'
    ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert $(( $#ZPWR_EXPAND_PRE_EXPAND > 1 )) equals 1
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor external_api "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert $ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND] same_as 'false'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_mw4
}

#==============================================================
# Contrast: single-word tail on same prefix — alias expands
#==============================================================

@test 'api: single-word PRE_EXPAND + SPACE — second position expands alias' {
    alias __zapi_mw5='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER='ltrace -f -- __zapi_mw5'
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert $#ZPWR_EXPAND_PRE_EXPAND equals 1
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as 'ltrace -f -- git status'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_mw5
}
