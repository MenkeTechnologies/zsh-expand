#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandGetAliasValue
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
# zpwrExpandGetAliasValue: basic retrieval
#==============================================================

@test 'getAliasValue: simple one-word alias' {
    alias __zexptest_gav1='ls'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav1
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls'
    unalias __zexptest_gav1
}

@test 'getAliasValue: two-word alias' {
    alias __zexptest_gav2='git status'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav2
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git status'
    unalias __zexptest_gav2
}

@test 'getAliasValue: alias with flags' {
    alias __zexptest_gav3='ls -la --color=auto'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav3
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -la --color=auto'
    unalias __zexptest_gav3
}

@test 'getAliasValue: alias with path' {
    alias __zexptest_gav4='cd ~/projects'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav4
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd ~/projects'
    unalias __zexptest_gav4
}

@test 'getAliasValue: alias with tilde' {
    alias __zexptest_gav5='cd ~'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav5
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd ~'
    unalias __zexptest_gav5
}

@test 'getAliasValue: alias with pipe' {
    alias __zexptest_gav6='ls -la | head'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav6
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -la | head'
    unalias __zexptest_gav6
}

@test 'getAliasValue: alias with semicolon' {
    alias __zexptest_gav7='echo hello; echo world'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav7
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo hello; echo world'
    unalias __zexptest_gav7
}

@test 'getAliasValue: alias with ampersand' {
    alias __zexptest_gav8='make && echo done'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav8
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'make && echo done'
    unalias __zexptest_gav8
}

@test 'getAliasValue: alias with redirect' {
    alias __zexptest_gav9='echo hello > /dev/null'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav9
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo hello > /dev/null'
    unalias __zexptest_gav9
}

@test 'getAliasValue: alias with single quotes in value' {
    alias __zexptest_gav10='echo hello world'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav10
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo hello world'
    unalias __zexptest_gav10
}

@test 'getAliasValue: alias with multiple flags' {
    alias __zexptest_gav11='grep -rn --include=*.py --color=auto'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav11
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'grep -rn --include=*.py --color=auto'
    unalias __zexptest_gav11
}

@test 'getAliasValue: alias expanding to path with dots' {
    alias __zexptest_gav12='cd ../..'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav12
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd ../..'
    unalias __zexptest_gav12
}

@test 'getAliasValue: alias with env var assignment' {
    alias __zexptest_gav13='LANG=C sort'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav13
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'LANG=C sort'
    unalias __zexptest_gav13
}

@test 'getAliasValue: alias with backslash' {
    alias __zexptest_gav14='\ls'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav14
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as '\ls'
    unalias __zexptest_gav14
}

@test 'getAliasValue: alias to long pipeline' {
    alias __zexptest_gav15='ps aux | grep -v grep | head -20'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav15
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ps aux | grep -v grep | head -20'
    unalias __zexptest_gav15
}

@test 'getAliasValue: alias with glob in value' {
    alias __zexptest_gav16='ls *.txt'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gav16
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls *.txt'
    unalias __zexptest_gav16
}

@test 'getAliasValue: single char alias' {
    alias __zexptest_g='git'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_g
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git'
    unalias __zexptest_g
}

@test 'getAliasValue: alias with hyphen in name' {
    alias __zexptest-ls='ls -la'
    ZPWR_VARS[lastword_lbuffer]=__zexptest-ls
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -la'
    unalias __zexptest-ls
}

@test 'getAliasValue: alias with underscore in name' {
    alias __zexptest_under_score='git log'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_under_score
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git log'
    unalias __zexptest_under_score
}

@test 'getAliasValue: alias with dot in name' {
    alias __zexptest.dot='git log'
    ZPWR_VARS[lastword_lbuffer]=__zexptest.dot
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git log'
    unalias __zexptest.dot
}
