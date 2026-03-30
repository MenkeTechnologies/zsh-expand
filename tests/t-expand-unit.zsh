#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: comprehensive unit tests for zsh-expand
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
# zpwrExpandAlias
#==============================================================

@test 'zpwrExpandAlias: basic expansion' {
    LBUFFER="pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls'
}

@test 'zpwrExpandAlias: no expand trailing space' {
    LBUFFER="pwd "
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias || :
    assert $LBUFFER same_as 'pwd '
}

@test 'zpwrExpandAlias: no expand word mismatch' {
    LBUFFER="sudo pwd "
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias || :
    assert $LBUFFER same_as 'sudo pwd '
}

@test 'zpwrExpandAlias: keep single leading space' {
    LBUFFER=" ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert $LBUFFER same_as ' ls -la'
}

@test 'zpwrExpandAlias: keep two leading spaces' {
    LBUFFER="  git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git log'
    zpwrExpandAlias
    assert $LBUFFER same_as '  git log'
}

@test 'zpwrExpandAlias: multi-word alias value' {
    LBUFFER="ll"
    ZPWR_VARS[lastword_lbuffer]=ll
    ZPWR_VARS[EXPANDED]='ls -la --color=auto'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls -la --color=auto'
}

@test 'zpwrExpandAlias: WAS_EXPANDED true on success' {
    LBUFFER="pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'zpwrExpandAlias: WAS_EXPANDED stays false when not expanded' {
    LBUFFER="pwd "
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'zpwrExpandAlias: word after semicolon expands' {
    LBUFFER="ls; pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls; ls'
}

@test 'zpwrExpandAlias: expands to path with tilde' {
    LBUFFER="cdp"
    ZPWR_VARS[lastword_lbuffer]=cdp
    ZPWR_VARS[EXPANDED]='cd ~/Projects'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ~/Projects'
}

@test 'zpwrExpandAlias: expands alias with flags' {
    LBUFFER="la"
    ZPWR_VARS[lastword_lbuffer]=la
    ZPWR_VARS[EXPANDED]='ls -A'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls -A'
}

@test 'zpwrExpandAlias: only replaces last word not middle occurrence' {
    LBUFFER="pwd; echo pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias
    assert $LBUFFER same_as 'pwd; echo ls'
}

#==============================================================
# zpwrExpandAliasEscape
#==============================================================

@test 'zpwrExpandAliasEscape: basic self-referential alias' {
    LBUFFER="pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='pwd -P'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\pwd -P'
}

@test 'zpwrExpandAliasEscape: keep leading space' {
    LBUFFER=" pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='pwd -P'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as ' \pwd -P'
}

@test 'zpwrExpandAliasEscape: curl' {
    LBUFFER="curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]="curl -fsSL"
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\curl -fsSL'
}

@test 'zpwrExpandAliasEscape: WAS_EXPANDED true on success' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'zpwrExpandAliasEscape: no expand trailing space' {
    LBUFFER="ls "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert "$LBUFFER" same_as 'ls '
}

@test 'zpwrExpandAliasEscape: WAS_EXPANDED stays false when not expanded' {
    LBUFFER="ls "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'zpwrExpandAliasEscape: preceding word preserved' {
    LBUFFER="sudo ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'sudo \ls -la'
}

@test 'zpwrExpandAliasEscape: two leading spaces' {
    LBUFFER="  ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '  \ls -la'
}

@test 'zpwrExpandAliasEscape: multi-word expansion' {
    LBUFFER="grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep -rn --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\grep -rn --color=auto'
}

#==============================================================
# zpwrExpandRightTrim
#==============================================================

@test 'zpwrExpandRightTrim: removes single trailing space' {
    LBUFFER="ls "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls'
}

@test 'zpwrExpandRightTrim: no change when no trailing space' {
    LBUFFER="ls"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls'
}

@test 'zpwrExpandRightTrim: no change when double trailing space' {
    LBUFFER="ls  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls  '
}

@test 'zpwrExpandRightTrim: multi-word with trailing space' {
    LBUFFER="git status "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git status'
}

@test 'zpwrExpandRightTrim: empty buffer unchanged' {
    LBUFFER=""
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'zpwrExpandRightTrim: single space trimmed' {
    LBUFFER=" "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'zpwrExpandRightTrim: triple trailing space unchanged' {
    LBUFFER="cmd   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cmd   '
}

@test 'zpwrExpandRightTrim: word with hyphen trailing space' {
    LBUFFER="git-flow "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git-flow'
}

#==============================================================
# zpwrExpandTerminateSpace
#==============================================================

@test 'zpwrExpandTerminateSpace: appends space to word' {
    LBUFFER="git"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git '
}

@test 'zpwrExpandTerminateSpace: appends space to empty buffer' {
    LBUFFER=""
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as ' '
}

@test 'zpwrExpandTerminateSpace: appends space when already has space' {
    LBUFFER="git "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git  '
}

@test 'zpwrExpandTerminateSpace: appends to multi-word buffer' {
    LBUFFER="git commit -m"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git commit -m '
}

@test 'zpwrExpandTerminateSpace: appends to buffer ending with special char' {
    LBUFFER="echo $HOME"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as "echo $HOME "
}

#==============================================================
# zpwrExpandParseWords
#==============================================================

@test 'zpwrExpandParseWords: single word lastword_lbuffer' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'zpwrExpandParseWords: single word firstword_partition' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'zpwrExpandParseWords: two words firstword' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'zpwrExpandParseWords: two words lastword' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'zpwrExpandParseWords: three words firstword' {
    zpwrExpandParseWords "sudo git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'sudo'
}

@test 'zpwrExpandParseWords: three words lastword' {
    zpwrExpandParseWords "sudo git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'zpwrExpandParseWords: after pipe firstword reset' {
    zpwrExpandParseWords "cat file | grep foo"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'zpwrExpandParseWords: after pipe lastword' {
    zpwrExpandParseWords "cat file | grep foo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'foo'
}

@test 'zpwrExpandParseWords: after semicolon firstword reset' {
    zpwrExpandParseWords "ls; git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'zpwrExpandParseWords: after semicolon lastword' {
    zpwrExpandParseWords "ls; git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'zpwrExpandParseWords: after && firstword reset' {
    zpwrExpandParseWords "make && git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'zpwrExpandParseWords: after || firstword reset' {
    zpwrExpandParseWords "ls || echo"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'zpwrExpandParseWords: after || lastword' {
    zpwrExpandParseWords "ls || echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'zpwrExpandParseWords: lastword_remove_special strips parens' {
    zpwrExpandParseWords "func(arg)"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'funcarg'
}

@test 'zpwrExpandParseWords: lastword_remove_special same as lastword for plain word' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'git'
}

@test 'zpwrExpandParseWords: lastword_remove_special strips square brackets' {
    zpwrExpandParseWords "echo arr[1]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arr1'
}

@test 'zpwrExpandParseWords: assignment removed from word list' {
    zpwrExpandParseWords "FOO=bar git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'zpwrExpandParseWords: single word lastword_remove_special' {
    zpwrExpandParseWords "hello"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'hello'
}

#==============================================================
# zpwrExpandGetAliasValue
#==============================================================

@test 'zpwrExpandGetAliasValue: retrieves simple alias value' {
    alias __zexptest_ls='ls -la'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_ls
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -la'
    unalias __zexptest_ls
}

@test 'zpwrExpandGetAliasValue: retrieves multi-word alias value' {
    alias __zexptest_gl='git log --oneline'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_gl
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git log --oneline'
    unalias __zexptest_gl
}

@test 'zpwrExpandGetAliasValue: retrieves alias with options' {
    alias __zexptest_grep='grep -rn --color=auto'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_grep
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'grep -rn --color=auto'
    unalias __zexptest_grep
}

@test 'zpwrExpandGetAliasValue: strips outer single quotes' {
    alias __zexptest_e='echo hello world'
    ZPWR_VARS[lastword_lbuffer]=__zexptest_e
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo hello world'
    unalias __zexptest_e
}

#==============================================================
# zpwrExpandGlobalAliases
#==============================================================

@test 'zpwrExpandGlobalAliases: basic expansion at end of buffer' {
    galiases[__ZEXPTEST_G]='| grep'
    LBUFFER="ls __ZEXPTEST_G"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZEXPTEST_G
    assert $LBUFFER same_as 'ls | grep'
    unset 'galiases[__ZEXPTEST_G]'
}

@test 'zpwrExpandGlobalAliases: WAS_EXPANDED true on match' {
    galiases[__ZEXPTEST_L]='| less'
    LBUFFER="cat file __ZEXPTEST_L"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZEXPTEST_L
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZEXPTEST_L]'
}

@test 'zpwrExpandGlobalAliases: no expand when word not at end' {
    galiases[__ZEXPTEST_G]='| grep'
    LBUFFER="ls __ZEXPTEST_G foo"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZEXPTEST_G || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unset 'galiases[__ZEXPTEST_G]'
}

@test 'zpwrExpandGlobalAliases: sets lastword_lbuffer to argument' {
    galiases[__ZEXPTEST_H]='| head'
    LBUFFER="cat file __ZEXPTEST_H"
    zpwrExpandGlobalAliases __ZEXPTEST_H
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZEXPTEST_H'
    unset 'galiases[__ZEXPTEST_H]'
}

@test 'zpwrExpandGlobalAliases: expands piped alias' {
    galiases[__ZEXPTEST_T]='| tail -n 20'
    LBUFFER="dmesg __ZEXPTEST_T"
    zpwrExpandGlobalAliases __ZEXPTEST_T
    assert $LBUFFER same_as 'dmesg | tail -n 20'
    unset 'galiases[__ZEXPTEST_T]'
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer
#==============================================================

@test 'zpwrExpandGoToTabStopOrEndOfLBuffer: no tabstop sets NEED_TO_ADD_SPACECHAR true' {
    LBUFFER="git commit -m msg"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'zpwrExpandGoToTabStopOrEndOfLBuffer: tabstop in LBUFFER sets NEED_TO_ADD_SPACECHAR false' {
    LBUFFER="git commit -m ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'zpwrExpandGoToTabStopOrEndOfLBuffer: RBUFFER tabstop prefix stripped when LBUFFER has tabstop' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER="${ZPWR_TABSTOP}extra"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as 'extra'
}

@test 'zpwrExpandGoToTabStopOrEndOfLBuffer: RBUFFER unchanged when no tabstop in LBUFFER' {
    LBUFFER="no tabstop here"
    RBUFFER="right side"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as 'right side'
}

@test 'zpwrExpandGoToTabStopOrEndOfLBuffer: empty LBUFFER sets NEED_TO_ADD_SPACECHAR true' {
    LBUFFER=""
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

#==============================================================
# zpwrExpandCorrectWord (spelling correction)
#==============================================================

@test 'zpwrExpandCorrectWord: corrects teh -> the in LBUFFER' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'zpwrExpandCorrectWord: sets foundIncorrect true on correction' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'zpwrExpandCorrectWord: corrects adn -> and' {
    LBUFFER="echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'
}

@test 'zpwrExpandCorrectWord: corrects nad -> and' {
    LBUFFER="echo nad"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'
}

@test 'zpwrExpandCorrectWord: corrects btw -> by the way (underscore key)' {
    LBUFFER="echo btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo by the way'
}

@test 'zpwrExpandCorrectWord: corrects b/c -> because' {
    LBUFFER="echo b/c"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo because'
}

@test 'zpwrExpandCorrectWord: corrects w/o -> without' {
    LBUFFER="echo w/o"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo without'
}

@test 'zpwrExpandCorrectWord: corrects hte -> the' {
    LBUFFER="echo hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'zpwrExpandCorrectWord: no correction for valid word hello' {
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'zpwrExpandCorrectWord: no correction LBUFFER unchanged for valid word' {
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo hello'
}

@test 'zpwrExpandCorrectWord: no correction for valid command git after sudo' {
    LBUFFER="sudo git"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'zpwrExpandCorrectWord: corrects josn -> JSON' {
    LBUFFER="echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JSON'
}

@test 'zpwrExpandCorrectWord: corrects ehco -> echo' {
    LBUFFER="echo ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo echo'
}

@test 'zpwrExpandCorrectWord: corrects jsut -> just' {
    LBUFFER="echo jsut"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo just'
}

@test 'zpwrExpandCorrectWord: preserves leading text before misspelling' {
    LBUFFER="git commit -m teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m the'
}
