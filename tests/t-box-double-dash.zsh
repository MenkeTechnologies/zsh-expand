#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandBox — `--` ends flag parsing so lines can start with dashes
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    export COLUMNS=80
}

@test 'box: double-dash line is content not a -t title flag' {
    local out
    out=$(zpwrExpandBox -- "-not-a-flag" "second line")
    assert "$out" contains '-not-a-flag'
    [[ $out != *Title* ]] 2>/dev/null
    assert $? equals 0
}

@test 'box: double-dash allows line that looks like --title' {
    local out
    out=$(zpwrExpandBox -- "--title" "real content")
    assert "$out" contains '--title'
    assert "$out" contains 'real content'
}

@test 'box: flags before -- still apply' {
    local out
    out=$(zpwrExpandBox -t "MyTitle" -- "-dashed" "plain")
    assert "$out" contains 'MyTitle'
    assert "$out" contains '-dashed'
    assert "$out" contains 'plain'
}
