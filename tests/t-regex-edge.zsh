#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandRegexMatchOnCommandPosition
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
# sudo with various flag combinations
#==============================================================

@test 'regex: sudo with no flags matches' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -i flag matches' {
    zpwrExpandParseWords "sudo -i git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -s flag matches' {
    zpwrExpandParseWords "sudo -s git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -E flag matches' {
    zpwrExpandParseWords "sudo -E git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -H flag matches' {
    zpwrExpandParseWords "sudo -H git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -n flag matches' {
    zpwrExpandParseWords "sudo -n git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -u user matches' {
    zpwrExpandParseWords "sudo -u root git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -u user PRE_EXPAND has git' {
    zpwrExpandParseWords "sudo -u root git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -g group matches' {
    zpwrExpandParseWords "sudo -g wheel git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -Eins combined flags matches' {
    zpwrExpandParseWords "sudo -Eins git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -- matches' {
    zpwrExpandParseWords "sudo -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -u root -- matches' {
    zpwrExpandParseWords "sudo -u root -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# env with various flags
#==============================================================

@test 'regex: env with no flags matches' {
    zpwrExpandParseWords "env git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -i flag matches' {
    zpwrExpandParseWords "env -i git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -- matches' {
    zpwrExpandParseWords "env -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env PRE_EXPAND has correct value' {
    zpwrExpandParseWords "env git status"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}

#==============================================================
# nice, time, nohup, rlwrap
#==============================================================

@test 'regex: nice matches' {
    zpwrExpandParseWords "nice git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time matches' {
    zpwrExpandParseWords "time git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup matches' {
    zpwrExpandParseWords "nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap matches' {
    zpwrExpandParseWords "rlwrap git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice PRE_EXPAND has git' {
    zpwrExpandParseWords "nice git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: time PRE_EXPAND has git status' {
    zpwrExpandParseWords "time git status"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}

#==============================================================
# builtin prefixes
#==============================================================

@test 'regex: command prefix matches' {
    zpwrExpandParseWords "command git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin prefix matches' {
    zpwrExpandParseWords "builtin git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob prefix matches' {
    zpwrExpandParseWords "noglob git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec prefix matches' {
    zpwrExpandParseWords "exec git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval prefix matches' {
    zpwrExpandParseWords "eval git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect prefix matches' {
    zpwrExpandParseWords "nocorrect git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# stacked prefixes
#==============================================================

@test 'regex: sudo env matches' {
    zpwrExpandParseWords "sudo env git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time sudo matches' {
    zpwrExpandParseWords "time sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command sudo matches' {
    zpwrExpandParseWords "command sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob sudo matches' {
    zpwrExpandParseWords "noglob sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice time sudo matches' {
    zpwrExpandParseWords "nice time sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin command sudo matches' {
    zpwrExpandParseWords "builtin command sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# case insensitive sudo/env/nice/time/nohup/rlwrap
#==============================================================

@test 'regex: SUDO uppercase matches' {
    zpwrExpandParseWords "SUDO git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Sudo mixed case matches' {
    zpwrExpandParseWords "Sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: ENV uppercase matches' {
    zpwrExpandParseWords "ENV git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: NICE uppercase matches' {
    zpwrExpandParseWords "NICE git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: TIME uppercase matches' {
    zpwrExpandParseWords "TIME git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: NOHUP uppercase matches' {
    zpwrExpandParseWords "NOHUP git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: RLWRAP uppercase matches' {
    zpwrExpandParseWords "RLWRAP git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# correct mode vs expand mode
#==============================================================

@test 'regex: correct mode sets ZPWR_EXPAND_PRE_CORRECT' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT" same_as 'git'
}

@test 'regex: expand mode sets ZPWR_EXPAND_PRE_EXPAND' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: correct mode with two words after sudo' {
    zpwrExpandParseWords "sudo git status"
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT" same_as 'git status'
}

@test 'regex: expand mode with two words after sudo' {
    zpwrExpandParseWords "sudo git status"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}

#==============================================================
# return value
#==============================================================

@test 'regex: returns 0 on match' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: returns 0 on simple two word match' {
    zpwrExpandParseWords "echo hello"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# leading whitespace
#==============================================================

@test 'regex: leading space before sudo matches' {
    zpwrExpandParseWords " sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: leading spaces before sudo matches' {
    zpwrExpandParseWords "   sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: leading space before env matches' {
    zpwrExpandParseWords " env git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}
