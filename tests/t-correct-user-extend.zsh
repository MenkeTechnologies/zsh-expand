#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: tests for user-extensible correction dictionary
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    # reset config to defaults so local env vars do not leak into tests
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

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# user can add new correction entries after plugin load
#==============================================================

@test 'user extend: custom single misspelling corrects' {
    ZPWR_EXPAND_CORRECT_WORDS[kubernetes]="k8ss"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo k8ss"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo kubernetes'
}

@test 'user extend: custom multiple misspellings correct first variant' {
    ZPWR_EXPAND_CORRECT_WORDS[terraform]="terrafrom terrafomr"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo terrafrom"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo terraform'
}

@test 'user extend: custom multiple misspellings correct second variant' {
    ZPWR_EXPAND_CORRECT_WORDS[terraform]="terrafrom terrafomr"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo terrafomr"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo terraform'
}

@test 'user extend: custom correction in first position single word' {
    ZPWR_EXPAND_CORRECT_WORDS[podman]="podmna"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="podmna"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'podman'
}

@test 'user extend: custom correction after sudo' {
    ZPWR_EXPAND_CORRECT_WORDS[podman]="podmna"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="sudo podmna"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sudo podman'
}

@test 'user extend: custom correction sets foundIncorrect true' {
    ZPWR_EXPAND_CORRECT_WORDS[kubernetes]="k8ss"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo k8ss"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'user extend: non-matching custom entry does not trigger' {
    ZPWR_EXPAND_CORRECT_WORDS[kubernetes]="k8ss"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo kubectl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# user can override existing built-in correction entries
#==============================================================

@test 'user extend: override built-in correction target' {
    # built-in has: ZPWR_EXPAND_CORRECT_WORDS[background]="bg"
    # user overrides to map bg -> backstage
    ZPWR_EXPAND_CORRECT_WORDS[backstage]="bg"
    unset 'ZPWR_EXPAND_CORRECT_WORDS[background]'
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo bg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo backstage'
}

@test 'user extend: add misspellings to existing built-in entry' {
    # built-in has: ZPWR_EXPAND_CORRECT_WORDS[echo]="ehco ecoh ..."
    # user appends a new misspelling
    ZPWR_EXPAND_CORRECT_WORDS[echo]+=" oech"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo oech"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo echo'
}

#==============================================================
# user can remove entries
#==============================================================

@test 'user extend: unset entry disables that correction' {
    unset 'ZPWR_EXPAND_CORRECT_WORDS[echo]'
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# user entry with underscores expands to spaces
#==============================================================

@test 'user extend: underscore in key becomes space in expansion' {
    ZPWR_EXPAND_CORRECT_WORDS[hello_world]="hworl"
    zpwrExpandRebuildCorrectReverse
    LBUFFER="echo hworl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo hello world'
}
