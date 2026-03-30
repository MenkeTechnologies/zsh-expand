#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandRightTrim
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
# single trailing space removal
#==============================================================

@test 'rightTrim: removes trailing space from single word' {
    LBUFFER="ls "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls'
}

@test 'rightTrim: removes trailing space from two words' {
    LBUFFER="git status "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git status'
}

@test 'rightTrim: removes trailing space from three words' {
    LBUFFER="git commit -m "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git commit -m'
}

@test 'rightTrim: removes trailing space from path' {
    LBUFFER="/usr/bin/ls "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '/usr/bin/ls'
}

@test 'rightTrim: removes trailing space from word with hyphen' {
    LBUFFER="git-flow "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git-flow'
}

@test 'rightTrim: removes trailing space from word with equals' {
    LBUFFER="--color=auto "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '--color=auto'
}

@test 'rightTrim: removes trailing space from word with dot' {
    LBUFFER="file.txt "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'file.txt'
}

@test 'rightTrim: removes trailing space from tilde path' {
    LBUFFER="~/projects "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '~/projects'
}

#==============================================================
# no change when no trailing space
#==============================================================

@test 'rightTrim: no change for word without space' {
    LBUFFER="ls"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls'
}

@test 'rightTrim: no change for path without space' {
    LBUFFER="/usr/bin/ls"
    zpwrExpandRightTrim
    assert $LBUFFER same_as '/usr/bin/ls'
}

@test 'rightTrim: no change for multi-word without space' {
    LBUFFER="git status"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git status'
}

@test 'rightTrim: no change for flag without space' {
    LBUFFER="-la"
    zpwrExpandRightTrim
    assert $LBUFFER same_as '-la'
}

#==============================================================
# no change with multiple trailing spaces
#==============================================================

@test 'rightTrim: no change for double trailing space' {
    LBUFFER="ls  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls  '
}

@test 'rightTrim: no change for triple trailing space' {
    LBUFFER="ls   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls   '
}

@test 'rightTrim: no change for quad trailing space' {
    LBUFFER="ls    "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls    '
}

#==============================================================
# empty and whitespace buffers
#==============================================================

@test 'rightTrim: empty buffer unchanged' {
    LBUFFER=""
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'rightTrim: single space trimmed to empty' {
    LBUFFER=" "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'rightTrim: double space unchanged' {
    LBUFFER="  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '  '
}

@test 'rightTrim: tab not treated as space' {
    LBUFFER="ls	"
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as "ls	"
}

#==============================================================
# special characters before trailing space
#==============================================================

@test 'rightTrim: removes space after pipe' {
    LBUFFER="| "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '|'
}

@test 'rightTrim: removes space after semicolon' {
    LBUFFER="; "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ';'
}

@test 'rightTrim: removes space after ampersand' {
    LBUFFER="& "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '&'
}

@test 'rightTrim: removes space after closing paren' {
    LBUFFER=") "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ')'
}

@test 'rightTrim: removes space after closing bracket' {
    LBUFFER="] "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ']'
}

@test 'rightTrim: removes space after closing brace' {
    LBUFFER="} "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '}'
}

@test 'rightTrim: removes space after number' {
    LBUFFER="42 "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '42'
}

@test 'rightTrim: removes space after asterisk' {
    LBUFFER="*.txt "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '*.txt'
}

#==============================================================
# preserves internal spaces
#==============================================================

@test 'rightTrim: preserves internal space with trailing space' {
    LBUFFER="git commit "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git commit'
}

@test 'rightTrim: preserves multiple internal spaces with trailing' {
    LBUFFER="echo hello world "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'echo hello world'
}

@test 'rightTrim: preserves leading space with trailing space' {
    LBUFFER=" ls "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ' ls'
}

@test 'rightTrim: preserves two leading spaces with trailing space' {
    LBUFFER="  ls "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '  ls'
}
