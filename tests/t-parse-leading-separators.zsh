#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandParseWords — partition starts after leading ; | && ||
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

@test 'parseWords: leading semicolon still finds git status segment' {
    zpwrExpandParseWords "; git status"
    assert "$ZPWR_VARS[firstword_partition]" same_as 'git'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'status'
}

@test 'parseWords: leading pipe starts new segment' {
    zpwrExpandParseWords "| grep foo"
    assert "$ZPWR_VARS[firstword_partition]" same_as 'grep'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'foo'
}

@test 'parseWords: leading && segment' {
    zpwrExpandParseWords "&& git status"
    assert "$ZPWR_VARS[firstword_partition]" same_as 'git'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'status'
}

@test 'parseWords: leading || segment' {
    zpwrExpandParseWords "|| echo x"
    assert "$ZPWR_VARS[firstword_partition]" same_as 'echo'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'x'
}
