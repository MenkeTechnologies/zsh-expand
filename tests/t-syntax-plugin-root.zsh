#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zsh -n on plugin root sources (t-syntax.zsh only covers tests/*.zsh)
##### Notes: resolve repo root by walking up from PWD until zsh-expand.plugin.zsh is found
#}}}***********************************************************

@setup {
    typeset search="$PWD"
    typeset -g repoRoot=""
    while [[ $search != / ]]; do
        if [[ -f "$search/zsh-expand.plugin.zsh" ]]; then
            repoRoot=$search
            break
        fi
        search="${search:h}"
    done
}

@test 'syntax: repo root resolved' {
    [[ -n $repoRoot && -f "$repoRoot/zsh-expand.plugin.zsh" ]]
    assert $? equals 0
}

@test 'repo root: zsh-expand.plugin.zsh parses' {
    run zsh -n "$repoRoot/zsh-expand.plugin.zsh"
    assert $state equals 0
}

@test 'repo root: zpwrExpandLib.zsh parses' {
    run zsh -n "$repoRoot/zpwrExpandLib.zsh"
    assert $state equals 0
}

@test 'repo root: zpwrExpandApi.zsh parses' {
    run zsh -n "$repoRoot/zpwrExpandApi.zsh"
    assert $state equals 0
}

@test 'repo root: zpwrExpandParser.zsh parses' {
    run zsh -n "$repoRoot/zpwrExpandParser.zsh"
    assert $state equals 0
}

@test 'scripts: count-tests.zsh parses' {
    run zsh -n "$repoRoot/scripts/count-tests.zsh"
    assert $state equals 0
}
