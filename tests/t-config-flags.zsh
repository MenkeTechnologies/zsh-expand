#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: tests for configuration flag interactions
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

#==============================================================
# ZPWR_CORRECT=true/false via zpwrExpandCorrectWord
#==============================================================

@test 'config: ZPWR_CORRECT=true corrects misspelling' {
    ZPWR_CORRECT=true
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'config: ZPWR_CORRECT no correction for valid word' {
    ZPWR_CORRECT=true
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
    assert $LBUFFER same_as 'echo hello'
}

#==============================================================
# ZPWR_EXPAND_SECOND_POSITION via zpwrExpandLastWordAtCommandPosAndExpand
#==============================================================

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after sudo' {
    alias __zexptest_sp1='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="sudo __zexptest_sp1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo git status'
    unalias __zexptest_sp1
}

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after env' {
    alias __zexptest_sp3='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="env __zexptest_sp3"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'env git status'
    unalias __zexptest_sp3
}

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after nice' {
    alias __zexptest_sp5='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="nice __zexptest_sp5"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'nice ls -la'
    unalias __zexptest_sp5
}

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after nohup' {
    alias __zexptest_sp6='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="nohup __zexptest_sp6"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'nohup ls -la'
    unalias __zexptest_sp6
}

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after time' {
    alias __zexptest_sp7='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="time __zexptest_sp7"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'time ls -la'
    unalias __zexptest_sp7
}

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after rlwrap' {
    alias __zexptest_sp8='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="rlwrap __zexptest_sp8"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'rlwrap ls -la'
    unalias __zexptest_sp8
}

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after sudo -u root' {
    alias __zexptest_sp9='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="sudo -u root __zexptest_sp9"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo -u root ls -la'
    unalias __zexptest_sp9
}

@test 'config: ZPWR_EXPAND_SECOND_POSITION=true expands after sudo -E' {
    alias __zexptest_sp10='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="sudo -E __zexptest_sp10"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo -E ls -la'
    unalias __zexptest_sp10
}

#==============================================================
# ZPWR_EXPAND_BLACKLIST via direct function calls
#==============================================================

@test 'config: blacklisted alias not expanded' {
    alias __zexptest_bl1='git status'
    ZPWR_EXPAND_BLACKLIST=(__zexptest_bl1)
    ZPWR_VARS[blacklistUser]="^(${(j:|:)ZPWR_EXPAND_BLACKLIST})$"
    LBUFFER="__zexptest_bl1"
    zpwrExpandParseWords "$LBUFFER"
    # blacklist check: should match
    local should_skip=false
    if [[ -n $ZPWR_VARS[blacklistUser] ]] && [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        should_skip=true
    fi
    assert $should_skip same_as 'true'
    ZPWR_EXPAND_BLACKLIST=()
    ZPWR_VARS[blacklistUser]=""
    unalias __zexptest_bl1
}

@test 'config: non-blacklisted alias not matched by blacklist' {
    alias __zexptest_bl2='git status'
    alias __zexptest_bl3='ls -la'
    ZPWR_EXPAND_BLACKLIST=(__zexptest_bl2)
    ZPWR_VARS[blacklistUser]="^(${(j:|:)ZPWR_EXPAND_BLACKLIST})$"
    LBUFFER="__zexptest_bl3"
    zpwrExpandParseWords "$LBUFFER"
    local should_skip=false
    if [[ -n $ZPWR_VARS[blacklistUser] ]] && [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        should_skip=true
    fi
    assert $should_skip same_as 'false'
    ZPWR_EXPAND_BLACKLIST=()
    ZPWR_VARS[blacklistUser]=""
    unalias __zexptest_bl2
    unalias __zexptest_bl3
}

@test 'config: multiple aliases in blacklist first blocked' {
    alias __zexptest_bl4='git status'
    alias __zexptest_bl5='ls -la'
    ZPWR_EXPAND_BLACKLIST=(__zexptest_bl4 __zexptest_bl5)
    ZPWR_VARS[blacklistUser]="^(${(j:|:)ZPWR_EXPAND_BLACKLIST})$"
    LBUFFER="__zexptest_bl4"
    zpwrExpandParseWords "$LBUFFER"
    local should_skip=false
    if [[ -n $ZPWR_VARS[blacklistUser] ]] && [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        should_skip=true
    fi
    assert $should_skip same_as 'true'
    ZPWR_EXPAND_BLACKLIST=()
    ZPWR_VARS[blacklistUser]=""
    unalias __zexptest_bl4
    unalias __zexptest_bl5
}

@test 'config: multiple aliases in blacklist second blocked' {
    alias __zexptest_bl6='git status'
    alias __zexptest_bl7='ls -la'
    ZPWR_EXPAND_BLACKLIST=(__zexptest_bl6 __zexptest_bl7)
    ZPWR_VARS[blacklistUser]="^(${(j:|:)ZPWR_EXPAND_BLACKLIST})$"
    LBUFFER="__zexptest_bl7"
    zpwrExpandParseWords "$LBUFFER"
    local should_skip=false
    if [[ -n $ZPWR_VARS[blacklistUser] ]] && [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        should_skip=true
    fi
    assert $should_skip same_as 'true'
    ZPWR_EXPAND_BLACKLIST=()
    ZPWR_VARS[blacklistUser]=""
    unalias __zexptest_bl6
    unalias __zexptest_bl7
}

@test 'config: empty blacklist does not block' {
    alias __zexptest_bl8='git status'
    ZPWR_EXPAND_BLACKLIST=()
    ZPWR_VARS[blacklistUser]=""
    LBUFFER="__zexptest_bl8"
    zpwrExpandParseWords "$LBUFFER"
    local should_skip=false
    if [[ -n $ZPWR_VARS[blacklistUser] ]] && [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        should_skip=true
    fi
    assert $should_skip same_as 'false'
    unalias __zexptest_bl8
}

#==============================================================
# ZPWR_EXPAND_QUOTE_DOUBLE
#==============================================================

@test 'config: ZPWR_EXPAND_QUOTE_DOUBLE=true strips double quotes in parseWords' {
    ZPWR_EXPAND_QUOTE_DOUBLE=true
    zpwrExpandParseWords '"git"'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
    ZPWR_EXPAND_QUOTE_DOUBLE=true
}

@test 'config: ZPWR_EXPAND_QUOTE_DOUBLE=false preserves double quotes in parseWords' {
    ZPWR_EXPAND_QUOTE_DOUBLE=false
    zpwrExpandParseWords '"git"'
    assert $ZPWR_VARS[lastword_lbuffer] same_as '"git"'
    ZPWR_EXPAND_QUOTE_DOUBLE=true
}

@test 'config: ZPWR_EXPAND_QUOTE_DOUBLE=true allows alias in double quoted context' {
    alias __zexptest_qd1='git status'
    ZPWR_EXPAND_QUOTE_DOUBLE=true
    LBUFFER='echo "__zexptest_qd1'
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'echo "git status'
    unalias __zexptest_qd1
}

#==============================================================
# ZPWR_EXPAND_QUOTE_SINGLE
#==============================================================

@test 'config: ZPWR_EXPAND_QUOTE_SINGLE=true strips single quotes in parseWords' {
    ZPWR_EXPAND_QUOTE_SINGLE=true
    zpwrExpandParseWords "'git'"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
    ZPWR_EXPAND_QUOTE_SINGLE=true
}

@test 'config: ZPWR_EXPAND_QUOTE_SINGLE=false preserves single quotes in parseWords' {
    ZPWR_EXPAND_QUOTE_SINGLE=false
    zpwrExpandParseWords "'git'"
    assert $ZPWR_VARS[lastword_lbuffer] same_as "'git'"
    ZPWR_EXPAND_QUOTE_SINGLE=true
}

@test 'config: ZPWR_EXPAND_QUOTE_DOUBLE=true multi-word' {
    ZPWR_EXPAND_QUOTE_DOUBLE=true
    zpwrExpandParseWords 'sudo "git"'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'config: ZPWR_EXPAND_QUOTE_SINGLE=true multi-word' {
    ZPWR_EXPAND_QUOTE_SINGLE=true
    zpwrExpandParseWords "sudo 'git'"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

#==============================================================
# blacklistSubcommandPositionRegex
#==============================================================

@test 'config: git matches blacklistSubcommandPositionRegex' {
    local word=git
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: docker matches blacklistSubcommandPositionRegex' {
    local word=docker
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: npm matches blacklistSubcommandPositionRegex' {
    local word=npm
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: brew matches blacklistSubcommandPositionRegex' {
    local word=brew
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: kubectl matches blacklistSubcommandPositionRegex' {
    local word=kubectl
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: yarn matches blacklistSubcommandPositionRegex' {
    local word=yarn
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: go matches blacklistSubcommandPositionRegex' {
    local word=go
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: cargo matches blacklistSubcommandPositionRegex' {
    local word=cargo
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: zinit matches blacklistSubcommandPositionRegex' {
    local word=zinit
    [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]
    assert $state equals 0
}

@test 'config: random word does not match blacklistSubcommandPositionRegex' {
    local word=somecmd
    local matched=false
    if [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]; then
        matched=true
    fi
    assert $matched same_as 'false'
}

@test 'config: ls does not match blacklistSubcommandPositionRegex' {
    local word=ls
    local matched=false
    if [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]; then
        matched=true
    fi
    assert $matched same_as 'false'
}
