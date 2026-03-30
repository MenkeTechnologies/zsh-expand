#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: tests for zpwrExpandIsCommand hash lookup function
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

    # define test aliases and functions
    alias testaliascmd='echo test'
    alias gitalias='git status'
    alias ll='ls -la'
    alias la='ls -A'
    alias testmultiword='echo foo bar'

    function testfuncmd() { echo test; }
    function myfuncone() { echo one; }
    function myfunctwo() { echo two; }
    function zpwrTestHelper() { return 0; }
    function _test_completion() { return 0; }
}

#==============================================================
# 1. Known builtins — should return true (0)
#==============================================================

@test 'isCommand: cd is a builtin' {
    run zpwrExpandIsCommand cd
    assert $state equals 0
}

@test 'isCommand: echo is a builtin' {
    run zpwrExpandIsCommand echo
    assert $state equals 0
}

@test 'isCommand: print is a builtin' {
    run zpwrExpandIsCommand print
    assert $state equals 0
}

@test 'isCommand: typeset is a builtin' {
    run zpwrExpandIsCommand typeset
    assert $state equals 0
}

@test 'isCommand: local is a builtin' {
    run zpwrExpandIsCommand local
    assert $state equals 0
}

@test 'isCommand: export is a builtin' {
    run zpwrExpandIsCommand export
    assert $state equals 0
}

@test 'isCommand: set is a builtin' {
    run zpwrExpandIsCommand set
    assert $state equals 0
}

@test 'isCommand: unset is a builtin' {
    run zpwrExpandIsCommand unset
    assert $state equals 0
}

@test 'isCommand: declare is a builtin' {
    run zpwrExpandIsCommand declare
    assert $state equals 0
}

@test 'isCommand: readonly is a builtin' {
    run zpwrExpandIsCommand readonly
    assert $state equals 0
}

@test 'isCommand: eval is a builtin' {
    run zpwrExpandIsCommand eval
    assert $state equals 0
}

@test 'isCommand: source is a builtin' {
    run zpwrExpandIsCommand source
    assert $state equals 0
}

@test 'isCommand: exec is a builtin' {
    run zpwrExpandIsCommand exec
    assert $state equals 0
}

@test 'isCommand: command is a builtin' {
    run zpwrExpandIsCommand command
    assert $state equals 0
}

@test 'isCommand: builtin is a builtin' {
    run zpwrExpandIsCommand builtin
    assert $state equals 0
}

@test 'isCommand: autoload is a builtin' {
    run zpwrExpandIsCommand autoload
    assert $state equals 0
}

@test 'isCommand: whence is a builtin' {
    run zpwrExpandIsCommand whence
    assert $state equals 0
}

@test 'isCommand: which is a builtin' {
    run zpwrExpandIsCommand which
    assert $state equals 0
}

@test 'isCommand: where is a builtin' {
    run zpwrExpandIsCommand where
    assert $state equals 0
}

@test 'isCommand: type is a builtin' {
    run zpwrExpandIsCommand type
    assert $state equals 0
}

@test 'isCommand: hash is a builtin' {
    run zpwrExpandIsCommand hash
    assert $state equals 0
}

@test 'isCommand: alias is a builtin' {
    run zpwrExpandIsCommand alias
    assert $state equals 0
}

@test 'isCommand: unalias is a builtin' {
    run zpwrExpandIsCommand unalias
    assert $state equals 0
}

@test 'isCommand: bg is a builtin' {
    run zpwrExpandIsCommand bg
    assert $state equals 0
}

@test 'isCommand: fg is a builtin' {
    run zpwrExpandIsCommand fg
    assert $state equals 0
}

@test 'isCommand: jobs is a builtin' {
    run zpwrExpandIsCommand jobs
    assert $state equals 0
}

@test 'isCommand: wait is a builtin' {
    run zpwrExpandIsCommand wait
    assert $state equals 0
}

@test 'isCommand: kill is a builtin' {
    run zpwrExpandIsCommand kill
    assert $state equals 0
}

@test 'isCommand: trap is a builtin' {
    run zpwrExpandIsCommand trap
    assert $state equals 0
}

@test 'isCommand: return is a builtin' {
    run zpwrExpandIsCommand return
    assert $state equals 0
}

@test 'isCommand: exit is a builtin' {
    run zpwrExpandIsCommand exit
    assert $state equals 0
}

@test 'isCommand: break is a builtin' {
    run zpwrExpandIsCommand break
    assert $state equals 0
}

@test 'isCommand: continue is a builtin' {
    run zpwrExpandIsCommand continue
    assert $state equals 0
}

@test 'isCommand: shift is a builtin' {
    run zpwrExpandIsCommand shift
    assert $state equals 0
}

@test 'isCommand: getopts is a builtin' {
    run zpwrExpandIsCommand getopts
    assert $state equals 0
}

@test 'isCommand: read is a builtin' {
    run zpwrExpandIsCommand read
    assert $state equals 0
}

@test 'isCommand: pushd is a builtin' {
    run zpwrExpandIsCommand pushd
    assert $state equals 0
}

@test 'isCommand: popd is a builtin' {
    run zpwrExpandIsCommand popd
    assert $state equals 0
}

@test 'isCommand: dirs is a builtin' {
    run zpwrExpandIsCommand dirs
    assert $state equals 0
}

@test 'isCommand: emulate is a builtin' {
    run zpwrExpandIsCommand emulate
    assert $state equals 0
}

@test 'isCommand: setopt is a builtin' {
    run zpwrExpandIsCommand setopt
    assert $state equals 0
}

@test 'isCommand: unsetopt is a builtin' {
    run zpwrExpandIsCommand unsetopt
    assert $state equals 0
}

@test 'isCommand: zmodload is a builtin' {
    run zpwrExpandIsCommand zmodload
    assert $state equals 0
}

@test 'isCommand: zle is a builtin' {
    run zpwrExpandIsCommand zle
    assert $state equals 0
}

@test 'isCommand: bindkey is a builtin' {
    run zpwrExpandIsCommand bindkey
    assert $state equals 0
}

@test 'isCommand: rehash is a builtin' {
    run zpwrExpandIsCommand rehash
    assert $state equals 0
}

@test 'isCommand: zstyle is a builtin' {
    run zpwrExpandIsCommand zstyle
    assert $state equals 0
}

@test 'isCommand: zformat is a builtin' {
    run zpwrExpandIsCommand zformat
    assert $state equals 0
}

@test 'isCommand: integer is a builtin' {
    run zpwrExpandIsCommand integer
    assert $state equals 0
}

@test 'isCommand: float is a builtin' {
    run zpwrExpandIsCommand float
    assert $state equals 0
}

@test 'isCommand: printf is a builtin' {
    run zpwrExpandIsCommand printf
    assert $state equals 0
}

@test 'isCommand: pwd is a builtin' {
    run zpwrExpandIsCommand pwd
    assert $state equals 0
}

@test 'isCommand: true is a builtin' {
    run zpwrExpandIsCommand true
    assert $state equals 0
}

@test 'isCommand: false is a builtin' {
    run zpwrExpandIsCommand false
    assert $state equals 0
}

@test 'isCommand: let is a builtin' {
    run zpwrExpandIsCommand let
    assert $state equals 0
}

@test 'isCommand: disable is a builtin' {
    run zpwrExpandIsCommand disable
    assert $state equals 0
}

@test 'isCommand: enable is a builtin' {
    run zpwrExpandIsCommand enable
    assert $state equals 0
}

@test 'isCommand: ulimit is a builtin' {
    run zpwrExpandIsCommand ulimit
    assert $state equals 0
}

@test 'isCommand: umask is a builtin' {
    run zpwrExpandIsCommand umask
    assert $state equals 0
}

@test 'isCommand: limit is a builtin' {
    run zpwrExpandIsCommand limit
    assert $state equals 0
}

@test 'isCommand: unlimit is a builtin' {
    run zpwrExpandIsCommand unlimit
    assert $state equals 0
}

@test 'isCommand: vared is a builtin' {
    run zpwrExpandIsCommand vared
    assert $state equals 0
}

@test 'isCommand: fc is a builtin' {
    run zpwrExpandIsCommand fc
    assert $state equals 0
}

@test 'isCommand: history is a builtin' {
    run zpwrExpandIsCommand history
    assert $state equals 0
}

@test 'isCommand: noglob is a builtin' {
    run zpwrExpandIsCommand noglob
    assert $state equals 0
}

@test 'isCommand: unfunction is a builtin' {
    run zpwrExpandIsCommand unfunction
    assert $state equals 0
}

#==============================================================
# 2. Known external commands — should return true (0)
#==============================================================

@test 'isCommand: ls is a command' {
    run zpwrExpandIsCommand ls
    assert $state equals 0
}

@test 'isCommand: cat is a command' {
    run zpwrExpandIsCommand cat
    assert $state equals 0
}

@test 'isCommand: grep is a command' {
    run zpwrExpandIsCommand grep
    assert $state equals 0
}

@test 'isCommand: sed is a command' {
    run zpwrExpandIsCommand sed
    assert $state equals 0
}

@test 'isCommand: awk is a command' {
    run zpwrExpandIsCommand awk
    assert $state equals 0
}

@test 'isCommand: sort is a command' {
    run zpwrExpandIsCommand sort
    assert $state equals 0
}

@test 'isCommand: uniq is a command' {
    run zpwrExpandIsCommand uniq
    assert $state equals 0
}

@test 'isCommand: wc is a command' {
    run zpwrExpandIsCommand wc
    assert $state equals 0
}

@test 'isCommand: head is a command' {
    run zpwrExpandIsCommand head
    assert $state equals 0
}

@test 'isCommand: tail is a command' {
    run zpwrExpandIsCommand tail
    assert $state equals 0
}

@test 'isCommand: cut is a command' {
    run zpwrExpandIsCommand cut
    assert $state equals 0
}

@test 'isCommand: tr is a command' {
    run zpwrExpandIsCommand tr
    assert $state equals 0
}

@test 'isCommand: find is a command' {
    run zpwrExpandIsCommand find
    assert $state equals 0
}

@test 'isCommand: xargs is a command' {
    run zpwrExpandIsCommand xargs
    assert $state equals 0
}

@test 'isCommand: tee is a command' {
    run zpwrExpandIsCommand tee
    assert $state equals 0
}

@test 'isCommand: cp is a command' {
    run zpwrExpandIsCommand cp
    assert $state equals 0
}

@test 'isCommand: mv is a command' {
    run zpwrExpandIsCommand mv
    assert $state equals 0
}

@test 'isCommand: rm is a command' {
    run zpwrExpandIsCommand rm
    assert $state equals 0
}

@test 'isCommand: mkdir is a command' {
    run zpwrExpandIsCommand mkdir
    assert $state equals 0
}

@test 'isCommand: rmdir is a command' {
    run zpwrExpandIsCommand rmdir
    assert $state equals 0
}

@test 'isCommand: chmod is a command' {
    run zpwrExpandIsCommand chmod
    assert $state equals 0
}

@test 'isCommand: chown is a command' {
    run zpwrExpandIsCommand chown
    assert $state equals 0
}

@test 'isCommand: ln is a command' {
    run zpwrExpandIsCommand ln
    assert $state equals 0
}

@test 'isCommand: touch is a command' {
    run zpwrExpandIsCommand touch
    assert $state equals 0
}

@test 'isCommand: date is a command' {
    run zpwrExpandIsCommand date
    assert $state equals 0
}

@test 'isCommand: hostname is a command' {
    run zpwrExpandIsCommand hostname
    assert $state equals 0
}

@test 'isCommand: uname is a command' {
    run zpwrExpandIsCommand uname
    assert $state equals 0
}

@test 'isCommand: env is a command' {
    run zpwrExpandIsCommand env
    assert $state equals 0
}

@test 'isCommand: basename is a command' {
    run zpwrExpandIsCommand basename
    assert $state equals 0
}

@test 'isCommand: dirname is a command' {
    run zpwrExpandIsCommand dirname
    assert $state equals 0
}

@test 'isCommand: diff is a command' {
    run zpwrExpandIsCommand diff
    assert $state equals 0
}

@test 'isCommand: tar is a command' {
    run zpwrExpandIsCommand tar
    assert $state equals 0
}

@test 'isCommand: gzip is a command' {
    run zpwrExpandIsCommand gzip
    assert $state equals 0
}

@test 'isCommand: file is a command' {
    run zpwrExpandIsCommand file
    assert $state equals 0
}

@test 'isCommand: less is a command' {
    run zpwrExpandIsCommand less
    assert $state equals 0
}

@test 'isCommand: more is a command' {
    run zpwrExpandIsCommand more
    assert $state equals 0
}

@test 'isCommand: man is a command' {
    run zpwrExpandIsCommand man
    assert $state equals 0
}

@test 'isCommand: git is a command' {
    run zpwrExpandIsCommand git
    assert $state equals 0
}

@test 'isCommand: curl is a command' {
    run zpwrExpandIsCommand curl
    assert $state equals 0
}

@test 'isCommand: ssh is a command' {
    run zpwrExpandIsCommand ssh
    assert $state equals 0
}

@test 'isCommand: scp is a command' {
    run zpwrExpandIsCommand scp
    assert $state equals 0
}

@test 'isCommand: ping is a command' {
    run zpwrExpandIsCommand ping
    assert $state equals 0
}

@test 'isCommand: ps is a command' {
    run zpwrExpandIsCommand ps
    assert $state equals 0
}

@test 'isCommand: id is a command' {
    run zpwrExpandIsCommand id
    assert $state equals 0
}

@test 'isCommand: whoami is a command' {
    run zpwrExpandIsCommand whoami
    assert $state equals 0
}

@test 'isCommand: sleep is a command' {
    run zpwrExpandIsCommand sleep
    assert $state equals 0
}

@test 'isCommand: nice is a command' {
    run zpwrExpandIsCommand nice
    assert $state equals 0
}

@test 'isCommand: nohup is a command' {
    run zpwrExpandIsCommand nohup
    assert $state equals 0
}

@test 'isCommand: sudo is a command' {
    run zpwrExpandIsCommand sudo
    assert $state equals 0
}

@test 'isCommand: tput is a command' {
    run zpwrExpandIsCommand tput
    assert $state equals 0
}

@test 'isCommand: stty is a command' {
    run zpwrExpandIsCommand stty
    assert $state equals 0
}

@test 'isCommand: expr is a command' {
    run zpwrExpandIsCommand expr
    assert $state equals 0
}

@test 'isCommand: test is a command' {
    run zpwrExpandIsCommand test
    assert $state equals 0
}

#==============================================================
# 3. Known aliases — should return true (0)
#==============================================================

@test 'isCommand: testaliascmd is an alias' {
    run zpwrExpandIsCommand testaliascmd
    assert $state equals 0
}

@test 'isCommand: gitalias is an alias' {
    run zpwrExpandIsCommand gitalias
    assert $state equals 0
}

@test 'isCommand: ll is an alias' {
    run zpwrExpandIsCommand ll
    assert $state equals 0
}

@test 'isCommand: la is an alias' {
    run zpwrExpandIsCommand la
    assert $state equals 0
}

@test 'isCommand: testmultiword is an alias' {
    run zpwrExpandIsCommand testmultiword
    assert $state equals 0
}

#==============================================================
# 4. Known functions — should return true (0)
#==============================================================

@test 'isCommand: testfuncmd is a function' {
    run zpwrExpandIsCommand testfuncmd
    assert $state equals 0
}

@test 'isCommand: myfuncone is a function' {
    run zpwrExpandIsCommand myfuncone
    assert $state equals 0
}

@test 'isCommand: myfunctwo is a function' {
    run zpwrExpandIsCommand myfunctwo
    assert $state equals 0
}

@test 'isCommand: zpwrTestHelper is a function' {
    run zpwrExpandIsCommand zpwrTestHelper
    assert $state equals 0
}

@test 'isCommand: _test_completion is a function' {
    run zpwrExpandIsCommand _test_completion
    assert $state equals 0
}

@test 'isCommand: zpwrExpandIsCommand itself is a function' {
    run zpwrExpandIsCommand zpwrExpandIsCommand
    assert $state equals 0
}

@test 'isCommand: zpwrExpandParseWords is a function' {
    run zpwrExpandIsCommand zpwrExpandParseWords
    assert $state equals 0
}

@test 'isCommand: zpwrExpandSuffixAlias is a function' {
    run zpwrExpandIsCommand zpwrExpandSuffixAlias
    assert $state equals 0
}

@test 'isCommand: zpwrExpandRegexMatchOnCommandPosition is a function' {
    run zpwrExpandIsCommand zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'isCommand: zpwrExpandRightTrim is a function' {
    run zpwrExpandIsCommand zpwrExpandRightTrim
    assert $state equals 0
}

#==============================================================
# 5. Non-existent commands — should return false (1)
#==============================================================

@test 'isCommand: nonexistentcmd123 returns false' {
    run zpwrExpandIsCommand nonexistentcmd123
    assert $state equals 1
}

@test 'isCommand: fakecmd returns false' {
    run zpwrExpandIsCommand fakecmd
    assert $state equals 1
}

@test 'isCommand: zzzznotarealcommand returns false' {
    run zpwrExpandIsCommand zzzznotarealcommand
    assert $state equals 1
}

@test 'isCommand: xyzabc123 returns false' {
    run zpwrExpandIsCommand xyzabc123
    assert $state equals 1
}

@test 'isCommand: notacommand returns false' {
    run zpwrExpandIsCommand notacommand
    assert $state equals 1
}

@test 'isCommand: qqqwwweee returns false' {
    run zpwrExpandIsCommand qqqwwweee
    assert $state equals 1
}

@test 'isCommand: aaaabbbbcccc returns false' {
    run zpwrExpandIsCommand aaaabbbbcccc
    assert $state equals 1
}

@test 'isCommand: this-is-not-a-command returns false' {
    run zpwrExpandIsCommand this-is-not-a-command
    assert $state equals 1
}

@test 'isCommand: __nonexistent__ returns false' {
    run zpwrExpandIsCommand __nonexistent__
    assert $state equals 1
}

@test 'isCommand: NONEXISTENT returns false' {
    run zpwrExpandIsCommand NONEXISTENT
    assert $state equals 1
}

@test 'isCommand: foobar123xyz returns false' {
    run zpwrExpandIsCommand foobar123xyz
    assert $state equals 1
}

@test 'isCommand: notacmd_underscore returns false' {
    run zpwrExpandIsCommand notacmd_underscore
    assert $state equals 1
}

@test 'isCommand: a1b2c3d4 returns false' {
    run zpwrExpandIsCommand a1b2c3d4
    assert $state equals 1
}

@test 'isCommand: very-long-nonexistent-command-name returns false' {
    run zpwrExpandIsCommand very-long-nonexistent-command-name
    assert $state equals 1
}

@test 'isCommand: cmd_with_many_underscores_not_real returns false' {
    run zpwrExpandIsCommand cmd_with_many_underscores_not_real
    assert $state equals 1
}

#==============================================================
# 6. Empty string — should return false
#==============================================================

@test 'isCommand: empty string returns false' {
    run zpwrExpandIsCommand ''
    assert $state equals 1
}

#==============================================================
# 7. Strings that look like commands but are not
#==============================================================

@test 'isCommand: lss (misspelled ls) returns false' {
    run zpwrExpandIsCommand lss
    assert $state equals 1
}

@test 'isCommand: gti (misspelled git) returns false' {
    run zpwrExpandIsCommand gti
    assert $state equals 1
}

@test 'isCommand: cta (misspelled cat) returns false' {
    run zpwrExpandIsCommand cta
    assert $state equals 1
}

@test 'isCommand: grpe (misspelled grep) returns false' {
    run zpwrExpandIsCommand grpe
    assert $state equals 1
}

@test 'isCommand: mkdri (misspelled mkdir) returns false' {
    run zpwrExpandIsCommand mkdri
    assert $state equals 1
}

@test 'isCommand: chmdo (misspelled chmod) returns false' {
    run zpwrExpandIsCommand chmdo
    assert $state equals 1
}

@test 'isCommand: touhc (misspelled touch) returns false' {
    run zpwrExpandIsCommand touhc
    assert $state equals 1
}

@test 'isCommand: maek (misspelled make) returns false' {
    run zpwrExpandIsCommand maek
    assert $state equals 1
}

@test 'isCommand: suod (misspelled sudo) returns false' {
    run zpwrExpandIsCommand suod
    assert $state equals 1
}

@test 'isCommand: ehco (misspelled echo) returns false' {
    run zpwrExpandIsCommand ehco
    assert $state equals 1
}

@test 'isCommand: pirnt (misspelled print) returns false' {
    run zpwrExpandIsCommand pirnt
    assert $state equals 1
}

@test 'isCommand: tpyeset (misspelled typeset) returns false' {
    run zpwrExpandIsCommand tpyeset
    assert $state equals 1
}

@test 'isCommand: soruce (misspelled source) returns false' {
    run zpwrExpandIsCommand soruce
    assert $state equals 1
}

@test 'isCommand: reutrn (misspelled return) returns false' {
    run zpwrExpandIsCommand reutrn
    assert $state equals 1
}

@test 'isCommand: exti (misspelled exit) returns false' {
    run zpwrExpandIsCommand exti
    assert $state equals 1
}

#==============================================================
# 8. Strings with special characters — should return false
#==============================================================

@test 'isCommand: dotted.name returns false' {
    run zpwrExpandIsCommand dotted.name
    assert $state equals 1
}

@test 'isCommand: slashed/name returns false' {
    run zpwrExpandIsCommand slashed/name
    assert $state equals 1
}

@test 'isCommand: name=value returns false' {
    run zpwrExpandIsCommand name=value
    assert $state equals 1
}

@test 'isCommand: star* returns false' {
    run zpwrExpandIsCommand 'star*'
    assert $state equals 1
}

@test 'isCommand: question? returns false' {
    run zpwrExpandIsCommand 'question?'
    assert $state equals 1
}

@test 'isCommand: brackets[] returns false' {
    run zpwrExpandIsCommand 'brackets[]'
    assert $state equals 1
}

@test 'isCommand: single word with space returns false' {
    run zpwrExpandIsCommand 'has space'
    assert $state equals 1
}

@test 'isCommand: semicolon; returns false' {
    run zpwrExpandIsCommand 'semicolon;'
    assert $state equals 1
}

@test 'isCommand: pipe| returns false' {
    run zpwrExpandIsCommand 'pipe|'
    assert $state equals 1
}

@test 'isCommand: ampersand& returns false' {
    run zpwrExpandIsCommand 'ampersand&'
    assert $state equals 1
}

@test 'isCommand: at@ returns false' {
    run zpwrExpandIsCommand 'at@'
    assert $state equals 1
}

@test 'isCommand: hash# returns false' {
    run zpwrExpandIsCommand 'hash#'
    assert $state equals 1
}

@test 'isCommand: dollar$ returns false' {
    run zpwrExpandIsCommand 'dollar$'
    assert $state equals 1
}

@test 'isCommand: percent% returns false' {
    run zpwrExpandIsCommand 'percent%'
    assert $state equals 1
}

@test 'isCommand: caret^ returns false' {
    run zpwrExpandIsCommand 'caret^'
    assert $state equals 1
}

@test 'isCommand: tilde~ returns false' {
    run zpwrExpandIsCommand 'tilde~'
    assert $state equals 1
}

@test 'isCommand: backtick` returns false' {
    run zpwrExpandIsCommand 'backtick`'
    assert $state equals 1
}

@test 'isCommand: braces{} returns false' {
    run zpwrExpandIsCommand 'braces{}'
    assert $state equals 1
}

@test 'isCommand: parens() returns false' {
    run zpwrExpandIsCommand 'parens()'
    assert $state equals 1
}

@test 'isCommand: plus+ returns false' {
    run zpwrExpandIsCommand 'plus+'
    assert $state equals 1
}

@test 'isCommand: comma, returns false' {
    run zpwrExpandIsCommand 'comma,'
    assert $state equals 1
}

#==============================================================
# 9. Numeric strings — should return false
#==============================================================

@test 'isCommand: 123 numeric returns false' {
    run zpwrExpandIsCommand 123
    assert $state equals 1
}

@test 'isCommand: 0 zero returns false' {
    run zpwrExpandIsCommand 0
    assert $state equals 1
}

@test 'isCommand: 999999 large number returns false' {
    run zpwrExpandIsCommand 999999
    assert $state equals 1
}

@test 'isCommand: -1 negative returns false' {
    run zpwrExpandIsCommand -- -1
    assert $state equals 1
}

@test 'isCommand: 3.14 decimal returns false' {
    run zpwrExpandIsCommand 3.14
    assert $state equals 1
}

#==============================================================
# 10. Path-like strings — should return false
#==============================================================

@test 'isCommand: /usr/bin/nonexistent returns false' {
    run zpwrExpandIsCommand /usr/bin/nonexistent
    assert $state equals 1
}

@test 'isCommand: ./relative/path returns false' {
    run zpwrExpandIsCommand ./relative/path
    assert $state equals 1
}

@test 'isCommand: ../parent/path returns false' {
    run zpwrExpandIsCommand ../parent/path
    assert $state equals 1
}

@test 'isCommand: ~/home/path returns false' {
    run zpwrExpandIsCommand '~/home/path'
    assert $state equals 1
}

#==============================================================
# 11. Plugin functions found after load
#==============================================================

@test 'isCommand: zpwrExpandSupernaturalSpace is loaded function' {
    run zpwrExpandIsCommand zpwrExpandSupernaturalSpace
    assert $state equals 0
}

@test 'isCommand: zpwrExpandTerminateSpace is loaded function' {
    run zpwrExpandIsCommand zpwrExpandTerminateSpace
    assert $state equals 0
}

@test 'isCommand: zpwrExpandCorrectWord is loaded function' {
    run zpwrExpandIsCommand zpwrExpandCorrectWord
    assert $state equals 0
}

@test 'isCommand: zpwrExpandGoToTabStopOrEndOfLBuffer is loaded function' {
    run zpwrExpandIsCommand zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $state equals 0
}

#==============================================================
# 12. More external commands found on typical systems
#==============================================================

@test 'isCommand: df is a command' {
    run zpwrExpandIsCommand df
    assert $state equals 0
}

@test 'isCommand: du is a command' {
    run zpwrExpandIsCommand du
    assert $state equals 0
}

@test 'isCommand: mount is a command' {
    run zpwrExpandIsCommand mount
    assert $state equals 0
}

@test 'isCommand: cal is a command' {
    run zpwrExpandIsCommand cal
    assert $state equals 0
}

@test 'isCommand: bc is a command' {
    run zpwrExpandIsCommand bc
    assert $state equals 0
}

@test 'isCommand: od is a command' {
    run zpwrExpandIsCommand od
    assert $state equals 0
}

@test 'isCommand: yes is a command' {
    run zpwrExpandIsCommand yes
    assert $state equals 0
}

@test 'isCommand: seq is a command' {
    run zpwrExpandIsCommand seq
    assert $state equals 0
}

@test 'isCommand: paste is a command' {
    run zpwrExpandIsCommand paste
    assert $state equals 0
}

@test 'isCommand: join is a command' {
    run zpwrExpandIsCommand join
    assert $state equals 0
}

@test 'isCommand: comm is a command' {
    run zpwrExpandIsCommand comm
    assert $state equals 0
}

@test 'isCommand: fold is a command' {
    run zpwrExpandIsCommand fold
    assert $state equals 0
}

@test 'isCommand: fmt is a command' {
    run zpwrExpandIsCommand fmt
    assert $state equals 0
}

@test 'isCommand: nl is a command' {
    run zpwrExpandIsCommand nl
    assert $state equals 0
}

@test 'isCommand: expand is a command' {
    run zpwrExpandIsCommand expand
    assert $state equals 0
}

@test 'isCommand: unexpand is a command' {
    run zpwrExpandIsCommand unexpand
    assert $state equals 0
}

@test 'isCommand: rev is a command' {
    run zpwrExpandIsCommand rev
    assert $state equals 0
}

@test 'isCommand: tac is a command' {
    run zpwrExpandIsCommand tac
    assert $state equals 0
}

@test 'isCommand: strings is a command' {
    run zpwrExpandIsCommand strings
    assert $state equals 0
}

@test 'isCommand: xxd is a command' {
    run zpwrExpandIsCommand xxd
    assert $state equals 0
}

@test 'isCommand: stat is a command' {
    run zpwrExpandIsCommand stat
    assert $state equals 0
}

@test 'isCommand: mktemp is a command' {
    run zpwrExpandIsCommand mktemp
    assert $state equals 0
}

@test 'isCommand: realpath is a command' {
    run zpwrExpandIsCommand realpath
    assert $state equals 0
}

@test 'isCommand: readlink is a command' {
    run zpwrExpandIsCommand readlink
    assert $state equals 0
}

@test 'isCommand: install is a command' {
    run zpwrExpandIsCommand install
    assert $state equals 0
}

@test 'isCommand: sum is a command' {
    run zpwrExpandIsCommand sum
    assert $state equals 0
}

@test 'isCommand: cksum is a command' {
    run zpwrExpandIsCommand cksum
    assert $state equals 0
}

@test 'isCommand: cmp is a command' {
    run zpwrExpandIsCommand cmp
    assert $state equals 0
}

@test 'isCommand: split is a command' {
    run zpwrExpandIsCommand split
    assert $state equals 0
}

@test 'isCommand: csplit is a command' {
    run zpwrExpandIsCommand csplit
    assert $state equals 0
}

#==============================================================
# 13. More non-existent to pad coverage
#==============================================================

@test 'isCommand: lsss returns false' {
    run zpwrExpandIsCommand lsss
    assert $state equals 1
}

@test 'isCommand: cattt returns false' {
    run zpwrExpandIsCommand cattt
    assert $state equals 1
}

@test 'isCommand: grepp returns false' {
    run zpwrExpandIsCommand grepp
    assert $state equals 1
}

@test 'isCommand: seedd returns false' {
    run zpwrExpandIsCommand seedd
    assert $state equals 1
}

@test 'isCommand: awkk returns false' {
    run zpwrExpandIsCommand awkk
    assert $state equals 1
}

@test 'isCommand: curlll returns false' {
    run zpwrExpandIsCommand curlll
    assert $state equals 1
}

@test 'isCommand: gittt returns false' {
    run zpwrExpandIsCommand gittt
    assert $state equals 1
}

@test 'isCommand: pythonnn returns false' {
    run zpwrExpandIsCommand pythonnn
    assert $state equals 1
}

@test 'isCommand: rubyyy returns false' {
    run zpwrExpandIsCommand rubyyy
    assert $state equals 1
}

@test 'isCommand: nodee returns false' {
    run zpwrExpandIsCommand nodee
    assert $state equals 1
}

@test 'isCommand: rusttc returns false' {
    run zpwrExpandIsCommand rusttc
    assert $state equals 1
}

@test 'isCommand: cargoo returns false' {
    run zpwrExpandIsCommand cargoo
    assert $state equals 1
}

#==============================================================
# 14. Single character — non-existent
#==============================================================

@test 'isCommand: single char a returns false' {
    run zpwrExpandIsCommand a
    assert $state equals 1
}

@test 'isCommand: single char b returns false' {
    run zpwrExpandIsCommand b
    assert $state equals 1
}

@test 'isCommand: single char x returns false' {
    run zpwrExpandIsCommand x
    assert $state equals 1
}

@test 'isCommand: single char z returns false' {
    run zpwrExpandIsCommand z
    assert $state equals 1
}

@test 'isCommand: single char q returns false' {
    run zpwrExpandIsCommand q
    assert $state equals 1
}
