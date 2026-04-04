#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandCorrectWord — early exits (env alone, galias, blacklist, command tail)
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

@test 'correct: env alone — tail empty, nothing to correct' {
    LBUFFER="env"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert "$LBUFFER" same_as 'env'
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correct: last word is global alias — skip correction entirely' {
    galiases[__ZGCORR_SKIP]='| less'
    LBUFFER="cat file __ZGCORR_SKIP"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert "$LBUFFER" same_as 'cat file __ZGCORR_SKIP'
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
    unset 'galiases[__ZGCORR_SKIP]'
}

@test 'correct: sudo git … — blacklist blocks correction after git (teh not fixed)' {
    LBUFFER="sudo git teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert "$LBUFFER" same_as 'sudo git teh'
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correct: single-word tail is a real command — skip (sudo pwd)' {
    LBUFFER="sudo pwd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert "$LBUFFER" same_as 'sudo pwd'
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}
