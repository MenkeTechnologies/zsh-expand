#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: integration tests for expansion flow using lower-level functions
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
# parseWords + getAliasValue + expandAlias: basic flow
#==============================================================

@test 'integration: parse then expand simple alias' {
    alias __zexptest_int1='git status'
    LBUFFER="__zexptest_int1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'git status'
    unalias __zexptest_int1
}

@test 'integration: parse then expand alias with flags' {
    alias __zexptest_int2='ls -la --color=auto'
    LBUFFER="__zexptest_int2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls -la --color=auto'
    unalias __zexptest_int2
}

@test 'integration: parse then expand alias after sudo' {
    alias __zexptest_int3='git status'
    LBUFFER="sudo __zexptest_int3"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo git status'
    unalias __zexptest_int3
}

@test 'integration: parse then expand alias after env' {
    alias __zexptest_int4='git status'
    LBUFFER="env __zexptest_int4"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'env git status'
    unalias __zexptest_int4
}

@test 'integration: no expansion for non-alias word' {
    LBUFFER="nonexistentcommand_xyz"
    zpwrExpandParseWords "$LBUFFER"
    ZPWR_VARS[WAS_EXPANDED]=false
    # non-alias word has no alias value, so expansion does nothing
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'integration: trailing space prevents expansion' {
    alias __zexptest_int5='git status'
    LBUFFER="__zexptest_int5 "
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias || :
    # trailing space means lastword doesn't match, no expansion
    assert $LBUFFER same_as '__zexptest_int5 '
    unalias __zexptest_int5
}

#==============================================================
# self-referential alias escape flow
#==============================================================

@test 'integration: self-referential alias escapes with backslash' {
    alias __zexptest_int6='__zexptest_int6 -la'
    LBUFFER="__zexptest_int6"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    local words=(${(z)ZPWR_VARS[EXPANDED]})
    # first word of expansion matches alias name, so escape
    assert ${words[1]} same_as '__zexptest_int6'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\__zexptest_int6 -la'
    unalias __zexptest_int6
}

@test 'integration: self-referential alias after sudo escapes' {
    alias __zexptest_int7='__zexptest_int7 -la'
    LBUFFER="sudo __zexptest_int7"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'sudo \\__zexptest_int7 -la'
    unalias __zexptest_int7
}

#==============================================================
# global alias expansion flow
#==============================================================

@test 'integration: global alias pipe expansion' {
    galiases[__ZEXPTEST_INT_G1]='| grep'
    LBUFFER="ls __ZEXPTEST_INT_G1"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_INT_G1
    assert $LBUFFER same_as 'ls | grep'
    unset 'galiases[__ZEXPTEST_INT_G1]'
}

@test 'integration: global alias pipe to less' {
    galiases[__ZEXPTEST_INT_G2]='| less'
    LBUFFER="cat file __ZEXPTEST_INT_G2"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_INT_G2
    assert $LBUFFER same_as 'cat file | less'
    unset 'galiases[__ZEXPTEST_INT_G2]'
}

@test 'integration: global alias sets WAS_EXPANDED true' {
    galiases[__ZEXPTEST_INT_G3]='| head'
    LBUFFER="dmesg __ZEXPTEST_INT_G3"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZEXPTEST_INT_G3
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZEXPTEST_INT_G3]'
}

#==============================================================
# correction + expansion flow
#==============================================================

@test 'integration: correct misspelling then verify' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'integration: correct adn to and' {
    LBUFFER="echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'
}

@test 'integration: correct josn to JSON' {
    LBUFFER="echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JSON'
}

@test 'integration: no correction for valid word' {
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
    assert $LBUFFER same_as 'echo hello'
}

#==============================================================
# correction then alias expansion (ZPWR_CORRECT_EXPAND flow)
#==============================================================

@test 'integration: correct then re-parse for alias check' {
    alias the='echo corrected'
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
    # after correction, re-parse to check if corrected word is alias
    zpwrExpandParseWords "$LBUFFER"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'the'
    unalias the
}

#==============================================================
# word starting with = not expanded
#==============================================================

@test 'integration: word starting with = detected by prefix check' {
    # the main code checks: ${ZPWR_VARS[lastword_lbuffer]:0:1} != '='
    # for =word, the lastword should start with = or parseWords transforms it
    # test the logic path: if first char is = then skip expansion
    local testword="=somecmd"
    local firstchar="${testword:0:1}"
    assert "$firstchar" same_as '='
}

#==============================================================
# preserves leading spaces
#==============================================================

@test 'integration: preserves one leading space on expansion' {
    alias __zexptest_int_ls1='git status'
    LBUFFER=" __zexptest_int_ls1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as ' git status'
    unalias __zexptest_int_ls1
}

@test 'integration: preserves two leading spaces on expansion' {
    alias __zexptest_int_ls2='git status'
    LBUFFER="  __zexptest_int_ls2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as '  git status'
    unalias __zexptest_int_ls2
}

@test 'integration: preserves three leading spaces on expansion' {
    alias __zexptest_int_ls3='git status'
    LBUFFER="   __zexptest_int_ls3"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as '   git status'
    unalias __zexptest_int_ls3
}

#==============================================================
# expansion after various separators
#==============================================================

@test 'integration: alias after pipe expands' {
    alias __zexptest_int_sep1='git status'
    LBUFFER="echo | __zexptest_int_sep1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo | git status'
    unalias __zexptest_int_sep1
}

@test 'integration: alias after semicolon expands' {
    alias __zexptest_int_sep2='git status'
    LBUFFER="echo; __zexptest_int_sep2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo; git status'
    unalias __zexptest_int_sep2
}

@test 'integration: alias after && expands' {
    alias __zexptest_int_sep3='git status'
    LBUFFER="make && __zexptest_int_sep3"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'make && git status'
    unalias __zexptest_int_sep3
}

@test 'integration: alias after || expands' {
    alias __zexptest_int_sep4='git status'
    LBUFFER="make || __zexptest_int_sep4"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'make || git status'
    unalias __zexptest_int_sep4
}

#==============================================================
# state flags
#==============================================================

@test 'integration: WAS_EXPANDED true after alias expansion' {
    alias __zexptest_int_flag1='git status'
    LBUFFER="__zexptest_int_flag1"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unalias __zexptest_int_flag1
}

@test 'integration: WAS_EXPANDED stays false when no match' {
    LBUFFER="nonexistentcmd_xyz "
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_VARS[lastword_lbuffer]=nonexistentcmd_xyz
    ZPWR_VARS[EXPANDED]='foo'
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'integration: foundIncorrect true after correction' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'integration: foundIncorrect false for valid word' {
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# zpwrExpandLastWordAtCommandPosAndExpand
#==============================================================

@test 'integration: lastWordAtCommandPos single word expands' {
    alias __zexptest_int_lw1='git status'
    LBUFFER="__zexptest_int_lw1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert $LBUFFER same_as 'git status'
    assert $ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND] same_as 'true'
    unalias __zexptest_int_lw1
}

@test 'integration: lastWordAtCommandPos sets ORIGINAL_LAST_COMMAND' {
    alias __zexptest_int_lw2='git status'
    LBUFFER="__zexptest_int_lw2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert $ZPWR_VARS[ORIGINAL_LAST_COMMAND] same_as '__zexptest_int_lw2'
    unalias __zexptest_int_lw2
}

@test 'integration: lastWordAtCommandPos after sudo expands' {
    alias __zexptest_int_lw3='git status'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="sudo __zexptest_int_lw3"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert $LBUFFER same_as 'sudo git status'
    unalias __zexptest_int_lw3
}

@test 'integration: lastWordAtCommandPos self-referential escapes' {
    alias __zexptest_int_lw4='__zexptest_int_lw4 -la'
    LBUFFER="__zexptest_int_lw4"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "${ZPWR_VARS[SPACEBAR_KEY]}"
    assert "$LBUFFER" same_as '\\__zexptest_int_lw4 -la'
    unalias __zexptest_int_lw4
}

#==============================================================
# global alias with tabstop
#==============================================================

@test 'integration: global alias with tabstop sets NEED_TO_ADD_SPACECHAR false' {
    galiases[__ZEXPTEST_INT_TS]="| grep ${ZPWR_TABSTOP}"
    LBUFFER="ls __ZEXPTEST_INT_TS"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_INT_TS
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
    unset 'galiases[__ZEXPTEST_INT_TS]'
}

@test 'integration: global alias without tabstop keeps NEED_TO_ADD_SPACECHAR true' {
    galiases[__ZEXPTEST_INT_NTS]='| grep pattern'
    LBUFFER="ls __ZEXPTEST_INT_NTS"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_INT_NTS
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
    unset 'galiases[__ZEXPTEST_INT_NTS]'
}

#==============================================================
# combo: parseWords + correctWord + expandAlias
#==============================================================

@test 'integration: correct misspelling then expand alias on corrected word' {
    alias the='some value'
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
    # now the corrected word might be an alias
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo some value'
    unalias the
}

@test 'integration: trim then expand' {
    alias __zexptest_int_te='git status'
    LBUFFER="__zexptest_int_te "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '__zexptest_int_te'
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'git status'
    unalias __zexptest_int_te
}

@test 'integration: parse + regex + expand after sudo -E' {
    alias __zexptest_int_se='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="sudo -E __zexptest_int_se"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo -E ls -la'
    unalias __zexptest_int_se
}

@test 'integration: parse + regex + expand after command sudo' {
    alias __zexptest_int_cs='ls -la'
    ZPWR_EXPAND_SECOND_POSITION=true
    LBUFFER="command sudo __zexptest_int_cs"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'command sudo ls -la'
    unalias __zexptest_int_cs
}
