#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: ZPWR_VARS[blacklistSubcommandPositionRegex] — pip/proxychains version suffixes (regression)
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

@test 'blacklistSubcmd: pip3.11 matches version suffix pattern' {
    [[ 'pip3.11' =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $? equals 0
}

@test 'blacklistSubcmd: pip3 matches' {
    [[ 'pip3' =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $? equals 0
}

@test 'blacklistSubcmd: proxychains4 matches version suffix pattern' {
    [[ 'proxychains4' =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $? equals 0
}

@test 'blacklistSubcmd: proxychains base matches' {
    [[ 'proxychains' =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $? equals 0
}

@test 'blacklistSubcmd: pnpm is not listed (does not match)' {
    [[ ! 'pnpm' =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $? equals 0
}

@test 'blacklistSubcmd: npx is not listed (does not match)' {
    [[ ! 'npx' =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $? equals 0
}
