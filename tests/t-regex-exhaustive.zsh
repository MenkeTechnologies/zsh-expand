#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Mar 25 2026
##### Purpose: exhaustive regex matching tests
##### Notes: tests zpwrExpandRegexMatchOnCommandPosition
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
}

@test 'regex: sudo -A cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -A cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -B cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -B cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -b cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -b cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -E cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -E cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -H cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -H cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -n cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -n cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -P cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -P cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -S cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -S cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -i cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -i cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -s cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -s cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -C val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -C val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -g val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -g val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -h val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -h val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -p val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -p val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -T val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -T val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -u val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -u val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -AE cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -AE cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -bEH cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -bEH cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -nPS cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -nPS cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -iSA cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -iSA cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -bns cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -bns cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -EHi cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -EHi cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -ABb cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -ABb cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -nSi cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -nSi cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -sEH cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -sEH cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -i cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -i cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -v cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -v cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -iv cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -iv cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -vi cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -vi cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -P val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -P val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -S val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -S val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -u val cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -u val cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice gcc' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice gcc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice python' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice node' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice cargo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice cargo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice npm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice ruby' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice ruby)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice perl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice perl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice java' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice java)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice go' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice go)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice docker' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice kubectl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice kubectl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice ssh' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice ssh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice curl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice curl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice wget' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice wget)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice find' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice find)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice sort' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice sort)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice head' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice head)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice tail' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice tail)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time gcc' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time gcc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time python' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time node' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time cargo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time cargo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time npm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time ruby' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time ruby)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time perl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time perl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time java' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time java)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time go' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time go)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time docker' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time kubectl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time kubectl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time ssh' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time ssh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time curl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time curl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time wget' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time wget)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time find' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time find)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time sort' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sort)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time head' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time head)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time tail' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time tail)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup gcc' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup gcc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup python' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup node' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup cargo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup cargo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup npm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup ruby' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup ruby)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup perl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup perl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup java' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup java)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup go' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup go)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup docker' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup kubectl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup kubectl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup ssh' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup ssh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup curl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup curl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup wget' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup wget)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup find' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup find)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup sort' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup sort)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup head' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup head)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup tail' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup tail)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap gcc' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap gcc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap python' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap node' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap cargo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap cargo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap npm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap ruby' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap ruby)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap perl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap perl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap java' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap java)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap go' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap go)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap docker' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap kubectl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap kubectl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap ssh' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap ssh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap curl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap curl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap wget' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap wget)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap find' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap find)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap sort' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap sort)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap head' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap head)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap tail' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap tail)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: SUDO cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(SUDO cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sUdO cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sUdO cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: SUdo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(SUdo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: SuDo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(SuDo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: SUDo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(SUDo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudO cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudO cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: SuDO cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(SuDO cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: suDo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(suDo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: suDO cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(suDO cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: ENV cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ENV cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eNv cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eNv cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: ENv cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ENv cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: EnV cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(EnV cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: enV cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(enV cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: NICE cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(NICE cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nIcE cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nIcE cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: TIME cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(TIME cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: tImE cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(tImE cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: NOHUP cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(NOHUP cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nOhUp cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nOhUp cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: RLWRAP cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(RLWRAP cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rLwRaP cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rLwRaP cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin cd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin cd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin rm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin mv' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin cp' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command cd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command cd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command rm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command mv' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command cp' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec cd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec cd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec rm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec mv' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec cp' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval cd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval cd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval rm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval mv' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval cp' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob echo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob cd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob cd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob rm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob mv' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob cp' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob cat' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob grep' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob sed' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob awk' {
    ZPWR_EXPAND_WORDS_LPARTITION=(noglob awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect rm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect mv' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect cp' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect apt' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect apt)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect npm' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect brew' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect brew)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect dnf' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect dnf)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect yum' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect yum)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect pacman' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect pacman)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect docker' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect kubectl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect kubectl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command sudo cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command sudo cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command time cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command time cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command nice cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command nice cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command nohup cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command rlwrap cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command rlwrap cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time sudo git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sudo git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice nohup server' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice nohup server)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect sudo apt' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect sudo apt)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time nice make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time nice make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin command ls' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin command ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect time sudo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect time sudo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time nohup sudo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time nohup sudo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice time sudo' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice time sudo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap nice node' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap nice node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time rlwrap python' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time rlwrap python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup time make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup time make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time sudo -E cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sudo -E cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice sudo -b cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice sudo -b cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup sudo -E cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup sudo -E cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time env -i cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time env -i cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice env -v cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice env -v cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -- cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -- cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain docker matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain echo matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain make matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain python matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain cargo matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cargo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain npm matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain cat matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain grep matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain sed matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sed)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain awk matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(awk)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain find matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(find)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain sort matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sort)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain uniq matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(uniq)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain wc matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(wc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain head matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(head)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain tail matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(tail)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain mv matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain cp matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain rm matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain mkdir matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(mkdir)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain rmdir matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rmdir)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain chmod matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(chmod)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain chown matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(chown)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain tar matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(tar)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain gzip matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(gzip)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain bzip2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(bzip2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain xz matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(xz)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain zip matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(zip)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain unzip matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(unzip)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain curl matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(curl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain wget matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(wget)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain ssh matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ssh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain scp matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(scp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain rsync matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rsync)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain mount matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(mount)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain umount matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(umount)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain kill matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(kill)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain ps matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ps)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain top matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(top)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain htop matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(htop)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain df matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(df)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain du matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(du)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain free matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(free)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain uname matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(uname)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain hostname matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(hostname)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain whoami matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(whoami)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain date matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(date)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain cal matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cal)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain bc matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(bc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain dc matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(dc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain factor matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(factor)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain seq matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(seq)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain shuf matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(shuf)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain comm matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(comm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain join matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(join)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain paste matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(paste)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain nl matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain pr matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(pr)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain fold matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(fold)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain fmt matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(fmt)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain tr matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(tr)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain cut matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cut)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain tee matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(tee)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain xargs matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(xargs)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain ruby matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ruby)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain perl matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(perl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain java matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(java)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain go matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(go)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain node matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain ls arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ls arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain git arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(git arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain docker arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(docker arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain echo arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(echo arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain make arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(make arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain python arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(python arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain cat arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cat arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain grep arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(grep arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain sed arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sed arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain awk arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(awk arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain find arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(find arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain sort arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sort arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain head arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(head arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain tail arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(tail arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain mv arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(mv arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain cp arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cp arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain rm arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rm arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain mkdir arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(mkdir arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain curl arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(curl arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain wget arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(wget arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain ssh arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ssh arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain node arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(node arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain ruby arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ruby arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: plain perl arg1 arg2 matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(perl arg1 arg2)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: sudo git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo git)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: sudo -E git log' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -E git log)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: env python' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env python)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: env -i make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -i make)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: time ls -la' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time ls -la)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: nice gcc -O2' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice gcc -O2)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: nohup server start' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup server start)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: rlwrap sbcl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap sbcl)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: builtin echo hello' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin echo hello)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: command ls -la' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command ls -la)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: nocorrect rm -rf' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect rm -rf)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: time sudo git status' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sudo git status)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: sudo env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo env cmd)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture expand: time nice make -j4' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time nice make -j4)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex capture correct: sudo git' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo git)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: sudo -E git log' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -E git log)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: env python' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env python)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: env -i make' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -i make)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: time ls -la' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time ls -la)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: nice gcc -O2' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice gcc -O2)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: nohup server start' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup server start)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: rlwrap sbcl' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap sbcl)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: builtin echo hello' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin echo hello)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: command ls -la' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command ls -la)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: nocorrect rm -rf' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect rm -rf)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: time sudo git status' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sudo git status)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: sudo env cmd' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo env cmd)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

@test 'regex capture correct: time nice make -j4' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time nice make -j4)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert $state equals 0
}

