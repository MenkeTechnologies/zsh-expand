#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandGoToTabStopOrEndOfLBuffer
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
    ZPWR_TRACE=false

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# no tabstop scenarios
#==============================================================

@test 'tabstop: no tabstop empty LBUFFER NEED_TO_ADD_SPACECHAR true' {
    LBUFFER=""
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'tabstop: no tabstop single word NEED_TO_ADD_SPACECHAR true' {
    LBUFFER="git"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'tabstop: no tabstop multi word NEED_TO_ADD_SPACECHAR true' {
    LBUFFER="git commit -m msg"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'tabstop: no tabstop RBUFFER not changed' {
    LBUFFER="git commit"
    RBUFFER="right side"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as 'right side'
}

@test 'tabstop: no tabstop with special chars NEED_TO_ADD_SPACECHAR true' {
    LBUFFER="echo hello | grep"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'tabstop: no tabstop with path NEED_TO_ADD_SPACECHAR true' {
    LBUFFER="cat /etc/hosts"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

#==============================================================
# tabstop in LBUFFER
#==============================================================

@test 'tabstop: tabstop at end of LBUFFER NEED_TO_ADD_SPACECHAR false' {
    LBUFFER="git commit -m ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'tabstop: tabstop in middle of LBUFFER NEED_TO_ADD_SPACECHAR false' {
    LBUFFER="git ${ZPWR_TABSTOP} commit"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'tabstop: tabstop at start of LBUFFER NEED_TO_ADD_SPACECHAR false' {
    LBUFFER="${ZPWR_TABSTOP}git commit"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'tabstop: CURSOR set to tabstop position' {
    LBUFFER="cmd ${ZPWR_TABSTOP}rest"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $CURSOR equals 4
}

@test 'tabstop: CURSOR set to 0 when tabstop at start' {
    LBUFFER="${ZPWR_TABSTOP}cmd rest"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $CURSOR equals 0
}

#==============================================================
# tabstop in RBUFFER interaction
#==============================================================

@test 'tabstop: RBUFFER tabstop prefix stripped when LBUFFER has tabstop' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER="${ZPWR_TABSTOP}extra"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as 'extra'
}

@test 'tabstop: RBUFFER not modified when no tabstop in LBUFFER' {
    LBUFFER="cmd rest"
    RBUFFER="${ZPWR_TABSTOP}extra"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as "${ZPWR_TABSTOP}extra"
}

@test 'tabstop: RBUFFER empty after stripping when only tabstop' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER="${ZPWR_TABSTOP}"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as ''
}

@test 'tabstop: RBUFFER starts from after tabstop content when LBUFFER has tabstop' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER="no tabstop here"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    # when LBUFFER has tabstop, CURSOR moves and RBUFFER is set from tabstop length onward
    assert $RBUFFER same_as ' here'
}

#==============================================================
# multiple tabstops
#==============================================================

@test 'tabstop: first tabstop found with two in LBUFFER' {
    LBUFFER="cmd ${ZPWR_TABSTOP} arg ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $CURSOR equals 4
}

@test 'tabstop: NEED_TO_ADD_SPACECHAR false with multiple tabstops' {
    LBUFFER="cmd ${ZPWR_TABSTOP} arg ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

#==============================================================
# edge cases
#==============================================================

@test 'tabstop: only tabstop in LBUFFER' {
    LBUFFER="${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'tabstop: tabstop followed by space' {
    LBUFFER="cmd ${ZPWR_TABSTOP} "
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'tabstop: text that looks like tabstop but is not' {
    LBUFFER="cmd _________"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}
