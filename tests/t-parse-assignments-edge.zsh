#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandParseWords — assignment-only lines and empty partition
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

@test 'parseWords: two assignments only yields empty partition after parser strips' {
    zpwrExpandParseWords "FOO=1 BAR=2"
    assert ${#ZPWR_EXPAND_WORDS_LPARTITION} same_as 0
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
    assert "$ZPWR_VARS[firstword_partition]" same_as ''
}

@test 'parseWords: single assignment lastword empty firstword is assignment token' {
    zpwrExpandParseWords "FOO=bar"
    assert ${#ZPWR_EXPAND_WORDS_LPARTITION} same_as 1
    assert "$ZPWR_VARS[firstword_partition]" same_as 'FOO=bar'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
}

@test 'parseWords: assignment line with real command still finds last word' {
    zpwrExpandParseWords "FOO=1 BAR=2 git status"
    assert "$ZPWR_VARS[firstword_partition]" same_as 'git'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'status'
}
