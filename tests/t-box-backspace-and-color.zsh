#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandBox — backspace overprint stripping and --color flag
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    export COLUMNS=80
}

#==============================================================
# Backspace overprint (terminal bold / underline) — stripped before wrap
#==============================================================

@test 'box: strips single bold-style char backspace sequence' {
    local out
    out=$(zpwrExpandBox $'H\bHelloworld')
    assert "$out" contains 'Helloworld'
    [[ $out != *$'\b'* ]]
    assert $? equals 0
}

@test 'box: strips multiple backspace sequences on one line' {
    local out
    out=$(zpwrExpandBox $'A\bAB\bBC')
    assert "$out" contains 'ABC'
    [[ $out != *$'\b'* ]]
    assert $? equals 0
}

@test 'box: backspace strip runs per line in multi-line box' {
    local out
    out=$(zpwrExpandBox $'one\bONE' $'two\bTWO')
    assert "$out" contains 'ONE'
    assert "$out" contains 'TWO'
    [[ $out != *$'\b'* ]]
    assert $? equals 0
}

#==============================================================
# --color / -c forces ANSI even when stdout is not a tty (e.g. CI, $(...))
#==============================================================

@test 'box: -c forces ANSI escape sequences in captured output' {
    local out
    out=$(zpwrExpandBox -c "hello")
    assert "$out" contains $'\e['
}

@test 'box: --color long flag forces ANSI in captured output' {
    local out
    out=$(zpwrExpandBox --color "hello")
    assert "$out" contains $'\e['
}
