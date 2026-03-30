#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive zpwrExpandAliasEscape edge case tests
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
# zpwrExpandAliasEscape: various self-referential patterns
#==============================================================

@test 'aliasEscape: ls to ls -la escapes' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ls -la'
}

@test 'aliasEscape: grep to grep --color escapes' {
    LBUFFER="grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\grep --color=auto'
}

@test 'aliasEscape: diff to diff --color escapes' {
    LBUFFER="diff"
    ZPWR_VARS[lastword_lbuffer]=diff
    ZPWR_VARS[EXPANDED]='diff --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\diff --color=auto'
}

@test 'aliasEscape: cp to cp -i escapes' {
    LBUFFER="cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -i'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\cp -i'
}

@test 'aliasEscape: mv to mv -i escapes' {
    LBUFFER="mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\mv -i'
}

@test 'aliasEscape: rm to rm -i escapes' {
    LBUFFER="rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\rm -i'
}

@test 'aliasEscape: mkdir to mkdir -p escapes' {
    LBUFFER="mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\mkdir -p'
}

@test 'aliasEscape: cat to cat -n escapes' {
    LBUFFER="cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\cat -n'
}

@test 'aliasEscape: sed to sed -E escapes' {
    LBUFFER="sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\sed -E'
}

@test 'aliasEscape: awk to awk -F escapes' {
    LBUFFER="awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F:'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\awk -F:'
}

#==============================================================
# zpwrExpandAliasEscape: leading spaces preservation
#==============================================================

@test 'aliasEscape: zero leading spaces' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ls -la'
}

@test 'aliasEscape: one leading space' {
    LBUFFER=" ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as ' \ls -la'
}

@test 'aliasEscape: two leading spaces' {
    LBUFFER="  ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '  \ls -la'
}

@test 'aliasEscape: three leading spaces' {
    LBUFFER="   ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '   \ls -la'
}

@test 'aliasEscape: four leading spaces' {
    LBUFFER="    ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '    \ls -la'
}

@test 'aliasEscape: five leading spaces' {
    LBUFFER="     ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '     \ls -la'
}

#==============================================================
# zpwrExpandAliasEscape: after various preceding commands
#==============================================================

@test 'aliasEscape: after sudo' {
    LBUFFER="sudo ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'sudo \ls -la'
}

@test 'aliasEscape: after env' {
    LBUFFER="env ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'env \ls -la'
}

@test 'aliasEscape: after command prefix' {
    LBUFFER="command ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'command \ls -la'
}

@test 'aliasEscape: after builtin' {
    LBUFFER="builtin ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'builtin \ls -la'
}

@test 'aliasEscape: after noglob' {
    LBUFFER="noglob ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'noglob \ls -la'
}

@test 'aliasEscape: after pipe' {
    LBUFFER="echo | ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'echo | \ls -la'
}

@test 'aliasEscape: after semicolon' {
    LBUFFER="echo; ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'echo; \ls -la'
}

@test 'aliasEscape: after &&' {
    LBUFFER="echo && ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'echo && \ls -la'
}

@test 'aliasEscape: after ||' {
    LBUFFER="echo || ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'echo || \ls -la'
}

#==============================================================
# zpwrExpandAliasEscape: trailing space behavior
#==============================================================

@test 'aliasEscape: trailing space prevents escape' {
    LBUFFER="ls "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert "$LBUFFER" same_as 'ls '
}

@test 'aliasEscape: double trailing space prevents escape' {
    LBUFFER="ls  "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert "$LBUFFER" same_as 'ls  '
}

@test 'aliasEscape: WAS_EXPANDED false on trailing space' {
    LBUFFER="ls "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# zpwrExpandAliasEscape: WAS_EXPANDED flag
#==============================================================

@test 'aliasEscape: WAS_EXPANDED true on success' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'aliasEscape: WAS_EXPANDED true after sudo' {
    LBUFFER="sudo ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

#==============================================================
# zpwrExpandAliasEscape: multi-word expanded values
#==============================================================

@test 'aliasEscape: three-word expansion' {
    LBUFFER="grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep -rn --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\grep -rn --color=auto'
}

@test 'aliasEscape: expansion with pipe' {
    LBUFFER="top"
    ZPWR_VARS[lastword_lbuffer]=top
    ZPWR_VARS[EXPANDED]='top -l 1 | head'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\top -l 1 | head'
}

@test 'aliasEscape: expansion with tilde path' {
    LBUFFER="cd"
    ZPWR_VARS[lastword_lbuffer]=cd
    ZPWR_VARS[EXPANDED]='cd ~/projects'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\cd ~/projects'
}

@test 'aliasEscape: expansion with env var' {
    LBUFFER="echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo $HOME'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\echo $HOME'
}
