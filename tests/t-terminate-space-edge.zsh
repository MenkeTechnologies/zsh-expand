#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandTerminateSpace
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
# basic space appending
#==============================================================

@test 'terminateSpace: appends space to single word' {
    LBUFFER="git"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git '
}

@test 'terminateSpace: appends space to empty buffer' {
    LBUFFER=""
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as ' '
}

@test 'terminateSpace: appends space to multi-word' {
    LBUFFER="git commit -m"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git commit -m '
}

@test 'terminateSpace: appends space when already has space' {
    LBUFFER="git "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git  '
}

@test 'terminateSpace: double space becomes triple' {
    LBUFFER="git  "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git   '
}

#==============================================================
# special characters
#==============================================================

@test 'terminateSpace: appends to pipe' {
    LBUFFER="ls |"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ls | '
}

@test 'terminateSpace: appends to semicolon' {
    LBUFFER="ls;"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ls; '
}

@test 'terminateSpace: appends to &&' {
    LBUFFER="make &&"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'make && '
}

@test 'terminateSpace: appends to path' {
    LBUFFER="/usr/bin/ls"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '/usr/bin/ls '
}

@test 'terminateSpace: appends to tilde path' {
    LBUFFER="~/projects"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '~/projects '
}

@test 'terminateSpace: appends to flag' {
    LBUFFER="-la"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '-la '
}

@test 'terminateSpace: appends to long flag' {
    LBUFFER="--color=auto"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '--color=auto '
}

@test 'terminateSpace: appends to glob' {
    LBUFFER="*.txt"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '*.txt '
}

@test 'terminateSpace: appends to redirect' {
    LBUFFER="echo > /dev/null"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'echo > /dev/null '
}

@test 'terminateSpace: appends to closing paren' {
    LBUFFER="echo (foo)"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'echo (foo) '
}

@test 'terminateSpace: appends to closing bracket' {
    LBUFFER="arr[0]"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'arr[0] '
}

@test 'terminateSpace: appends to number' {
    LBUFFER="echo 42"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'echo 42 '
}

#==============================================================
# leading spaces preserved
#==============================================================

@test 'terminateSpace: preserves leading space' {
    LBUFFER=" git"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as ' git '
}

@test 'terminateSpace: preserves two leading spaces' {
    LBUFFER="  git"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '  git '
}

@test 'terminateSpace: preserves leading spaces with multi-word' {
    LBUFFER="  git commit"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '  git commit '
}

#==============================================================
# long buffers
#==============================================================

@test 'terminateSpace: appends to long command' {
    LBUFFER="find . -name *.log -exec grep -l error {} +"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'find . -name *.log -exec grep -l error {} + '
}

@test 'terminateSpace: appends to pipeline' {
    LBUFFER="cat file | grep pattern | sort -u | head"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cat file | grep pattern | sort -u | head '
}

@test 'terminateSpace: single char' {
    LBUFFER="a"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'a '
}

@test 'terminateSpace: single special char' {
    LBUFFER="|"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '| '
}

@test 'terminateSpace: only spaces' {
    LBUFFER="   "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '    '
}
