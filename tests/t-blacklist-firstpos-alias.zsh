#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: ZPWR_VARS[blacklistFirstPosRegex] — alias *values* that skip regular alias expansion
##### (see zpwrExpandSupernaturalSpace: expand only if alias value does NOT match)
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

#==============================================================
# Values that MUST match (first token is a blocked prefix)
#==============================================================

@test 'blacklistFirstPos: cd dir matches' {
    [[ 'cd /tmp/foo' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

@test 'blacklistFirstPos: podman run matches' {
    [[ 'podman run -it alpine' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

@test 'blacklistFirstPos: hub clone matches' {
    [[ 'hub clone repo' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

@test 'blacklistFirstPos: rlwrap with space after word matches' {
    [[ 'rlwrap -a foo bar' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

@test 'blacklistFirstPos: noglob with trailing space matches' {
    [[ 'noglob rm -rf /tmp/x' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

@test 'blacklistFirstPos: grc tail matches' {
    [[ 'grc tail -f /var/log/syslog' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

#==============================================================
# Values that must NOT match — normal alias expansion allowed
#==============================================================

@test 'blacklistFirstPos: plain ls does not match' {
    [[ ! 'ls -la' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

@test 'blacklistFirstPos: git status does not match' {
    [[ ! 'git status -sb' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

@test 'blacklistFirstPos: echo hello does not match' {
    [[ ! 'echo hello' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}

#==============================================================
# Edge: rlwrap token requires following space in the regex
#==============================================================

@test 'blacklistFirstPos: rlwrap alone does not match (no space after rlwrap)' {
    [[ ! 'rlwrap' =~ $ZPWR_VARS[blacklistFirstPosRegex] ]]
    assert $? equals 0
}
