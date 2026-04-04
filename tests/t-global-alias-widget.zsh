#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandGlobalAliases with no argument — parses LBUFFER (ZLE widget path)
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

@test 'globalAlias widget: no arg parses LBUFFER and expands last word' {
    galiases[__ZGWIDGET_A]='| grep -E'
    LBUFFER="ls -la __ZGWIDGET_A"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases
    assert "$LBUFFER" same_as 'ls -la | grep -E'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZGWIDGET_A]'
}

@test 'globalAlias widget: no arg sets lastword_lbuffer from parse' {
    galiases[__ZGWIDGET_B]='| tail -n 5'
    LBUFFER="dmesg __ZGWIDGET_B"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZGWIDGET_B'
    unset 'galiases[__ZGWIDGET_B]'
}

@test 'globalAlias widget: no arg leaves buffer unchanged when last word is not a global alias' {
    LBUFFER="git status --short"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases
    assert "$LBUFFER" same_as 'git status --short'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}
