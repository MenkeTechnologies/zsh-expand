#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandLastWordAtCommandPosAndExpand — non-zle callers and ENTER / pre-exec flags
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
# Non-zle caller (e.g. fzf / script using the API): no alias mutation
#==============================================================

@test 'api: non-zle caller leaves LBUFFER unchanged for single-word alias' {
    alias __zapi_ext1='git status'
    LBUFFER="__zapi_ext1"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor external_api "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as '__zapi_ext1'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unalias __zapi_ext1
}

@test 'api: non-zle caller still records ORIGINAL_LAST_COMMAND for single word' {
    alias __zapi_ext2='git status'
    LBUFFER="__zapi_ext2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor external_api "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert $ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND] same_as 'true'
    assert $ZPWR_VARS[ORIGINAL_LAST_COMMAND] same_as '__zapi_ext2'
    unalias __zapi_ext2
}

@test 'api: zle caller expands single-word alias' {
    alias __zapi_zle1='git status'
    LBUFFER="__zapi_zle1"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as 'git status'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unalias __zapi_zle1
}

@test 'api: non-zle caller leaves LBUFFER unchanged for sudo + alias' {
    alias __zapi_ext3='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="sudo __zapi_ext3"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor external_api "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as 'sudo __zapi_ext3'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_ext3
}

@test 'api: zle caller expands sudo + alias when second position enabled' {
    alias __zapi_zle2='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="sudo __zapi_zle2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as 'sudo ls -la'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_zle2
}

#==============================================================
# ENTER vs SPACE — ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION
#==============================================================

@test 'api: ENTER defers second-position expansion when PRE_EXEC_SECOND is false' {
    alias __zapi_ent1='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=false
    LBUFFER="sudo __zapi_ent1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[ENTER_KEY]}"
    assert "$LBUFFER" same_as 'sudo __zapi_ent1'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_ent1
}

@test 'api: ENTER expands second position when PRE_EXEC_SECOND is true' {
    alias __zapi_ent2='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=true
    LBUFFER="sudo __zapi_ent2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[ENTER_KEY]}"
    assert "$LBUFFER" same_as 'sudo git status'
    ZPWR_EXPAND_SECOND_POSITION=false
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=false
    unalias __zapi_ent2
}

@test 'api: SPACE still expands second position when PRE_EXEC_SECOND is false' {
    alias __zapi_ent3='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=false
    LBUFFER="sudo __zapi_ent3"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as 'sudo git status'
    ZPWR_EXPAND_SECOND_POSITION=false
    unalias __zapi_ent3
}

#==============================================================
# cursorAction — tabstop handling only runs for moveCursor
# (expanded value must contain ZPWR_TABSTOP so GoToTabStopOrEndOfLBuffer strips RBUFFER)
#==============================================================

@test 'api: noMove skips tabstop cursor/RBUFFER adjustment after expand' {
    alias __zapi_tab="git${ZPWR_TABSTOP} status"
    LBUFFER="__zapi_tab"
    RBUFFER="${ZPWR_TABSTOP}suffix"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand noMove zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$RBUFFER" same_as "${ZPWR_TABSTOP}suffix"
    unalias __zapi_tab
}

@test 'api: moveCursor applies tabstop handling after expand' {
    alias __zapi_tab2="git${ZPWR_TABSTOP} status"
    LBUFFER="__zapi_tab2"
    RBUFFER="${ZPWR_TABSTOP}suffix"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$RBUFFER" same_as 'suffix'
    unalias __zapi_tab2
}
