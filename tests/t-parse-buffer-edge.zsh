#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandParseWords — empty parser tail, tab-separated tokens
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

@test 'parseWords: all-prefix line has empty tail and matched true' {
    zpwrExpandParseWords "sudo -u root"
    assert "$ZPWR_VARS[cachedRegexMatch]" same_as ''
    assert $ZPWR_VARS[cachedRegexMatched] same_as 'true'
    assert "$ZPWR_VARS[cachedParserPrefix]" same_as 'sudo -u root'
}

@test 'parseWords: tab between words splits lastword' {
    zpwrExpandParseWords $'echo\tfoo'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'foo'
    assert "$ZPWR_VARS[firstword_partition]" same_as 'echo'
}

@test 'parseWords: multiple tabs still yield last token' {
    zpwrExpandParseWords $'git\t\tstatus\t--short'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as '--short'
}
