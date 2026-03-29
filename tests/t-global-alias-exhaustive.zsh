#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive global alias expansion tests
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
# zpwrExpandGlobalAliases: basic expansion patterns
#==============================================================

@test 'globalAlias: expands simple pipe alias' {
    galiases[__ZEXPTEST_G1]='| grep'
    LBUFFER="ls __ZEXPTEST_G1"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G1
    assert $LBUFFER same_as 'ls | grep'
    unset 'galiases[__ZEXPTEST_G1]'
}

@test 'globalAlias: expands pipe with flags' {
    galiases[__ZEXPTEST_G2]='| grep -i'
    LBUFFER="cat file __ZEXPTEST_G2"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G2
    assert $LBUFFER same_as 'cat file | grep -i'
    unset 'galiases[__ZEXPTEST_G2]'
}

@test 'globalAlias: expands redirect alias' {
    galiases[__ZEXPTEST_G3]='> /dev/null 2>&1'
    LBUFFER="make __ZEXPTEST_G3"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G3
    assert $LBUFFER same_as 'make > /dev/null 2>&1'
    unset 'galiases[__ZEXPTEST_G3]'
}

@test 'globalAlias: expands pipe to less' {
    galiases[__ZEXPTEST_G4]='| less'
    LBUFFER="dmesg __ZEXPTEST_G4"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G4
    assert $LBUFFER same_as 'dmesg | less'
    unset 'galiases[__ZEXPTEST_G4]'
}

@test 'globalAlias: expands pipe to head' {
    galiases[__ZEXPTEST_G5]='| head -20'
    LBUFFER="cat log __ZEXPTEST_G5"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G5
    assert $LBUFFER same_as 'cat log | head -20'
    unset 'galiases[__ZEXPTEST_G5]'
}

@test 'globalAlias: expands pipe to tail' {
    galiases[__ZEXPTEST_G6]='| tail -f'
    LBUFFER="cat log __ZEXPTEST_G6"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G6
    assert $LBUFFER same_as 'cat log | tail -f'
    unset 'galiases[__ZEXPTEST_G6]'
}

@test 'globalAlias: expands pipe to wc' {
    galiases[__ZEXPTEST_G7]='| wc -l'
    LBUFFER="find . __ZEXPTEST_G7"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G7
    assert $LBUFFER same_as 'find . | wc -l'
    unset 'galiases[__ZEXPTEST_G7]'
}

@test 'globalAlias: expands pipe to sort' {
    galiases[__ZEXPTEST_G8]='| sort -u'
    LBUFFER="cut -d: -f1 /etc/passwd __ZEXPTEST_G8"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G8
    assert $LBUFFER same_as 'cut -d: -f1 /etc/passwd | sort -u'
    unset 'galiases[__ZEXPTEST_G8]'
}

@test 'globalAlias: expands pipe to xargs' {
    galiases[__ZEXPTEST_G9]='| xargs rm'
    LBUFFER="find . -name *.tmp __ZEXPTEST_G9"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G9
    assert $LBUFFER same_as 'find . -name *.tmp | xargs rm'
    unset 'galiases[__ZEXPTEST_G9]'
}

@test 'globalAlias: expands tee alias' {
    galiases[__ZEXPTEST_G10]='| tee output.log'
    LBUFFER="make __ZEXPTEST_G10"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G10
    assert $LBUFFER same_as 'make | tee output.log'
    unset 'galiases[__ZEXPTEST_G10]'
}

#==============================================================
# zpwrExpandGlobalAliases: position sensitivity
#==============================================================

@test 'globalAlias: does not expand when not at end of buffer' {
    galiases[__ZEXPTEST_GP1]='| grep'
    LBUFFER="ls __ZEXPTEST_GP1 foo"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZEXPTEST_GP1 || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unset 'galiases[__ZEXPTEST_GP1]'
}

@test 'globalAlias: does not expand in middle of pipeline' {
    galiases[__ZEXPTEST_GP2]='| grep'
    LBUFFER="ls __ZEXPTEST_GP2 | wc -l"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZEXPTEST_GP2 || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unset 'galiases[__ZEXPTEST_GP2]'
}

@test 'globalAlias: expands at end after pipe' {
    galiases[__ZEXPTEST_GP3]='| less'
    LBUFFER="cat file | grep foo __ZEXPTEST_GP3"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GP3
    assert $LBUFFER same_as 'cat file | grep foo | less'
    unset 'galiases[__ZEXPTEST_GP3]'
}

@test 'globalAlias: expands at end after semicolon' {
    galiases[__ZEXPTEST_GP4]='| less'
    LBUFFER="ls; cat file __ZEXPTEST_GP4"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GP4
    assert $LBUFFER same_as 'ls; cat file | less'
    unset 'galiases[__ZEXPTEST_GP4]'
}

@test 'globalAlias: expands at end after &&' {
    galiases[__ZEXPTEST_GP5]='| less'
    LBUFFER="make && cat log __ZEXPTEST_GP5"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GP5
    assert $LBUFFER same_as 'make && cat log | less'
    unset 'galiases[__ZEXPTEST_GP5]'
}

#==============================================================
# zpwrExpandGlobalAliases: WAS_EXPANDED flag
#==============================================================

@test 'globalAlias: WAS_EXPANDED true on successful expand' {
    galiases[__ZEXPTEST_GW1]='| grep'
    LBUFFER="ls __ZEXPTEST_GW1"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZEXPTEST_GW1
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZEXPTEST_GW1]'
}

@test 'globalAlias: WAS_EXPANDED false when no match position' {
    galiases[__ZEXPTEST_GW2]='| grep'
    LBUFFER="ls __ZEXPTEST_GW2 extra"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZEXPTEST_GW2 || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unset 'galiases[__ZEXPTEST_GW2]'
}

#==============================================================
# zpwrExpandGlobalAliases: NEED_TO_ADD_SPACECHAR / tabstop
#==============================================================

@test 'globalAlias: NEED_TO_ADD_SPACECHAR true when no tabstop in expansion' {
    galiases[__ZEXPTEST_GT1]='| grep'
    LBUFFER="ls __ZEXPTEST_GT1"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GT1
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
    unset 'galiases[__ZEXPTEST_GT1]'
}

@test 'globalAlias: NEED_TO_ADD_SPACECHAR false when tabstop in expansion' {
    galiases[__ZEXPTEST_GT2]="| grep ${ZPWR_TABSTOP}"
    LBUFFER="ls __ZEXPTEST_GT2"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GT2
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
    unset 'galiases[__ZEXPTEST_GT2]'
}

#==============================================================
# zpwrExpandGlobalAliases: special characters in expansion
#==============================================================

@test 'globalAlias: expands to pipe chain' {
    galiases[__ZEXPTEST_GS1]='| grep -v | head -5'
    LBUFFER="cat log __ZEXPTEST_GS1"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GS1
    assert $LBUFFER same_as 'cat log | grep -v | head -5'
    unset 'galiases[__ZEXPTEST_GS1]'
}

@test 'globalAlias: expands to redirect with append' {
    galiases[__ZEXPTEST_GS2]='>> output.log'
    LBUFFER="echo hello __ZEXPTEST_GS2"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GS2
    assert $LBUFFER same_as 'echo hello >> output.log'
    unset 'galiases[__ZEXPTEST_GS2]'
}

@test 'globalAlias: expands to stderr redirect' {
    galiases[__ZEXPTEST_GS3]='2>/dev/null'
    LBUFFER="cmd __ZEXPTEST_GS3"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GS3
    assert $LBUFFER same_as 'cmd 2>/dev/null'
    unset 'galiases[__ZEXPTEST_GS3]'
}

@test 'globalAlias: expands to combined redirect' {
    galiases[__ZEXPTEST_GS4]='&>/dev/null'
    LBUFFER="cmd __ZEXPTEST_GS4"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GS4
    assert $LBUFFER same_as 'cmd &>/dev/null'
    unset 'galiases[__ZEXPTEST_GS4]'
}

@test 'globalAlias: expands pipe to awk' {
    galiases[__ZEXPTEST_GS5]="| awk '{print \$1}'"
    LBUFFER="ls -l __ZEXPTEST_GS5"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GS5
    assert $LBUFFER same_as "ls -l | awk '{print \$1}'"
    unset 'galiases[__ZEXPTEST_GS5]'
}

#==============================================================
# zpwrExpandGlobalAliases: various preceding contexts
#==============================================================

@test 'globalAlias: expands after simple command' {
    galiases[__ZEXPTEST_GC1]='| less'
    LBUFFER="cat __ZEXPTEST_GC1"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GC1
    assert $LBUFFER same_as 'cat | less'
    unset 'galiases[__ZEXPTEST_GC1]'
}

@test 'globalAlias: expands after command with args' {
    galiases[__ZEXPTEST_GC2]='| less'
    LBUFFER="grep -rn pattern dir __ZEXPTEST_GC2"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GC2
    assert $LBUFFER same_as 'grep -rn pattern dir | less'
    unset 'galiases[__ZEXPTEST_GC2]'
}

@test 'globalAlias: expands after sudo command' {
    galiases[__ZEXPTEST_GC3]='| grep error'
    LBUFFER="sudo dmesg __ZEXPTEST_GC3"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GC3
    assert $LBUFFER same_as 'sudo dmesg | grep error'
    unset 'galiases[__ZEXPTEST_GC3]'
}

@test 'globalAlias: expands after redirection' {
    galiases[__ZEXPTEST_GC4]='| wc -l'
    LBUFFER="cat < input.txt __ZEXPTEST_GC4"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GC4
    assert $LBUFFER same_as 'cat < input.txt | wc -l'
    unset 'galiases[__ZEXPTEST_GC4]'
}

@test 'globalAlias: expands after command with equals' {
    galiases[__ZEXPTEST_GC5]='| head'
    LBUFFER="grep --color=auto pattern __ZEXPTEST_GC5"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GC5
    assert $LBUFFER same_as 'grep --color=auto pattern | head'
    unset 'galiases[__ZEXPTEST_GC5]'
}

#==============================================================
# zpwrExpandGlobalAliases: lastword_lbuffer set correctly
#==============================================================

@test 'globalAlias: lastword_lbuffer set to alias name' {
    galiases[__ZEXPTEST_GL1]='| head'
    LBUFFER="cat file __ZEXPTEST_GL1"
    zpwrExpandGlobalAliases __ZEXPTEST_GL1
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZEXPTEST_GL1'
    unset 'galiases[__ZEXPTEST_GL1]'
}

@test 'globalAlias: lastword_lbuffer set even on no-match' {
    galiases[__ZEXPTEST_GL2]='| head'
    LBUFFER="cat file __ZEXPTEST_GL2 extra"
    zpwrExpandGlobalAliases __ZEXPTEST_GL2 || :
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZEXPTEST_GL2'
    unset 'galiases[__ZEXPTEST_GL2]'
}

#==============================================================
# zpwrExpandGlobalAliases: with leading spaces
#==============================================================

@test 'globalAlias: expands with one leading space' {
    galiases[__ZEXPTEST_GLS1]='| grep'
    LBUFFER=" ls __ZEXPTEST_GLS1"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GLS1
    assert $LBUFFER same_as ' ls | grep'
    unset 'galiases[__ZEXPTEST_GLS1]'
}

@test 'globalAlias: expands with two leading spaces' {
    galiases[__ZEXPTEST_GLS2]='| grep'
    LBUFFER="  ls __ZEXPTEST_GLS2"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GLS2
    assert $LBUFFER same_as '  ls | grep'
    unset 'galiases[__ZEXPTEST_GLS2]'
}

@test 'globalAlias: expands single word preceded by global alias' {
    galiases[__ZEXPTEST_GLS3]='| less -R'
    LBUFFER="__ZEXPTEST_GLS3"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_GLS3
    assert $LBUFFER same_as '| less -R'
    unset 'galiases[__ZEXPTEST_GLS3]'
}
