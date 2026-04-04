#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandParserFindCommandPosition — cachedParserPrefix / cachedRegexMatch / cleaned partition
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

@test 'parser cache: sudo -E sets prefix and tail' {
    zpwrExpandParseWords "sudo -E git status"
    assert "$ZPWR_VARS[cachedParserPrefix]" same_as 'sudo -E'
    assert "$ZPWR_VARS[cachedRegexMatch]" same_as 'git status'
    assert $ZPWR_VARS[cachedRegexMatched] same_as 'true'
}

@test 'parser cache: builtin command sets prefix and tail' {
    zpwrExpandParseWords "builtin command git diff"
    assert "$ZPWR_VARS[cachedParserPrefix]" same_as 'builtin command'
    assert "$ZPWR_VARS[cachedRegexMatch]" same_as 'git diff'
}

@test 'parser cache: single-word line skips parser (matched stays false)' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[cachedRegexMatched] same_as 'false'
    assert "$ZPWR_VARS[cachedParserPrefix]" same_as ''
    assert "$ZPWR_VARS[cachedRegexMatch]" same_as ''
}

@test 'parser cache: assignment before sudo stripped from partition' {
    zpwrExpandParseWords "VAR=x sudo git status"
    assert "${(j:|:)ZPWR_EXPAND_WORDS_LPARTITION}" same_as 'sudo|git|status'
    assert "$ZPWR_VARS[cachedRegexMatch]" same_as 'git status'
}

@test 'parser cache: env with assignments before command' {
    zpwrExpandParseWords "env FOO=bar BAZ=qux git log"
    assert "$ZPWR_VARS[cachedRegexMatch]" same_as 'git log'
}
