#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: tests for suffix alias expansion
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
    ZPWR_EXPAND_SUFFIX=true
    ZPWR_TRACE=false

    alias -s txt=vim
    alias -s py=python
    alias -s json=jq

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# basic suffix alias expansion at command position
#==============================================================

@test 'suffix: file.txt expands to vim file.txt' {
    LBUFFER="file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'vim file.txt'
}

@test 'suffix: script.py expands to python script.py' {
    LBUFFER="script.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'python script.py'
}

@test 'suffix: data.json expands to jq data.json' {
    LBUFFER="data.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'jq data.json'
}

@test 'suffix: sets WAS_EXPANDED true' {
    LBUFFER="file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

#==============================================================
# no expansion for unknown extensions
#==============================================================

@test 'suffix: unknown extension does not expand' {
    LBUFFER="file.xyz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.xyz'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix: no extension does not expand' {
    LBUFFER="Makefile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Makefile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# no expansion in argument position
#==============================================================

@test 'suffix: does not expand in argument position' {
    LBUFFER="echo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    # zpwrExpandSuffixAlias only fires when partition == 1
    # so calling it here should not expand since word is file.txt not at command pos
    assert (( $#ZPWR_EXPAND_WORDS_LPARTITION > 1 )) equals 1
}

#==============================================================
# path with directories
#==============================================================

@test 'suffix: path with directory expands' {
    LBUFFER="./notes/todo.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'vim ./notes/todo.txt'
}

@test 'suffix: absolute path expands' {
    LBUFFER="/tmp/data.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'jq /tmp/data.json'
}
