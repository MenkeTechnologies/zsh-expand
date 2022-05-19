#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Feb 25 19:37:50 EST 2020
##### Purpose: zsh script to
##### Notes:
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

@test 'expand alias pwd="ls' {
    LBUFFER="pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias

    printLBUFFER
    assert $LBUFFER same_as 'ls'
}

@test 'no expand alias pwd="pwd "' {
    LBUFFER="pwd "
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias || :

    printLBUFFER
    assert $LBUFFER same_as 'pwd '
}

@test 'no expand alias pwd="ls' {
    LBUFFER="sudo pwd "
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias || :

    printLBUFFER
    assert $LBUFFER same_as 'sudo pwd '
}

@test 'expand alias pwd="ls" keep space' {
    typeset -A ZPWR_VARS
    LBUFFER=" ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias

    printLBUFFER
    assert $LBUFFER same_as ' ls'
}

@test 'expand alias pwd="pwd -P"' {
    LBUFFER="pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='pwd -P'
    zpwrExpandAliasEscape

    printLBUFFER
    assert "$LBUFFER" same_as '\pwd -P'
}


@test 'expand alias pwd="pwd -P" keep space' {
    LBUFFER=" pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='pwd -P'
    zpwrExpandAliasEscape

    printLBUFFER
    assert "$LBUFFER" same_as ' \pwd -P'
}


@test 'expand alias curl' {
    LBUFFER="curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]="curl -fsSL"
    zpwrExpandAliasEscape

    printLBUFFER
    assert "$LBUFFER" same_as '\\curl -fsSL'
}
