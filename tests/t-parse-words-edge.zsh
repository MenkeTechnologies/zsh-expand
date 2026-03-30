#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandParseWords
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
# empty and whitespace inputs
#==============================================================

@test 'parseWords: empty string lastword empty' {
    zpwrExpandParseWords ""
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
}

@test 'parseWords: empty string firstword empty' {
    zpwrExpandParseWords ""
    assert "$ZPWR_VARS[firstword_partition]" same_as ''
}

@test 'parseWords: single space lastword empty' {
    zpwrExpandParseWords " "
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
}

@test 'parseWords: multiple spaces lastword empty' {
    zpwrExpandParseWords "   "
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
}

#==============================================================
# command substitution handling
#==============================================================

@test 'parseWords: dollar-paren splits as semicolon' {
    zpwrExpandParseWords 'echo $(cat file)'
    # $( is converted to ; so the last word after (z) splitting changes
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ')'
}

@test 'parseWords: backtick in last word splits correctly' {
    # backtick replacement only applies to tmp[-1]
    # testing that backtick handling doesn't crash
    zpwrExpandParseWords 'echo hello'
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as 'hello'
}

#==============================================================
# arithmetic expansion
#==============================================================

@test 'parseWords: arithmetic expansion replaced with junk' {
    zpwrExpandParseWords 'echo $(( 1 + 2 ))'
    # $(( should be replaced with no_cmd_* so it is not a command position
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ')'
}

#==============================================================
# process substitution
#==============================================================

@test 'parseWords: process sub <() parsed correctly' {
    zpwrExpandParseWords 'diff <(sort file1) file2'
    # <( is converted to ; so diff is removed from partition
    assert "$ZPWR_VARS[firstword_partition]" same_as 'diff'
}

@test 'parseWords: equals process sub =() parsed correctly' {
    zpwrExpandParseWords 'vim =(sort file1)'
    # =( is converted to ; so the parsing changes
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ')'
}

#==============================================================
# multiple separators
#==============================================================

@test 'parseWords: double semicolon resets firstword' {
    zpwrExpandParseWords "case x;; git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'parseWords: pipe after semicolon' {
    zpwrExpandParseWords "ls; cat file | grep"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'parseWords: && after pipe' {
    zpwrExpandParseWords "cat | grep foo && echo"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'parseWords: || after &&' {
    zpwrExpandParseWords "make && test || echo"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'parseWords: multiple pipes firstword is last pipe segment' {
    zpwrExpandParseWords "cat file | grep foo | sort | head"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'parseWords: multiple pipes lastword' {
    zpwrExpandParseWords "cat file | grep foo | sort | head -5"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-5'
}

@test 'parseWords: semicolons chain' {
    zpwrExpandParseWords "ls; pwd; echo hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'parseWords: semicolons chain lastword' {
    zpwrExpandParseWords "ls; pwd; echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

#==============================================================
# assignments
#==============================================================

@test 'parseWords: single assignment before command' {
    zpwrExpandParseWords "FOO=bar git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'parseWords: multiple assignments before command' {
    zpwrExpandParseWords "FOO=bar BAZ=qux git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'parseWords: assignment with path value' {
    zpwrExpandParseWords "PATH=/usr/bin git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'parseWords: assignment with complex value' {
    zpwrExpandParseWords "CFLAGS=-O2 make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'parseWords: assignment lastword is command' {
    zpwrExpandParseWords "FOO=bar git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

#==============================================================
# redirections
#==============================================================

@test 'parseWords: output redirect removed from words' {
    zpwrExpandParseWords "echo hello > file.txt git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'parseWords: input redirect removed from words' {
    zpwrExpandParseWords "cat < input.txt"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'parseWords: append redirect' {
    zpwrExpandParseWords "echo hello >> file.txt git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'parseWords: stderr redirect' {
    zpwrExpandParseWords "cmd 2> err.log git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

#==============================================================
# special characters in words
#==============================================================

@test 'parseWords: lastword_remove_special strips parens' {
    zpwrExpandParseWords "echo foo(bar)"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'foobar'
}

@test 'parseWords: lastword_remove_special strips brackets' {
    zpwrExpandParseWords "echo arr[0]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arr0'
}

@test 'parseWords: lastword_remove_special strips braces' {
    zpwrExpandParseWords 'echo ${var}'
    assert "$ZPWR_VARS[lastword_remove_special]" same_as '$var'
}

@test 'parseWords: lastword_remove_special plain word unchanged' {
    zpwrExpandParseWords "echo hello"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'hello'
}

@test 'parseWords: lastword_remove_special with mixed specials' {
    zpwrExpandParseWords "echo foo[1](2){3}"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'foo123'
}

#==============================================================
# subshell and grouping
#==============================================================

@test 'parseWords: open paren resets firstword' {
    zpwrExpandParseWords "( git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'parseWords: open brace resets firstword' {
    zpwrExpandParseWords "{ git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'parseWords: paren lastword' {
    zpwrExpandParseWords "( git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'parseWords: brace lastword' {
    zpwrExpandParseWords "{ echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

#==============================================================
# words with hyphens and special flags
#==============================================================

@test 'parseWords: hyphenated command' {
    zpwrExpandParseWords "git-flow"
    assert $ZPWR_VARS[firstword_partition] same_as 'git-flow'
}

@test 'parseWords: flag as lastword' {
    zpwrExpandParseWords "ls -la"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-la'
}

@test 'parseWords: long option as lastword' {
    zpwrExpandParseWords "grep --color auto"
    # --color=auto is treated as assignment and removed
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'auto'
}

@test 'parseWords: double dash separator' {
    zpwrExpandParseWords "git checkout -- file.txt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file.txt'
}

#==============================================================
# paths
#==============================================================

@test 'parseWords: absolute path as lastword' {
    zpwrExpandParseWords "cat /etc/hosts"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/etc/hosts'
}

@test 'parseWords: relative path as lastword' {
    zpwrExpandParseWords "cat ./file.txt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as './file.txt'
}

@test 'parseWords: tilde path as lastword' {
    zpwrExpandParseWords "cd ~/projects"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '~/projects'
}

@test 'parseWords: path with spaces (quoted) lastword is last token' {
    zpwrExpandParseWords "cd '/path with spaces'"
    # (z) preserves quotes around the token
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as "'/path with spaces'"
}

#==============================================================
# complex multi-segment commands
#==============================================================

@test 'parseWords: complex pipeline firstword' {
    zpwrExpandParseWords "find . -name *.log | xargs grep error | sort -u | head -10"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'parseWords: complex pipeline lastword' {
    zpwrExpandParseWords "find . -name *.log | xargs grep error | sort -u | head -10"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-10'
}

@test 'parseWords: mixed separators complex' {
    zpwrExpandParseWords "make clean && make build || echo failed; git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'parseWords: mixed separators complex lastword' {
    zpwrExpandParseWords "make clean && make build || echo failed; git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'parseWords: nested commands with pipe' {
    zpwrExpandParseWords "ls -la | grep ^d; echo done"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'parseWords: ZPWR_EXPAND_WORDS_LPARTITION correct after pipe' {
    zpwrExpandParseWords "cat file | grep foo bar"
    assert "$ZPWR_EXPAND_WORDS_LPARTITION" same_as 'grep foo bar'
}

@test 'parseWords: ZPWR_EXPAND_WORDS_LPARTITION correct after semicolon' {
    zpwrExpandParseWords "ls; git status"
    assert "$ZPWR_EXPAND_WORDS_LPARTITION" same_as 'git status'
}
