#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandParseWords — words containing = are skipped for lastword (--flag=value, VAR=val)
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

@test 'parseWords: lastword skips trailing --long=value (use prior token)' {
    zpwrExpandParseWords "git --foo=bar"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'git'
}

@test 'parseWords: lastword skips -short=value' {
    zpwrExpandParseWords "cmd -o=v"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'cmd'
}

@test 'parseWords: lastword is last token without equals among trailing flags' {
    zpwrExpandParseWords "npm run script --output=path"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'script'
}

@test 'parseWords: only --flag=value tokens (no bare word) yields empty lastword' {
    zpwrExpandParseWords "--foo=1 --bar=2"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
}
