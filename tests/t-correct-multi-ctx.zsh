#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Mar 25 2026
##### Purpose: multi-context correction tests
##### Notes: tests corrections in print, cat, grep, sed, awk, man, ls contexts
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

    function correct_in_ctx() {
        local ctx=$1 word=$2
        LBUFFER="$ctx $word"
        ZPWR_VARS[foundIncorrect]=false
        zpwrExpandParseWords "$LBUFFER"
        zpwrExpandCorrectWord
    }
}

@test 'print: aobut -> about' {
    correct_in_ctx print aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print about'
}

@test 'cat: aobut -> about' {
    correct_in_ctx cat aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat about'
}

@test 'grep: aobut -> about' {
    correct_in_ctx grep aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep about'
}

@test 'sed: aobut -> about' {
    correct_in_ctx sed aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed about'
}

@test 'awk: aobut -> about' {
    correct_in_ctx awk aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk about'
}

@test 'man: aobut -> about' {
    correct_in_ctx man aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man about'
}

@test 'ls: aobut -> about' {
    correct_in_ctx ls aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls about'
}

@test 'head: aobut -> about' {
    correct_in_ctx head aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head about'
}

@test 'tail: aobut -> about' {
    correct_in_ctx tail aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail about'
}

@test 'sort: aobut -> about' {
    correct_in_ctx sort aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort about'
}

@test 'uniq: aobut -> about' {
    correct_in_ctx uniq aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq about'
}

@test 'wc: aobut -> about' {
    correct_in_ctx wc aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc about'
}

@test 'tr: aobut -> about' {
    correct_in_ctx tr aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr about'
}

@test 'cut: aobut -> about' {
    correct_in_ctx cut aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut about'
}

@test 'diff: aobut -> about' {
    correct_in_ctx diff aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff about'
}

@test 'print: aka -> AKA' {
    correct_in_ctx print aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print AKA'
}

@test 'cat: aka -> AKA' {
    correct_in_ctx cat aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat AKA'
}

@test 'grep: aka -> AKA' {
    correct_in_ctx grep aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep AKA'
}

@test 'sed: aka -> AKA' {
    correct_in_ctx sed aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed AKA'
}

@test 'awk: aka -> AKA' {
    correct_in_ctx awk aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk AKA'
}

@test 'man: aka -> AKA' {
    correct_in_ctx man aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man AKA'
}

@test 'ls: aka -> AKA' {
    correct_in_ctx ls aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls AKA'
}

@test 'head: aka -> AKA' {
    correct_in_ctx head aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head AKA'
}

@test 'tail: aka -> AKA' {
    correct_in_ctx tail aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail AKA'
}

@test 'sort: aka -> AKA' {
    correct_in_ctx sort aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort AKA'
}

@test 'uniq: aka -> AKA' {
    correct_in_ctx uniq aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq AKA'
}

@test 'wc: aka -> AKA' {
    correct_in_ctx wc aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc AKA'
}

@test 'tr: aka -> AKA' {
    correct_in_ctx tr aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr AKA'
}

@test 'cut: aka -> AKA' {
    correct_in_ctx cut aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut AKA'
}

@test 'diff: aka -> AKA' {
    correct_in_ctx diff aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff AKA'
}

@test 'print: alll -> all' {
    correct_in_ctx print alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print all'
}

@test 'cat: alll -> all' {
    correct_in_ctx cat alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat all'
}

@test 'grep: alll -> all' {
    correct_in_ctx grep alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep all'
}

@test 'sed: alll -> all' {
    correct_in_ctx sed alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed all'
}

@test 'awk: alll -> all' {
    correct_in_ctx awk alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk all'
}

@test 'man: alll -> all' {
    correct_in_ctx man alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man all'
}

@test 'ls: alll -> all' {
    correct_in_ctx ls alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls all'
}

@test 'head: alll -> all' {
    correct_in_ctx head alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head all'
}

@test 'tail: alll -> all' {
    correct_in_ctx tail alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail all'
}

@test 'sort: alll -> all' {
    correct_in_ctx sort alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort all'
}

@test 'uniq: alll -> all' {
    correct_in_ctx uniq alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq all'
}

@test 'wc: alll -> all' {
    correct_in_ctx wc alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc all'
}

@test 'tr: alll -> all' {
    correct_in_ctx tr alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr all'
}

@test 'cut: alll -> all' {
    correct_in_ctx cut alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut all'
}

@test 'diff: alll -> all' {
    correct_in_ctx diff alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff all'
}

@test 'print: laso -> also' {
    correct_in_ctx print laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print also'
}

@test 'cat: laso -> also' {
    correct_in_ctx cat laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat also'
}

@test 'grep: laso -> also' {
    correct_in_ctx grep laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep also'
}

@test 'sed: laso -> also' {
    correct_in_ctx sed laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed also'
}

@test 'awk: laso -> also' {
    correct_in_ctx awk laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk also'
}

@test 'man: laso -> also' {
    correct_in_ctx man laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man also'
}

@test 'ls: laso -> also' {
    correct_in_ctx ls laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls also'
}

@test 'head: laso -> also' {
    correct_in_ctx head laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head also'
}

@test 'tail: laso -> also' {
    correct_in_ctx tail laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail also'
}

@test 'sort: laso -> also' {
    correct_in_ctx sort laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort also'
}

@test 'uniq: laso -> also' {
    correct_in_ctx uniq laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq also'
}

@test 'wc: laso -> also' {
    correct_in_ctx wc laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc also'
}

@test 'tr: laso -> also' {
    correct_in_ctx tr laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr also'
}

@test 'cut: laso -> also' {
    correct_in_ctx cut laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut also'
}

@test 'diff: laso -> also' {
    correct_in_ctx diff laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff also'
}

@test 'print: alternaet -> alternate' {
    correct_in_ctx print alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print alternate'
}

@test 'cat: alternaet -> alternate' {
    correct_in_ctx cat alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat alternate'
}

@test 'grep: alternaet -> alternate' {
    correct_in_ctx grep alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep alternate'
}

@test 'sed: alternaet -> alternate' {
    correct_in_ctx sed alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed alternate'
}

@test 'awk: alternaet -> alternate' {
    correct_in_ctx awk alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk alternate'
}

@test 'man: alternaet -> alternate' {
    correct_in_ctx man alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man alternate'
}

@test 'ls: alternaet -> alternate' {
    correct_in_ctx ls alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls alternate'
}

@test 'head: alternaet -> alternate' {
    correct_in_ctx head alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head alternate'
}

@test 'tail: alternaet -> alternate' {
    correct_in_ctx tail alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail alternate'
}

@test 'sort: alternaet -> alternate' {
    correct_in_ctx sort alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort alternate'
}

@test 'uniq: alternaet -> alternate' {
    correct_in_ctx uniq alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq alternate'
}

@test 'wc: alternaet -> alternate' {
    correct_in_ctx wc alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc alternate'
}

@test 'tr: alternaet -> alternate' {
    correct_in_ctx tr alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr alternate'
}

@test 'cut: alternaet -> alternate' {
    correct_in_ctx cut alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut alternate'
}

@test 'diff: alternaet -> alternate' {
    correct_in_ctx diff alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff alternate'
}

@test 'print: adn -> and' {
    correct_in_ctx print adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print and'
}

@test 'cat: adn -> and' {
    correct_in_ctx cat adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat and'
}

@test 'grep: adn -> and' {
    correct_in_ctx grep adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep and'
}

@test 'sed: adn -> and' {
    correct_in_ctx sed adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed and'
}

@test 'awk: adn -> and' {
    correct_in_ctx awk adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk and'
}

@test 'man: adn -> and' {
    correct_in_ctx man adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man and'
}

@test 'ls: adn -> and' {
    correct_in_ctx ls adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls and'
}

@test 'head: adn -> and' {
    correct_in_ctx head adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head and'
}

@test 'tail: adn -> and' {
    correct_in_ctx tail adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail and'
}

@test 'sort: adn -> and' {
    correct_in_ctx sort adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort and'
}

@test 'uniq: adn -> and' {
    correct_in_ctx uniq adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq and'
}

@test 'wc: adn -> and' {
    correct_in_ctx wc adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc and'
}

@test 'tr: adn -> and' {
    correct_in_ctx tr adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr and'
}

@test 'cut: adn -> and' {
    correct_in_ctx cut adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut and'
}

@test 'diff: adn -> and' {
    correct_in_ctx diff adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff and'
}

@test 'print: ansi -> ANSI' {
    correct_in_ctx print ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print ANSI'
}

@test 'cat: ansi -> ANSI' {
    correct_in_ctx cat ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat ANSI'
}

@test 'grep: ansi -> ANSI' {
    correct_in_ctx grep ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep ANSI'
}

@test 'sed: ansi -> ANSI' {
    correct_in_ctx sed ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed ANSI'
}

@test 'awk: ansi -> ANSI' {
    correct_in_ctx awk ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk ANSI'
}

@test 'man: ansi -> ANSI' {
    correct_in_ctx man ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man ANSI'
}

@test 'ls: ansi -> ANSI' {
    correct_in_ctx ls ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls ANSI'
}

@test 'head: ansi -> ANSI' {
    correct_in_ctx head ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head ANSI'
}

@test 'tail: ansi -> ANSI' {
    correct_in_ctx tail ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail ANSI'
}

@test 'sort: ansi -> ANSI' {
    correct_in_ctx sort ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort ANSI'
}

@test 'uniq: ansi -> ANSI' {
    correct_in_ctx uniq ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq ANSI'
}

@test 'wc: ansi -> ANSI' {
    correct_in_ctx wc ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc ANSI'
}

@test 'tr: ansi -> ANSI' {
    correct_in_ctx tr ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr ANSI'
}

@test 'cut: ansi -> ANSI' {
    correct_in_ctx cut ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut ANSI'
}

@test 'diff: ansi -> ANSI' {
    correct_in_ctx diff ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff ANSI'
}

@test 'print: aer -> are' {
    correct_in_ctx print aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print are'
}

@test 'cat: aer -> are' {
    correct_in_ctx cat aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat are'
}

@test 'grep: aer -> are' {
    correct_in_ctx grep aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep are'
}

@test 'sed: aer -> are' {
    correct_in_ctx sed aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed are'
}

@test 'awk: aer -> are' {
    correct_in_ctx awk aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk are'
}

@test 'man: aer -> are' {
    correct_in_ctx man aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man are'
}

@test 'ls: aer -> are' {
    correct_in_ctx ls aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls are'
}

@test 'head: aer -> are' {
    correct_in_ctx head aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head are'
}

@test 'tail: aer -> are' {
    correct_in_ctx tail aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail are'
}

@test 'sort: aer -> are' {
    correct_in_ctx sort aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort are'
}

@test 'uniq: aer -> are' {
    correct_in_ctx uniq aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq are'
}

@test 'wc: aer -> are' {
    correct_in_ctx wc aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc are'
}

@test 'tr: aer -> are' {
    correct_in_ctx tr aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr are'
}

@test 'cut: aer -> are' {
    correct_in_ctx cut aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut are'
}

@test 'diff: aer -> are' {
    correct_in_ctx diff aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff are'
}

@test 'print: arg -> argument' {
    correct_in_ctx print arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print argument'
}

@test 'cat: arg -> argument' {
    correct_in_ctx cat arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat argument'
}

@test 'grep: arg -> argument' {
    correct_in_ctx grep arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep argument'
}

@test 'sed: arg -> argument' {
    correct_in_ctx sed arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed argument'
}

@test 'awk: arg -> argument' {
    correct_in_ctx awk arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk argument'
}

@test 'man: arg -> argument' {
    correct_in_ctx man arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man argument'
}

@test 'ls: arg -> argument' {
    correct_in_ctx ls arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls argument'
}

@test 'head: arg -> argument' {
    correct_in_ctx head arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head argument'
}

@test 'tail: arg -> argument' {
    correct_in_ctx tail arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail argument'
}

@test 'sort: arg -> argument' {
    correct_in_ctx sort arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort argument'
}

@test 'uniq: arg -> argument' {
    correct_in_ctx uniq arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq argument'
}

@test 'wc: arg -> argument' {
    correct_in_ctx wc arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc argument'
}

@test 'tr: arg -> argument' {
    correct_in_ctx tr arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr argument'
}

@test 'cut: arg -> argument' {
    correct_in_ctx cut arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut argument'
}

@test 'diff: arg -> argument' {
    correct_in_ctx diff arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff argument'
}

@test 'print: args -> arguments' {
    correct_in_ctx print args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print arguments'
}

@test 'cat: args -> arguments' {
    correct_in_ctx cat args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat arguments'
}

@test 'grep: args -> arguments' {
    correct_in_ctx grep args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep arguments'
}

@test 'sed: args -> arguments' {
    correct_in_ctx sed args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed arguments'
}

@test 'awk: args -> arguments' {
    correct_in_ctx awk args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk arguments'
}

@test 'man: args -> arguments' {
    correct_in_ctx man args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man arguments'
}

@test 'ls: args -> arguments' {
    correct_in_ctx ls args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls arguments'
}

@test 'head: args -> arguments' {
    correct_in_ctx head args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head arguments'
}

@test 'tail: args -> arguments' {
    correct_in_ctx tail args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail arguments'
}

@test 'sort: args -> arguments' {
    correct_in_ctx sort args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort arguments'
}

@test 'uniq: args -> arguments' {
    correct_in_ctx uniq args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq arguments'
}

@test 'wc: args -> arguments' {
    correct_in_ctx wc args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc arguments'
}

@test 'tr: args -> arguments' {
    correct_in_ctx tr args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr arguments'
}

@test 'cut: args -> arguments' {
    correct_in_ctx cut args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut arguments'
}

@test 'diff: args -> arguments' {
    correct_in_ctx diff args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff arguments'
}

@test 'print: arrayy -> array' {
    correct_in_ctx print arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print array'
}

@test 'cat: arrayy -> array' {
    correct_in_ctx cat arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat array'
}

@test 'grep: arrayy -> array' {
    correct_in_ctx grep arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep array'
}

@test 'sed: arrayy -> array' {
    correct_in_ctx sed arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed array'
}

@test 'awk: arrayy -> array' {
    correct_in_ctx awk arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk array'
}

@test 'man: arrayy -> array' {
    correct_in_ctx man arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man array'
}

@test 'ls: arrayy -> array' {
    correct_in_ctx ls arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls array'
}

@test 'head: arrayy -> array' {
    correct_in_ctx head arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head array'
}

@test 'tail: arrayy -> array' {
    correct_in_ctx tail arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail array'
}

@test 'sort: arrayy -> array' {
    correct_in_ctx sort arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort array'
}

@test 'uniq: arrayy -> array' {
    correct_in_ctx uniq arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq array'
}

@test 'wc: arrayy -> array' {
    correct_in_ctx wc arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc array'
}

@test 'tr: arrayy -> array' {
    correct_in_ctx tr arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr array'
}

@test 'cut: arrayy -> array' {
    correct_in_ctx cut arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut array'
}

@test 'diff: arrayy -> array' {
    correct_in_ctx diff arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff array'
}

@test 'print: ascii -> ASCII' {
    correct_in_ctx print ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print ASCII'
}

@test 'cat: ascii -> ASCII' {
    correct_in_ctx cat ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat ASCII'
}

@test 'grep: ascii -> ASCII' {
    correct_in_ctx grep ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep ASCII'
}

@test 'sed: ascii -> ASCII' {
    correct_in_ctx sed ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed ASCII'
}

@test 'awk: ascii -> ASCII' {
    correct_in_ctx awk ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk ASCII'
}

@test 'man: ascii -> ASCII' {
    correct_in_ctx man ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man ASCII'
}

@test 'ls: ascii -> ASCII' {
    correct_in_ctx ls ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls ASCII'
}

@test 'head: ascii -> ASCII' {
    correct_in_ctx head ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head ASCII'
}

@test 'tail: ascii -> ASCII' {
    correct_in_ctx tail ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail ASCII'
}

@test 'sort: ascii -> ASCII' {
    correct_in_ctx sort ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort ASCII'
}

@test 'uniq: ascii -> ASCII' {
    correct_in_ctx uniq ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq ASCII'
}

@test 'wc: ascii -> ASCII' {
    correct_in_ctx wc ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc ASCII'
}

@test 'tr: ascii -> ASCII' {
    correct_in_ctx tr ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr ASCII'
}

@test 'cut: ascii -> ASCII' {
    correct_in_ctx cut ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut ASCII'
}

@test 'diff: ascii -> ASCII' {
    correct_in_ctx diff ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff ASCII'
}

@test 'print: auto -> automatically' {
    correct_in_ctx print auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print automatically'
}

@test 'cat: auto -> automatically' {
    correct_in_ctx cat auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat automatically'
}

@test 'grep: auto -> automatically' {
    correct_in_ctx grep auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep automatically'
}

@test 'sed: auto -> automatically' {
    correct_in_ctx sed auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed automatically'
}

@test 'awk: auto -> automatically' {
    correct_in_ctx awk auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk automatically'
}

@test 'man: auto -> automatically' {
    correct_in_ctx man auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man automatically'
}

@test 'ls: auto -> automatically' {
    correct_in_ctx ls auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls automatically'
}

@test 'head: auto -> automatically' {
    correct_in_ctx head auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head automatically'
}

@test 'tail: auto -> automatically' {
    correct_in_ctx tail auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail automatically'
}

@test 'sort: auto -> automatically' {
    correct_in_ctx sort auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort automatically'
}

@test 'uniq: auto -> automatically' {
    correct_in_ctx uniq auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq automatically'
}

@test 'wc: auto -> automatically' {
    correct_in_ctx wc auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc automatically'
}

@test 'tr: auto -> automatically' {
    correct_in_ctx tr auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr automatically'
}

@test 'cut: auto -> automatically' {
    correct_in_ctx cut auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut automatically'
}

@test 'diff: auto -> automatically' {
    correct_in_ctx diff auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff automatically'
}

@test 'print: aws -> AWS' {
    correct_in_ctx print aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print AWS'
}

@test 'cat: aws -> AWS' {
    correct_in_ctx cat aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat AWS'
}

@test 'grep: aws -> AWS' {
    correct_in_ctx grep aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep AWS'
}

@test 'sed: aws -> AWS' {
    correct_in_ctx sed aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed AWS'
}

@test 'awk: aws -> AWS' {
    correct_in_ctx awk aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk AWS'
}

@test 'man: aws -> AWS' {
    correct_in_ctx man aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man AWS'
}

@test 'ls: aws -> AWS' {
    correct_in_ctx ls aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls AWS'
}

@test 'head: aws -> AWS' {
    correct_in_ctx head aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head AWS'
}

@test 'tail: aws -> AWS' {
    correct_in_ctx tail aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail AWS'
}

@test 'sort: aws -> AWS' {
    correct_in_ctx sort aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort AWS'
}

@test 'uniq: aws -> AWS' {
    correct_in_ctx uniq aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq AWS'
}

@test 'wc: aws -> AWS' {
    correct_in_ctx wc aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc AWS'
}

@test 'tr: aws -> AWS' {
    correct_in_ctx tr aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr AWS'
}

@test 'cut: aws -> AWS' {
    correct_in_ctx cut aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut AWS'
}

@test 'diff: aws -> AWS' {
    correct_in_ctx diff aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff AWS'
}

@test 'print: bkac -> back' {
    correct_in_ctx print bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print back'
}

@test 'cat: bkac -> back' {
    correct_in_ctx cat bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat back'
}

@test 'grep: bkac -> back' {
    correct_in_ctx grep bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep back'
}

@test 'sed: bkac -> back' {
    correct_in_ctx sed bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed back'
}

@test 'awk: bkac -> back' {
    correct_in_ctx awk bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk back'
}

@test 'man: bkac -> back' {
    correct_in_ctx man bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man back'
}

@test 'ls: bkac -> back' {
    correct_in_ctx ls bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls back'
}

@test 'head: bkac -> back' {
    correct_in_ctx head bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head back'
}

@test 'tail: bkac -> back' {
    correct_in_ctx tail bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail back'
}

@test 'sort: bkac -> back' {
    correct_in_ctx sort bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort back'
}

@test 'uniq: bkac -> back' {
    correct_in_ctx uniq bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq back'
}

@test 'wc: bkac -> back' {
    correct_in_ctx wc bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc back'
}

@test 'tr: bkac -> back' {
    correct_in_ctx tr bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr back'
}

@test 'cut: bkac -> back' {
    correct_in_ctx cut bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut back'
}

@test 'diff: bkac -> back' {
    correct_in_ctx diff bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff back'
}

@test 'print: bg -> background' {
    correct_in_ctx print bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print background'
}

@test 'cat: bg -> background' {
    correct_in_ctx cat bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat background'
}

@test 'grep: bg -> background' {
    correct_in_ctx grep bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep background'
}

@test 'sed: bg -> background' {
    correct_in_ctx sed bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed background'
}

@test 'awk: bg -> background' {
    correct_in_ctx awk bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk background'
}

@test 'man: bg -> background' {
    correct_in_ctx man bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man background'
}

@test 'ls: bg -> background' {
    correct_in_ctx ls bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls background'
}

@test 'head: bg -> background' {
    correct_in_ctx head bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head background'
}

@test 'tail: bg -> background' {
    correct_in_ctx tail bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail background'
}

@test 'sort: bg -> background' {
    correct_in_ctx sort bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort background'
}

@test 'uniq: bg -> background' {
    correct_in_ctx uniq bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq background'
}

@test 'wc: bg -> background' {
    correct_in_ctx wc bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc background'
}

@test 'tr: bg -> background' {
    correct_in_ctx tr bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr background'
}

@test 'cut: bg -> background' {
    correct_in_ctx cut bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut background'
}

@test 'diff: bg -> background' {
    correct_in_ctx diff bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff background'
}

@test 'print: bda -> bad' {
    correct_in_ctx print bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print bad'
}

@test 'cat: bda -> bad' {
    correct_in_ctx cat bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat bad'
}

@test 'grep: bda -> bad' {
    correct_in_ctx grep bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep bad'
}

@test 'sed: bda -> bad' {
    correct_in_ctx sed bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed bad'
}

@test 'awk: bda -> bad' {
    correct_in_ctx awk bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk bad'
}

@test 'man: bda -> bad' {
    correct_in_ctx man bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man bad'
}

@test 'ls: bda -> bad' {
    correct_in_ctx ls bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls bad'
}

@test 'head: bda -> bad' {
    correct_in_ctx head bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head bad'
}

@test 'tail: bda -> bad' {
    correct_in_ctx tail bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail bad'
}

@test 'sort: bda -> bad' {
    correct_in_ctx sort bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort bad'
}

@test 'uniq: bda -> bad' {
    correct_in_ctx uniq bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq bad'
}

@test 'wc: bda -> bad' {
    correct_in_ctx wc bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc bad'
}

@test 'tr: bda -> bad' {
    correct_in_ctx tr bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr bad'
}

@test 'cut: bda -> bad' {
    correct_in_ctx cut bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut bad'
}

@test 'diff: bda -> bad' {
    correct_in_ctx diff bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff bad'
}

@test 'print: bw -> bandwidth' {
    correct_in_ctx print bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print bandwidth'
}

@test 'cat: bw -> bandwidth' {
    correct_in_ctx cat bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat bandwidth'
}

@test 'grep: bw -> bandwidth' {
    correct_in_ctx grep bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep bandwidth'
}

@test 'sed: bw -> bandwidth' {
    correct_in_ctx sed bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed bandwidth'
}

@test 'awk: bw -> bandwidth' {
    correct_in_ctx awk bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk bandwidth'
}

@test 'man: bw -> bandwidth' {
    correct_in_ctx man bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man bandwidth'
}

@test 'ls: bw -> bandwidth' {
    correct_in_ctx ls bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls bandwidth'
}

@test 'head: bw -> bandwidth' {
    correct_in_ctx head bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head bandwidth'
}

@test 'tail: bw -> bandwidth' {
    correct_in_ctx tail bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail bandwidth'
}

@test 'sort: bw -> bandwidth' {
    correct_in_ctx sort bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort bandwidth'
}

@test 'uniq: bw -> bandwidth' {
    correct_in_ctx uniq bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq bandwidth'
}

@test 'wc: bw -> bandwidth' {
    correct_in_ctx wc bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc bandwidth'
}

@test 'tr: bw -> bandwidth' {
    correct_in_ctx tr bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr bandwidth'
}

@test 'cut: bw -> bandwidth' {
    correct_in_ctx cut bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut bandwidth'
}

@test 'diff: bw -> bandwidth' {
    correct_in_ctx diff bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff bandwidth'
}

@test 'print: baesd -> based' {
    correct_in_ctx print baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print based'
}

@test 'cat: baesd -> based' {
    correct_in_ctx cat baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat based'
}

@test 'grep: baesd -> based' {
    correct_in_ctx grep baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep based'
}

@test 'sed: baesd -> based' {
    correct_in_ctx sed baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed based'
}

@test 'awk: baesd -> based' {
    correct_in_ctx awk baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk based'
}

@test 'man: baesd -> based' {
    correct_in_ctx man baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man based'
}

@test 'ls: baesd -> based' {
    correct_in_ctx ls baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls based'
}

@test 'head: baesd -> based' {
    correct_in_ctx head baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head based'
}

@test 'tail: baesd -> based' {
    correct_in_ctx tail baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail based'
}

@test 'sort: baesd -> based' {
    correct_in_ctx sort baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort based'
}

@test 'uniq: baesd -> based' {
    correct_in_ctx uniq baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq based'
}

@test 'wc: baesd -> based' {
    correct_in_ctx wc baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc based'
}

@test 'tr: baesd -> based' {
    correct_in_ctx tr baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr based'
}

@test 'cut: baesd -> based' {
    correct_in_ctx cut baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut based'
}

@test 'diff: baesd -> based' {
    correct_in_ctx diff baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff based'
}

@test 'print: bahs -> bash' {
    correct_in_ctx print bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print bash'
}

@test 'cat: bahs -> bash' {
    correct_in_ctx cat bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat bash'
}

@test 'grep: bahs -> bash' {
    correct_in_ctx grep bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep bash'
}

@test 'sed: bahs -> bash' {
    correct_in_ctx sed bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed bash'
}

@test 'awk: bahs -> bash' {
    correct_in_ctx awk bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk bash'
}

@test 'man: bahs -> bash' {
    correct_in_ctx man bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man bash'
}

@test 'ls: bahs -> bash' {
    correct_in_ctx ls bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls bash'
}

@test 'head: bahs -> bash' {
    correct_in_ctx head bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head bash'
}

@test 'tail: bahs -> bash' {
    correct_in_ctx tail bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail bash'
}

@test 'sort: bahs -> bash' {
    correct_in_ctx sort bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort bash'
}

@test 'uniq: bahs -> bash' {
    correct_in_ctx uniq bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq bash'
}

@test 'wc: bahs -> bash' {
    correct_in_ctx wc bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc bash'
}

@test 'tr: bahs -> bash' {
    correct_in_ctx tr bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr bash'
}

@test 'cut: bahs -> bash' {
    correct_in_ctx cut bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut bash'
}

@test 'diff: bahs -> bash' {
    correct_in_ctx diff bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff bash'
}

@test 'print: bc -> because' {
    correct_in_ctx print bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print because'
}

@test 'cat: bc -> because' {
    correct_in_ctx cat bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat because'
}

@test 'grep: bc -> because' {
    correct_in_ctx grep bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep because'
}

@test 'sed: bc -> because' {
    correct_in_ctx sed bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed because'
}

@test 'awk: bc -> because' {
    correct_in_ctx awk bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk because'
}

@test 'man: bc -> because' {
    correct_in_ctx man bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man because'
}

@test 'ls: bc -> because' {
    correct_in_ctx ls bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls because'
}

@test 'head: bc -> because' {
    correct_in_ctx head bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head because'
}

@test 'tail: bc -> because' {
    correct_in_ctx tail bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail because'
}

@test 'sort: bc -> because' {
    correct_in_ctx sort bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort because'
}

@test 'uniq: bc -> because' {
    correct_in_ctx uniq bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq because'
}

@test 'wc: bc -> because' {
    correct_in_ctx wc bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc because'
}

@test 'tr: bc -> because' {
    correct_in_ctx tr bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr because'
}

@test 'cut: bc -> because' {
    correct_in_ctx cut bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut because'
}

@test 'diff: bc -> because' {
    correct_in_ctx diff bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff because'
}

@test 'print: befor -> before' {
    correct_in_ctx print befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print before'
}

@test 'cat: befor -> before' {
    correct_in_ctx cat befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat before'
}

@test 'grep: befor -> before' {
    correct_in_ctx grep befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep before'
}

@test 'sed: befor -> before' {
    correct_in_ctx sed befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed before'
}

@test 'awk: befor -> before' {
    correct_in_ctx awk befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk before'
}

@test 'man: befor -> before' {
    correct_in_ctx man befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man before'
}

@test 'ls: befor -> before' {
    correct_in_ctx ls befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls before'
}

@test 'head: befor -> before' {
    correct_in_ctx head befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head before'
}

@test 'tail: befor -> before' {
    correct_in_ctx tail befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail before'
}

@test 'sort: befor -> before' {
    correct_in_ctx sort befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort before'
}

@test 'uniq: befor -> before' {
    correct_in_ctx uniq befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq before'
}

@test 'wc: befor -> before' {
    correct_in_ctx wc befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc before'
}

@test 'tr: befor -> before' {
    correct_in_ctx tr befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr before'
}

@test 'cut: befor -> before' {
    correct_in_ctx cut befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut before'
}

@test 'diff: befor -> before' {
    correct_in_ctx diff befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff before'
}

@test 'print: bets -> best' {
    correct_in_ctx print bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print best'
}

@test 'cat: bets -> best' {
    correct_in_ctx cat bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat best'
}

@test 'grep: bets -> best' {
    correct_in_ctx grep bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep best'
}

@test 'sed: bets -> best' {
    correct_in_ctx sed bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed best'
}

@test 'awk: bets -> best' {
    correct_in_ctx awk bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk best'
}

@test 'man: bets -> best' {
    correct_in_ctx man bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man best'
}

@test 'ls: bets -> best' {
    correct_in_ctx ls bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls best'
}

@test 'head: bets -> best' {
    correct_in_ctx head bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head best'
}

@test 'tail: bets -> best' {
    correct_in_ctx tail bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail best'
}

@test 'sort: bets -> best' {
    correct_in_ctx sort bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort best'
}

@test 'uniq: bets -> best' {
    correct_in_ctx uniq bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq best'
}

@test 'wc: bets -> best' {
    correct_in_ctx wc bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc best'
}

@test 'tr: bets -> best' {
    correct_in_ctx tr bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr best'
}

@test 'cut: bets -> best' {
    correct_in_ctx cut bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut best'
}

@test 'diff: bets -> best' {
    correct_in_ctx diff bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff best'
}

@test 'print: bt -> between' {
    correct_in_ctx print bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print between'
}

@test 'cat: bt -> between' {
    correct_in_ctx cat bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat between'
}

@test 'grep: bt -> between' {
    correct_in_ctx grep bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep between'
}

@test 'sed: bt -> between' {
    correct_in_ctx sed bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed between'
}

@test 'awk: bt -> between' {
    correct_in_ctx awk bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk between'
}

@test 'man: bt -> between' {
    correct_in_ctx man bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man between'
}

@test 'ls: bt -> between' {
    correct_in_ctx ls bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls between'
}

@test 'head: bt -> between' {
    correct_in_ctx head bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head between'
}

@test 'tail: bt -> between' {
    correct_in_ctx tail bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail between'
}

@test 'sort: bt -> between' {
    correct_in_ctx sort bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort between'
}

@test 'uniq: bt -> between' {
    correct_in_ctx uniq bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq between'
}

@test 'wc: bt -> between' {
    correct_in_ctx wc bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc between'
}

@test 'tr: bt -> between' {
    correct_in_ctx tr bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr between'
}

@test 'cut: bt -> between' {
    correct_in_ctx cut bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut between'
}

@test 'diff: bt -> between' {
    correct_in_ctx diff bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff between'
}

@test 'print: bianry -> binary' {
    correct_in_ctx print bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print binary'
}

@test 'cat: bianry -> binary' {
    correct_in_ctx cat bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat binary'
}

@test 'grep: bianry -> binary' {
    correct_in_ctx grep bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep binary'
}

@test 'sed: bianry -> binary' {
    correct_in_ctx sed bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed binary'
}

@test 'awk: bianry -> binary' {
    correct_in_ctx awk bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk binary'
}

@test 'man: bianry -> binary' {
    correct_in_ctx man bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man binary'
}

@test 'ls: bianry -> binary' {
    correct_in_ctx ls bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls binary'
}

@test 'head: bianry -> binary' {
    correct_in_ctx head bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head binary'
}

@test 'tail: bianry -> binary' {
    correct_in_ctx tail bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail binary'
}

@test 'sort: bianry -> binary' {
    correct_in_ctx sort bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort binary'
}

@test 'uniq: bianry -> binary' {
    correct_in_ctx uniq bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq binary'
}

@test 'wc: bianry -> binary' {
    correct_in_ctx wc bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc binary'
}

@test 'tr: bianry -> binary' {
    correct_in_ctx tr bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr binary'
}

@test 'cut: bianry -> binary' {
    correct_in_ctx cut bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut binary'
}

@test 'diff: bianry -> binary' {
    correct_in_ctx diff bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff binary'
}

@test 'print: bios -> BIOS' {
    correct_in_ctx print bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print BIOS'
}

@test 'cat: bios -> BIOS' {
    correct_in_ctx cat bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat BIOS'
}

@test 'grep: bios -> BIOS' {
    correct_in_ctx grep bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep BIOS'
}

@test 'sed: bios -> BIOS' {
    correct_in_ctx sed bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed BIOS'
}

@test 'awk: bios -> BIOS' {
    correct_in_ctx awk bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk BIOS'
}

@test 'man: bios -> BIOS' {
    correct_in_ctx man bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man BIOS'
}

@test 'ls: bios -> BIOS' {
    correct_in_ctx ls bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls BIOS'
}

@test 'head: bios -> BIOS' {
    correct_in_ctx head bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head BIOS'
}

@test 'tail: bios -> BIOS' {
    correct_in_ctx tail bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail BIOS'
}

@test 'sort: bios -> BIOS' {
    correct_in_ctx sort bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort BIOS'
}

@test 'uniq: bios -> BIOS' {
    correct_in_ctx uniq bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq BIOS'
}

@test 'wc: bios -> BIOS' {
    correct_in_ctx wc bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc BIOS'
}

@test 'tr: bios -> BIOS' {
    correct_in_ctx tr bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr BIOS'
}

@test 'cut: bios -> BIOS' {
    correct_in_ctx cut bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut BIOS'
}

@test 'diff: bios -> BIOS' {
    correct_in_ctx diff bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff BIOS'
}

@test 'print: blokc -> block' {
    correct_in_ctx print blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print block'
}

@test 'cat: blokc -> block' {
    correct_in_ctx cat blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat block'
}

@test 'grep: blokc -> block' {
    correct_in_ctx grep blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep block'
}

@test 'sed: blokc -> block' {
    correct_in_ctx sed blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed block'
}

@test 'awk: blokc -> block' {
    correct_in_ctx awk blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk block'
}

@test 'man: blokc -> block' {
    correct_in_ctx man blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man block'
}

@test 'ls: blokc -> block' {
    correct_in_ctx ls blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls block'
}

@test 'head: blokc -> block' {
    correct_in_ctx head blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head block'
}

@test 'tail: blokc -> block' {
    correct_in_ctx tail blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail block'
}

@test 'sort: blokc -> block' {
    correct_in_ctx sort blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort block'
}

@test 'uniq: blokc -> block' {
    correct_in_ctx uniq blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq block'
}

@test 'wc: blokc -> block' {
    correct_in_ctx wc blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc block'
}

@test 'tr: blokc -> block' {
    correct_in_ctx tr blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr block'
}

@test 'cut: blokc -> block' {
    correct_in_ctx cut blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut block'
}

@test 'diff: blokc -> block' {
    correct_in_ctx diff blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff block'
}

@test 'print: berw -> brew' {
    correct_in_ctx print berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print brew'
}

@test 'cat: berw -> brew' {
    correct_in_ctx cat berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat brew'
}

@test 'grep: berw -> brew' {
    correct_in_ctx grep berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep brew'
}

@test 'sed: berw -> brew' {
    correct_in_ctx sed berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed brew'
}

@test 'awk: berw -> brew' {
    correct_in_ctx awk berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk brew'
}

@test 'man: berw -> brew' {
    correct_in_ctx man berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man brew'
}

@test 'ls: berw -> brew' {
    correct_in_ctx ls berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls brew'
}

@test 'head: berw -> brew' {
    correct_in_ctx head berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head brew'
}

@test 'tail: berw -> brew' {
    correct_in_ctx tail berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail brew'
}

@test 'sort: berw -> brew' {
    correct_in_ctx sort berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort brew'
}

@test 'uniq: berw -> brew' {
    correct_in_ctx uniq berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq brew'
}

@test 'wc: berw -> brew' {
    correct_in_ctx wc berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc brew'
}

@test 'tr: berw -> brew' {
    correct_in_ctx tr berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr brew'
}

@test 'cut: berw -> brew' {
    correct_in_ctx cut berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut brew'
}

@test 'diff: berw -> brew' {
    correct_in_ctx diff berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff brew'
}

@test 'print: bsd -> BSD' {
    correct_in_ctx print bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print BSD'
}

@test 'cat: bsd -> BSD' {
    correct_in_ctx cat bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat BSD'
}

@test 'grep: bsd -> BSD' {
    correct_in_ctx grep bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep BSD'
}

@test 'sed: bsd -> BSD' {
    correct_in_ctx sed bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed BSD'
}

@test 'awk: bsd -> BSD' {
    correct_in_ctx awk bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk BSD'
}

@test 'man: bsd -> BSD' {
    correct_in_ctx man bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man BSD'
}

@test 'ls: bsd -> BSD' {
    correct_in_ctx ls bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls BSD'
}

@test 'head: bsd -> BSD' {
    correct_in_ctx head bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head BSD'
}

@test 'tail: bsd -> BSD' {
    correct_in_ctx tail bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail BSD'
}

@test 'sort: bsd -> BSD' {
    correct_in_ctx sort bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort BSD'
}

@test 'uniq: bsd -> BSD' {
    correct_in_ctx uniq bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq BSD'
}

@test 'wc: bsd -> BSD' {
    correct_in_ctx wc bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc BSD'
}

@test 'tr: bsd -> BSD' {
    correct_in_ctx tr bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr BSD'
}

@test 'cut: bsd -> BSD' {
    correct_in_ctx cut bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut BSD'
}

@test 'diff: bsd -> BSD' {
    correct_in_ctx diff bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff BSD'
}

@test 'print: btw -> by the way' {
    correct_in_ctx print btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print by the way'
}

@test 'cat: btw -> by the way' {
    correct_in_ctx cat btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat by the way'
}

@test 'grep: btw -> by the way' {
    correct_in_ctx grep btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep by the way'
}

@test 'sed: btw -> by the way' {
    correct_in_ctx sed btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed by the way'
}

@test 'awk: btw -> by the way' {
    correct_in_ctx awk btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk by the way'
}

@test 'man: btw -> by the way' {
    correct_in_ctx man btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man by the way'
}

@test 'ls: btw -> by the way' {
    correct_in_ctx ls btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls by the way'
}

@test 'head: btw -> by the way' {
    correct_in_ctx head btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head by the way'
}

@test 'tail: btw -> by the way' {
    correct_in_ctx tail btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail by the way'
}

@test 'sort: btw -> by the way' {
    correct_in_ctx sort btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort by the way'
}

@test 'uniq: btw -> by the way' {
    correct_in_ctx uniq btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq by the way'
}

@test 'wc: btw -> by the way' {
    correct_in_ctx wc btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc by the way'
}

@test 'tr: btw -> by the way' {
    correct_in_ctx tr btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr by the way'
}

@test 'cut: btw -> by the way' {
    correct_in_ctx cut btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut by the way'
}

@test 'diff: btw -> by the way' {
    correct_in_ctx diff btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff by the way'
}

@test 'print: cant -> can not' {
    correct_in_ctx print cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print can not'
}

@test 'cat: cant -> can not' {
    correct_in_ctx cat cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat can not'
}

@test 'grep: cant -> can not' {
    correct_in_ctx grep cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep can not'
}

@test 'sed: cant -> can not' {
    correct_in_ctx sed cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed can not'
}

@test 'awk: cant -> can not' {
    correct_in_ctx awk cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk can not'
}

@test 'man: cant -> can not' {
    correct_in_ctx man cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man can not'
}

@test 'ls: cant -> can not' {
    correct_in_ctx ls cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls can not'
}

@test 'head: cant -> can not' {
    correct_in_ctx head cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head can not'
}

@test 'tail: cant -> can not' {
    correct_in_ctx tail cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail can not'
}

@test 'sort: cant -> can not' {
    correct_in_ctx sort cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort can not'
}

@test 'uniq: cant -> can not' {
    correct_in_ctx uniq cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq can not'
}

@test 'wc: cant -> can not' {
    correct_in_ctx wc cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc can not'
}

@test 'tr: cant -> can not' {
    correct_in_ctx tr cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr can not'
}

@test 'cut: cant -> can not' {
    correct_in_ctx cut cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut can not'
}

@test 'diff: cant -> can not' {
    correct_in_ctx diff cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff can not'
}

@test 'print: catpure -> capture' {
    correct_in_ctx print catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print capture'
}

@test 'cat: catpure -> capture' {
    correct_in_ctx cat catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat capture'
}

@test 'grep: catpure -> capture' {
    correct_in_ctx grep catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep capture'
}

@test 'sed: catpure -> capture' {
    correct_in_ctx sed catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed capture'
}

@test 'awk: catpure -> capture' {
    correct_in_ctx awk catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk capture'
}

@test 'man: catpure -> capture' {
    correct_in_ctx man catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man capture'
}

@test 'ls: catpure -> capture' {
    correct_in_ctx ls catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls capture'
}

@test 'head: catpure -> capture' {
    correct_in_ctx head catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head capture'
}

@test 'tail: catpure -> capture' {
    correct_in_ctx tail catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail capture'
}

@test 'sort: catpure -> capture' {
    correct_in_ctx sort catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort capture'
}

@test 'uniq: catpure -> capture' {
    correct_in_ctx uniq catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq capture'
}

@test 'wc: catpure -> capture' {
    correct_in_ctx wc catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc capture'
}

@test 'tr: catpure -> capture' {
    correct_in_ctx tr catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr capture'
}

@test 'cut: catpure -> capture' {
    correct_in_ctx cut catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut capture'
}

@test 'diff: catpure -> capture' {
    correct_in_ctx diff catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff capture'
}

@test 'print: caes -> case' {
    correct_in_ctx print caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print case'
}

@test 'cat: caes -> case' {
    correct_in_ctx cat caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat case'
}

@test 'grep: caes -> case' {
    correct_in_ctx grep caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep case'
}

@test 'sed: caes -> case' {
    correct_in_ctx sed caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed case'
}

@test 'awk: caes -> case' {
    correct_in_ctx awk caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk case'
}

@test 'man: caes -> case' {
    correct_in_ctx man caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man case'
}

@test 'ls: caes -> case' {
    correct_in_ctx ls caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls case'
}

@test 'head: caes -> case' {
    correct_in_ctx head caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head case'
}

@test 'tail: caes -> case' {
    correct_in_ctx tail caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail case'
}

@test 'sort: caes -> case' {
    correct_in_ctx sort caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort case'
}

@test 'uniq: caes -> case' {
    correct_in_ctx uniq caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq case'
}

@test 'wc: caes -> case' {
    correct_in_ctx wc caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc case'
}

@test 'tr: caes -> case' {
    correct_in_ctx tr caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr case'
}

@test 'cut: caes -> case' {
    correct_in_ctx cut caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut case'
}

@test 'diff: caes -> case' {
    correct_in_ctx diff caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff case'
}

@test 'print: cdn -> CDN' {
    correct_in_ctx print cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print CDN'
}

@test 'cat: cdn -> CDN' {
    correct_in_ctx cat cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat CDN'
}

@test 'grep: cdn -> CDN' {
    correct_in_ctx grep cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep CDN'
}

@test 'sed: cdn -> CDN' {
    correct_in_ctx sed cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed CDN'
}

@test 'awk: cdn -> CDN' {
    correct_in_ctx awk cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk CDN'
}

@test 'man: cdn -> CDN' {
    correct_in_ctx man cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man CDN'
}

@test 'ls: cdn -> CDN' {
    correct_in_ctx ls cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls CDN'
}

@test 'head: cdn -> CDN' {
    correct_in_ctx head cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head CDN'
}

@test 'tail: cdn -> CDN' {
    correct_in_ctx tail cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail CDN'
}

@test 'sort: cdn -> CDN' {
    correct_in_ctx sort cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort CDN'
}

@test 'uniq: cdn -> CDN' {
    correct_in_ctx uniq cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq CDN'
}

@test 'wc: cdn -> CDN' {
    correct_in_ctx wc cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc CDN'
}

@test 'tr: cdn -> CDN' {
    correct_in_ctx tr cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr CDN'
}

@test 'cut: cdn -> CDN' {
    correct_in_ctx cut cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut CDN'
}

@test 'diff: cdn -> CDN' {
    correct_in_ctx diff cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff CDN'
}

@test 'print: cahnge -> change' {
    correct_in_ctx print cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print change'
}

@test 'cat: cahnge -> change' {
    correct_in_ctx cat cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat change'
}

@test 'grep: cahnge -> change' {
    correct_in_ctx grep cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep change'
}

@test 'sed: cahnge -> change' {
    correct_in_ctx sed cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed change'
}

@test 'awk: cahnge -> change' {
    correct_in_ctx awk cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk change'
}

@test 'man: cahnge -> change' {
    correct_in_ctx man cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man change'
}

@test 'ls: cahnge -> change' {
    correct_in_ctx ls cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls change'
}

@test 'head: cahnge -> change' {
    correct_in_ctx head cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head change'
}

@test 'tail: cahnge -> change' {
    correct_in_ctx tail cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail change'
}

@test 'sort: cahnge -> change' {
    correct_in_ctx sort cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort change'
}

@test 'uniq: cahnge -> change' {
    correct_in_ctx uniq cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq change'
}

@test 'wc: cahnge -> change' {
    correct_in_ctx wc cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc change'
}

@test 'tr: cahnge -> change' {
    correct_in_ctx tr cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr change'
}

@test 'cut: cahnge -> change' {
    correct_in_ctx cut cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut change'
}

@test 'diff: cahnge -> change' {
    correct_in_ctx diff cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff change'
}

@test 'print: cli -> CLI' {
    correct_in_ctx print cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print CLI'
}

@test 'cat: cli -> CLI' {
    correct_in_ctx cat cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat CLI'
}

@test 'grep: cli -> CLI' {
    correct_in_ctx grep cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep CLI'
}

@test 'sed: cli -> CLI' {
    correct_in_ctx sed cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed CLI'
}

@test 'awk: cli -> CLI' {
    correct_in_ctx awk cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk CLI'
}

@test 'man: cli -> CLI' {
    correct_in_ctx man cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man CLI'
}

@test 'ls: cli -> CLI' {
    correct_in_ctx ls cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls CLI'
}

@test 'head: cli -> CLI' {
    correct_in_ctx head cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head CLI'
}

@test 'tail: cli -> CLI' {
    correct_in_ctx tail cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail CLI'
}

@test 'sort: cli -> CLI' {
    correct_in_ctx sort cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort CLI'
}

@test 'uniq: cli -> CLI' {
    correct_in_ctx uniq cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq CLI'
}

@test 'wc: cli -> CLI' {
    correct_in_ctx wc cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc CLI'
}

@test 'tr: cli -> CLI' {
    correct_in_ctx tr cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr CLI'
}

@test 'cut: cli -> CLI' {
    correct_in_ctx cut cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut CLI'
}

@test 'diff: cli -> CLI' {
    correct_in_ctx diff cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff CLI'
}

@test 'print: clikc -> click' {
    correct_in_ctx print clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print click'
}

@test 'cat: clikc -> click' {
    correct_in_ctx cat clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat click'
}

@test 'grep: clikc -> click' {
    correct_in_ctx grep clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep click'
}

@test 'sed: clikc -> click' {
    correct_in_ctx sed clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed click'
}

@test 'awk: clikc -> click' {
    correct_in_ctx awk clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk click'
}

@test 'man: clikc -> click' {
    correct_in_ctx man clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man click'
}

@test 'ls: clikc -> click' {
    correct_in_ctx ls clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls click'
}

@test 'head: clikc -> click' {
    correct_in_ctx head clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head click'
}

@test 'tail: clikc -> click' {
    correct_in_ctx tail clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail click'
}

@test 'sort: clikc -> click' {
    correct_in_ctx sort clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort click'
}

@test 'uniq: clikc -> click' {
    correct_in_ctx uniq clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq click'
}

@test 'wc: clikc -> click' {
    correct_in_ctx wc clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc click'
}

@test 'tr: clikc -> click' {
    correct_in_ctx tr clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr click'
}

@test 'cut: clikc -> click' {
    correct_in_ctx cut clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut click'
}

@test 'diff: clikc -> click' {
    correct_in_ctx diff clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff click'
}

@test 'print: cleint -> client' {
    correct_in_ctx print cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print client'
}

@test 'cat: cleint -> client' {
    correct_in_ctx cat cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat client'
}

@test 'grep: cleint -> client' {
    correct_in_ctx grep cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep client'
}

@test 'sed: cleint -> client' {
    correct_in_ctx sed cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed client'
}

@test 'awk: cleint -> client' {
    correct_in_ctx awk cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk client'
}

@test 'man: cleint -> client' {
    correct_in_ctx man cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man client'
}

@test 'ls: cleint -> client' {
    correct_in_ctx ls cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls client'
}

@test 'head: cleint -> client' {
    correct_in_ctx head cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head client'
}

@test 'tail: cleint -> client' {
    correct_in_ctx tail cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail client'
}

@test 'sort: cleint -> client' {
    correct_in_ctx sort cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort client'
}

@test 'uniq: cleint -> client' {
    correct_in_ctx uniq cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq client'
}

@test 'wc: cleint -> client' {
    correct_in_ctx wc cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc client'
}

@test 'tr: cleint -> client' {
    correct_in_ctx tr cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr client'
}

@test 'cut: cleint -> client' {
    correct_in_ctx cut cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut client'
}

@test 'diff: cleint -> client' {
    correct_in_ctx diff cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff client'
}

@test 'print: cloen -> clone' {
    correct_in_ctx print cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print clone'
}

@test 'cat: cloen -> clone' {
    correct_in_ctx cat cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat clone'
}

@test 'grep: cloen -> clone' {
    correct_in_ctx grep cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep clone'
}

@test 'sed: cloen -> clone' {
    correct_in_ctx sed cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed clone'
}

@test 'awk: cloen -> clone' {
    correct_in_ctx awk cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk clone'
}

@test 'man: cloen -> clone' {
    correct_in_ctx man cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man clone'
}

@test 'ls: cloen -> clone' {
    correct_in_ctx ls cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls clone'
}

@test 'head: cloen -> clone' {
    correct_in_ctx head cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head clone'
}

@test 'tail: cloen -> clone' {
    correct_in_ctx tail cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail clone'
}

@test 'sort: cloen -> clone' {
    correct_in_ctx sort cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort clone'
}

@test 'uniq: cloen -> clone' {
    correct_in_ctx uniq cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq clone'
}

@test 'wc: cloen -> clone' {
    correct_in_ctx wc cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc clone'
}

@test 'tr: cloen -> clone' {
    correct_in_ctx tr cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr clone'
}

@test 'cut: cloen -> clone' {
    correct_in_ctx cut cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut clone'
}

@test 'diff: cloen -> clone' {
    correct_in_ctx diff cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff clone'
}

@test 'print: cloes -> close' {
    correct_in_ctx print cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print close'
}

@test 'cat: cloes -> close' {
    correct_in_ctx cat cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat close'
}

@test 'grep: cloes -> close' {
    correct_in_ctx grep cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep close'
}

@test 'sed: cloes -> close' {
    correct_in_ctx sed cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed close'
}

@test 'awk: cloes -> close' {
    correct_in_ctx awk cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk close'
}

@test 'man: cloes -> close' {
    correct_in_ctx man cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man close'
}

@test 'ls: cloes -> close' {
    correct_in_ctx ls cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls close'
}

@test 'head: cloes -> close' {
    correct_in_ctx head cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head close'
}

@test 'tail: cloes -> close' {
    correct_in_ctx tail cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail close'
}

@test 'sort: cloes -> close' {
    correct_in_ctx sort cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort close'
}

@test 'uniq: cloes -> close' {
    correct_in_ctx uniq cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq close'
}

@test 'wc: cloes -> close' {
    correct_in_ctx wc cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc close'
}

@test 'tr: cloes -> close' {
    correct_in_ctx tr cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr close'
}

@test 'cut: cloes -> close' {
    correct_in_ctx cut cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut close'
}

@test 'diff: cloes -> close' {
    correct_in_ctx diff cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff close'
}

@test 'print: cmd -> command' {
    correct_in_ctx print cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print command'
}

@test 'cat: cmd -> command' {
    correct_in_ctx cat cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat command'
}

@test 'grep: cmd -> command' {
    correct_in_ctx grep cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep command'
}

@test 'sed: cmd -> command' {
    correct_in_ctx sed cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed command'
}

@test 'awk: cmd -> command' {
    correct_in_ctx awk cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk command'
}

@test 'man: cmd -> command' {
    correct_in_ctx man cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man command'
}

@test 'ls: cmd -> command' {
    correct_in_ctx ls cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls command'
}

@test 'head: cmd -> command' {
    correct_in_ctx head cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head command'
}

@test 'tail: cmd -> command' {
    correct_in_ctx tail cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail command'
}

@test 'sort: cmd -> command' {
    correct_in_ctx sort cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort command'
}

@test 'uniq: cmd -> command' {
    correct_in_ctx uniq cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq command'
}

@test 'wc: cmd -> command' {
    correct_in_ctx wc cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc command'
}

@test 'tr: cmd -> command' {
    correct_in_ctx tr cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr command'
}

@test 'cut: cmd -> command' {
    correct_in_ctx cut cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut command'
}

@test 'diff: cmd -> command' {
    correct_in_ctx diff cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff command'
}

@test 'print: cmds -> commands' {
    correct_in_ctx print cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print commands'
}

@test 'cat: cmds -> commands' {
    correct_in_ctx cat cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat commands'
}

@test 'grep: cmds -> commands' {
    correct_in_ctx grep cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep commands'
}

@test 'sed: cmds -> commands' {
    correct_in_ctx sed cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed commands'
}

@test 'awk: cmds -> commands' {
    correct_in_ctx awk cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk commands'
}

@test 'man: cmds -> commands' {
    correct_in_ctx man cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man commands'
}

@test 'ls: cmds -> commands' {
    correct_in_ctx ls cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls commands'
}

@test 'head: cmds -> commands' {
    correct_in_ctx head cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head commands'
}

@test 'tail: cmds -> commands' {
    correct_in_ctx tail cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail commands'
}

@test 'sort: cmds -> commands' {
    correct_in_ctx sort cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort commands'
}

@test 'uniq: cmds -> commands' {
    correct_in_ctx uniq cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq commands'
}

@test 'wc: cmds -> commands' {
    correct_in_ctx wc cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc commands'
}

@test 'tr: cmds -> commands' {
    correct_in_ctx tr cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr commands'
}

@test 'cut: cmds -> commands' {
    correct_in_ctx cut cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut commands'
}

@test 'diff: cmds -> commands' {
    correct_in_ctx diff cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff commands'
}

@test 'print: cs -> computer science' {
    correct_in_ctx print cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print computer science'
}

@test 'cat: cs -> computer science' {
    correct_in_ctx cat cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat computer science'
}

@test 'grep: cs -> computer science' {
    correct_in_ctx grep cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep computer science'
}

@test 'sed: cs -> computer science' {
    correct_in_ctx sed cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed computer science'
}

@test 'awk: cs -> computer science' {
    correct_in_ctx awk cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk computer science'
}

@test 'man: cs -> computer science' {
    correct_in_ctx man cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man computer science'
}

@test 'ls: cs -> computer science' {
    correct_in_ctx ls cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls computer science'
}

@test 'head: cs -> computer science' {
    correct_in_ctx head cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head computer science'
}

@test 'tail: cs -> computer science' {
    correct_in_ctx tail cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail computer science'
}

@test 'sort: cs -> computer science' {
    correct_in_ctx sort cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort computer science'
}

@test 'uniq: cs -> computer science' {
    correct_in_ctx uniq cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq computer science'
}

@test 'wc: cs -> computer science' {
    correct_in_ctx wc cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc computer science'
}

@test 'tr: cs -> computer science' {
    correct_in_ctx tr cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr computer science'
}

@test 'cut: cs -> computer science' {
    correct_in_ctx cut cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut computer science'
}

@test 'diff: cs -> computer science' {
    correct_in_ctx diff cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff computer science'
}

@test 'print: ocunt -> count' {
    correct_in_ctx print ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print count'
}

@test 'cat: ocunt -> count' {
    correct_in_ctx cat ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat count'
}

@test 'grep: ocunt -> count' {
    correct_in_ctx grep ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep count'
}

@test 'sed: ocunt -> count' {
    correct_in_ctx sed ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed count'
}

@test 'awk: ocunt -> count' {
    correct_in_ctx awk ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk count'
}

@test 'man: ocunt -> count' {
    correct_in_ctx man ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man count'
}

@test 'ls: ocunt -> count' {
    correct_in_ctx ls ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls count'
}

@test 'head: ocunt -> count' {
    correct_in_ctx head ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head count'
}

@test 'tail: ocunt -> count' {
    correct_in_ctx tail ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail count'
}

@test 'sort: ocunt -> count' {
    correct_in_ctx sort ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort count'
}

@test 'uniq: ocunt -> count' {
    correct_in_ctx uniq ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq count'
}

@test 'wc: ocunt -> count' {
    correct_in_ctx wc ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc count'
}

@test 'tr: ocunt -> count' {
    correct_in_ctx tr ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr count'
}

@test 'cut: ocunt -> count' {
    correct_in_ctx cut ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut count'
}

@test 'diff: ocunt -> count' {
    correct_in_ctx diff ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff count'
}

@test 'print: cpu -> CPU' {
    correct_in_ctx print cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print CPU'
}

@test 'cat: cpu -> CPU' {
    correct_in_ctx cat cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat CPU'
}

@test 'grep: cpu -> CPU' {
    correct_in_ctx grep cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep CPU'
}

@test 'sed: cpu -> CPU' {
    correct_in_ctx sed cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed CPU'
}

@test 'awk: cpu -> CPU' {
    correct_in_ctx awk cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk CPU'
}

@test 'man: cpu -> CPU' {
    correct_in_ctx man cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man CPU'
}

@test 'ls: cpu -> CPU' {
    correct_in_ctx ls cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls CPU'
}

@test 'head: cpu -> CPU' {
    correct_in_ctx head cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head CPU'
}

@test 'tail: cpu -> CPU' {
    correct_in_ctx tail cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail CPU'
}

@test 'sort: cpu -> CPU' {
    correct_in_ctx sort cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort CPU'
}

@test 'uniq: cpu -> CPU' {
    correct_in_ctx uniq cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq CPU'
}

@test 'wc: cpu -> CPU' {
    correct_in_ctx wc cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc CPU'
}

@test 'tr: cpu -> CPU' {
    correct_in_ctx tr cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr CPU'
}

@test 'cut: cpu -> CPU' {
    correct_in_ctx cut cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut CPU'
}

@test 'diff: cpu -> CPU' {
    correct_in_ctx diff cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff CPU'
}

@test 'print: ccreate -> create' {
    correct_in_ctx print ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print create'
}

@test 'cat: ccreate -> create' {
    correct_in_ctx cat ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat create'
}

@test 'grep: ccreate -> create' {
    correct_in_ctx grep ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep create'
}

@test 'sed: ccreate -> create' {
    correct_in_ctx sed ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed create'
}

@test 'awk: ccreate -> create' {
    correct_in_ctx awk ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk create'
}

@test 'man: ccreate -> create' {
    correct_in_ctx man ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man create'
}

@test 'ls: ccreate -> create' {
    correct_in_ctx ls ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls create'
}

@test 'head: ccreate -> create' {
    correct_in_ctx head ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head create'
}

@test 'tail: ccreate -> create' {
    correct_in_ctx tail ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail create'
}

@test 'sort: ccreate -> create' {
    correct_in_ctx sort ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort create'
}

@test 'uniq: ccreate -> create' {
    correct_in_ctx uniq ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq create'
}

@test 'wc: ccreate -> create' {
    correct_in_ctx wc ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc create'
}

@test 'tr: ccreate -> create' {
    correct_in_ctx tr ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr create'
}

@test 'cut: ccreate -> create' {
    correct_in_ctx cut ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut create'
}

@test 'diff: ccreate -> create' {
    correct_in_ctx diff ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff create'
}

@test 'print: css -> CSS' {
    correct_in_ctx print css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print CSS'
}

@test 'cat: css -> CSS' {
    correct_in_ctx cat css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat CSS'
}

@test 'grep: css -> CSS' {
    correct_in_ctx grep css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep CSS'
}

@test 'sed: css -> CSS' {
    correct_in_ctx sed css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed CSS'
}

@test 'awk: css -> CSS' {
    correct_in_ctx awk css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk CSS'
}

@test 'man: css -> CSS' {
    correct_in_ctx man css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man CSS'
}

@test 'ls: css -> CSS' {
    correct_in_ctx ls css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls CSS'
}

@test 'head: css -> CSS' {
    correct_in_ctx head css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head CSS'
}

@test 'tail: css -> CSS' {
    correct_in_ctx tail css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail CSS'
}

@test 'sort: css -> CSS' {
    correct_in_ctx sort css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort CSS'
}

@test 'uniq: css -> CSS' {
    correct_in_ctx uniq css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq CSS'
}

@test 'wc: css -> CSS' {
    correct_in_ctx wc css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc CSS'
}

@test 'tr: css -> CSS' {
    correct_in_ctx tr css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr CSS'
}

@test 'cut: css -> CSS' {
    correct_in_ctx cut css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut CSS'
}

@test 'diff: css -> CSS' {
    correct_in_ctx diff css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff CSS'
}

@test 'print: custmo -> custom' {
    correct_in_ctx print custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print custom'
}

@test 'cat: custmo -> custom' {
    correct_in_ctx cat custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat custom'
}

@test 'grep: custmo -> custom' {
    correct_in_ctx grep custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep custom'
}

@test 'sed: custmo -> custom' {
    correct_in_ctx sed custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed custom'
}

@test 'awk: custmo -> custom' {
    correct_in_ctx awk custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk custom'
}

@test 'man: custmo -> custom' {
    correct_in_ctx man custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man custom'
}

@test 'ls: custmo -> custom' {
    correct_in_ctx ls custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls custom'
}

@test 'head: custmo -> custom' {
    correct_in_ctx head custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head custom'
}

@test 'tail: custmo -> custom' {
    correct_in_ctx tail custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail custom'
}

@test 'sort: custmo -> custom' {
    correct_in_ctx sort custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort custom'
}

@test 'uniq: custmo -> custom' {
    correct_in_ctx uniq custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq custom'
}

@test 'wc: custmo -> custom' {
    correct_in_ctx wc custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc custom'
}

@test 'tr: custmo -> custom' {
    correct_in_ctx tr custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr custom'
}

@test 'cut: custmo -> custom' {
    correct_in_ctx cut custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut custom'
}

@test 'diff: custmo -> custom' {
    correct_in_ctx diff custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff custom'
}

@test 'print: darwin -> Darwin' {
    correct_in_ctx print darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print Darwin'
}

@test 'cat: darwin -> Darwin' {
    correct_in_ctx cat darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat Darwin'
}

@test 'grep: darwin -> Darwin' {
    correct_in_ctx grep darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep Darwin'
}

@test 'sed: darwin -> Darwin' {
    correct_in_ctx sed darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed Darwin'
}

@test 'awk: darwin -> Darwin' {
    correct_in_ctx awk darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk Darwin'
}

@test 'man: darwin -> Darwin' {
    correct_in_ctx man darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man Darwin'
}

@test 'ls: darwin -> Darwin' {
    correct_in_ctx ls darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls Darwin'
}

@test 'head: darwin -> Darwin' {
    correct_in_ctx head darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head Darwin'
}

@test 'tail: darwin -> Darwin' {
    correct_in_ctx tail darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail Darwin'
}

@test 'sort: darwin -> Darwin' {
    correct_in_ctx sort darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort Darwin'
}

@test 'uniq: darwin -> Darwin' {
    correct_in_ctx uniq darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq Darwin'
}

@test 'wc: darwin -> Darwin' {
    correct_in_ctx wc darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc Darwin'
}

@test 'tr: darwin -> Darwin' {
    correct_in_ctx tr darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr Darwin'
}

@test 'cut: darwin -> Darwin' {
    correct_in_ctx cut darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut Darwin'
}

@test 'diff: darwin -> Darwin' {
    correct_in_ctx diff darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff Darwin'
}

@test 'print: db -> database' {
    correct_in_ctx print db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print database'
}

@test 'cat: db -> database' {
    correct_in_ctx cat db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat database'
}

@test 'grep: db -> database' {
    correct_in_ctx grep db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep database'
}

@test 'sed: db -> database' {
    correct_in_ctx sed db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed database'
}

@test 'awk: db -> database' {
    correct_in_ctx awk db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk database'
}

@test 'man: db -> database' {
    correct_in_ctx man db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man database'
}

@test 'ls: db -> database' {
    correct_in_ctx ls db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls database'
}

@test 'head: db -> database' {
    correct_in_ctx head db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head database'
}

@test 'tail: db -> database' {
    correct_in_ctx tail db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail database'
}

@test 'sort: db -> database' {
    correct_in_ctx sort db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort database'
}

@test 'uniq: db -> database' {
    correct_in_ctx uniq db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq database'
}

@test 'wc: db -> database' {
    correct_in_ctx wc db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc database'
}

@test 'tr: db -> database' {
    correct_in_ctx tr db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr database'
}

@test 'cut: db -> database' {
    correct_in_ctx cut db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut database'
}

@test 'diff: db -> database' {
    correct_in_ctx diff db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff database'
}

@test 'print: dbs -> databases' {
    correct_in_ctx print dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print databases'
}

@test 'cat: dbs -> databases' {
    correct_in_ctx cat dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat databases'
}

@test 'grep: dbs -> databases' {
    correct_in_ctx grep dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep databases'
}

@test 'sed: dbs -> databases' {
    correct_in_ctx sed dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed databases'
}

@test 'awk: dbs -> databases' {
    correct_in_ctx awk dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk databases'
}

@test 'man: dbs -> databases' {
    correct_in_ctx man dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man databases'
}

@test 'ls: dbs -> databases' {
    correct_in_ctx ls dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls databases'
}

@test 'head: dbs -> databases' {
    correct_in_ctx head dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head databases'
}

@test 'tail: dbs -> databases' {
    correct_in_ctx tail dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail databases'
}

@test 'sort: dbs -> databases' {
    correct_in_ctx sort dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort databases'
}

@test 'uniq: dbs -> databases' {
    correct_in_ctx uniq dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq databases'
}

@test 'wc: dbs -> databases' {
    correct_in_ctx wc dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc databases'
}

@test 'tr: dbs -> databases' {
    correct_in_ctx tr dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr databases'
}

@test 'cut: dbs -> databases' {
    correct_in_ctx cut dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut databases'
}

@test 'diff: dbs -> databases' {
    correct_in_ctx diff dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff databases'
}

@test 'print: ddl -> DDL' {
    correct_in_ctx print ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print DDL'
}

@test 'cat: ddl -> DDL' {
    correct_in_ctx cat ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat DDL'
}

@test 'grep: ddl -> DDL' {
    correct_in_ctx grep ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep DDL'
}

@test 'sed: ddl -> DDL' {
    correct_in_ctx sed ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed DDL'
}

@test 'awk: ddl -> DDL' {
    correct_in_ctx awk ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk DDL'
}

@test 'man: ddl -> DDL' {
    correct_in_ctx man ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man DDL'
}

@test 'ls: ddl -> DDL' {
    correct_in_ctx ls ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls DDL'
}

@test 'head: ddl -> DDL' {
    correct_in_ctx head ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head DDL'
}

@test 'tail: ddl -> DDL' {
    correct_in_ctx tail ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail DDL'
}

@test 'sort: ddl -> DDL' {
    correct_in_ctx sort ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort DDL'
}

@test 'uniq: ddl -> DDL' {
    correct_in_ctx uniq ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq DDL'
}

@test 'wc: ddl -> DDL' {
    correct_in_ctx wc ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc DDL'
}

@test 'tr: ddl -> DDL' {
    correct_in_ctx tr ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr DDL'
}

@test 'cut: ddl -> DDL' {
    correct_in_ctx cut ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut DDL'
}

@test 'diff: ddl -> DDL' {
    correct_in_ctx diff ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff DDL'
}

@test 'print: decl -> declaration' {
    correct_in_ctx print decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print declaration'
}

@test 'cat: decl -> declaration' {
    correct_in_ctx cat decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat declaration'
}

@test 'grep: decl -> declaration' {
    correct_in_ctx grep decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep declaration'
}

@test 'sed: decl -> declaration' {
    correct_in_ctx sed decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed declaration'
}

@test 'awk: decl -> declaration' {
    correct_in_ctx awk decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk declaration'
}

@test 'man: decl -> declaration' {
    correct_in_ctx man decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man declaration'
}

@test 'ls: decl -> declaration' {
    correct_in_ctx ls decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls declaration'
}

@test 'head: decl -> declaration' {
    correct_in_ctx head decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head declaration'
}

@test 'tail: decl -> declaration' {
    correct_in_ctx tail decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail declaration'
}

@test 'sort: decl -> declaration' {
    correct_in_ctx sort decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort declaration'
}

@test 'uniq: decl -> declaration' {
    correct_in_ctx uniq decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq declaration'
}

@test 'wc: decl -> declaration' {
    correct_in_ctx wc decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc declaration'
}

@test 'tr: decl -> declaration' {
    correct_in_ctx tr decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr declaration'
}

@test 'cut: decl -> declaration' {
    correct_in_ctx cut decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut declaration'
}

@test 'diff: decl -> declaration' {
    correct_in_ctx diff decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff declaration'
}

@test 'print: delcare -> declare' {
    correct_in_ctx print delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print declare'
}

@test 'cat: delcare -> declare' {
    correct_in_ctx cat delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat declare'
}

@test 'grep: delcare -> declare' {
    correct_in_ctx grep delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep declare'
}

@test 'sed: delcare -> declare' {
    correct_in_ctx sed delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed declare'
}

@test 'awk: delcare -> declare' {
    correct_in_ctx awk delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk declare'
}

@test 'man: delcare -> declare' {
    correct_in_ctx man delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man declare'
}

@test 'ls: delcare -> declare' {
    correct_in_ctx ls delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls declare'
}

@test 'head: delcare -> declare' {
    correct_in_ctx head delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head declare'
}

@test 'tail: delcare -> declare' {
    correct_in_ctx tail delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail declare'
}

@test 'sort: delcare -> declare' {
    correct_in_ctx sort delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort declare'
}

@test 'uniq: delcare -> declare' {
    correct_in_ctx uniq delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq declare'
}

@test 'wc: delcare -> declare' {
    correct_in_ctx wc delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc declare'
}

@test 'tr: delcare -> declare' {
    correct_in_ctx tr delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr declare'
}

@test 'cut: delcare -> declare' {
    correct_in_ctx cut delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut declare'
}

@test 'diff: delcare -> declare' {
    correct_in_ctx diff delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff declare'
}

@test 'print: defalut -> default' {
    correct_in_ctx print defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print default'
}

@test 'cat: defalut -> default' {
    correct_in_ctx cat defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat default'
}

@test 'grep: defalut -> default' {
    correct_in_ctx grep defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep default'
}

@test 'sed: defalut -> default' {
    correct_in_ctx sed defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed default'
}

@test 'awk: defalut -> default' {
    correct_in_ctx awk defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk default'
}

@test 'man: defalut -> default' {
    correct_in_ctx man defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man default'
}

@test 'ls: defalut -> default' {
    correct_in_ctx ls defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls default'
}

@test 'head: defalut -> default' {
    correct_in_ctx head defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head default'
}

@test 'tail: defalut -> default' {
    correct_in_ctx tail defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail default'
}

@test 'sort: defalut -> default' {
    correct_in_ctx sort defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort default'
}

@test 'uniq: defalut -> default' {
    correct_in_ctx uniq defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq default'
}

@test 'wc: defalut -> default' {
    correct_in_ctx wc defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc default'
}

@test 'tr: defalut -> default' {
    correct_in_ctx tr defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr default'
}

@test 'cut: defalut -> default' {
    correct_in_ctx cut defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut default'
}

@test 'diff: defalut -> default' {
    correct_in_ctx diff defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff default'
}

@test 'print: dly -> delay' {
    correct_in_ctx print dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print delay'
}

@test 'cat: dly -> delay' {
    correct_in_ctx cat dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat delay'
}

@test 'grep: dly -> delay' {
    correct_in_ctx grep dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep delay'
}

@test 'sed: dly -> delay' {
    correct_in_ctx sed dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed delay'
}

@test 'awk: dly -> delay' {
    correct_in_ctx awk dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk delay'
}

@test 'man: dly -> delay' {
    correct_in_ctx man dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man delay'
}

@test 'ls: dly -> delay' {
    correct_in_ctx ls dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls delay'
}

@test 'head: dly -> delay' {
    correct_in_ctx head dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head delay'
}

@test 'tail: dly -> delay' {
    correct_in_ctx tail dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail delay'
}

@test 'sort: dly -> delay' {
    correct_in_ctx sort dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort delay'
}

@test 'uniq: dly -> delay' {
    correct_in_ctx uniq dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq delay'
}

@test 'wc: dly -> delay' {
    correct_in_ctx wc dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc delay'
}

@test 'tr: dly -> delay' {
    correct_in_ctx tr dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr delay'
}

@test 'cut: dly -> delay' {
    correct_in_ctx cut dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut delay'
}

@test 'diff: dly -> delay' {
    correct_in_ctx diff dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff delay'
}

@test 'print: deps -> dependencies' {
    correct_in_ctx print deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print dependencies'
}

@test 'cat: deps -> dependencies' {
    correct_in_ctx cat deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat dependencies'
}

@test 'grep: deps -> dependencies' {
    correct_in_ctx grep deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep dependencies'
}

@test 'sed: deps -> dependencies' {
    correct_in_ctx sed deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed dependencies'
}

@test 'awk: deps -> dependencies' {
    correct_in_ctx awk deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk dependencies'
}

@test 'man: deps -> dependencies' {
    correct_in_ctx man deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man dependencies'
}

@test 'ls: deps -> dependencies' {
    correct_in_ctx ls deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls dependencies'
}

@test 'head: deps -> dependencies' {
    correct_in_ctx head deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head dependencies'
}

@test 'tail: deps -> dependencies' {
    correct_in_ctx tail deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail dependencies'
}

@test 'sort: deps -> dependencies' {
    correct_in_ctx sort deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort dependencies'
}

@test 'uniq: deps -> dependencies' {
    correct_in_ctx uniq deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq dependencies'
}

@test 'wc: deps -> dependencies' {
    correct_in_ctx wc deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc dependencies'
}

@test 'tr: deps -> dependencies' {
    correct_in_ctx tr deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr dependencies'
}

@test 'cut: deps -> dependencies' {
    correct_in_ctx cut deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut dependencies'
}

@test 'diff: deps -> dependencies' {
    correct_in_ctx diff deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff dependencies'
}

@test 'print: dep -> dependency' {
    correct_in_ctx print dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print dependency'
}

@test 'cat: dep -> dependency' {
    correct_in_ctx cat dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat dependency'
}

@test 'grep: dep -> dependency' {
    correct_in_ctx grep dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep dependency'
}

@test 'sed: dep -> dependency' {
    correct_in_ctx sed dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed dependency'
}

@test 'awk: dep -> dependency' {
    correct_in_ctx awk dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk dependency'
}

@test 'man: dep -> dependency' {
    correct_in_ctx man dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man dependency'
}

@test 'ls: dep -> dependency' {
    correct_in_ctx ls dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls dependency'
}

@test 'head: dep -> dependency' {
    correct_in_ctx head dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head dependency'
}

@test 'tail: dep -> dependency' {
    correct_in_ctx tail dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail dependency'
}

@test 'sort: dep -> dependency' {
    correct_in_ctx sort dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort dependency'
}

@test 'uniq: dep -> dependency' {
    correct_in_ctx uniq dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq dependency'
}

@test 'wc: dep -> dependency' {
    correct_in_ctx wc dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc dependency'
}

@test 'tr: dep -> dependency' {
    correct_in_ctx tr dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr dependency'
}

@test 'cut: dep -> dependency' {
    correct_in_ctx cut dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut dependency'
}

@test 'diff: dep -> dependency' {
    correct_in_ctx diff dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff dependency'
}

@test 'print: dest -> destination' {
    correct_in_ctx print dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print destination'
}

@test 'cat: dest -> destination' {
    correct_in_ctx cat dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat destination'
}

@test 'grep: dest -> destination' {
    correct_in_ctx grep dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep destination'
}

@test 'sed: dest -> destination' {
    correct_in_ctx sed dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed destination'
}

@test 'awk: dest -> destination' {
    correct_in_ctx awk dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk destination'
}

@test 'man: dest -> destination' {
    correct_in_ctx man dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man destination'
}

@test 'ls: dest -> destination' {
    correct_in_ctx ls dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls destination'
}

@test 'head: dest -> destination' {
    correct_in_ctx head dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head destination'
}

@test 'tail: dest -> destination' {
    correct_in_ctx tail dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail destination'
}

@test 'sort: dest -> destination' {
    correct_in_ctx sort dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort destination'
}

@test 'uniq: dest -> destination' {
    correct_in_ctx uniq dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq destination'
}

@test 'wc: dest -> destination' {
    correct_in_ctx wc dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc destination'
}

@test 'tr: dest -> destination' {
    correct_in_ctx tr dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr destination'
}

@test 'cut: dest -> destination' {
    correct_in_ctx cut dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut destination'
}

@test 'diff: dest -> destination' {
    correct_in_ctx diff dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff destination'
}

@test 'print: deve -> developer' {
    correct_in_ctx print deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print developer'
}

@test 'cat: deve -> developer' {
    correct_in_ctx cat deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat developer'
}

@test 'grep: deve -> developer' {
    correct_in_ctx grep deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep developer'
}

@test 'sed: deve -> developer' {
    correct_in_ctx sed deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed developer'
}

@test 'awk: deve -> developer' {
    correct_in_ctx awk deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk developer'
}

@test 'man: deve -> developer' {
    correct_in_ctx man deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man developer'
}

@test 'ls: deve -> developer' {
    correct_in_ctx ls deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls developer'
}

@test 'head: deve -> developer' {
    correct_in_ctx head deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head developer'
}

@test 'tail: deve -> developer' {
    correct_in_ctx tail deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail developer'
}

@test 'sort: deve -> developer' {
    correct_in_ctx sort deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort developer'
}

@test 'uniq: deve -> developer' {
    correct_in_ctx uniq deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq developer'
}

@test 'wc: deve -> developer' {
    correct_in_ctx wc deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc developer'
}

@test 'tr: deve -> developer' {
    correct_in_ctx tr deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr developer'
}

@test 'cut: deve -> developer' {
    correct_in_ctx cut deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut developer'
}

@test 'diff: deve -> developer' {
    correct_in_ctx diff deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff developer'
}

@test 'print: devs -> developers' {
    correct_in_ctx print devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print developers'
}

@test 'cat: devs -> developers' {
    correct_in_ctx cat devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat developers'
}

@test 'grep: devs -> developers' {
    correct_in_ctx grep devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep developers'
}

@test 'sed: devs -> developers' {
    correct_in_ctx sed devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed developers'
}

@test 'awk: devs -> developers' {
    correct_in_ctx awk devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk developers'
}

@test 'man: devs -> developers' {
    correct_in_ctx man devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man developers'
}

@test 'ls: devs -> developers' {
    correct_in_ctx ls devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls developers'
}

@test 'head: devs -> developers' {
    correct_in_ctx head devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head developers'
}

@test 'tail: devs -> developers' {
    correct_in_ctx tail devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail developers'
}

@test 'sort: devs -> developers' {
    correct_in_ctx sort devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort developers'
}

@test 'uniq: devs -> developers' {
    correct_in_ctx uniq devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq developers'
}

@test 'wc: devs -> developers' {
    correct_in_ctx wc devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc developers'
}

@test 'tr: devs -> developers' {
    correct_in_ctx tr devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr developers'
}

@test 'cut: devs -> developers' {
    correct_in_ctx cut devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut developers'
}

@test 'diff: devs -> developers' {
    correct_in_ctx diff devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff developers'
}

@test 'print: didt -> did not' {
    correct_in_ctx print didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print did not'
}

@test 'cat: didt -> did not' {
    correct_in_ctx cat didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat did not'
}

@test 'grep: didt -> did not' {
    correct_in_ctx grep didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep did not'
}

@test 'sed: didt -> did not' {
    correct_in_ctx sed didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed did not'
}

@test 'awk: didt -> did not' {
    correct_in_ctx awk didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk did not'
}

@test 'man: didt -> did not' {
    correct_in_ctx man didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man did not'
}

@test 'ls: didt -> did not' {
    correct_in_ctx ls didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls did not'
}

@test 'head: didt -> did not' {
    correct_in_ctx head didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head did not'
}

@test 'tail: didt -> did not' {
    correct_in_ctx tail didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail did not'
}

@test 'sort: didt -> did not' {
    correct_in_ctx sort didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort did not'
}

@test 'uniq: didt -> did not' {
    correct_in_ctx uniq didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq did not'
}

@test 'wc: didt -> did not' {
    correct_in_ctx wc didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc did not'
}

@test 'tr: didt -> did not' {
    correct_in_ctx tr didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr did not'
}

@test 'cut: didt -> did not' {
    correct_in_ctx cut didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut did not'
}

@test 'diff: didt -> did not' {
    correct_in_ctx diff didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff did not'
}

@test 'print: dirss -> directories' {
    correct_in_ctx print dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print directories'
}

@test 'cat: dirss -> directories' {
    correct_in_ctx cat dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat directories'
}

@test 'grep: dirss -> directories' {
    correct_in_ctx grep dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep directories'
}

@test 'sed: dirss -> directories' {
    correct_in_ctx sed dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed directories'
}

@test 'awk: dirss -> directories' {
    correct_in_ctx awk dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk directories'
}

@test 'man: dirss -> directories' {
    correct_in_ctx man dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man directories'
}

@test 'ls: dirss -> directories' {
    correct_in_ctx ls dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls directories'
}

@test 'head: dirss -> directories' {
    correct_in_ctx head dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head directories'
}

@test 'tail: dirss -> directories' {
    correct_in_ctx tail dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail directories'
}

@test 'sort: dirss -> directories' {
    correct_in_ctx sort dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort directories'
}

@test 'uniq: dirss -> directories' {
    correct_in_ctx uniq dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq directories'
}

@test 'wc: dirss -> directories' {
    correct_in_ctx wc dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc directories'
}

@test 'tr: dirss -> directories' {
    correct_in_ctx tr dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr directories'
}

@test 'cut: dirss -> directories' {
    correct_in_ctx cut dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut directories'
}

@test 'diff: dirss -> directories' {
    correct_in_ctx diff dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff directories'
}

@test 'print: dir -> directory' {
    correct_in_ctx print dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print directory'
}

@test 'cat: dir -> directory' {
    correct_in_ctx cat dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat directory'
}

@test 'grep: dir -> directory' {
    correct_in_ctx grep dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep directory'
}

@test 'sed: dir -> directory' {
    correct_in_ctx sed dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed directory'
}

@test 'awk: dir -> directory' {
    correct_in_ctx awk dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk directory'
}

@test 'man: dir -> directory' {
    correct_in_ctx man dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man directory'
}

@test 'ls: dir -> directory' {
    correct_in_ctx ls dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls directory'
}

@test 'head: dir -> directory' {
    correct_in_ctx head dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head directory'
}

@test 'tail: dir -> directory' {
    correct_in_ctx tail dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail directory'
}

@test 'sort: dir -> directory' {
    correct_in_ctx sort dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort directory'
}

@test 'uniq: dir -> directory' {
    correct_in_ctx uniq dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq directory'
}

@test 'wc: dir -> directory' {
    correct_in_ctx wc dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc directory'
}

@test 'tr: dir -> directory' {
    correct_in_ctx tr dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr directory'
}

@test 'cut: dir -> directory' {
    correct_in_ctx cut dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut directory'
}

@test 'diff: dir -> directory' {
    correct_in_ctx diff dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff directory'
}

@test 'print: dist -> distribution' {
    correct_in_ctx print dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print distribution'
}

@test 'cat: dist -> distribution' {
    correct_in_ctx cat dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat distribution'
}

@test 'grep: dist -> distribution' {
    correct_in_ctx grep dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep distribution'
}

@test 'sed: dist -> distribution' {
    correct_in_ctx sed dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed distribution'
}

@test 'awk: dist -> distribution' {
    correct_in_ctx awk dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk distribution'
}

@test 'man: dist -> distribution' {
    correct_in_ctx man dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man distribution'
}

@test 'ls: dist -> distribution' {
    correct_in_ctx ls dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls distribution'
}

@test 'head: dist -> distribution' {
    correct_in_ctx head dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head distribution'
}

@test 'tail: dist -> distribution' {
    correct_in_ctx tail dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail distribution'
}

@test 'sort: dist -> distribution' {
    correct_in_ctx sort dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort distribution'
}

@test 'uniq: dist -> distribution' {
    correct_in_ctx uniq dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq distribution'
}

@test 'wc: dist -> distribution' {
    correct_in_ctx wc dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc distribution'
}

@test 'tr: dist -> distribution' {
    correct_in_ctx tr dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr distribution'
}

@test 'cut: dist -> distribution' {
    correct_in_ctx cut dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut distribution'
}

@test 'diff: dist -> distribution' {
    correct_in_ctx diff dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff distribution'
}

@test 'print: dma -> DMA' {
    correct_in_ctx print dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print DMA'
}

@test 'cat: dma -> DMA' {
    correct_in_ctx cat dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat DMA'
}

@test 'grep: dma -> DMA' {
    correct_in_ctx grep dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep DMA'
}

@test 'sed: dma -> DMA' {
    correct_in_ctx sed dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed DMA'
}

@test 'awk: dma -> DMA' {
    correct_in_ctx awk dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk DMA'
}

@test 'man: dma -> DMA' {
    correct_in_ctx man dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man DMA'
}

@test 'ls: dma -> DMA' {
    correct_in_ctx ls dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls DMA'
}

@test 'head: dma -> DMA' {
    correct_in_ctx head dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head DMA'
}

@test 'tail: dma -> DMA' {
    correct_in_ctx tail dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail DMA'
}

@test 'sort: dma -> DMA' {
    correct_in_ctx sort dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort DMA'
}

@test 'uniq: dma -> DMA' {
    correct_in_ctx uniq dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq DMA'
}

@test 'wc: dma -> DMA' {
    correct_in_ctx wc dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc DMA'
}

@test 'tr: dma -> DMA' {
    correct_in_ctx tr dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr DMA'
}

@test 'cut: dma -> DMA' {
    correct_in_ctx cut dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut DMA'
}

@test 'diff: dma -> DMA' {
    correct_in_ctx diff dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff DMA'
}

@test 'print: dml -> DML' {
    correct_in_ctx print dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print DML'
}

@test 'cat: dml -> DML' {
    correct_in_ctx cat dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat DML'
}

@test 'grep: dml -> DML' {
    correct_in_ctx grep dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep DML'
}

@test 'sed: dml -> DML' {
    correct_in_ctx sed dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed DML'
}

@test 'awk: dml -> DML' {
    correct_in_ctx awk dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk DML'
}

@test 'man: dml -> DML' {
    correct_in_ctx man dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man DML'
}

@test 'ls: dml -> DML' {
    correct_in_ctx ls dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls DML'
}

@test 'head: dml -> DML' {
    correct_in_ctx head dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head DML'
}

@test 'tail: dml -> DML' {
    correct_in_ctx tail dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail DML'
}

@test 'sort: dml -> DML' {
    correct_in_ctx sort dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort DML'
}

@test 'uniq: dml -> DML' {
    correct_in_ctx uniq dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq DML'
}

@test 'wc: dml -> DML' {
    correct_in_ctx wc dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc DML'
}

@test 'tr: dml -> DML' {
    correct_in_ctx tr dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr DML'
}

@test 'cut: dml -> DML' {
    correct_in_ctx cut dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut DML'
}

@test 'diff: dml -> DML' {
    correct_in_ctx diff dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff DML'
}

@test 'print: dns -> DNS' {
    correct_in_ctx print dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print DNS'
}

@test 'cat: dns -> DNS' {
    correct_in_ctx cat dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat DNS'
}

@test 'grep: dns -> DNS' {
    correct_in_ctx grep dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep DNS'
}

@test 'sed: dns -> DNS' {
    correct_in_ctx sed dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed DNS'
}

@test 'awk: dns -> DNS' {
    correct_in_ctx awk dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk DNS'
}

@test 'man: dns -> DNS' {
    correct_in_ctx man dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man DNS'
}

@test 'ls: dns -> DNS' {
    correct_in_ctx ls dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls DNS'
}

@test 'head: dns -> DNS' {
    correct_in_ctx head dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head DNS'
}

@test 'tail: dns -> DNS' {
    correct_in_ctx tail dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail DNS'
}

@test 'sort: dns -> DNS' {
    correct_in_ctx sort dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort DNS'
}

@test 'uniq: dns -> DNS' {
    correct_in_ctx uniq dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq DNS'
}

@test 'wc: dns -> DNS' {
    correct_in_ctx wc dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc DNS'
}

@test 'tr: dns -> DNS' {
    correct_in_ctx tr dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr DNS'
}

@test 'cut: dns -> DNS' {
    correct_in_ctx cut dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut DNS'
}

@test 'diff: dns -> DNS' {
    correct_in_ctx diff dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff DNS'
}

@test 'print: dont -> do not' {
    correct_in_ctx print dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print do not'
}

@test 'cat: dont -> do not' {
    correct_in_ctx cat dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat do not'
}

@test 'grep: dont -> do not' {
    correct_in_ctx grep dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep do not'
}

@test 'sed: dont -> do not' {
    correct_in_ctx sed dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed do not'
}

@test 'awk: dont -> do not' {
    correct_in_ctx awk dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk do not'
}

@test 'man: dont -> do not' {
    correct_in_ctx man dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man do not'
}

@test 'ls: dont -> do not' {
    correct_in_ctx ls dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls do not'
}

@test 'head: dont -> do not' {
    correct_in_ctx head dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head do not'
}

@test 'tail: dont -> do not' {
    correct_in_ctx tail dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail do not'
}

@test 'sort: dont -> do not' {
    correct_in_ctx sort dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort do not'
}

@test 'uniq: dont -> do not' {
    correct_in_ctx uniq dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq do not'
}

@test 'wc: dont -> do not' {
    correct_in_ctx wc dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc do not'
}

@test 'tr: dont -> do not' {
    correct_in_ctx tr dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr do not'
}

@test 'cut: dont -> do not' {
    correct_in_ctx cut dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut do not'
}

@test 'diff: dont -> do not' {
    correct_in_ctx diff dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff do not'
}

@test 'print: dokcer -> docker' {
    correct_in_ctx print dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print docker'
}

@test 'cat: dokcer -> docker' {
    correct_in_ctx cat dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat docker'
}

@test 'grep: dokcer -> docker' {
    correct_in_ctx grep dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep docker'
}

@test 'sed: dokcer -> docker' {
    correct_in_ctx sed dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed docker'
}

@test 'awk: dokcer -> docker' {
    correct_in_ctx awk dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk docker'
}

@test 'man: dokcer -> docker' {
    correct_in_ctx man dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man docker'
}

@test 'ls: dokcer -> docker' {
    correct_in_ctx ls dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls docker'
}

@test 'head: dokcer -> docker' {
    correct_in_ctx head dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head docker'
}

@test 'tail: dokcer -> docker' {
    correct_in_ctx tail dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail docker'
}

@test 'sort: dokcer -> docker' {
    correct_in_ctx sort dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort docker'
}

@test 'uniq: dokcer -> docker' {
    correct_in_ctx uniq dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq docker'
}

@test 'wc: dokcer -> docker' {
    correct_in_ctx wc dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc docker'
}

@test 'tr: dokcer -> docker' {
    correct_in_ctx tr dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr docker'
}

@test 'cut: dokcer -> docker' {
    correct_in_ctx cut dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut docker'
}

@test 'diff: dokcer -> docker' {
    correct_in_ctx diff dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff docker'
}

@test 'print: docu -> documentation' {
    correct_in_ctx print docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print documentation'
}

@test 'cat: docu -> documentation' {
    correct_in_ctx cat docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat documentation'
}

@test 'grep: docu -> documentation' {
    correct_in_ctx grep docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep documentation'
}

@test 'sed: docu -> documentation' {
    correct_in_ctx sed docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed documentation'
}

@test 'awk: docu -> documentation' {
    correct_in_ctx awk docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk documentation'
}

@test 'man: docu -> documentation' {
    correct_in_ctx man docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man documentation'
}

@test 'ls: docu -> documentation' {
    correct_in_ctx ls docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls documentation'
}

@test 'head: docu -> documentation' {
    correct_in_ctx head docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head documentation'
}

@test 'tail: docu -> documentation' {
    correct_in_ctx tail docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail documentation'
}

@test 'sort: docu -> documentation' {
    correct_in_ctx sort docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort documentation'
}

@test 'uniq: docu -> documentation' {
    correct_in_ctx uniq docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq documentation'
}

@test 'wc: docu -> documentation' {
    correct_in_ctx wc docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc documentation'
}

@test 'tr: docu -> documentation' {
    correct_in_ctx tr docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr documentation'
}

@test 'cut: docu -> documentation' {
    correct_in_ctx cut docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut documentation'
}

@test 'diff: docu -> documentation' {
    correct_in_ctx diff docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff documentation'
}

@test 'print: doesnt -> does not' {
    correct_in_ctx print doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print does not'
}

@test 'cat: doesnt -> does not' {
    correct_in_ctx cat doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat does not'
}

@test 'grep: doesnt -> does not' {
    correct_in_ctx grep doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep does not'
}

@test 'sed: doesnt -> does not' {
    correct_in_ctx sed doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed does not'
}

@test 'awk: doesnt -> does not' {
    correct_in_ctx awk doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk does not'
}

@test 'man: doesnt -> does not' {
    correct_in_ctx man doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man does not'
}

@test 'ls: doesnt -> does not' {
    correct_in_ctx ls doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls does not'
}

@test 'head: doesnt -> does not' {
    correct_in_ctx head doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head does not'
}

@test 'tail: doesnt -> does not' {
    correct_in_ctx tail doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail does not'
}

@test 'sort: doesnt -> does not' {
    correct_in_ctx sort doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort does not'
}

@test 'uniq: doesnt -> does not' {
    correct_in_ctx uniq doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq does not'
}

@test 'wc: doesnt -> does not' {
    correct_in_ctx wc doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc does not'
}

@test 'tr: doesnt -> does not' {
    correct_in_ctx tr doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr does not'
}

@test 'cut: doesnt -> does not' {
    correct_in_ctx cut doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut does not'
}

@test 'diff: doesnt -> does not' {
    correct_in_ctx diff doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff does not'
}

@test 'print: dbl -> double' {
    correct_in_ctx print dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print double'
}

@test 'cat: dbl -> double' {
    correct_in_ctx cat dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat double'
}

@test 'grep: dbl -> double' {
    correct_in_ctx grep dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep double'
}

@test 'sed: dbl -> double' {
    correct_in_ctx sed dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed double'
}

@test 'awk: dbl -> double' {
    correct_in_ctx awk dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk double'
}

@test 'man: dbl -> double' {
    correct_in_ctx man dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man double'
}

@test 'ls: dbl -> double' {
    correct_in_ctx ls dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls double'
}

@test 'head: dbl -> double' {
    correct_in_ctx head dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head double'
}

@test 'tail: dbl -> double' {
    correct_in_ctx tail dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail double'
}

@test 'sort: dbl -> double' {
    correct_in_ctx sort dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort double'
}

@test 'uniq: dbl -> double' {
    correct_in_ctx uniq dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq double'
}

@test 'wc: dbl -> double' {
    correct_in_ctx wc dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc double'
}

@test 'tr: dbl -> double' {
    correct_in_ctx tr dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr double'
}

@test 'cut: dbl -> double' {
    correct_in_ctx cut dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut double'
}

@test 'diff: dbl -> double' {
    correct_in_ctx diff dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff double'
}

@test 'print: dql -> DQL' {
    correct_in_ctx print dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print DQL'
}

@test 'cat: dql -> DQL' {
    correct_in_ctx cat dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat DQL'
}

@test 'grep: dql -> DQL' {
    correct_in_ctx grep dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep DQL'
}

@test 'sed: dql -> DQL' {
    correct_in_ctx sed dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed DQL'
}

@test 'awk: dql -> DQL' {
    correct_in_ctx awk dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk DQL'
}

@test 'man: dql -> DQL' {
    correct_in_ctx man dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man DQL'
}

@test 'ls: dql -> DQL' {
    correct_in_ctx ls dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls DQL'
}

@test 'head: dql -> DQL' {
    correct_in_ctx head dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head DQL'
}

@test 'tail: dql -> DQL' {
    correct_in_ctx tail dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail DQL'
}

@test 'sort: dql -> DQL' {
    correct_in_ctx sort dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort DQL'
}

@test 'uniq: dql -> DQL' {
    correct_in_ctx uniq dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq DQL'
}

@test 'wc: dql -> DQL' {
    correct_in_ctx wc dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc DQL'
}

@test 'tr: dql -> DQL' {
    correct_in_ctx tr dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr DQL'
}

@test 'cut: dql -> DQL' {
    correct_in_ctx cut dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut DQL'
}

@test 'diff: dql -> DQL' {
    correct_in_ctx diff dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff DQL'
}

@test 'print: darg -> drag' {
    correct_in_ctx print darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print drag'
}

@test 'cat: darg -> drag' {
    correct_in_ctx cat darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat drag'
}

@test 'grep: darg -> drag' {
    correct_in_ctx grep darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep drag'
}

@test 'sed: darg -> drag' {
    correct_in_ctx sed darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed drag'
}

@test 'awk: darg -> drag' {
    correct_in_ctx awk darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk drag'
}

@test 'man: darg -> drag' {
    correct_in_ctx man darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man drag'
}

@test 'ls: darg -> drag' {
    correct_in_ctx ls darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls drag'
}

@test 'head: darg -> drag' {
    correct_in_ctx head darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head drag'
}

@test 'tail: darg -> drag' {
    correct_in_ctx tail darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail drag'
}

@test 'sort: darg -> drag' {
    correct_in_ctx sort darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort drag'
}

@test 'uniq: darg -> drag' {
    correct_in_ctx uniq darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq drag'
}

@test 'wc: darg -> drag' {
    correct_in_ctx wc darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc drag'
}

@test 'tr: darg -> drag' {
    correct_in_ctx tr darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr drag'
}

@test 'cut: darg -> drag' {
    correct_in_ctx cut darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut drag'
}

@test 'diff: darg -> drag' {
    correct_in_ctx diff darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff drag'
}

@test 'print: dorp -> drop' {
    correct_in_ctx print dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print drop'
}

@test 'cat: dorp -> drop' {
    correct_in_ctx cat dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat drop'
}

@test 'grep: dorp -> drop' {
    correct_in_ctx grep dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep drop'
}

@test 'sed: dorp -> drop' {
    correct_in_ctx sed dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed drop'
}

@test 'awk: dorp -> drop' {
    correct_in_ctx awk dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk drop'
}

@test 'man: dorp -> drop' {
    correct_in_ctx man dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man drop'
}

@test 'ls: dorp -> drop' {
    correct_in_ctx ls dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls drop'
}

@test 'head: dorp -> drop' {
    correct_in_ctx head dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head drop'
}

@test 'tail: dorp -> drop' {
    correct_in_ctx tail dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail drop'
}

@test 'sort: dorp -> drop' {
    correct_in_ctx sort dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort drop'
}

@test 'uniq: dorp -> drop' {
    correct_in_ctx uniq dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq drop'
}

@test 'wc: dorp -> drop' {
    correct_in_ctx wc dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc drop'
}

@test 'tr: dorp -> drop' {
    correct_in_ctx tr dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr drop'
}

@test 'cut: dorp -> drop' {
    correct_in_ctx cut dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut drop'
}

@test 'diff: dorp -> drop' {
    correct_in_ctx diff dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff drop'
}

@test 'print: durring -> during' {
    correct_in_ctx print durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print during'
}

@test 'cat: durring -> during' {
    correct_in_ctx cat durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat during'
}

@test 'grep: durring -> during' {
    correct_in_ctx grep durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep during'
}

@test 'sed: durring -> during' {
    correct_in_ctx sed durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed during'
}

@test 'awk: durring -> during' {
    correct_in_ctx awk durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk during'
}

@test 'man: durring -> during' {
    correct_in_ctx man durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man during'
}

@test 'ls: durring -> during' {
    correct_in_ctx ls durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls during'
}

@test 'head: durring -> during' {
    correct_in_ctx head durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head during'
}

@test 'tail: durring -> during' {
    correct_in_ctx tail durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail during'
}

@test 'sort: durring -> during' {
    correct_in_ctx sort durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort during'
}

@test 'uniq: durring -> during' {
    correct_in_ctx uniq durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq during'
}

@test 'wc: durring -> during' {
    correct_in_ctx wc durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc during'
}

@test 'tr: durring -> during' {
    correct_in_ctx tr durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr during'
}

@test 'cut: durring -> during' {
    correct_in_ctx cut durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut during'
}

@test 'diff: durring -> during' {
    correct_in_ctx diff durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff during'
}

@test 'print: eah -> each' {
    correct_in_ctx print eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print each'
}

@test 'cat: eah -> each' {
    correct_in_ctx cat eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat each'
}

@test 'grep: eah -> each' {
    correct_in_ctx grep eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep each'
}

@test 'sed: eah -> each' {
    correct_in_ctx sed eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed each'
}

@test 'awk: eah -> each' {
    correct_in_ctx awk eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk each'
}

@test 'man: eah -> each' {
    correct_in_ctx man eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man each'
}

@test 'ls: eah -> each' {
    correct_in_ctx ls eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls each'
}

@test 'head: eah -> each' {
    correct_in_ctx head eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head each'
}

@test 'tail: eah -> each' {
    correct_in_ctx tail eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail each'
}

@test 'sort: eah -> each' {
    correct_in_ctx sort eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort each'
}

@test 'uniq: eah -> each' {
    correct_in_ctx uniq eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq each'
}

@test 'wc: eah -> each' {
    correct_in_ctx wc eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc each'
}

@test 'tr: eah -> each' {
    correct_in_ctx tr eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr each'
}

@test 'cut: eah -> each' {
    correct_in_ctx cut eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut each'
}

@test 'diff: eah -> each' {
    correct_in_ctx diff eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff each'
}

@test 'print: ehco -> echo' {
    correct_in_ctx print ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print echo'
}

@test 'cat: ehco -> echo' {
    correct_in_ctx cat ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat echo'
}

@test 'grep: ehco -> echo' {
    correct_in_ctx grep ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep echo'
}

@test 'sed: ehco -> echo' {
    correct_in_ctx sed ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed echo'
}

@test 'awk: ehco -> echo' {
    correct_in_ctx awk ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk echo'
}

@test 'man: ehco -> echo' {
    correct_in_ctx man ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man echo'
}

@test 'ls: ehco -> echo' {
    correct_in_ctx ls ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls echo'
}

@test 'head: ehco -> echo' {
    correct_in_ctx head ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head echo'
}

@test 'tail: ehco -> echo' {
    correct_in_ctx tail ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail echo'
}

@test 'sort: ehco -> echo' {
    correct_in_ctx sort ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort echo'
}

@test 'uniq: ehco -> echo' {
    correct_in_ctx uniq ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq echo'
}

@test 'wc: ehco -> echo' {
    correct_in_ctx wc ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc echo'
}

@test 'tr: ehco -> echo' {
    correct_in_ctx tr ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr echo'
}

@test 'cut: ehco -> echo' {
    correct_in_ctx cut ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut echo'
}

@test 'diff: ehco -> echo' {
    correct_in_ctx diff ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff echo'
}

@test 'print: efi -> EFI' {
    correct_in_ctx print efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print EFI'
}

@test 'cat: efi -> EFI' {
    correct_in_ctx cat efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat EFI'
}

@test 'grep: efi -> EFI' {
    correct_in_ctx grep efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep EFI'
}

@test 'sed: efi -> EFI' {
    correct_in_ctx sed efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed EFI'
}

@test 'awk: efi -> EFI' {
    correct_in_ctx awk efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk EFI'
}

@test 'man: efi -> EFI' {
    correct_in_ctx man efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man EFI'
}

@test 'ls: efi -> EFI' {
    correct_in_ctx ls efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls EFI'
}

@test 'head: efi -> EFI' {
    correct_in_ctx head efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head EFI'
}

@test 'tail: efi -> EFI' {
    correct_in_ctx tail efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail EFI'
}

@test 'sort: efi -> EFI' {
    correct_in_ctx sort efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort EFI'
}

@test 'uniq: efi -> EFI' {
    correct_in_ctx uniq efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq EFI'
}

@test 'wc: efi -> EFI' {
    correct_in_ctx wc efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc EFI'
}

@test 'tr: efi -> EFI' {
    correct_in_ctx tr efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr EFI'
}

@test 'cut: efi -> EFI' {
    correct_in_ctx cut efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut EFI'
}

@test 'diff: efi -> EFI' {
    correct_in_ctx diff efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff EFI'
}

@test 'print: ned -> end' {
    correct_in_ctx print ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print end'
}

@test 'cat: ned -> end' {
    correct_in_ctx cat ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat end'
}

@test 'grep: ned -> end' {
    correct_in_ctx grep ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep end'
}

@test 'sed: ned -> end' {
    correct_in_ctx sed ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed end'
}

@test 'awk: ned -> end' {
    correct_in_ctx awk ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk end'
}

@test 'man: ned -> end' {
    correct_in_ctx man ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man end'
}

@test 'ls: ned -> end' {
    correct_in_ctx ls ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls end'
}

@test 'head: ned -> end' {
    correct_in_ctx head ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head end'
}

@test 'tail: ned -> end' {
    correct_in_ctx tail ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail end'
}

@test 'sort: ned -> end' {
    correct_in_ctx sort ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort end'
}

@test 'uniq: ned -> end' {
    correct_in_ctx uniq ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq end'
}

@test 'wc: ned -> end' {
    correct_in_ctx wc ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc end'
}

@test 'tr: ned -> end' {
    correct_in_ctx tr ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr end'
}

@test 'cut: ned -> end' {
    correct_in_ctx cut ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut end'
}

@test 'diff: ned -> end' {
    correct_in_ctx diff ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff end'
}

@test 'print: environ -> environment' {
    correct_in_ctx print environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print environment'
}

@test 'cat: environ -> environment' {
    correct_in_ctx cat environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat environment'
}

@test 'grep: environ -> environment' {
    correct_in_ctx grep environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep environment'
}

@test 'sed: environ -> environment' {
    correct_in_ctx sed environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed environment'
}

@test 'awk: environ -> environment' {
    correct_in_ctx awk environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk environment'
}

@test 'man: environ -> environment' {
    correct_in_ctx man environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man environment'
}

@test 'ls: environ -> environment' {
    correct_in_ctx ls environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls environment'
}

@test 'head: environ -> environment' {
    correct_in_ctx head environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head environment'
}

@test 'tail: environ -> environment' {
    correct_in_ctx tail environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail environment'
}

@test 'sort: environ -> environment' {
    correct_in_ctx sort environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort environment'
}

@test 'uniq: environ -> environment' {
    correct_in_ctx uniq environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq environment'
}

@test 'wc: environ -> environment' {
    correct_in_ctx wc environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc environment'
}

@test 'tr: environ -> environment' {
    correct_in_ctx tr environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr environment'
}

@test 'cut: environ -> environment' {
    correct_in_ctx cut environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut environment'
}

@test 'diff: environ -> environment' {
    correct_in_ctx diff environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff environment'
}

@test 'print: envvar -> environment variable' {
    correct_in_ctx print envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print environment variable'
}

@test 'cat: envvar -> environment variable' {
    correct_in_ctx cat envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat environment variable'
}

@test 'grep: envvar -> environment variable' {
    correct_in_ctx grep envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep environment variable'
}

@test 'sed: envvar -> environment variable' {
    correct_in_ctx sed envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed environment variable'
}

@test 'awk: envvar -> environment variable' {
    correct_in_ctx awk envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk environment variable'
}

@test 'man: envvar -> environment variable' {
    correct_in_ctx man envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man environment variable'
}

@test 'ls: envvar -> environment variable' {
    correct_in_ctx ls envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls environment variable'
}

@test 'head: envvar -> environment variable' {
    correct_in_ctx head envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head environment variable'
}

@test 'tail: envvar -> environment variable' {
    correct_in_ctx tail envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail environment variable'
}

@test 'sort: envvar -> environment variable' {
    correct_in_ctx sort envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort environment variable'
}

@test 'uniq: envvar -> environment variable' {
    correct_in_ctx uniq envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq environment variable'
}

@test 'wc: envvar -> environment variable' {
    correct_in_ctx wc envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc environment variable'
}

@test 'tr: envvar -> environment variable' {
    correct_in_ctx tr envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr environment variable'
}

@test 'cut: envvar -> environment variable' {
    correct_in_ctx cut envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut environment variable'
}

@test 'diff: envvar -> environment variable' {
    correct_in_ctx diff envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff environment variable'
}

@test 'print: envvars -> environment variables' {
    correct_in_ctx print envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print environment variables'
}

@test 'cat: envvars -> environment variables' {
    correct_in_ctx cat envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat environment variables'
}

@test 'grep: envvars -> environment variables' {
    correct_in_ctx grep envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep environment variables'
}

@test 'sed: envvars -> environment variables' {
    correct_in_ctx sed envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed environment variables'
}

@test 'awk: envvars -> environment variables' {
    correct_in_ctx awk envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk environment variables'
}

@test 'man: envvars -> environment variables' {
    correct_in_ctx man envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man environment variables'
}

@test 'ls: envvars -> environment variables' {
    correct_in_ctx ls envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls environment variables'
}

@test 'head: envvars -> environment variables' {
    correct_in_ctx head envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head environment variables'
}

@test 'tail: envvars -> environment variables' {
    correct_in_ctx tail envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail environment variables'
}

@test 'sort: envvars -> environment variables' {
    correct_in_ctx sort envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort environment variables'
}

@test 'uniq: envvars -> environment variables' {
    correct_in_ctx uniq envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq environment variables'
}

@test 'wc: envvars -> environment variables' {
    correct_in_ctx wc envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc environment variables'
}

@test 'tr: envvars -> environment variables' {
    correct_in_ctx tr envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr environment variables'
}

@test 'cut: envvars -> environment variables' {
    correct_in_ctx cut envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut environment variables'
}

@test 'diff: envvars -> environment variables' {
    correct_in_ctx diff envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff environment variables'
}

@test 'print: environs -> environments' {
    correct_in_ctx print environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print environments'
}

@test 'cat: environs -> environments' {
    correct_in_ctx cat environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat environments'
}

@test 'grep: environs -> environments' {
    correct_in_ctx grep environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep environments'
}

@test 'sed: environs -> environments' {
    correct_in_ctx sed environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed environments'
}

@test 'awk: environs -> environments' {
    correct_in_ctx awk environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk environments'
}

@test 'man: environs -> environments' {
    correct_in_ctx man environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man environments'
}

@test 'ls: environs -> environments' {
    correct_in_ctx ls environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls environments'
}

@test 'head: environs -> environments' {
    correct_in_ctx head environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head environments'
}

@test 'tail: environs -> environments' {
    correct_in_ctx tail environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail environments'
}

@test 'sort: environs -> environments' {
    correct_in_ctx sort environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort environments'
}

@test 'uniq: environs -> environments' {
    correct_in_ctx uniq environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq environments'
}

@test 'wc: environs -> environments' {
    correct_in_ctx wc environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc environments'
}

@test 'tr: environs -> environments' {
    correct_in_ctx tr environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr environments'
}

@test 'cut: environs -> environments' {
    correct_in_ctx cut environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut environments'
}

@test 'diff: environs -> environments' {
    correct_in_ctx diff environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff environments'
}

@test 'print: eror -> error' {
    correct_in_ctx print eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print error'
}

@test 'cat: eror -> error' {
    correct_in_ctx cat eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat error'
}

@test 'grep: eror -> error' {
    correct_in_ctx grep eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep error'
}

@test 'sed: eror -> error' {
    correct_in_ctx sed eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed error'
}

@test 'awk: eror -> error' {
    correct_in_ctx awk eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk error'
}

@test 'man: eror -> error' {
    correct_in_ctx man eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man error'
}

@test 'ls: eror -> error' {
    correct_in_ctx ls eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls error'
}

@test 'head: eror -> error' {
    correct_in_ctx head eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head error'
}

@test 'tail: eror -> error' {
    correct_in_ctx tail eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail error'
}

@test 'sort: eror -> error' {
    correct_in_ctx sort eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort error'
}

@test 'uniq: eror -> error' {
    correct_in_ctx uniq eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq error'
}

@test 'wc: eror -> error' {
    correct_in_ctx wc eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc error'
}

@test 'tr: eror -> error' {
    correct_in_ctx tr eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr error'
}

@test 'cut: eror -> error' {
    correct_in_ctx cut eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut error'
}

@test 'diff: eror -> error' {
    correct_in_ctx diff eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff error'
}

@test 'print: eixt -> exit' {
    correct_in_ctx print eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print exit'
}

@test 'cat: eixt -> exit' {
    correct_in_ctx cat eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat exit'
}

@test 'grep: eixt -> exit' {
    correct_in_ctx grep eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep exit'
}

@test 'sed: eixt -> exit' {
    correct_in_ctx sed eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed exit'
}

@test 'awk: eixt -> exit' {
    correct_in_ctx awk eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk exit'
}

@test 'man: eixt -> exit' {
    correct_in_ctx man eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man exit'
}

@test 'ls: eixt -> exit' {
    correct_in_ctx ls eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls exit'
}

@test 'head: eixt -> exit' {
    correct_in_ctx head eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head exit'
}

@test 'tail: eixt -> exit' {
    correct_in_ctx tail eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail exit'
}

@test 'sort: eixt -> exit' {
    correct_in_ctx sort eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort exit'
}

@test 'uniq: eixt -> exit' {
    correct_in_ctx uniq eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq exit'
}

@test 'wc: eixt -> exit' {
    correct_in_ctx wc eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc exit'
}

@test 'tr: eixt -> exit' {
    correct_in_ctx tr eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr exit'
}

@test 'cut: eixt -> exit' {
    correct_in_ctx cut eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut exit'
}

@test 'diff: eixt -> exit' {
    correct_in_ctx diff eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff exit'
}

@test 'print: exp -> expansion' {
    correct_in_ctx print exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print expansion'
}

@test 'cat: exp -> expansion' {
    correct_in_ctx cat exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat expansion'
}

@test 'grep: exp -> expansion' {
    correct_in_ctx grep exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep expansion'
}

@test 'sed: exp -> expansion' {
    correct_in_ctx sed exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed expansion'
}

@test 'awk: exp -> expansion' {
    correct_in_ctx awk exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk expansion'
}

@test 'man: exp -> expansion' {
    correct_in_ctx man exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man expansion'
}

@test 'ls: exp -> expansion' {
    correct_in_ctx ls exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls expansion'
}

@test 'head: exp -> expansion' {
    correct_in_ctx head exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head expansion'
}

@test 'tail: exp -> expansion' {
    correct_in_ctx tail exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail expansion'
}

@test 'sort: exp -> expansion' {
    correct_in_ctx sort exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort expansion'
}

@test 'uniq: exp -> expansion' {
    correct_in_ctx uniq exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq expansion'
}

@test 'wc: exp -> expansion' {
    correct_in_ctx wc exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc expansion'
}

@test 'tr: exp -> expansion' {
    correct_in_ctx tr exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr expansion'
}

@test 'cut: exp -> expansion' {
    correct_in_ctx cut exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut expansion'
}

@test 'diff: exp -> expansion' {
    correct_in_ctx diff exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff expansion'
}

@test 'print: fales -> false' {
    correct_in_ctx print fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print false'
}

@test 'cat: fales -> false' {
    correct_in_ctx cat fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat false'
}

@test 'grep: fales -> false' {
    correct_in_ctx grep fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep false'
}

@test 'sed: fales -> false' {
    correct_in_ctx sed fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed false'
}

@test 'awk: fales -> false' {
    correct_in_ctx awk fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk false'
}

@test 'man: fales -> false' {
    correct_in_ctx man fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man false'
}

@test 'ls: fales -> false' {
    correct_in_ctx ls fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls false'
}

@test 'head: fales -> false' {
    correct_in_ctx head fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head false'
}

@test 'tail: fales -> false' {
    correct_in_ctx tail fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail false'
}

@test 'sort: fales -> false' {
    correct_in_ctx sort fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort false'
}

@test 'uniq: fales -> false' {
    correct_in_ctx uniq fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq false'
}

@test 'wc: fales -> false' {
    correct_in_ctx wc fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc false'
}

@test 'tr: fales -> false' {
    correct_in_ctx tr fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr false'
}

@test 'cut: fales -> false' {
    correct_in_ctx cut fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut false'
}

@test 'diff: fales -> false' {
    correct_in_ctx diff fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff false'
}

@test 'print: fied -> field' {
    correct_in_ctx print fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print field'
}

@test 'cat: fied -> field' {
    correct_in_ctx cat fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat field'
}

@test 'grep: fied -> field' {
    correct_in_ctx grep fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep field'
}

@test 'sed: fied -> field' {
    correct_in_ctx sed fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed field'
}

@test 'awk: fied -> field' {
    correct_in_ctx awk fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk field'
}

@test 'man: fied -> field' {
    correct_in_ctx man fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man field'
}

@test 'ls: fied -> field' {
    correct_in_ctx ls fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls field'
}

@test 'head: fied -> field' {
    correct_in_ctx head fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head field'
}

@test 'tail: fied -> field' {
    correct_in_ctx tail fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail field'
}

@test 'sort: fied -> field' {
    correct_in_ctx sort fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort field'
}

@test 'uniq: fied -> field' {
    correct_in_ctx uniq fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq field'
}

@test 'wc: fied -> field' {
    correct_in_ctx wc fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc field'
}

@test 'tr: fied -> field' {
    correct_in_ctx tr fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr field'
}

@test 'cut: fied -> field' {
    correct_in_ctx cut fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut field'
}

@test 'diff: fied -> field' {
    correct_in_ctx diff fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff field'
}

@test 'print: feil -> file' {
    correct_in_ctx print feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print file'
}

@test 'cat: feil -> file' {
    correct_in_ctx cat feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat file'
}

@test 'grep: feil -> file' {
    correct_in_ctx grep feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep file'
}

@test 'sed: feil -> file' {
    correct_in_ctx sed feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed file'
}

@test 'awk: feil -> file' {
    correct_in_ctx awk feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk file'
}

@test 'man: feil -> file' {
    correct_in_ctx man feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man file'
}

@test 'ls: feil -> file' {
    correct_in_ctx ls feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls file'
}

@test 'head: feil -> file' {
    correct_in_ctx head feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head file'
}

@test 'tail: feil -> file' {
    correct_in_ctx tail feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail file'
}

@test 'sort: feil -> file' {
    correct_in_ctx sort feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort file'
}

@test 'uniq: feil -> file' {
    correct_in_ctx uniq feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq file'
}

@test 'wc: feil -> file' {
    correct_in_ctx wc feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc file'
}

@test 'tr: feil -> file' {
    correct_in_ctx tr feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr file'
}

@test 'cut: feil -> file' {
    correct_in_ctx cut feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut file'
}

@test 'diff: feil -> file' {
    correct_in_ctx diff feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff file'
}

@test 'print: ifles -> files' {
    correct_in_ctx print ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print files'
}

@test 'cat: ifles -> files' {
    correct_in_ctx cat ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat files'
}

@test 'grep: ifles -> files' {
    correct_in_ctx grep ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep files'
}

@test 'sed: ifles -> files' {
    correct_in_ctx sed ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed files'
}

@test 'awk: ifles -> files' {
    correct_in_ctx awk ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk files'
}

@test 'man: ifles -> files' {
    correct_in_ctx man ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man files'
}

@test 'ls: ifles -> files' {
    correct_in_ctx ls ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls files'
}

@test 'head: ifles -> files' {
    correct_in_ctx head ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head files'
}

@test 'tail: ifles -> files' {
    correct_in_ctx tail ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail files'
}

@test 'sort: ifles -> files' {
    correct_in_ctx sort ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort files'
}

@test 'uniq: ifles -> files' {
    correct_in_ctx uniq ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq files'
}

@test 'wc: ifles -> files' {
    correct_in_ctx wc ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc files'
}

@test 'tr: ifles -> files' {
    correct_in_ctx tr ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr files'
}

@test 'cut: ifles -> files' {
    correct_in_ctx cut ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut files'
}

@test 'diff: ifles -> files' {
    correct_in_ctx diff ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff files'
}

@test 'print: fnial -> final' {
    correct_in_ctx print fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print final'
}

@test 'cat: fnial -> final' {
    correct_in_ctx cat fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat final'
}

@test 'grep: fnial -> final' {
    correct_in_ctx grep fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep final'
}

@test 'sed: fnial -> final' {
    correct_in_ctx sed fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed final'
}

@test 'awk: fnial -> final' {
    correct_in_ctx awk fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk final'
}

@test 'man: fnial -> final' {
    correct_in_ctx man fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man final'
}

@test 'ls: fnial -> final' {
    correct_in_ctx ls fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls final'
}

@test 'head: fnial -> final' {
    correct_in_ctx head fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head final'
}

@test 'tail: fnial -> final' {
    correct_in_ctx tail fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail final'
}

@test 'sort: fnial -> final' {
    correct_in_ctx sort fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort final'
}

@test 'uniq: fnial -> final' {
    correct_in_ctx uniq fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq final'
}

@test 'wc: fnial -> final' {
    correct_in_ctx wc fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc final'
}

@test 'tr: fnial -> final' {
    correct_in_ctx tr fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr final'
}

@test 'cut: fnial -> final' {
    correct_in_ctx cut fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut final'
}

@test 'diff: fnial -> final' {
    correct_in_ctx diff fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff final'
}

@test 'print: fingre -> finger' {
    correct_in_ctx print fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print finger'
}

@test 'cat: fingre -> finger' {
    correct_in_ctx cat fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat finger'
}

@test 'grep: fingre -> finger' {
    correct_in_ctx grep fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep finger'
}

@test 'sed: fingre -> finger' {
    correct_in_ctx sed fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed finger'
}

@test 'awk: fingre -> finger' {
    correct_in_ctx awk fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk finger'
}

@test 'man: fingre -> finger' {
    correct_in_ctx man fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man finger'
}

@test 'ls: fingre -> finger' {
    correct_in_ctx ls fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls finger'
}

@test 'head: fingre -> finger' {
    correct_in_ctx head fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head finger'
}

@test 'tail: fingre -> finger' {
    correct_in_ctx tail fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail finger'
}

@test 'sort: fingre -> finger' {
    correct_in_ctx sort fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort finger'
}

@test 'uniq: fingre -> finger' {
    correct_in_ctx uniq fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq finger'
}

@test 'wc: fingre -> finger' {
    correct_in_ctx wc fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc finger'
}

@test 'tr: fingre -> finger' {
    correct_in_ctx tr fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr finger'
}

@test 'cut: fingre -> finger' {
    correct_in_ctx cut fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut finger'
}

@test 'diff: fingre -> finger' {
    correct_in_ctx diff fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff finger'
}

@test 'print: firsst -> first' {
    correct_in_ctx print firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print first'
}

@test 'cat: firsst -> first' {
    correct_in_ctx cat firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat first'
}

@test 'grep: firsst -> first' {
    correct_in_ctx grep firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep first'
}

@test 'sed: firsst -> first' {
    correct_in_ctx sed firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed first'
}

@test 'awk: firsst -> first' {
    correct_in_ctx awk firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk first'
}

@test 'man: firsst -> first' {
    correct_in_ctx man firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man first'
}

@test 'ls: firsst -> first' {
    correct_in_ctx ls firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls first'
}

@test 'head: firsst -> first' {
    correct_in_ctx head firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head first'
}

@test 'tail: firsst -> first' {
    correct_in_ctx tail firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail first'
}

@test 'sort: firsst -> first' {
    correct_in_ctx sort firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort first'
}

@test 'uniq: firsst -> first' {
    correct_in_ctx uniq firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq first'
}

@test 'wc: firsst -> first' {
    correct_in_ctx wc firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc first'
}

@test 'tr: firsst -> first' {
    correct_in_ctx tr firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr first'
}

@test 'cut: firsst -> first' {
    correct_in_ctx cut firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut first'
}

@test 'diff: firsst -> first' {
    correct_in_ctx diff firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff first'
}

@test 'print: forr -> for' {
    correct_in_ctx print forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print for'
}

@test 'cat: forr -> for' {
    correct_in_ctx cat forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat for'
}

@test 'grep: forr -> for' {
    correct_in_ctx grep forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep for'
}

@test 'sed: forr -> for' {
    correct_in_ctx sed forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed for'
}

@test 'awk: forr -> for' {
    correct_in_ctx awk forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk for'
}

@test 'man: forr -> for' {
    correct_in_ctx man forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man for'
}

@test 'ls: forr -> for' {
    correct_in_ctx ls forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls for'
}

@test 'head: forr -> for' {
    correct_in_ctx head forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head for'
}

@test 'tail: forr -> for' {
    correct_in_ctx tail forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail for'
}

@test 'sort: forr -> for' {
    correct_in_ctx sort forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort for'
}

@test 'uniq: forr -> for' {
    correct_in_ctx uniq forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq for'
}

@test 'wc: forr -> for' {
    correct_in_ctx wc forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc for'
}

@test 'tr: forr -> for' {
    correct_in_ctx tr forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr for'
}

@test 'cut: forr -> for' {
    correct_in_ctx cut forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut for'
}

@test 'diff: forr -> for' {
    correct_in_ctx diff forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff for'
}

@test 'print: fg -> foreground' {
    correct_in_ctx print fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print foreground'
}

@test 'cat: fg -> foreground' {
    correct_in_ctx cat fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat foreground'
}

@test 'grep: fg -> foreground' {
    correct_in_ctx grep fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep foreground'
}

@test 'sed: fg -> foreground' {
    correct_in_ctx sed fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed foreground'
}

@test 'awk: fg -> foreground' {
    correct_in_ctx awk fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk foreground'
}

@test 'man: fg -> foreground' {
    correct_in_ctx man fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man foreground'
}

@test 'ls: fg -> foreground' {
    correct_in_ctx ls fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls foreground'
}

@test 'head: fg -> foreground' {
    correct_in_ctx head fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head foreground'
}

@test 'tail: fg -> foreground' {
    correct_in_ctx tail fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail foreground'
}

@test 'sort: fg -> foreground' {
    correct_in_ctx sort fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort foreground'
}

@test 'uniq: fg -> foreground' {
    correct_in_ctx uniq fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq foreground'
}

@test 'wc: fg -> foreground' {
    correct_in_ctx wc fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc foreground'
}

@test 'tr: fg -> foreground' {
    correct_in_ctx tr fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr foreground'
}

@test 'cut: fg -> foreground' {
    correct_in_ctx cut fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut foreground'
}

@test 'diff: fg -> foreground' {
    correct_in_ctx diff fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff foreground'
}

@test 'print: ofund -> found' {
    correct_in_ctx print ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print found'
}

@test 'cat: ofund -> found' {
    correct_in_ctx cat ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat found'
}

@test 'grep: ofund -> found' {
    correct_in_ctx grep ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep found'
}

@test 'sed: ofund -> found' {
    correct_in_ctx sed ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed found'
}

@test 'awk: ofund -> found' {
    correct_in_ctx awk ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk found'
}

@test 'man: ofund -> found' {
    correct_in_ctx man ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man found'
}

@test 'ls: ofund -> found' {
    correct_in_ctx ls ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls found'
}

@test 'head: ofund -> found' {
    correct_in_ctx head ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head found'
}

@test 'tail: ofund -> found' {
    correct_in_ctx tail ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail found'
}

@test 'sort: ofund -> found' {
    correct_in_ctx sort ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort found'
}

@test 'uniq: ofund -> found' {
    correct_in_ctx uniq ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq found'
}

@test 'wc: ofund -> found' {
    correct_in_ctx wc ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc found'
}

@test 'tr: ofund -> found' {
    correct_in_ctx tr ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr found'
}

@test 'cut: ofund -> found' {
    correct_in_ctx cut ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut found'
}

@test 'diff: ofund -> found' {
    correct_in_ctx diff ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff found'
}

@test 'print: fxn -> function' {
    correct_in_ctx print fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print function'
}

@test 'cat: fxn -> function' {
    correct_in_ctx cat fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat function'
}

@test 'grep: fxn -> function' {
    correct_in_ctx grep fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep function'
}

@test 'sed: fxn -> function' {
    correct_in_ctx sed fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed function'
}

@test 'awk: fxn -> function' {
    correct_in_ctx awk fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk function'
}

@test 'man: fxn -> function' {
    correct_in_ctx man fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man function'
}

@test 'ls: fxn -> function' {
    correct_in_ctx ls fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls function'
}

@test 'head: fxn -> function' {
    correct_in_ctx head fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head function'
}

@test 'tail: fxn -> function' {
    correct_in_ctx tail fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail function'
}

@test 'sort: fxn -> function' {
    correct_in_ctx sort fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort function'
}

@test 'uniq: fxn -> function' {
    correct_in_ctx uniq fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq function'
}

@test 'wc: fxn -> function' {
    correct_in_ctx wc fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc function'
}

@test 'tr: fxn -> function' {
    correct_in_ctx tr fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr function'
}

@test 'cut: fxn -> function' {
    correct_in_ctx cut fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut function'
}

@test 'diff: fxn -> function' {
    correct_in_ctx diff fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff function'
}

@test 'print: fxnal -> functional' {
    correct_in_ctx print fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print functional'
}

@test 'cat: fxnal -> functional' {
    correct_in_ctx cat fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat functional'
}

@test 'grep: fxnal -> functional' {
    correct_in_ctx grep fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep functional'
}

@test 'sed: fxnal -> functional' {
    correct_in_ctx sed fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed functional'
}

@test 'awk: fxnal -> functional' {
    correct_in_ctx awk fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk functional'
}

@test 'man: fxnal -> functional' {
    correct_in_ctx man fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man functional'
}

@test 'ls: fxnal -> functional' {
    correct_in_ctx ls fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls functional'
}

@test 'head: fxnal -> functional' {
    correct_in_ctx head fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head functional'
}

@test 'tail: fxnal -> functional' {
    correct_in_ctx tail fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail functional'
}

@test 'sort: fxnal -> functional' {
    correct_in_ctx sort fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort functional'
}

@test 'uniq: fxnal -> functional' {
    correct_in_ctx uniq fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq functional'
}

@test 'wc: fxnal -> functional' {
    correct_in_ctx wc fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc functional'
}

@test 'tr: fxnal -> functional' {
    correct_in_ctx tr fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr functional'
}

@test 'cut: fxnal -> functional' {
    correct_in_ctx cut fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut functional'
}

@test 'diff: fxnal -> functional' {
    correct_in_ctx diff fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff functional'
}

@test 'print: fxns -> functions' {
    correct_in_ctx print fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print functions'
}

@test 'cat: fxns -> functions' {
    correct_in_ctx cat fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat functions'
}

@test 'grep: fxns -> functions' {
    correct_in_ctx grep fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep functions'
}

@test 'sed: fxns -> functions' {
    correct_in_ctx sed fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed functions'
}

@test 'awk: fxns -> functions' {
    correct_in_ctx awk fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk functions'
}

@test 'man: fxns -> functions' {
    correct_in_ctx man fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man functions'
}

@test 'ls: fxns -> functions' {
    correct_in_ctx ls fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls functions'
}

@test 'head: fxns -> functions' {
    correct_in_ctx head fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head functions'
}

@test 'tail: fxns -> functions' {
    correct_in_ctx tail fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail functions'
}

@test 'sort: fxns -> functions' {
    correct_in_ctx sort fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort functions'
}

@test 'uniq: fxns -> functions' {
    correct_in_ctx uniq fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq functions'
}

@test 'wc: fxns -> functions' {
    correct_in_ctx wc fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc functions'
}

@test 'tr: fxns -> functions' {
    correct_in_ctx tr fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr functions'
}

@test 'cut: fxns -> functions' {
    correct_in_ctx cut fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut functions'
}

@test 'diff: fxns -> functions' {
    correct_in_ctx diff fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff functions'
}

@test 'print: gw -> gateway' {
    correct_in_ctx print gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print gateway'
}

@test 'cat: gw -> gateway' {
    correct_in_ctx cat gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat gateway'
}

@test 'grep: gw -> gateway' {
    correct_in_ctx grep gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep gateway'
}

@test 'sed: gw -> gateway' {
    correct_in_ctx sed gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed gateway'
}

@test 'awk: gw -> gateway' {
    correct_in_ctx awk gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk gateway'
}

@test 'man: gw -> gateway' {
    correct_in_ctx man gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man gateway'
}

@test 'ls: gw -> gateway' {
    correct_in_ctx ls gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls gateway'
}

@test 'head: gw -> gateway' {
    correct_in_ctx head gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head gateway'
}

@test 'tail: gw -> gateway' {
    correct_in_ctx tail gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail gateway'
}

@test 'sort: gw -> gateway' {
    correct_in_ctx sort gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort gateway'
}

@test 'uniq: gw -> gateway' {
    correct_in_ctx uniq gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq gateway'
}

@test 'wc: gw -> gateway' {
    correct_in_ctx wc gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc gateway'
}

@test 'tr: gw -> gateway' {
    correct_in_ctx tr gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr gateway'
}

@test 'cut: gw -> gateway' {
    correct_in_ctx cut gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut gateway'
}

@test 'diff: gw -> gateway' {
    correct_in_ctx diff gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff gateway'
}

@test 'print: igt -> git' {
    correct_in_ctx print igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print git'
}

@test 'cat: igt -> git' {
    correct_in_ctx cat igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat git'
}

@test 'grep: igt -> git' {
    correct_in_ctx grep igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep git'
}

@test 'sed: igt -> git' {
    correct_in_ctx sed igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed git'
}

@test 'awk: igt -> git' {
    correct_in_ctx awk igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk git'
}

@test 'man: igt -> git' {
    correct_in_ctx man igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man git'
}

@test 'ls: igt -> git' {
    correct_in_ctx ls igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls git'
}

@test 'head: igt -> git' {
    correct_in_ctx head igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head git'
}

@test 'tail: igt -> git' {
    correct_in_ctx tail igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail git'
}

@test 'sort: igt -> git' {
    correct_in_ctx sort igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort git'
}

@test 'uniq: igt -> git' {
    correct_in_ctx uniq igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq git'
}

@test 'wc: igt -> git' {
    correct_in_ctx wc igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc git'
}

@test 'tr: igt -> git' {
    correct_in_ctx tr igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr git'
}

@test 'cut: igt -> git' {
    correct_in_ctx cut igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut git'
}

@test 'diff: igt -> git' {
    correct_in_ctx diff igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff git'
}

@test 'print: og -> go' {
    correct_in_ctx print og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print go'
}

@test 'cat: og -> go' {
    correct_in_ctx cat og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat go'
}

@test 'grep: og -> go' {
    correct_in_ctx grep og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep go'
}

@test 'sed: og -> go' {
    correct_in_ctx sed og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed go'
}

@test 'awk: og -> go' {
    correct_in_ctx awk og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk go'
}

@test 'man: og -> go' {
    correct_in_ctx man og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man go'
}

@test 'ls: og -> go' {
    correct_in_ctx ls og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls go'
}

@test 'head: og -> go' {
    correct_in_ctx head og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head go'
}

@test 'tail: og -> go' {
    correct_in_ctx tail og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail go'
}

@test 'sort: og -> go' {
    correct_in_ctx sort og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort go'
}

@test 'uniq: og -> go' {
    correct_in_ctx uniq og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq go'
}

@test 'wc: og -> go' {
    correct_in_ctx wc og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc go'
}

@test 'tr: og -> go' {
    correct_in_ctx tr og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr go'
}

@test 'cut: og -> go' {
    correct_in_ctx cut og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut go'
}

@test 'diff: og -> go' {
    correct_in_ctx diff og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff go'
}

@test 'print: gpt -> GPT' {
    correct_in_ctx print gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print GPT'
}

@test 'cat: gpt -> GPT' {
    correct_in_ctx cat gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat GPT'
}

@test 'grep: gpt -> GPT' {
    correct_in_ctx grep gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep GPT'
}

@test 'sed: gpt -> GPT' {
    correct_in_ctx sed gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed GPT'
}

@test 'awk: gpt -> GPT' {
    correct_in_ctx awk gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk GPT'
}

@test 'man: gpt -> GPT' {
    correct_in_ctx man gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man GPT'
}

@test 'ls: gpt -> GPT' {
    correct_in_ctx ls gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls GPT'
}

@test 'head: gpt -> GPT' {
    correct_in_ctx head gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head GPT'
}

@test 'tail: gpt -> GPT' {
    correct_in_ctx tail gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail GPT'
}

@test 'sort: gpt -> GPT' {
    correct_in_ctx sort gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort GPT'
}

@test 'uniq: gpt -> GPT' {
    correct_in_ctx uniq gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq GPT'
}

@test 'wc: gpt -> GPT' {
    correct_in_ctx wc gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc GPT'
}

@test 'tr: gpt -> GPT' {
    correct_in_ctx tr gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr GPT'
}

@test 'cut: gpt -> GPT' {
    correct_in_ctx cut gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut GPT'
}

@test 'diff: gpt -> GPT' {
    correct_in_ctx diff gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff GPT'
}

@test 'print: gpu -> GPU' {
    correct_in_ctx print gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print GPU'
}

@test 'cat: gpu -> GPU' {
    correct_in_ctx cat gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat GPU'
}

@test 'grep: gpu -> GPU' {
    correct_in_ctx grep gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep GPU'
}

@test 'sed: gpu -> GPU' {
    correct_in_ctx sed gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed GPU'
}

@test 'awk: gpu -> GPU' {
    correct_in_ctx awk gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk GPU'
}

@test 'man: gpu -> GPU' {
    correct_in_ctx man gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man GPU'
}

@test 'ls: gpu -> GPU' {
    correct_in_ctx ls gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls GPU'
}

@test 'head: gpu -> GPU' {
    correct_in_ctx head gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head GPU'
}

@test 'tail: gpu -> GPU' {
    correct_in_ctx tail gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail GPU'
}

@test 'sort: gpu -> GPU' {
    correct_in_ctx sort gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort GPU'
}

@test 'uniq: gpu -> GPU' {
    correct_in_ctx uniq gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq GPU'
}

@test 'wc: gpu -> GPU' {
    correct_in_ctx wc gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc GPU'
}

@test 'tr: gpu -> GPU' {
    correct_in_ctx tr gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr GPU'
}

@test 'cut: gpu -> GPU' {
    correct_in_ctx cut gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut GPU'
}

@test 'diff: gpu -> GPU' {
    correct_in_ctx diff gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff GPU'
}

@test 'print: gorup -> group' {
    correct_in_ctx print gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print group'
}

@test 'cat: gorup -> group' {
    correct_in_ctx cat gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat group'
}

@test 'grep: gorup -> group' {
    correct_in_ctx grep gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep group'
}

@test 'sed: gorup -> group' {
    correct_in_ctx sed gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed group'
}

@test 'awk: gorup -> group' {
    correct_in_ctx awk gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk group'
}

@test 'man: gorup -> group' {
    correct_in_ctx man gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man group'
}

@test 'ls: gorup -> group' {
    correct_in_ctx ls gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls group'
}

@test 'head: gorup -> group' {
    correct_in_ctx head gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head group'
}

@test 'tail: gorup -> group' {
    correct_in_ctx tail gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail group'
}

@test 'sort: gorup -> group' {
    correct_in_ctx sort gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort group'
}

@test 'uniq: gorup -> group' {
    correct_in_ctx uniq gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq group'
}

@test 'wc: gorup -> group' {
    correct_in_ctx wc gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc group'
}

@test 'tr: gorup -> group' {
    correct_in_ctx tr gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr group'
}

@test 'cut: gorup -> group' {
    correct_in_ctx cut gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut group'
}

@test 'diff: gorup -> group' {
    correct_in_ctx diff gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff group'
}

@test 'print: h2 -> H2' {
    correct_in_ctx print h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print H2'
}

@test 'cat: h2 -> H2' {
    correct_in_ctx cat h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat H2'
}

@test 'grep: h2 -> H2' {
    correct_in_ctx grep h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep H2'
}

@test 'sed: h2 -> H2' {
    correct_in_ctx sed h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed H2'
}

@test 'awk: h2 -> H2' {
    correct_in_ctx awk h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk H2'
}

@test 'man: h2 -> H2' {
    correct_in_ctx man h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man H2'
}

@test 'ls: h2 -> H2' {
    correct_in_ctx ls h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls H2'
}

@test 'head: h2 -> H2' {
    correct_in_ctx head h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head H2'
}

@test 'tail: h2 -> H2' {
    correct_in_ctx tail h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail H2'
}

@test 'sort: h2 -> H2' {
    correct_in_ctx sort h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort H2'
}

@test 'uniq: h2 -> H2' {
    correct_in_ctx uniq h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq H2'
}

@test 'wc: h2 -> H2' {
    correct_in_ctx wc h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc H2'
}

@test 'tr: h2 -> H2' {
    correct_in_ctx tr h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr H2'
}

@test 'cut: h2 -> H2' {
    correct_in_ctx cut h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut H2'
}

@test 'diff: h2 -> H2' {
    correct_in_ctx diff h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff H2'
}

@test 'print: hasnt -> has not' {
    correct_in_ctx print hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print has not'
}

@test 'cat: hasnt -> has not' {
    correct_in_ctx cat hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat has not'
}

@test 'grep: hasnt -> has not' {
    correct_in_ctx grep hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep has not'
}

@test 'sed: hasnt -> has not' {
    correct_in_ctx sed hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed has not'
}

@test 'awk: hasnt -> has not' {
    correct_in_ctx awk hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk has not'
}

@test 'man: hasnt -> has not' {
    correct_in_ctx man hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man has not'
}

@test 'ls: hasnt -> has not' {
    correct_in_ctx ls hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls has not'
}

@test 'head: hasnt -> has not' {
    correct_in_ctx head hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head has not'
}

@test 'tail: hasnt -> has not' {
    correct_in_ctx tail hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail has not'
}

@test 'sort: hasnt -> has not' {
    correct_in_ctx sort hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort has not'
}

@test 'uniq: hasnt -> has not' {
    correct_in_ctx uniq hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq has not'
}

@test 'wc: hasnt -> has not' {
    correct_in_ctx wc hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc has not'
}

@test 'tr: hasnt -> has not' {
    correct_in_ctx tr hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr has not'
}

@test 'cut: hasnt -> has not' {
    correct_in_ctx cut hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut has not'
}

@test 'diff: hasnt -> has not' {
    correct_in_ctx diff hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff has not'
}

@test 'print: havent -> have not' {
    correct_in_ctx print havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print have not'
}

@test 'cat: havent -> have not' {
    correct_in_ctx cat havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat have not'
}

@test 'grep: havent -> have not' {
    correct_in_ctx grep havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep have not'
}

@test 'sed: havent -> have not' {
    correct_in_ctx sed havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed have not'
}

@test 'awk: havent -> have not' {
    correct_in_ctx awk havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk have not'
}

@test 'man: havent -> have not' {
    correct_in_ctx man havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man have not'
}

@test 'ls: havent -> have not' {
    correct_in_ctx ls havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls have not'
}

@test 'head: havent -> have not' {
    correct_in_ctx head havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head have not'
}

@test 'tail: havent -> have not' {
    correct_in_ctx tail havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail have not'
}

@test 'sort: havent -> have not' {
    correct_in_ctx sort havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort have not'
}

@test 'uniq: havent -> have not' {
    correct_in_ctx uniq havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq have not'
}

@test 'wc: havent -> have not' {
    correct_in_ctx wc havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc have not'
}

@test 'tr: havent -> have not' {
    correct_in_ctx tr havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr have not'
}

@test 'cut: havent -> have not' {
    correct_in_ctx cut havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut have not'
}

@test 'diff: havent -> have not' {
    correct_in_ctx diff havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff have not'
}

@test 'print: ehre -> here' {
    correct_in_ctx print ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print here'
}

@test 'cat: ehre -> here' {
    correct_in_ctx cat ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat here'
}

@test 'grep: ehre -> here' {
    correct_in_ctx grep ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep here'
}

@test 'sed: ehre -> here' {
    correct_in_ctx sed ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed here'
}

@test 'awk: ehre -> here' {
    correct_in_ctx awk ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk here'
}

@test 'man: ehre -> here' {
    correct_in_ctx man ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man here'
}

@test 'ls: ehre -> here' {
    correct_in_ctx ls ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls here'
}

@test 'head: ehre -> here' {
    correct_in_ctx head ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head here'
}

@test 'tail: ehre -> here' {
    correct_in_ctx tail ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail here'
}

@test 'sort: ehre -> here' {
    correct_in_ctx sort ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort here'
}

@test 'uniq: ehre -> here' {
    correct_in_ctx uniq ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq here'
}

@test 'wc: ehre -> here' {
    correct_in_ctx wc ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc here'
}

@test 'tr: ehre -> here' {
    correct_in_ctx tr ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr here'
}

@test 'cut: ehre -> here' {
    correct_in_ctx cut ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut here'
}

@test 'diff: ehre -> here' {
    correct_in_ctx diff ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff here'
}

@test 'print: hfs -> HFS' {
    correct_in_ctx print hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print HFS'
}

@test 'cat: hfs -> HFS' {
    correct_in_ctx cat hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat HFS'
}

@test 'grep: hfs -> HFS' {
    correct_in_ctx grep hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep HFS'
}

@test 'sed: hfs -> HFS' {
    correct_in_ctx sed hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed HFS'
}

@test 'awk: hfs -> HFS' {
    correct_in_ctx awk hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk HFS'
}

@test 'man: hfs -> HFS' {
    correct_in_ctx man hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man HFS'
}

@test 'ls: hfs -> HFS' {
    correct_in_ctx ls hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls HFS'
}

@test 'head: hfs -> HFS' {
    correct_in_ctx head hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head HFS'
}

@test 'tail: hfs -> HFS' {
    correct_in_ctx tail hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail HFS'
}

@test 'sort: hfs -> HFS' {
    correct_in_ctx sort hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort HFS'
}

@test 'uniq: hfs -> HFS' {
    correct_in_ctx uniq hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq HFS'
}

@test 'wc: hfs -> HFS' {
    correct_in_ctx wc hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc HFS'
}

@test 'tr: hfs -> HFS' {
    correct_in_ctx tr hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr HFS'
}

@test 'cut: hfs -> HFS' {
    correct_in_ctx cut hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut HFS'
}

@test 'diff: hfs -> HFS' {
    correct_in_ctx diff hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff HFS'
}

@test 'print: hgih -> high' {
    correct_in_ctx print hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print high'
}

@test 'cat: hgih -> high' {
    correct_in_ctx cat hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat high'
}

@test 'grep: hgih -> high' {
    correct_in_ctx grep hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep high'
}

@test 'sed: hgih -> high' {
    correct_in_ctx sed hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed high'
}

@test 'awk: hgih -> high' {
    correct_in_ctx awk hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk high'
}

@test 'man: hgih -> high' {
    correct_in_ctx man hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man high'
}

@test 'ls: hgih -> high' {
    correct_in_ctx ls hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls high'
}

@test 'head: hgih -> high' {
    correct_in_ctx head hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head high'
}

@test 'tail: hgih -> high' {
    correct_in_ctx tail hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail high'
}

@test 'sort: hgih -> high' {
    correct_in_ctx sort hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort high'
}

@test 'uniq: hgih -> high' {
    correct_in_ctx uniq hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq high'
}

@test 'wc: hgih -> high' {
    correct_in_ctx wc hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc high'
}

@test 'tr: hgih -> high' {
    correct_in_ctx tr hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr high'
}

@test 'cut: hgih -> high' {
    correct_in_ctx cut hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut high'
}

@test 'diff: hgih -> high' {
    correct_in_ctx diff hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff high'
}

@test 'print: hollld -> hold' {
    correct_in_ctx print hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print hold'
}

@test 'cat: hollld -> hold' {
    correct_in_ctx cat hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat hold'
}

@test 'grep: hollld -> hold' {
    correct_in_ctx grep hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep hold'
}

@test 'sed: hollld -> hold' {
    correct_in_ctx sed hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed hold'
}

@test 'awk: hollld -> hold' {
    correct_in_ctx awk hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk hold'
}

@test 'man: hollld -> hold' {
    correct_in_ctx man hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man hold'
}

@test 'ls: hollld -> hold' {
    correct_in_ctx ls hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls hold'
}

@test 'head: hollld -> hold' {
    correct_in_ctx head hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head hold'
}

@test 'tail: hollld -> hold' {
    correct_in_ctx tail hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail hold'
}

@test 'sort: hollld -> hold' {
    correct_in_ctx sort hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort hold'
}

@test 'uniq: hollld -> hold' {
    correct_in_ctx uniq hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq hold'
}

@test 'wc: hollld -> hold' {
    correct_in_ctx wc hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc hold'
}

@test 'tr: hollld -> hold' {
    correct_in_ctx tr hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr hold'
}

@test 'cut: hollld -> hold' {
    correct_in_ctx cut hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut hold'
}

@test 'diff: hollld -> hold' {
    correct_in_ctx diff hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff hold'
}

@test 'print: html -> HTML' {
    correct_in_ctx print html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print HTML'
}

@test 'cat: html -> HTML' {
    correct_in_ctx cat html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat HTML'
}

@test 'grep: html -> HTML' {
    correct_in_ctx grep html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep HTML'
}

@test 'sed: html -> HTML' {
    correct_in_ctx sed html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed HTML'
}

@test 'awk: html -> HTML' {
    correct_in_ctx awk html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk HTML'
}

@test 'man: html -> HTML' {
    correct_in_ctx man html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man HTML'
}

@test 'ls: html -> HTML' {
    correct_in_ctx ls html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls HTML'
}

@test 'head: html -> HTML' {
    correct_in_ctx head html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head HTML'
}

@test 'tail: html -> HTML' {
    correct_in_ctx tail html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail HTML'
}

@test 'sort: html -> HTML' {
    correct_in_ctx sort html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort HTML'
}

@test 'uniq: html -> HTML' {
    correct_in_ctx uniq html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq HTML'
}

@test 'wc: html -> HTML' {
    correct_in_ctx wc html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc HTML'
}

@test 'tr: html -> HTML' {
    correct_in_ctx tr html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr HTML'
}

@test 'cut: html -> HTML' {
    correct_in_ctx cut html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut HTML'
}

@test 'diff: html -> HTML' {
    correct_in_ctx diff html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff HTML'
}

@test 'print: http -> HTTP' {
    correct_in_ctx print http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print HTTP'
}

@test 'cat: http -> HTTP' {
    correct_in_ctx cat http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat HTTP'
}

@test 'grep: http -> HTTP' {
    correct_in_ctx grep http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep HTTP'
}

@test 'sed: http -> HTTP' {
    correct_in_ctx sed http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed HTTP'
}

@test 'awk: http -> HTTP' {
    correct_in_ctx awk http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk HTTP'
}

@test 'man: http -> HTTP' {
    correct_in_ctx man http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man HTTP'
}

@test 'ls: http -> HTTP' {
    correct_in_ctx ls http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls HTTP'
}

@test 'head: http -> HTTP' {
    correct_in_ctx head http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head HTTP'
}

@test 'tail: http -> HTTP' {
    correct_in_ctx tail http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail HTTP'
}

@test 'sort: http -> HTTP' {
    correct_in_ctx sort http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort HTTP'
}

@test 'uniq: http -> HTTP' {
    correct_in_ctx uniq http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq HTTP'
}

@test 'wc: http -> HTTP' {
    correct_in_ctx wc http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc HTTP'
}

@test 'tr: http -> HTTP' {
    correct_in_ctx tr http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr HTTP'
}

@test 'cut: http -> HTTP' {
    correct_in_ctx cut http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut HTTP'
}

@test 'diff: http -> HTTP' {
    correct_in_ctx diff http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff HTTP'
}

@test 'print: https -> HTTPS' {
    correct_in_ctx print https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print HTTPS'
}

@test 'cat: https -> HTTPS' {
    correct_in_ctx cat https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat HTTPS'
}

@test 'grep: https -> HTTPS' {
    correct_in_ctx grep https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep HTTPS'
}

@test 'sed: https -> HTTPS' {
    correct_in_ctx sed https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed HTTPS'
}

@test 'awk: https -> HTTPS' {
    correct_in_ctx awk https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk HTTPS'
}

@test 'man: https -> HTTPS' {
    correct_in_ctx man https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man HTTPS'
}

@test 'ls: https -> HTTPS' {
    correct_in_ctx ls https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls HTTPS'
}

@test 'head: https -> HTTPS' {
    correct_in_ctx head https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head HTTPS'
}

@test 'tail: https -> HTTPS' {
    correct_in_ctx tail https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail HTTPS'
}

@test 'sort: https -> HTTPS' {
    correct_in_ctx sort https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort HTTPS'
}

@test 'uniq: https -> HTTPS' {
    correct_in_ctx uniq https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq HTTPS'
}

@test 'wc: https -> HTTPS' {
    correct_in_ctx wc https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc HTTPS'
}

@test 'tr: https -> HTTPS' {
    correct_in_ctx tr https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr HTTPS'
}

@test 'cut: https -> HTTPS' {
    correct_in_ctx cut https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut HTTPS'
}

@test 'diff: https -> HTTPS' {
    correct_in_ctx diff https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff HTTPS'
}

@test 'print: ieee -> IEEE' {
    correct_in_ctx print ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print IEEE'
}

@test 'cat: ieee -> IEEE' {
    correct_in_ctx cat ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat IEEE'
}

@test 'grep: ieee -> IEEE' {
    correct_in_ctx grep ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep IEEE'
}

@test 'sed: ieee -> IEEE' {
    correct_in_ctx sed ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed IEEE'
}

@test 'awk: ieee -> IEEE' {
    correct_in_ctx awk ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk IEEE'
}

@test 'man: ieee -> IEEE' {
    correct_in_ctx man ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man IEEE'
}

@test 'ls: ieee -> IEEE' {
    correct_in_ctx ls ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls IEEE'
}

@test 'head: ieee -> IEEE' {
    correct_in_ctx head ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head IEEE'
}

@test 'tail: ieee -> IEEE' {
    correct_in_ctx tail ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail IEEE'
}

@test 'sort: ieee -> IEEE' {
    correct_in_ctx sort ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort IEEE'
}

@test 'uniq: ieee -> IEEE' {
    correct_in_ctx uniq ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq IEEE'
}

@test 'wc: ieee -> IEEE' {
    correct_in_ctx wc ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc IEEE'
}

@test 'tr: ieee -> IEEE' {
    correct_in_ctx tr ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr IEEE'
}

@test 'cut: ieee -> IEEE' {
    correct_in_ctx cut ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut IEEE'
}

@test 'diff: ieee -> IEEE' {
    correct_in_ctx diff ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff IEEE'
}

@test 'print: iamges -> images' {
    correct_in_ctx print iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print images'
}

@test 'cat: iamges -> images' {
    correct_in_ctx cat iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat images'
}

@test 'grep: iamges -> images' {
    correct_in_ctx grep iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep images'
}

@test 'sed: iamges -> images' {
    correct_in_ctx sed iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed images'
}

@test 'awk: iamges -> images' {
    correct_in_ctx awk iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk images'
}

@test 'man: iamges -> images' {
    correct_in_ctx man iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man images'
}

@test 'ls: iamges -> images' {
    correct_in_ctx ls iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls images'
}

@test 'head: iamges -> images' {
    correct_in_ctx head iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head images'
}

@test 'tail: iamges -> images' {
    correct_in_ctx tail iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail images'
}

@test 'sort: iamges -> images' {
    correct_in_ctx sort iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort images'
}

@test 'uniq: iamges -> images' {
    correct_in_ctx uniq iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq images'
}

@test 'wc: iamges -> images' {
    correct_in_ctx wc iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc images'
}

@test 'tr: iamges -> images' {
    correct_in_ctx tr iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr images'
}

@test 'cut: iamges -> images' {
    correct_in_ctx cut iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut images'
}

@test 'diff: iamges -> images' {
    correct_in_ctx diff iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff images'
}

@test 'print: impl -> implementation' {
    correct_in_ctx print impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print implementation'
}

@test 'cat: impl -> implementation' {
    correct_in_ctx cat impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat implementation'
}

@test 'grep: impl -> implementation' {
    correct_in_ctx grep impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep implementation'
}

@test 'sed: impl -> implementation' {
    correct_in_ctx sed impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed implementation'
}

@test 'awk: impl -> implementation' {
    correct_in_ctx awk impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk implementation'
}

@test 'man: impl -> implementation' {
    correct_in_ctx man impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man implementation'
}

@test 'ls: impl -> implementation' {
    correct_in_ctx ls impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls implementation'
}

@test 'head: impl -> implementation' {
    correct_in_ctx head impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head implementation'
}

@test 'tail: impl -> implementation' {
    correct_in_ctx tail impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail implementation'
}

@test 'sort: impl -> implementation' {
    correct_in_ctx sort impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort implementation'
}

@test 'uniq: impl -> implementation' {
    correct_in_ctx uniq impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq implementation'
}

@test 'wc: impl -> implementation' {
    correct_in_ctx wc impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc implementation'
}

@test 'tr: impl -> implementation' {
    correct_in_ctx tr impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr implementation'
}

@test 'cut: impl -> implementation' {
    correct_in_ctx cut impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut implementation'
}

@test 'diff: impl -> implementation' {
    correct_in_ctx diff impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff implementation'
}

@test 'print: incl -> including' {
    correct_in_ctx print incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print including'
}

@test 'cat: incl -> including' {
    correct_in_ctx cat incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat including'
}

@test 'grep: incl -> including' {
    correct_in_ctx grep incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep including'
}

@test 'sed: incl -> including' {
    correct_in_ctx sed incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed including'
}

@test 'awk: incl -> including' {
    correct_in_ctx awk incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk including'
}

@test 'man: incl -> including' {
    correct_in_ctx man incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man including'
}

@test 'ls: incl -> including' {
    correct_in_ctx ls incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls including'
}

@test 'head: incl -> including' {
    correct_in_ctx head incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head including'
}

@test 'tail: incl -> including' {
    correct_in_ctx tail incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail including'
}

@test 'sort: incl -> including' {
    correct_in_ctx sort incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort including'
}

@test 'uniq: incl -> including' {
    correct_in_ctx uniq incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq including'
}

@test 'wc: incl -> including' {
    correct_in_ctx wc incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc including'
}

@test 'tr: incl -> including' {
    correct_in_ctx tr incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr including'
}

@test 'cut: incl -> including' {
    correct_in_ctx cut incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut including'
}

@test 'diff: incl -> including' {
    correct_in_ctx diff incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff including'
}

@test 'print: initi -> initialization' {
    correct_in_ctx print initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print initialization'
}

@test 'cat: initi -> initialization' {
    correct_in_ctx cat initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat initialization'
}

@test 'grep: initi -> initialization' {
    correct_in_ctx grep initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep initialization'
}

@test 'sed: initi -> initialization' {
    correct_in_ctx sed initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed initialization'
}

@test 'awk: initi -> initialization' {
    correct_in_ctx awk initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk initialization'
}

@test 'man: initi -> initialization' {
    correct_in_ctx man initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man initialization'
}

@test 'ls: initi -> initialization' {
    correct_in_ctx ls initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls initialization'
}

@test 'head: initi -> initialization' {
    correct_in_ctx head initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head initialization'
}

@test 'tail: initi -> initialization' {
    correct_in_ctx tail initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail initialization'
}

@test 'sort: initi -> initialization' {
    correct_in_ctx sort initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort initialization'
}

@test 'uniq: initi -> initialization' {
    correct_in_ctx uniq initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq initialization'
}

@test 'wc: initi -> initialization' {
    correct_in_ctx wc initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc initialization'
}

@test 'tr: initi -> initialization' {
    correct_in_ctx tr initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr initialization'
}

@test 'cut: initi -> initialization' {
    correct_in_ctx cut initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut initialization'
}

@test 'diff: initi -> initialization' {
    correct_in_ctx diff initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff initialization'
}

@test 'print: insdie -> inside' {
    correct_in_ctx print insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print inside'
}

@test 'cat: insdie -> inside' {
    correct_in_ctx cat insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat inside'
}

@test 'grep: insdie -> inside' {
    correct_in_ctx grep insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep inside'
}

@test 'sed: insdie -> inside' {
    correct_in_ctx sed insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed inside'
}

@test 'awk: insdie -> inside' {
    correct_in_ctx awk insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk inside'
}

@test 'man: insdie -> inside' {
    correct_in_ctx man insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man inside'
}

@test 'ls: insdie -> inside' {
    correct_in_ctx ls insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls inside'
}

@test 'head: insdie -> inside' {
    correct_in_ctx head insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head inside'
}

@test 'tail: insdie -> inside' {
    correct_in_ctx tail insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail inside'
}

@test 'sort: insdie -> inside' {
    correct_in_ctx sort insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort inside'
}

@test 'uniq: insdie -> inside' {
    correct_in_ctx uniq insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq inside'
}

@test 'wc: insdie -> inside' {
    correct_in_ctx wc insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc inside'
}

@test 'tr: insdie -> inside' {
    correct_in_ctx tr insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr inside'
}

@test 'cut: insdie -> inside' {
    correct_in_ctx cut insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut inside'
}

@test 'diff: insdie -> inside' {
    correct_in_ctx diff insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff inside'
}

@test 'print: insaed -> instead' {
    correct_in_ctx print insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print instead'
}

@test 'cat: insaed -> instead' {
    correct_in_ctx cat insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat instead'
}

@test 'grep: insaed -> instead' {
    correct_in_ctx grep insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep instead'
}

@test 'sed: insaed -> instead' {
    correct_in_ctx sed insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed instead'
}

@test 'awk: insaed -> instead' {
    correct_in_ctx awk insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk instead'
}

@test 'man: insaed -> instead' {
    correct_in_ctx man insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man instead'
}

@test 'ls: insaed -> instead' {
    correct_in_ctx ls insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls instead'
}

@test 'head: insaed -> instead' {
    correct_in_ctx head insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head instead'
}

@test 'tail: insaed -> instead' {
    correct_in_ctx tail insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail instead'
}

@test 'sort: insaed -> instead' {
    correct_in_ctx sort insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort instead'
}

@test 'uniq: insaed -> instead' {
    correct_in_ctx uniq insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq instead'
}

@test 'wc: insaed -> instead' {
    correct_in_ctx wc insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc instead'
}

@test 'tr: insaed -> instead' {
    correct_in_ctx tr insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr instead'
}

@test 'cut: insaed -> instead' {
    correct_in_ctx cut insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut instead'
}

@test 'diff: insaed -> instead' {
    correct_in_ctx diff insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff instead'
}

@test 'print: interfaec -> interface' {
    correct_in_ctx print interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print interface'
}

@test 'cat: interfaec -> interface' {
    correct_in_ctx cat interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat interface'
}

@test 'grep: interfaec -> interface' {
    correct_in_ctx grep interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep interface'
}

@test 'sed: interfaec -> interface' {
    correct_in_ctx sed interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed interface'
}

@test 'awk: interfaec -> interface' {
    correct_in_ctx awk interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk interface'
}

@test 'man: interfaec -> interface' {
    correct_in_ctx man interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man interface'
}

@test 'ls: interfaec -> interface' {
    correct_in_ctx ls interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls interface'
}

@test 'head: interfaec -> interface' {
    correct_in_ctx head interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head interface'
}

@test 'tail: interfaec -> interface' {
    correct_in_ctx tail interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail interface'
}

@test 'sort: interfaec -> interface' {
    correct_in_ctx sort interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort interface'
}

@test 'uniq: interfaec -> interface' {
    correct_in_ctx uniq interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq interface'
}

@test 'wc: interfaec -> interface' {
    correct_in_ctx wc interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc interface'
}

@test 'tr: interfaec -> interface' {
    correct_in_ctx tr interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr interface'
}

@test 'cut: interfaec -> interface' {
    correct_in_ctx cut interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut interface'
}

@test 'diff: interfaec -> interface' {
    correct_in_ctx diff interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff interface'
}

@test 'print: ios -> iOS' {
    correct_in_ctx print ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print iOS'
}

@test 'cat: ios -> iOS' {
    correct_in_ctx cat ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat iOS'
}

@test 'grep: ios -> iOS' {
    correct_in_ctx grep ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep iOS'
}

@test 'sed: ios -> iOS' {
    correct_in_ctx sed ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed iOS'
}

@test 'awk: ios -> iOS' {
    correct_in_ctx awk ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk iOS'
}

@test 'man: ios -> iOS' {
    correct_in_ctx man ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man iOS'
}

@test 'ls: ios -> iOS' {
    correct_in_ctx ls ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls iOS'
}

@test 'head: ios -> iOS' {
    correct_in_ctx head ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head iOS'
}

@test 'tail: ios -> iOS' {
    correct_in_ctx tail ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail iOS'
}

@test 'sort: ios -> iOS' {
    correct_in_ctx sort ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort iOS'
}

@test 'uniq: ios -> iOS' {
    correct_in_ctx uniq ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq iOS'
}

@test 'wc: ios -> iOS' {
    correct_in_ctx wc ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc iOS'
}

@test 'tr: ios -> iOS' {
    correct_in_ctx tr ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr iOS'
}

@test 'cut: ios -> iOS' {
    correct_in_ctx cut ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut iOS'
}

@test 'diff: ios -> iOS' {
    correct_in_ctx diff ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff iOS'
}

@test 'print: ipad -> iPad' {
    correct_in_ctx print ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print iPad'
}

@test 'cat: ipad -> iPad' {
    correct_in_ctx cat ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat iPad'
}

@test 'grep: ipad -> iPad' {
    correct_in_ctx grep ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep iPad'
}

@test 'sed: ipad -> iPad' {
    correct_in_ctx sed ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed iPad'
}

@test 'awk: ipad -> iPad' {
    correct_in_ctx awk ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk iPad'
}

@test 'man: ipad -> iPad' {
    correct_in_ctx man ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man iPad'
}

@test 'ls: ipad -> iPad' {
    correct_in_ctx ls ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls iPad'
}

@test 'head: ipad -> iPad' {
    correct_in_ctx head ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head iPad'
}

@test 'tail: ipad -> iPad' {
    correct_in_ctx tail ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail iPad'
}

@test 'sort: ipad -> iPad' {
    correct_in_ctx sort ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort iPad'
}

@test 'uniq: ipad -> iPad' {
    correct_in_ctx uniq ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq iPad'
}

@test 'wc: ipad -> iPad' {
    correct_in_ctx wc ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc iPad'
}

@test 'tr: ipad -> iPad' {
    correct_in_ctx tr ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr iPad'
}

@test 'cut: ipad -> iPad' {
    correct_in_ctx cut ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut iPad'
}

@test 'diff: ipad -> iPad' {
    correct_in_ctx diff ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff iPad'
}

@test 'print: iphone -> iPhone' {
    correct_in_ctx print iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print iPhone'
}

@test 'cat: iphone -> iPhone' {
    correct_in_ctx cat iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat iPhone'
}

@test 'grep: iphone -> iPhone' {
    correct_in_ctx grep iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep iPhone'
}

@test 'sed: iphone -> iPhone' {
    correct_in_ctx sed iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed iPhone'
}

@test 'awk: iphone -> iPhone' {
    correct_in_ctx awk iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk iPhone'
}

@test 'man: iphone -> iPhone' {
    correct_in_ctx man iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man iPhone'
}

@test 'ls: iphone -> iPhone' {
    correct_in_ctx ls iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls iPhone'
}

@test 'head: iphone -> iPhone' {
    correct_in_ctx head iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head iPhone'
}

@test 'tail: iphone -> iPhone' {
    correct_in_ctx tail iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail iPhone'
}

@test 'sort: iphone -> iPhone' {
    correct_in_ctx sort iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort iPhone'
}

@test 'uniq: iphone -> iPhone' {
    correct_in_ctx uniq iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq iPhone'
}

@test 'wc: iphone -> iPhone' {
    correct_in_ctx wc iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc iPhone'
}

@test 'tr: iphone -> iPhone' {
    correct_in_ctx tr iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr iPhone'
}

@test 'cut: iphone -> iPhone' {
    correct_in_ctx cut iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut iPhone'
}

@test 'diff: iphone -> iPhone' {
    correct_in_ctx diff iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff iPhone'
}

@test 'print: si -> is' {
    correct_in_ctx print si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print is'
}

@test 'cat: si -> is' {
    correct_in_ctx cat si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat is'
}

@test 'grep: si -> is' {
    correct_in_ctx grep si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep is'
}

@test 'sed: si -> is' {
    correct_in_ctx sed si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed is'
}

@test 'awk: si -> is' {
    correct_in_ctx awk si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk is'
}

@test 'man: si -> is' {
    correct_in_ctx man si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man is'
}

@test 'ls: si -> is' {
    correct_in_ctx ls si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls is'
}

@test 'head: si -> is' {
    correct_in_ctx head si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head is'
}

@test 'tail: si -> is' {
    correct_in_ctx tail si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail is'
}

@test 'sort: si -> is' {
    correct_in_ctx sort si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort is'
}

@test 'uniq: si -> is' {
    correct_in_ctx uniq si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq is'
}

@test 'wc: si -> is' {
    correct_in_ctx wc si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc is'
}

@test 'tr: si -> is' {
    correct_in_ctx tr si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr is'
}

@test 'cut: si -> is' {
    correct_in_ctx cut si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut is'
}

@test 'diff: si -> is' {
    correct_in_ctx diff si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff is'
}

@test 'print: isnt -> is not' {
    correct_in_ctx print isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print is not'
}

@test 'cat: isnt -> is not' {
    correct_in_ctx cat isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat is not'
}

@test 'grep: isnt -> is not' {
    correct_in_ctx grep isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep is not'
}

@test 'sed: isnt -> is not' {
    correct_in_ctx sed isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed is not'
}

@test 'awk: isnt -> is not' {
    correct_in_ctx awk isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk is not'
}

@test 'man: isnt -> is not' {
    correct_in_ctx man isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man is not'
}

@test 'ls: isnt -> is not' {
    correct_in_ctx ls isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls is not'
}

@test 'head: isnt -> is not' {
    correct_in_ctx head isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head is not'
}

@test 'tail: isnt -> is not' {
    correct_in_ctx tail isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail is not'
}

@test 'sort: isnt -> is not' {
    correct_in_ctx sort isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort is not'
}

@test 'uniq: isnt -> is not' {
    correct_in_ctx uniq isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq is not'
}

@test 'wc: isnt -> is not' {
    correct_in_ctx wc isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc is not'
}

@test 'tr: isnt -> is not' {
    correct_in_ctx tr isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr is not'
}

@test 'cut: isnt -> is not' {
    correct_in_ctx cut isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut is not'
}

@test 'diff: isnt -> is not' {
    correct_in_ctx diff isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff is not'
}

@test 'print: iscsi -> iSCSI' {
    correct_in_ctx print iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print iSCSI'
}

@test 'cat: iscsi -> iSCSI' {
    correct_in_ctx cat iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat iSCSI'
}

@test 'grep: iscsi -> iSCSI' {
    correct_in_ctx grep iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep iSCSI'
}

@test 'sed: iscsi -> iSCSI' {
    correct_in_ctx sed iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed iSCSI'
}

@test 'awk: iscsi -> iSCSI' {
    correct_in_ctx awk iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk iSCSI'
}

@test 'man: iscsi -> iSCSI' {
    correct_in_ctx man iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man iSCSI'
}

@test 'ls: iscsi -> iSCSI' {
    correct_in_ctx ls iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls iSCSI'
}

@test 'head: iscsi -> iSCSI' {
    correct_in_ctx head iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head iSCSI'
}

@test 'tail: iscsi -> iSCSI' {
    correct_in_ctx tail iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail iSCSI'
}

@test 'sort: iscsi -> iSCSI' {
    correct_in_ctx sort iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort iSCSI'
}

@test 'uniq: iscsi -> iSCSI' {
    correct_in_ctx uniq iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq iSCSI'
}

@test 'wc: iscsi -> iSCSI' {
    correct_in_ctx wc iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc iSCSI'
}

@test 'tr: iscsi -> iSCSI' {
    correct_in_ctx tr iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr iSCSI'
}

@test 'cut: iscsi -> iSCSI' {
    correct_in_ctx cut iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut iSCSI'
}

@test 'diff: iscsi -> iSCSI' {
    correct_in_ctx diff iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff iSCSI'
}

@test 'print: iso -> ISO' {
    correct_in_ctx print iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print ISO'
}

@test 'cat: iso -> ISO' {
    correct_in_ctx cat iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat ISO'
}

@test 'grep: iso -> ISO' {
    correct_in_ctx grep iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep ISO'
}

@test 'sed: iso -> ISO' {
    correct_in_ctx sed iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed ISO'
}

@test 'awk: iso -> ISO' {
    correct_in_ctx awk iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk ISO'
}

@test 'man: iso -> ISO' {
    correct_in_ctx man iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man ISO'
}

@test 'ls: iso -> ISO' {
    correct_in_ctx ls iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls ISO'
}

@test 'head: iso -> ISO' {
    correct_in_ctx head iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head ISO'
}

@test 'tail: iso -> ISO' {
    correct_in_ctx tail iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail ISO'
}

@test 'sort: iso -> ISO' {
    correct_in_ctx sort iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort ISO'
}

@test 'uniq: iso -> ISO' {
    correct_in_ctx uniq iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq ISO'
}

@test 'wc: iso -> ISO' {
    correct_in_ctx wc iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc ISO'
}

@test 'tr: iso -> ISO' {
    correct_in_ctx tr iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr ISO'
}

@test 'cut: iso -> ISO' {
    correct_in_ctx cut iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut ISO'
}

@test 'diff: iso -> ISO' {
    correct_in_ctx diff iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff ISO'
}

@test 'print: js -> JavaScript' {
    correct_in_ctx print js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print JavaScript'
}

@test 'cat: js -> JavaScript' {
    correct_in_ctx cat js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat JavaScript'
}

@test 'grep: js -> JavaScript' {
    correct_in_ctx grep js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep JavaScript'
}

@test 'sed: js -> JavaScript' {
    correct_in_ctx sed js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed JavaScript'
}

@test 'awk: js -> JavaScript' {
    correct_in_ctx awk js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk JavaScript'
}

@test 'man: js -> JavaScript' {
    correct_in_ctx man js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man JavaScript'
}

@test 'ls: js -> JavaScript' {
    correct_in_ctx ls js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls JavaScript'
}

@test 'head: js -> JavaScript' {
    correct_in_ctx head js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head JavaScript'
}

@test 'tail: js -> JavaScript' {
    correct_in_ctx tail js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail JavaScript'
}

@test 'sort: js -> JavaScript' {
    correct_in_ctx sort js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort JavaScript'
}

@test 'uniq: js -> JavaScript' {
    correct_in_ctx uniq js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq JavaScript'
}

@test 'wc: js -> JavaScript' {
    correct_in_ctx wc js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc JavaScript'
}

@test 'tr: js -> JavaScript' {
    correct_in_ctx tr js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr JavaScript'
}

@test 'cut: js -> JavaScript' {
    correct_in_ctx cut js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut JavaScript'
}

@test 'diff: js -> JavaScript' {
    correct_in_ctx diff js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff JavaScript'
}

@test 'print: josn -> JSON' {
    correct_in_ctx print josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print JSON'
}

@test 'cat: josn -> JSON' {
    correct_in_ctx cat josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat JSON'
}

@test 'grep: josn -> JSON' {
    correct_in_ctx grep josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep JSON'
}

@test 'sed: josn -> JSON' {
    correct_in_ctx sed josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed JSON'
}

@test 'awk: josn -> JSON' {
    correct_in_ctx awk josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk JSON'
}

@test 'man: josn -> JSON' {
    correct_in_ctx man josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man JSON'
}

@test 'ls: josn -> JSON' {
    correct_in_ctx ls josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls JSON'
}

@test 'head: josn -> JSON' {
    correct_in_ctx head josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head JSON'
}

@test 'tail: josn -> JSON' {
    correct_in_ctx tail josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail JSON'
}

@test 'sort: josn -> JSON' {
    correct_in_ctx sort josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort JSON'
}

@test 'uniq: josn -> JSON' {
    correct_in_ctx uniq josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq JSON'
}

@test 'wc: josn -> JSON' {
    correct_in_ctx wc josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc JSON'
}

@test 'tr: josn -> JSON' {
    correct_in_ctx tr josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr JSON'
}

@test 'cut: josn -> JSON' {
    correct_in_ctx cut josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut JSON'
}

@test 'diff: josn -> JSON' {
    correct_in_ctx diff josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff JSON'
}

@test 'print: jsut -> just' {
    correct_in_ctx print jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print just'
}

@test 'cat: jsut -> just' {
    correct_in_ctx cat jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat just'
}

@test 'grep: jsut -> just' {
    correct_in_ctx grep jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep just'
}

@test 'sed: jsut -> just' {
    correct_in_ctx sed jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed just'
}

@test 'awk: jsut -> just' {
    correct_in_ctx awk jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk just'
}

@test 'man: jsut -> just' {
    correct_in_ctx man jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man just'
}

@test 'ls: jsut -> just' {
    correct_in_ctx ls jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls just'
}

@test 'head: jsut -> just' {
    correct_in_ctx head jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head just'
}

@test 'tail: jsut -> just' {
    correct_in_ctx tail jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail just'
}

@test 'sort: jsut -> just' {
    correct_in_ctx sort jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort just'
}

@test 'uniq: jsut -> just' {
    correct_in_ctx uniq jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq just'
}

@test 'wc: jsut -> just' {
    correct_in_ctx wc jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc just'
}

@test 'tr: jsut -> just' {
    correct_in_ctx tr jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr just'
}

@test 'cut: jsut -> just' {
    correct_in_ctx cut jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut just'
}

@test 'diff: jsut -> just' {
    correct_in_ctx diff jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff just'
}

@test 'print: llasst -> last' {
    correct_in_ctx print llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print last'
}

@test 'cat: llasst -> last' {
    correct_in_ctx cat llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat last'
}

@test 'grep: llasst -> last' {
    correct_in_ctx grep llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep last'
}

@test 'sed: llasst -> last' {
    correct_in_ctx sed llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed last'
}

@test 'awk: llasst -> last' {
    correct_in_ctx awk llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk last'
}

@test 'man: llasst -> last' {
    correct_in_ctx man llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man last'
}

@test 'ls: llasst -> last' {
    correct_in_ctx ls llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls last'
}

@test 'head: llasst -> last' {
    correct_in_ctx head llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head last'
}

@test 'tail: llasst -> last' {
    correct_in_ctx tail llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail last'
}

@test 'sort: llasst -> last' {
    correct_in_ctx sort llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort last'
}

@test 'uniq: llasst -> last' {
    correct_in_ctx uniq llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq last'
}

@test 'wc: llasst -> last' {
    correct_in_ctx wc llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc last'
}

@test 'tr: llasst -> last' {
    correct_in_ctx tr llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr last'
}

@test 'cut: llasst -> last' {
    correct_in_ctx cut llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut last'
}

@test 'diff: llasst -> last' {
    correct_in_ctx diff llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff last'
}

@test 'print: latex -> LaTeX' {
    correct_in_ctx print latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print LaTeX'
}

@test 'cat: latex -> LaTeX' {
    correct_in_ctx cat latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat LaTeX'
}

@test 'grep: latex -> LaTeX' {
    correct_in_ctx grep latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep LaTeX'
}

@test 'sed: latex -> LaTeX' {
    correct_in_ctx sed latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed LaTeX'
}

@test 'awk: latex -> LaTeX' {
    correct_in_ctx awk latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk LaTeX'
}

@test 'man: latex -> LaTeX' {
    correct_in_ctx man latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man LaTeX'
}

@test 'ls: latex -> LaTeX' {
    correct_in_ctx ls latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls LaTeX'
}

@test 'head: latex -> LaTeX' {
    correct_in_ctx head latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head LaTeX'
}

@test 'tail: latex -> LaTeX' {
    correct_in_ctx tail latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail LaTeX'
}

@test 'sort: latex -> LaTeX' {
    correct_in_ctx sort latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort LaTeX'
}

@test 'uniq: latex -> LaTeX' {
    correct_in_ctx uniq latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq LaTeX'
}

@test 'wc: latex -> LaTeX' {
    correct_in_ctx wc latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc LaTeX'
}

@test 'tr: latex -> LaTeX' {
    correct_in_ctx tr latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr LaTeX'
}

@test 'cut: latex -> LaTeX' {
    correct_in_ctx cut latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut LaTeX'
}

@test 'diff: latex -> LaTeX' {
    correct_in_ctx diff latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff LaTeX'
}

@test 'print: lyaer -> layer' {
    correct_in_ctx print lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print layer'
}

@test 'cat: lyaer -> layer' {
    correct_in_ctx cat lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat layer'
}

@test 'grep: lyaer -> layer' {
    correct_in_ctx grep lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep layer'
}

@test 'sed: lyaer -> layer' {
    correct_in_ctx sed lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed layer'
}

@test 'awk: lyaer -> layer' {
    correct_in_ctx awk lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk layer'
}

@test 'man: lyaer -> layer' {
    correct_in_ctx man lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man layer'
}

@test 'ls: lyaer -> layer' {
    correct_in_ctx ls lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls layer'
}

@test 'head: lyaer -> layer' {
    correct_in_ctx head lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head layer'
}

@test 'tail: lyaer -> layer' {
    correct_in_ctx tail lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail layer'
}

@test 'sort: lyaer -> layer' {
    correct_in_ctx sort lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort layer'
}

@test 'uniq: lyaer -> layer' {
    correct_in_ctx uniq lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq layer'
}

@test 'wc: lyaer -> layer' {
    correct_in_ctx wc lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc layer'
}

@test 'tr: lyaer -> layer' {
    correct_in_ctx tr lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr layer'
}

@test 'cut: lyaer -> layer' {
    correct_in_ctx cut lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut layer'
}

@test 'diff: lyaer -> layer' {
    correct_in_ctx diff lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff layer'
}

@test 'print: led -> LED' {
    correct_in_ctx print led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print LED'
}

@test 'cat: led -> LED' {
    correct_in_ctx cat led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat LED'
}

@test 'grep: led -> LED' {
    correct_in_ctx grep led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep LED'
}

@test 'sed: led -> LED' {
    correct_in_ctx sed led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed LED'
}

@test 'awk: led -> LED' {
    correct_in_ctx awk led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk LED'
}

@test 'man: led -> LED' {
    correct_in_ctx man led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man LED'
}

@test 'ls: led -> LED' {
    correct_in_ctx ls led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls LED'
}

@test 'head: led -> LED' {
    correct_in_ctx head led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head LED'
}

@test 'tail: led -> LED' {
    correct_in_ctx tail led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail LED'
}

@test 'sort: led -> LED' {
    correct_in_ctx sort led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort LED'
}

@test 'uniq: led -> LED' {
    correct_in_ctx uniq led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq LED'
}

@test 'wc: led -> LED' {
    correct_in_ctx wc led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc LED'
}

@test 'tr: led -> LED' {
    correct_in_ctx tr led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr LED'
}

@test 'cut: led -> LED' {
    correct_in_ctx cut led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut LED'
}

@test 'diff: led -> LED' {
    correct_in_ctx diff led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff LED'
}

@test 'print: lvl -> level' {
    correct_in_ctx print lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print level'
}

@test 'cat: lvl -> level' {
    correct_in_ctx cat lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat level'
}

@test 'grep: lvl -> level' {
    correct_in_ctx grep lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep level'
}

@test 'sed: lvl -> level' {
    correct_in_ctx sed lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed level'
}

@test 'awk: lvl -> level' {
    correct_in_ctx awk lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk level'
}

@test 'man: lvl -> level' {
    correct_in_ctx man lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man level'
}

@test 'ls: lvl -> level' {
    correct_in_ctx ls lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls level'
}

@test 'head: lvl -> level' {
    correct_in_ctx head lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head level'
}

@test 'tail: lvl -> level' {
    correct_in_ctx tail lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail level'
}

@test 'sort: lvl -> level' {
    correct_in_ctx sort lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort level'
}

@test 'uniq: lvl -> level' {
    correct_in_ctx uniq lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq level'
}

@test 'wc: lvl -> level' {
    correct_in_ctx wc lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc level'
}

@test 'tr: lvl -> level' {
    correct_in_ctx tr lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr level'
}

@test 'cut: lvl -> level' {
    correct_in_ctx cut lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut level'
}

@test 'diff: lvl -> level' {
    correct_in_ctx diff lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff level'
}

@test 'print: lvls -> levels' {
    correct_in_ctx print lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print levels'
}

@test 'cat: lvls -> levels' {
    correct_in_ctx cat lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat levels'
}

@test 'grep: lvls -> levels' {
    correct_in_ctx grep lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep levels'
}

@test 'sed: lvls -> levels' {
    correct_in_ctx sed lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed levels'
}

@test 'awk: lvls -> levels' {
    correct_in_ctx awk lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk levels'
}

@test 'man: lvls -> levels' {
    correct_in_ctx man lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man levels'
}

@test 'ls: lvls -> levels' {
    correct_in_ctx ls lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls levels'
}

@test 'head: lvls -> levels' {
    correct_in_ctx head lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head levels'
}

@test 'tail: lvls -> levels' {
    correct_in_ctx tail lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail levels'
}

@test 'sort: lvls -> levels' {
    correct_in_ctx sort lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort levels'
}

@test 'uniq: lvls -> levels' {
    correct_in_ctx uniq lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq levels'
}

@test 'wc: lvls -> levels' {
    correct_in_ctx wc lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc levels'
}

@test 'tr: lvls -> levels' {
    correct_in_ctx tr lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr levels'
}

@test 'cut: lvls -> levels' {
    correct_in_ctx cut lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut levels'
}

@test 'diff: lvls -> levels' {
    correct_in_ctx diff lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff levels'
}

@test 'print: libs -> libraries' {
    correct_in_ctx print libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print libraries'
}

@test 'cat: libs -> libraries' {
    correct_in_ctx cat libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat libraries'
}

@test 'grep: libs -> libraries' {
    correct_in_ctx grep libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep libraries'
}

@test 'sed: libs -> libraries' {
    correct_in_ctx sed libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed libraries'
}

@test 'awk: libs -> libraries' {
    correct_in_ctx awk libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk libraries'
}

@test 'man: libs -> libraries' {
    correct_in_ctx man libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man libraries'
}

@test 'ls: libs -> libraries' {
    correct_in_ctx ls libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls libraries'
}

@test 'head: libs -> libraries' {
    correct_in_ctx head libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head libraries'
}

@test 'tail: libs -> libraries' {
    correct_in_ctx tail libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail libraries'
}

@test 'sort: libs -> libraries' {
    correct_in_ctx sort libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort libraries'
}

@test 'uniq: libs -> libraries' {
    correct_in_ctx uniq libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq libraries'
}

@test 'wc: libs -> libraries' {
    correct_in_ctx wc libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc libraries'
}

@test 'tr: libs -> libraries' {
    correct_in_ctx tr libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr libraries'
}

@test 'cut: libs -> libraries' {
    correct_in_ctx cut libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut libraries'
}

@test 'diff: libs -> libraries' {
    correct_in_ctx diff libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff libraries'
}

@test 'print: lib -> library' {
    correct_in_ctx print lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print library'
}

@test 'cat: lib -> library' {
    correct_in_ctx cat lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat library'
}

@test 'grep: lib -> library' {
    correct_in_ctx grep lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep library'
}

@test 'sed: lib -> library' {
    correct_in_ctx sed lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed library'
}

@test 'awk: lib -> library' {
    correct_in_ctx awk lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk library'
}

@test 'man: lib -> library' {
    correct_in_ctx man lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man library'
}

@test 'ls: lib -> library' {
    correct_in_ctx ls lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls library'
}

@test 'head: lib -> library' {
    correct_in_ctx head lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head library'
}

@test 'tail: lib -> library' {
    correct_in_ctx tail lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail library'
}

@test 'sort: lib -> library' {
    correct_in_ctx sort lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort library'
}

@test 'uniq: lib -> library' {
    correct_in_ctx uniq lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq library'
}

@test 'wc: lib -> library' {
    correct_in_ctx wc lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc library'
}

@test 'tr: lib -> library' {
    correct_in_ctx tr lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr library'
}

@test 'cut: lib -> library' {
    correct_in_ctx cut lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut library'
}

@test 'diff: lib -> library' {
    correct_in_ctx diff lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff library'
}

@test 'print: liek -> like' {
    correct_in_ctx print liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print like'
}

@test 'cat: liek -> like' {
    correct_in_ctx cat liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat like'
}

@test 'grep: liek -> like' {
    correct_in_ctx grep liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep like'
}

@test 'sed: liek -> like' {
    correct_in_ctx sed liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed like'
}

@test 'awk: liek -> like' {
    correct_in_ctx awk liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk like'
}

@test 'man: liek -> like' {
    correct_in_ctx man liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man like'
}

@test 'ls: liek -> like' {
    correct_in_ctx ls liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls like'
}

@test 'head: liek -> like' {
    correct_in_ctx head liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head like'
}

@test 'tail: liek -> like' {
    correct_in_ctx tail liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail like'
}

@test 'sort: liek -> like' {
    correct_in_ctx sort liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort like'
}

@test 'uniq: liek -> like' {
    correct_in_ctx uniq liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq like'
}

@test 'wc: liek -> like' {
    correct_in_ctx wc liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc like'
}

@test 'tr: liek -> like' {
    correct_in_ctx tr liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr like'
}

@test 'cut: liek -> like' {
    correct_in_ctx cut liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut like'
}

@test 'diff: liek -> like' {
    correct_in_ctx diff liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff like'
}

@test 'print: llink -> link' {
    correct_in_ctx print llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print link'
}

@test 'cat: llink -> link' {
    correct_in_ctx cat llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat link'
}

@test 'grep: llink -> link' {
    correct_in_ctx grep llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep link'
}

@test 'sed: llink -> link' {
    correct_in_ctx sed llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed link'
}

@test 'awk: llink -> link' {
    correct_in_ctx awk llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk link'
}

@test 'man: llink -> link' {
    correct_in_ctx man llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man link'
}

@test 'ls: llink -> link' {
    correct_in_ctx ls llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls link'
}

@test 'head: llink -> link' {
    correct_in_ctx head llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head link'
}

@test 'tail: llink -> link' {
    correct_in_ctx tail llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail link'
}

@test 'sort: llink -> link' {
    correct_in_ctx sort llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort link'
}

@test 'uniq: llink -> link' {
    correct_in_ctx uniq llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq link'
}

@test 'wc: llink -> link' {
    correct_in_ctx wc llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc link'
}

@test 'tr: llink -> link' {
    correct_in_ctx tr llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr link'
}

@test 'cut: llink -> link' {
    correct_in_ctx cut llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut link'
}

@test 'diff: llink -> link' {
    correct_in_ctx diff llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff link'
}

@test 'print: linux -> Linux' {
    correct_in_ctx print linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print Linux'
}

@test 'cat: linux -> Linux' {
    correct_in_ctx cat linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat Linux'
}

@test 'grep: linux -> Linux' {
    correct_in_ctx grep linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep Linux'
}

@test 'sed: linux -> Linux' {
    correct_in_ctx sed linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed Linux'
}

@test 'awk: linux -> Linux' {
    correct_in_ctx awk linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk Linux'
}

@test 'man: linux -> Linux' {
    correct_in_ctx man linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man Linux'
}

@test 'ls: linux -> Linux' {
    correct_in_ctx ls linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls Linux'
}

@test 'head: linux -> Linux' {
    correct_in_ctx head linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head Linux'
}

@test 'tail: linux -> Linux' {
    correct_in_ctx tail linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail Linux'
}

@test 'sort: linux -> Linux' {
    correct_in_ctx sort linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort Linux'
}

@test 'uniq: linux -> Linux' {
    correct_in_ctx uniq linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq Linux'
}

@test 'wc: linux -> Linux' {
    correct_in_ctx wc linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc Linux'
}

@test 'tr: linux -> Linux' {
    correct_in_ctx tr linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr Linux'
}

@test 'cut: linux -> Linux' {
    correct_in_ctx cut linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut Linux'
}

@test 'diff: linux -> Linux' {
    correct_in_ctx diff linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff Linux'
}

@test 'print: llist -> list' {
    correct_in_ctx print llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print list'
}

@test 'cat: llist -> list' {
    correct_in_ctx cat llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat list'
}

@test 'grep: llist -> list' {
    correct_in_ctx grep llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep list'
}

@test 'sed: llist -> list' {
    correct_in_ctx sed llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed list'
}

@test 'awk: llist -> list' {
    correct_in_ctx awk llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk list'
}

@test 'man: llist -> list' {
    correct_in_ctx man llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man list'
}

@test 'ls: llist -> list' {
    correct_in_ctx ls llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls list'
}

@test 'head: llist -> list' {
    correct_in_ctx head llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head list'
}

@test 'tail: llist -> list' {
    correct_in_ctx tail llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail list'
}

@test 'sort: llist -> list' {
    correct_in_ctx sort llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort list'
}

@test 'uniq: llist -> list' {
    correct_in_ctx uniq llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq list'
}

@test 'wc: llist -> list' {
    correct_in_ctx wc llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc list'
}

@test 'tr: llist -> list' {
    correct_in_ctx tr llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr list'
}

@test 'cut: llist -> list' {
    correct_in_ctx cut llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut list'
}

@test 'diff: llist -> list' {
    correct_in_ctx diff llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff list'
}

@test 'print: locaiton -> location' {
    correct_in_ctx print locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print location'
}

@test 'cat: locaiton -> location' {
    correct_in_ctx cat locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat location'
}

@test 'grep: locaiton -> location' {
    correct_in_ctx grep locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep location'
}

@test 'sed: locaiton -> location' {
    correct_in_ctx sed locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed location'
}

@test 'awk: locaiton -> location' {
    correct_in_ctx awk locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk location'
}

@test 'man: locaiton -> location' {
    correct_in_ctx man locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man location'
}

@test 'ls: locaiton -> location' {
    correct_in_ctx ls locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls location'
}

@test 'head: locaiton -> location' {
    correct_in_ctx head locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head location'
}

@test 'tail: locaiton -> location' {
    correct_in_ctx tail locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail location'
}

@test 'sort: locaiton -> location' {
    correct_in_ctx sort locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort location'
}

@test 'uniq: locaiton -> location' {
    correct_in_ctx uniq locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq location'
}

@test 'wc: locaiton -> location' {
    correct_in_ctx wc locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc location'
}

@test 'tr: locaiton -> location' {
    correct_in_ctx tr locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr location'
}

@test 'cut: locaiton -> location' {
    correct_in_ctx cut locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut location'
}

@test 'diff: locaiton -> location' {
    correct_in_ctx diff locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff location'
}

@test 'print: lokc -> lock' {
    correct_in_ctx print lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print lock'
}

@test 'cat: lokc -> lock' {
    correct_in_ctx cat lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat lock'
}

@test 'grep: lokc -> lock' {
    correct_in_ctx grep lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep lock'
}

@test 'sed: lokc -> lock' {
    correct_in_ctx sed lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed lock'
}

@test 'awk: lokc -> lock' {
    correct_in_ctx awk lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk lock'
}

@test 'man: lokc -> lock' {
    correct_in_ctx man lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man lock'
}

@test 'ls: lokc -> lock' {
    correct_in_ctx ls lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls lock'
}

@test 'head: lokc -> lock' {
    correct_in_ctx head lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head lock'
}

@test 'tail: lokc -> lock' {
    correct_in_ctx tail lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail lock'
}

@test 'sort: lokc -> lock' {
    correct_in_ctx sort lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort lock'
}

@test 'uniq: lokc -> lock' {
    correct_in_ctx uniq lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq lock'
}

@test 'wc: lokc -> lock' {
    correct_in_ctx wc lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc lock'
}

@test 'tr: lokc -> lock' {
    correct_in_ctx tr lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr lock'
}

@test 'cut: lokc -> lock' {
    correct_in_ctx cut lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut lock'
}

@test 'diff: lokc -> lock' {
    correct_in_ctx diff lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff lock'
}

@test 'print: macos -> macOS' {
    correct_in_ctx print macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print macOS'
}

@test 'cat: macos -> macOS' {
    correct_in_ctx cat macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat macOS'
}

@test 'grep: macos -> macOS' {
    correct_in_ctx grep macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep macOS'
}

@test 'sed: macos -> macOS' {
    correct_in_ctx sed macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed macOS'
}

@test 'awk: macos -> macOS' {
    correct_in_ctx awk macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk macOS'
}

@test 'man: macos -> macOS' {
    correct_in_ctx man macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man macOS'
}

@test 'ls: macos -> macOS' {
    correct_in_ctx ls macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls macOS'
}

@test 'head: macos -> macOS' {
    correct_in_ctx head macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head macOS'
}

@test 'tail: macos -> macOS' {
    correct_in_ctx tail macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail macOS'
}

@test 'sort: macos -> macOS' {
    correct_in_ctx sort macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort macOS'
}

@test 'uniq: macos -> macOS' {
    correct_in_ctx uniq macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq macOS'
}

@test 'wc: macos -> macOS' {
    correct_in_ctx wc macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc macOS'
}

@test 'tr: macos -> macOS' {
    correct_in_ctx tr macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr macOS'
}

@test 'cut: macos -> macOS' {
    correct_in_ctx cut macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut macOS'
}

@test 'diff: macos -> macOS' {
    correct_in_ctx diff macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff macOS'
}

@test 'print: maek -> make' {
    correct_in_ctx print maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print make'
}

@test 'cat: maek -> make' {
    correct_in_ctx cat maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat make'
}

@test 'grep: maek -> make' {
    correct_in_ctx grep maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep make'
}

@test 'sed: maek -> make' {
    correct_in_ctx sed maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed make'
}

@test 'awk: maek -> make' {
    correct_in_ctx awk maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk make'
}

@test 'man: maek -> make' {
    correct_in_ctx man maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man make'
}

@test 'ls: maek -> make' {
    correct_in_ctx ls maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls make'
}

@test 'head: maek -> make' {
    correct_in_ctx head maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head make'
}

@test 'tail: maek -> make' {
    correct_in_ctx tail maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail make'
}

@test 'sort: maek -> make' {
    correct_in_ctx sort maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort make'
}

@test 'uniq: maek -> make' {
    correct_in_ctx uniq maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq make'
}

@test 'wc: maek -> make' {
    correct_in_ctx wc maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc make'
}

@test 'tr: maek -> make' {
    correct_in_ctx tr maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr make'
}

@test 'cut: maek -> make' {
    correct_in_ctx cut maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut make'
}

@test 'diff: maek -> make' {
    correct_in_ctx diff maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff make'
}

@test 'print: mbr -> MBR' {
    correct_in_ctx print mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print MBR'
}

@test 'cat: mbr -> MBR' {
    correct_in_ctx cat mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat MBR'
}

@test 'grep: mbr -> MBR' {
    correct_in_ctx grep mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep MBR'
}

@test 'sed: mbr -> MBR' {
    correct_in_ctx sed mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed MBR'
}

@test 'awk: mbr -> MBR' {
    correct_in_ctx awk mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk MBR'
}

@test 'man: mbr -> MBR' {
    correct_in_ctx man mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man MBR'
}

@test 'ls: mbr -> MBR' {
    correct_in_ctx ls mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls MBR'
}

@test 'head: mbr -> MBR' {
    correct_in_ctx head mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head MBR'
}

@test 'tail: mbr -> MBR' {
    correct_in_ctx tail mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail MBR'
}

@test 'sort: mbr -> MBR' {
    correct_in_ctx sort mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort MBR'
}

@test 'uniq: mbr -> MBR' {
    correct_in_ctx uniq mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq MBR'
}

@test 'wc: mbr -> MBR' {
    correct_in_ctx wc mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc MBR'
}

@test 'tr: mbr -> MBR' {
    correct_in_ctx tr mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr MBR'
}

@test 'cut: mbr -> MBR' {
    correct_in_ctx cut mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut MBR'
}

@test 'diff: mbr -> MBR' {
    correct_in_ctx diff mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff MBR'
}

@test 'print: msg -> message' {
    correct_in_ctx print msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print message'
}

@test 'cat: msg -> message' {
    correct_in_ctx cat msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat message'
}

@test 'grep: msg -> message' {
    correct_in_ctx grep msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep message'
}

@test 'sed: msg -> message' {
    correct_in_ctx sed msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed message'
}

@test 'awk: msg -> message' {
    correct_in_ctx awk msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk message'
}

@test 'man: msg -> message' {
    correct_in_ctx man msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man message'
}

@test 'ls: msg -> message' {
    correct_in_ctx ls msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls message'
}

@test 'head: msg -> message' {
    correct_in_ctx head msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head message'
}

@test 'tail: msg -> message' {
    correct_in_ctx tail msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail message'
}

@test 'sort: msg -> message' {
    correct_in_ctx sort msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort message'
}

@test 'uniq: msg -> message' {
    correct_in_ctx uniq msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq message'
}

@test 'wc: msg -> message' {
    correct_in_ctx wc msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc message'
}

@test 'tr: msg -> message' {
    correct_in_ctx tr msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr message'
}

@test 'cut: msg -> message' {
    correct_in_ctx cut msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut message'
}

@test 'diff: msg -> message' {
    correct_in_ctx diff msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff message'
}

@test 'print: msgs -> messages' {
    correct_in_ctx print msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print messages'
}

@test 'cat: msgs -> messages' {
    correct_in_ctx cat msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat messages'
}

@test 'grep: msgs -> messages' {
    correct_in_ctx grep msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep messages'
}

@test 'sed: msgs -> messages' {
    correct_in_ctx sed msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed messages'
}

@test 'awk: msgs -> messages' {
    correct_in_ctx awk msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk messages'
}

@test 'man: msgs -> messages' {
    correct_in_ctx man msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man messages'
}

@test 'ls: msgs -> messages' {
    correct_in_ctx ls msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls messages'
}

@test 'head: msgs -> messages' {
    correct_in_ctx head msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head messages'
}

@test 'tail: msgs -> messages' {
    correct_in_ctx tail msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail messages'
}

@test 'sort: msgs -> messages' {
    correct_in_ctx sort msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort messages'
}

@test 'uniq: msgs -> messages' {
    correct_in_ctx uniq msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq messages'
}

@test 'wc: msgs -> messages' {
    correct_in_ctx wc msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc messages'
}

@test 'tr: msgs -> messages' {
    correct_in_ctx tr msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr messages'
}

@test 'cut: msgs -> messages' {
    correct_in_ctx cut msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut messages'
}

@test 'diff: msgs -> messages' {
    correct_in_ctx diff msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff messages'
}

@test 'print: midi -> MIDI' {
    correct_in_ctx print midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print MIDI'
}

@test 'cat: midi -> MIDI' {
    correct_in_ctx cat midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat MIDI'
}

@test 'grep: midi -> MIDI' {
    correct_in_ctx grep midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep MIDI'
}

@test 'sed: midi -> MIDI' {
    correct_in_ctx sed midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed MIDI'
}

@test 'awk: midi -> MIDI' {
    correct_in_ctx awk midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk MIDI'
}

@test 'man: midi -> MIDI' {
    correct_in_ctx man midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man MIDI'
}

@test 'ls: midi -> MIDI' {
    correct_in_ctx ls midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls MIDI'
}

@test 'head: midi -> MIDI' {
    correct_in_ctx head midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head MIDI'
}

@test 'tail: midi -> MIDI' {
    correct_in_ctx tail midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail MIDI'
}

@test 'sort: midi -> MIDI' {
    correct_in_ctx sort midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort MIDI'
}

@test 'uniq: midi -> MIDI' {
    correct_in_ctx uniq midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq MIDI'
}

@test 'wc: midi -> MIDI' {
    correct_in_ctx wc midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc MIDI'
}

@test 'tr: midi -> MIDI' {
    correct_in_ctx tr midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr MIDI'
}

@test 'cut: midi -> MIDI' {
    correct_in_ctx cut midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut MIDI'
}

@test 'diff: midi -> MIDI' {
    correct_in_ctx diff midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff MIDI'
}

@test 'print: mobille -> mobile' {
    correct_in_ctx print mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print mobile'
}

@test 'cat: mobille -> mobile' {
    correct_in_ctx cat mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat mobile'
}

@test 'grep: mobille -> mobile' {
    correct_in_ctx grep mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep mobile'
}

@test 'sed: mobille -> mobile' {
    correct_in_ctx sed mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed mobile'
}

@test 'awk: mobille -> mobile' {
    correct_in_ctx awk mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk mobile'
}

@test 'man: mobille -> mobile' {
    correct_in_ctx man mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man mobile'
}

@test 'ls: mobille -> mobile' {
    correct_in_ctx ls mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls mobile'
}

@test 'head: mobille -> mobile' {
    correct_in_ctx head mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head mobile'
}

@test 'tail: mobille -> mobile' {
    correct_in_ctx tail mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail mobile'
}

@test 'sort: mobille -> mobile' {
    correct_in_ctx sort mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort mobile'
}

@test 'uniq: mobille -> mobile' {
    correct_in_ctx uniq mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq mobile'
}

@test 'wc: mobille -> mobile' {
    correct_in_ctx wc mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc mobile'
}

@test 'tr: mobille -> mobile' {
    correct_in_ctx tr mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr mobile'
}

@test 'cut: mobille -> mobile' {
    correct_in_ctx cut mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut mobile'
}

@test 'diff: mobille -> mobile' {
    correct_in_ctx diff mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff mobile'
}

@test 'print: moer -> more' {
    correct_in_ctx print moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print more'
}

@test 'cat: moer -> more' {
    correct_in_ctx cat moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat more'
}

@test 'grep: moer -> more' {
    correct_in_ctx grep moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep more'
}

@test 'sed: moer -> more' {
    correct_in_ctx sed moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed more'
}

@test 'awk: moer -> more' {
    correct_in_ctx awk moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk more'
}

@test 'man: moer -> more' {
    correct_in_ctx man moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man more'
}

@test 'ls: moer -> more' {
    correct_in_ctx ls moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls more'
}

@test 'head: moer -> more' {
    correct_in_ctx head moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head more'
}

@test 'tail: moer -> more' {
    correct_in_ctx tail moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail more'
}

@test 'sort: moer -> more' {
    correct_in_ctx sort moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort more'
}

@test 'uniq: moer -> more' {
    correct_in_ctx uniq moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq more'
}

@test 'wc: moer -> more' {
    correct_in_ctx wc moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc more'
}

@test 'tr: moer -> more' {
    correct_in_ctx tr moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr more'
}

@test 'cut: moer -> more' {
    correct_in_ctx cut moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut more'
}

@test 'diff: moer -> more' {
    correct_in_ctx diff moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff more'
}

@test 'print: mobo -> motherboard' {
    correct_in_ctx print mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print motherboard'
}

@test 'cat: mobo -> motherboard' {
    correct_in_ctx cat mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat motherboard'
}

@test 'grep: mobo -> motherboard' {
    correct_in_ctx grep mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep motherboard'
}

@test 'sed: mobo -> motherboard' {
    correct_in_ctx sed mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed motherboard'
}

@test 'awk: mobo -> motherboard' {
    correct_in_ctx awk mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk motherboard'
}

@test 'man: mobo -> motherboard' {
    correct_in_ctx man mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man motherboard'
}

@test 'ls: mobo -> motherboard' {
    correct_in_ctx ls mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls motherboard'
}

@test 'head: mobo -> motherboard' {
    correct_in_ctx head mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head motherboard'
}

@test 'tail: mobo -> motherboard' {
    correct_in_ctx tail mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail motherboard'
}

@test 'sort: mobo -> motherboard' {
    correct_in_ctx sort mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort motherboard'
}

@test 'uniq: mobo -> motherboard' {
    correct_in_ctx uniq mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq motherboard'
}

@test 'wc: mobo -> motherboard' {
    correct_in_ctx wc mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc motherboard'
}

@test 'tr: mobo -> motherboard' {
    correct_in_ctx tr mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr motherboard'
}

@test 'cut: mobo -> motherboard' {
    correct_in_ctx cut mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut motherboard'
}

@test 'diff: mobo -> motherboard' {
    correct_in_ctx diff mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff motherboard'
}

@test 'print: mounr -> mount' {
    correct_in_ctx print mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print mount'
}

@test 'cat: mounr -> mount' {
    correct_in_ctx cat mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat mount'
}

@test 'grep: mounr -> mount' {
    correct_in_ctx grep mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep mount'
}

@test 'sed: mounr -> mount' {
    correct_in_ctx sed mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed mount'
}

@test 'awk: mounr -> mount' {
    correct_in_ctx awk mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk mount'
}

@test 'man: mounr -> mount' {
    correct_in_ctx man mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man mount'
}

@test 'ls: mounr -> mount' {
    correct_in_ctx ls mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls mount'
}

@test 'head: mounr -> mount' {
    correct_in_ctx head mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head mount'
}

@test 'tail: mounr -> mount' {
    correct_in_ctx tail mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail mount'
}

@test 'sort: mounr -> mount' {
    correct_in_ctx sort mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort mount'
}

@test 'uniq: mounr -> mount' {
    correct_in_ctx uniq mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq mount'
}

@test 'wc: mounr -> mount' {
    correct_in_ctx wc mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc mount'
}

@test 'tr: mounr -> mount' {
    correct_in_ctx tr mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr mount'
}

@test 'cut: mounr -> mount' {
    correct_in_ctx cut mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut mount'
}

@test 'diff: mounr -> mount' {
    correct_in_ctx diff mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff mount'
}

@test 'print: moev -> move' {
    correct_in_ctx print moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print move'
}

@test 'cat: moev -> move' {
    correct_in_ctx cat moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat move'
}

@test 'grep: moev -> move' {
    correct_in_ctx grep moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep move'
}

@test 'sed: moev -> move' {
    correct_in_ctx sed moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed move'
}

@test 'awk: moev -> move' {
    correct_in_ctx awk moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk move'
}

@test 'man: moev -> move' {
    correct_in_ctx man moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man move'
}

@test 'ls: moev -> move' {
    correct_in_ctx ls moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls move'
}

@test 'head: moev -> move' {
    correct_in_ctx head moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head move'
}

@test 'tail: moev -> move' {
    correct_in_ctx tail moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail move'
}

@test 'sort: moev -> move' {
    correct_in_ctx sort moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort move'
}

@test 'uniq: moev -> move' {
    correct_in_ctx uniq moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq move'
}

@test 'wc: moev -> move' {
    correct_in_ctx wc moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc move'
}

@test 'tr: moev -> move' {
    correct_in_ctx tr moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr move'
}

@test 'cut: moev -> move' {
    correct_in_ctx cut moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut move'
}

@test 'diff: moev -> move' {
    correct_in_ctx diff moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff move'
}

@test 'print: mysql -> MySQL' {
    correct_in_ctx print mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print MySQL'
}

@test 'cat: mysql -> MySQL' {
    correct_in_ctx cat mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat MySQL'
}

@test 'grep: mysql -> MySQL' {
    correct_in_ctx grep mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep MySQL'
}

@test 'sed: mysql -> MySQL' {
    correct_in_ctx sed mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed MySQL'
}

@test 'awk: mysql -> MySQL' {
    correct_in_ctx awk mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk MySQL'
}

@test 'man: mysql -> MySQL' {
    correct_in_ctx man mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man MySQL'
}

@test 'ls: mysql -> MySQL' {
    correct_in_ctx ls mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls MySQL'
}

@test 'head: mysql -> MySQL' {
    correct_in_ctx head mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head MySQL'
}

@test 'tail: mysql -> MySQL' {
    correct_in_ctx tail mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail MySQL'
}

@test 'sort: mysql -> MySQL' {
    correct_in_ctx sort mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort MySQL'
}

@test 'uniq: mysql -> MySQL' {
    correct_in_ctx uniq mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq MySQL'
}

@test 'wc: mysql -> MySQL' {
    correct_in_ctx wc mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc MySQL'
}

@test 'tr: mysql -> MySQL' {
    correct_in_ctx tr mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr MySQL'
}

@test 'cut: mysql -> MySQL' {
    correct_in_ctx cut mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut MySQL'
}

@test 'diff: mysql -> MySQL' {
    correct_in_ctx diff mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff MySQL'
}

@test 'print: anme -> name' {
    correct_in_ctx print anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print name'
}

@test 'cat: anme -> name' {
    correct_in_ctx cat anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat name'
}

@test 'grep: anme -> name' {
    correct_in_ctx grep anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep name'
}

@test 'sed: anme -> name' {
    correct_in_ctx sed anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed name'
}

@test 'awk: anme -> name' {
    correct_in_ctx awk anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk name'
}

@test 'man: anme -> name' {
    correct_in_ctx man anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man name'
}

@test 'ls: anme -> name' {
    correct_in_ctx ls anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls name'
}

@test 'head: anme -> name' {
    correct_in_ctx head anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head name'
}

@test 'tail: anme -> name' {
    correct_in_ctx tail anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail name'
}

@test 'sort: anme -> name' {
    correct_in_ctx sort anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort name'
}

@test 'uniq: anme -> name' {
    correct_in_ctx uniq anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq name'
}

@test 'wc: anme -> name' {
    correct_in_ctx wc anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc name'
}

@test 'tr: anme -> name' {
    correct_in_ctx tr anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr name'
}

@test 'cut: anme -> name' {
    correct_in_ctx cut anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut name'
}

@test 'diff: anme -> name' {
    correct_in_ctx diff anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff name'
}

@test 'print: namepsace -> namespace' {
    correct_in_ctx print namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print namespace'
}

@test 'cat: namepsace -> namespace' {
    correct_in_ctx cat namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat namespace'
}

@test 'grep: namepsace -> namespace' {
    correct_in_ctx grep namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep namespace'
}

@test 'sed: namepsace -> namespace' {
    correct_in_ctx sed namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed namespace'
}

@test 'awk: namepsace -> namespace' {
    correct_in_ctx awk namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk namespace'
}

@test 'man: namepsace -> namespace' {
    correct_in_ctx man namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man namespace'
}

@test 'ls: namepsace -> namespace' {
    correct_in_ctx ls namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls namespace'
}

@test 'head: namepsace -> namespace' {
    correct_in_ctx head namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head namespace'
}

@test 'tail: namepsace -> namespace' {
    correct_in_ctx tail namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail namespace'
}

@test 'sort: namepsace -> namespace' {
    correct_in_ctx sort namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort namespace'
}

@test 'uniq: namepsace -> namespace' {
    correct_in_ctx uniq namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq namespace'
}

@test 'wc: namepsace -> namespace' {
    correct_in_ctx wc namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc namespace'
}

@test 'tr: namepsace -> namespace' {
    correct_in_ctx tr namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr namespace'
}

@test 'cut: namepsace -> namespace' {
    correct_in_ctx cut namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut namespace'
}

@test 'diff: namepsace -> namespace' {
    correct_in_ctx diff namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff namespace'
}

@test 'print: newtork -> network' {
    correct_in_ctx print newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print network'
}

@test 'cat: newtork -> network' {
    correct_in_ctx cat newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat network'
}

@test 'grep: newtork -> network' {
    correct_in_ctx grep newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep network'
}

@test 'sed: newtork -> network' {
    correct_in_ctx sed newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed network'
}

@test 'awk: newtork -> network' {
    correct_in_ctx awk newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk network'
}

@test 'man: newtork -> network' {
    correct_in_ctx man newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man network'
}

@test 'ls: newtork -> network' {
    correct_in_ctx ls newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls network'
}

@test 'head: newtork -> network' {
    correct_in_ctx head newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head network'
}

@test 'tail: newtork -> network' {
    correct_in_ctx tail newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail network'
}

@test 'sort: newtork -> network' {
    correct_in_ctx sort newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort network'
}

@test 'uniq: newtork -> network' {
    correct_in_ctx uniq newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq network'
}

@test 'wc: newtork -> network' {
    correct_in_ctx wc newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc network'
}

@test 'tr: newtork -> network' {
    correct_in_ctx tr newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr network'
}

@test 'cut: newtork -> network' {
    correct_in_ctx cut newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut network'
}

@test 'diff: newtork -> network' {
    correct_in_ctx diff newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff network'
}

@test 'print: nextt -> next' {
    correct_in_ctx print nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print next'
}

@test 'cat: nextt -> next' {
    correct_in_ctx cat nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat next'
}

@test 'grep: nextt -> next' {
    correct_in_ctx grep nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep next'
}

@test 'sed: nextt -> next' {
    correct_in_ctx sed nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed next'
}

@test 'awk: nextt -> next' {
    correct_in_ctx awk nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk next'
}

@test 'man: nextt -> next' {
    correct_in_ctx man nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man next'
}

@test 'ls: nextt -> next' {
    correct_in_ctx ls nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls next'
}

@test 'head: nextt -> next' {
    correct_in_ctx head nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head next'
}

@test 'tail: nextt -> next' {
    correct_in_ctx tail nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail next'
}

@test 'sort: nextt -> next' {
    correct_in_ctx sort nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort next'
}

@test 'uniq: nextt -> next' {
    correct_in_ctx uniq nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq next'
}

@test 'wc: nextt -> next' {
    correct_in_ctx wc nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc next'
}

@test 'tr: nextt -> next' {
    correct_in_ctx tr nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr next'
}

@test 'cut: nextt -> next' {
    correct_in_ctx cut nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut next'
}

@test 'diff: nextt -> next' {
    correct_in_ctx diff nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff next'
}

@test 'print: nite -> night' {
    correct_in_ctx print nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print night'
}

@test 'cat: nite -> night' {
    correct_in_ctx cat nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat night'
}

@test 'grep: nite -> night' {
    correct_in_ctx grep nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep night'
}

@test 'sed: nite -> night' {
    correct_in_ctx sed nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed night'
}

@test 'awk: nite -> night' {
    correct_in_ctx awk nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk night'
}

@test 'man: nite -> night' {
    correct_in_ctx man nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man night'
}

@test 'ls: nite -> night' {
    correct_in_ctx ls nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls night'
}

@test 'head: nite -> night' {
    correct_in_ctx head nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head night'
}

@test 'tail: nite -> night' {
    correct_in_ctx tail nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail night'
}

@test 'sort: nite -> night' {
    correct_in_ctx sort nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort night'
}

@test 'uniq: nite -> night' {
    correct_in_ctx uniq nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq night'
}

@test 'wc: nite -> night' {
    correct_in_ctx wc nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc night'
}

@test 'tr: nite -> night' {
    correct_in_ctx tr nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr night'
}

@test 'cut: nite -> night' {
    correct_in_ctx cut nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut night'
}

@test 'diff: nite -> night' {
    correct_in_ctx diff nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff night'
}

@test 'print: nto -> not' {
    correct_in_ctx print nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print not'
}

@test 'cat: nto -> not' {
    correct_in_ctx cat nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat not'
}

@test 'grep: nto -> not' {
    correct_in_ctx grep nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep not'
}

@test 'sed: nto -> not' {
    correct_in_ctx sed nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed not'
}

@test 'awk: nto -> not' {
    correct_in_ctx awk nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk not'
}

@test 'man: nto -> not' {
    correct_in_ctx man nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man not'
}

@test 'ls: nto -> not' {
    correct_in_ctx ls nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls not'
}

@test 'head: nto -> not' {
    correct_in_ctx head nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head not'
}

@test 'tail: nto -> not' {
    correct_in_ctx tail nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail not'
}

@test 'sort: nto -> not' {
    correct_in_ctx sort nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort not'
}

@test 'uniq: nto -> not' {
    correct_in_ctx uniq nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq not'
}

@test 'wc: nto -> not' {
    correct_in_ctx wc nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc not'
}

@test 'tr: nto -> not' {
    correct_in_ctx tr nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr not'
}

@test 'cut: nto -> not' {
    correct_in_ctx cut nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut not'
}

@test 'diff: nto -> not' {
    correct_in_ctx diff nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff not'
}

@test 'print: ntfs -> NTFS' {
    correct_in_ctx print ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print NTFS'
}

@test 'cat: ntfs -> NTFS' {
    correct_in_ctx cat ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat NTFS'
}

@test 'grep: ntfs -> NTFS' {
    correct_in_ctx grep ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep NTFS'
}

@test 'sed: ntfs -> NTFS' {
    correct_in_ctx sed ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed NTFS'
}

@test 'awk: ntfs -> NTFS' {
    correct_in_ctx awk ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk NTFS'
}

@test 'man: ntfs -> NTFS' {
    correct_in_ctx man ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man NTFS'
}

@test 'ls: ntfs -> NTFS' {
    correct_in_ctx ls ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls NTFS'
}

@test 'head: ntfs -> NTFS' {
    correct_in_ctx head ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head NTFS'
}

@test 'tail: ntfs -> NTFS' {
    correct_in_ctx tail ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail NTFS'
}

@test 'sort: ntfs -> NTFS' {
    correct_in_ctx sort ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort NTFS'
}

@test 'uniq: ntfs -> NTFS' {
    correct_in_ctx uniq ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq NTFS'
}

@test 'wc: ntfs -> NTFS' {
    correct_in_ctx wc ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc NTFS'
}

@test 'tr: ntfs -> NTFS' {
    correct_in_ctx tr ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr NTFS'
}

@test 'cut: ntfs -> NTFS' {
    correct_in_ctx cut ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut NTFS'
}

@test 'diff: ntfs -> NTFS' {
    correct_in_ctx diff ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff NTFS'
}

@test 'print: numbre -> number' {
    correct_in_ctx print numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print number'
}

@test 'cat: numbre -> number' {
    correct_in_ctx cat numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat number'
}

@test 'grep: numbre -> number' {
    correct_in_ctx grep numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep number'
}

@test 'sed: numbre -> number' {
    correct_in_ctx sed numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed number'
}

@test 'awk: numbre -> number' {
    correct_in_ctx awk numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk number'
}

@test 'man: numbre -> number' {
    correct_in_ctx man numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man number'
}

@test 'ls: numbre -> number' {
    correct_in_ctx ls numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls number'
}

@test 'head: numbre -> number' {
    correct_in_ctx head numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head number'
}

@test 'tail: numbre -> number' {
    correct_in_ctx tail numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail number'
}

@test 'sort: numbre -> number' {
    correct_in_ctx sort numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort number'
}

@test 'uniq: numbre -> number' {
    correct_in_ctx uniq numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq number'
}

@test 'wc: numbre -> number' {
    correct_in_ctx wc numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc number'
}

@test 'tr: numbre -> number' {
    correct_in_ctx tr numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr number'
}

@test 'cut: numbre -> number' {
    correct_in_ctx cut numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut number'
}

@test 'diff: numbre -> number' {
    correct_in_ctx diff numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff number'
}

@test 'print: fo -> of' {
    correct_in_ctx print fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print of'
}

@test 'cat: fo -> of' {
    correct_in_ctx cat fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat of'
}

@test 'grep: fo -> of' {
    correct_in_ctx grep fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep of'
}

@test 'sed: fo -> of' {
    correct_in_ctx sed fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed of'
}

@test 'awk: fo -> of' {
    correct_in_ctx awk fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk of'
}

@test 'man: fo -> of' {
    correct_in_ctx man fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man of'
}

@test 'ls: fo -> of' {
    correct_in_ctx ls fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls of'
}

@test 'head: fo -> of' {
    correct_in_ctx head fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head of'
}

@test 'tail: fo -> of' {
    correct_in_ctx tail fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail of'
}

@test 'sort: fo -> of' {
    correct_in_ctx sort fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort of'
}

@test 'uniq: fo -> of' {
    correct_in_ctx uniq fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq of'
}

@test 'wc: fo -> of' {
    correct_in_ctx wc fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc of'
}

@test 'tr: fo -> of' {
    correct_in_ctx tr fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr of'
}

@test 'cut: fo -> of' {
    correct_in_ctx cut fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut of'
}

@test 'diff: fo -> of' {
    correct_in_ctx diff fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff of'
}

@test 'print: oepn -> open' {
    correct_in_ctx print oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print open'
}

@test 'cat: oepn -> open' {
    correct_in_ctx cat oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat open'
}

@test 'grep: oepn -> open' {
    correct_in_ctx grep oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep open'
}

@test 'sed: oepn -> open' {
    correct_in_ctx sed oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed open'
}

@test 'awk: oepn -> open' {
    correct_in_ctx awk oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk open'
}

@test 'man: oepn -> open' {
    correct_in_ctx man oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man open'
}

@test 'ls: oepn -> open' {
    correct_in_ctx ls oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls open'
}

@test 'head: oepn -> open' {
    correct_in_ctx head oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head open'
}

@test 'tail: oepn -> open' {
    correct_in_ctx tail oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail open'
}

@test 'sort: oepn -> open' {
    correct_in_ctx sort oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort open'
}

@test 'uniq: oepn -> open' {
    correct_in_ctx uniq oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq open'
}

@test 'wc: oepn -> open' {
    correct_in_ctx wc oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc open'
}

@test 'tr: oepn -> open' {
    correct_in_ctx tr oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr open'
}

@test 'cut: oepn -> open' {
    correct_in_ctx cut oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut open'
}

@test 'diff: oepn -> open' {
    correct_in_ctx diff oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff open'
}

@test 'print: os -> operating system' {
    correct_in_ctx print os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print operating system'
}

@test 'cat: os -> operating system' {
    correct_in_ctx cat os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat operating system'
}

@test 'grep: os -> operating system' {
    correct_in_ctx grep os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep operating system'
}

@test 'sed: os -> operating system' {
    correct_in_ctx sed os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed operating system'
}

@test 'awk: os -> operating system' {
    correct_in_ctx awk os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk operating system'
}

@test 'man: os -> operating system' {
    correct_in_ctx man os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man operating system'
}

@test 'ls: os -> operating system' {
    correct_in_ctx ls os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls operating system'
}

@test 'head: os -> operating system' {
    correct_in_ctx head os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head operating system'
}

@test 'tail: os -> operating system' {
    correct_in_ctx tail os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail operating system'
}

@test 'sort: os -> operating system' {
    correct_in_ctx sort os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort operating system'
}

@test 'uniq: os -> operating system' {
    correct_in_ctx uniq os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq operating system'
}

@test 'wc: os -> operating system' {
    correct_in_ctx wc os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc operating system'
}

@test 'tr: os -> operating system' {
    correct_in_ctx tr os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr operating system'
}

@test 'cut: os -> operating system' {
    correct_in_ctx cut os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut operating system'
}

@test 'diff: os -> operating system' {
    correct_in_ctx diff os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff operating system'
}

@test 'print: ro -> or' {
    correct_in_ctx print ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print or'
}

@test 'cat: ro -> or' {
    correct_in_ctx cat ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat or'
}

@test 'grep: ro -> or' {
    correct_in_ctx grep ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep or'
}

@test 'sed: ro -> or' {
    correct_in_ctx sed ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed or'
}

@test 'awk: ro -> or' {
    correct_in_ctx awk ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk or'
}

@test 'man: ro -> or' {
    correct_in_ctx man ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man or'
}

@test 'ls: ro -> or' {
    correct_in_ctx ls ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls or'
}

@test 'head: ro -> or' {
    correct_in_ctx head ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head or'
}

@test 'tail: ro -> or' {
    correct_in_ctx tail ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail or'
}

@test 'sort: ro -> or' {
    correct_in_ctx sort ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort or'
}

@test 'uniq: ro -> or' {
    correct_in_ctx uniq ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq or'
}

@test 'wc: ro -> or' {
    correct_in_ctx wc ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc or'
}

@test 'tr: ro -> or' {
    correct_in_ctx tr ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr or'
}

@test 'cut: ro -> or' {
    correct_in_ctx cut ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut or'
}

@test 'diff: ro -> or' {
    correct_in_ctx diff ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff or'
}

@test 'print: othe -> other' {
    correct_in_ctx print othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print other'
}

@test 'cat: othe -> other' {
    correct_in_ctx cat othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat other'
}

@test 'grep: othe -> other' {
    correct_in_ctx grep othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep other'
}

@test 'sed: othe -> other' {
    correct_in_ctx sed othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed other'
}

@test 'awk: othe -> other' {
    correct_in_ctx awk othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk other'
}

@test 'man: othe -> other' {
    correct_in_ctx man othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man other'
}

@test 'ls: othe -> other' {
    correct_in_ctx ls othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls other'
}

@test 'head: othe -> other' {
    correct_in_ctx head othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head other'
}

@test 'tail: othe -> other' {
    correct_in_ctx tail othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail other'
}

@test 'sort: othe -> other' {
    correct_in_ctx sort othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort other'
}

@test 'uniq: othe -> other' {
    correct_in_ctx uniq othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq other'
}

@test 'wc: othe -> other' {
    correct_in_ctx wc othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc other'
}

@test 'tr: othe -> other' {
    correct_in_ctx tr othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr other'
}

@test 'cut: othe -> other' {
    correct_in_ctx cut othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut other'
}

@test 'diff: othe -> other' {
    correct_in_ctx diff othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff other'
}

@test 'print: otuside -> outside' {
    correct_in_ctx print otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print outside'
}

@test 'cat: otuside -> outside' {
    correct_in_ctx cat otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat outside'
}

@test 'grep: otuside -> outside' {
    correct_in_ctx grep otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep outside'
}

@test 'sed: otuside -> outside' {
    correct_in_ctx sed otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed outside'
}

@test 'awk: otuside -> outside' {
    correct_in_ctx awk otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk outside'
}

@test 'man: otuside -> outside' {
    correct_in_ctx man otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man outside'
}

@test 'ls: otuside -> outside' {
    correct_in_ctx ls otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls outside'
}

@test 'head: otuside -> outside' {
    correct_in_ctx head otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head outside'
}

@test 'tail: otuside -> outside' {
    correct_in_ctx tail otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail outside'
}

@test 'sort: otuside -> outside' {
    correct_in_ctx sort otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort outside'
}

@test 'uniq: otuside -> outside' {
    correct_in_ctx uniq otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq outside'
}

@test 'wc: otuside -> outside' {
    correct_in_ctx wc otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc outside'
}

@test 'tr: otuside -> outside' {
    correct_in_ctx tr otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr outside'
}

@test 'cut: otuside -> outside' {
    correct_in_ctx cut otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut outside'
}

@test 'diff: otuside -> outside' {
    correct_in_ctx diff otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff outside'
}

@test 'print: voer -> over' {
    correct_in_ctx print voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print over'
}

@test 'cat: voer -> over' {
    correct_in_ctx cat voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat over'
}

@test 'grep: voer -> over' {
    correct_in_ctx grep voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep over'
}

@test 'sed: voer -> over' {
    correct_in_ctx sed voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed over'
}

@test 'awk: voer -> over' {
    correct_in_ctx awk voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk over'
}

@test 'man: voer -> over' {
    correct_in_ctx man voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man over'
}

@test 'ls: voer -> over' {
    correct_in_ctx ls voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls over'
}

@test 'head: voer -> over' {
    correct_in_ctx head voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head over'
}

@test 'tail: voer -> over' {
    correct_in_ctx tail voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail over'
}

@test 'sort: voer -> over' {
    correct_in_ctx sort voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort over'
}

@test 'uniq: voer -> over' {
    correct_in_ctx uniq voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq over'
}

@test 'wc: voer -> over' {
    correct_in_ctx wc voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc over'
}

@test 'tr: voer -> over' {
    correct_in_ctx tr voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr over'
}

@test 'cut: voer -> over' {
    correct_in_ctx cut voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut over'
}

@test 'diff: voer -> over' {
    correct_in_ctx diff voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff over'
}

@test 'print: packk -> pack' {
    correct_in_ctx print packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print pack'
}

@test 'cat: packk -> pack' {
    correct_in_ctx cat packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat pack'
}

@test 'grep: packk -> pack' {
    correct_in_ctx grep packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep pack'
}

@test 'sed: packk -> pack' {
    correct_in_ctx sed packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed pack'
}

@test 'awk: packk -> pack' {
    correct_in_ctx awk packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk pack'
}

@test 'man: packk -> pack' {
    correct_in_ctx man packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man pack'
}

@test 'ls: packk -> pack' {
    correct_in_ctx ls packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls pack'
}

@test 'head: packk -> pack' {
    correct_in_ctx head packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head pack'
}

@test 'tail: packk -> pack' {
    correct_in_ctx tail packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail pack'
}

@test 'sort: packk -> pack' {
    correct_in_ctx sort packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort pack'
}

@test 'uniq: packk -> pack' {
    correct_in_ctx uniq packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq pack'
}

@test 'wc: packk -> pack' {
    correct_in_ctx wc packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc pack'
}

@test 'tr: packk -> pack' {
    correct_in_ctx tr packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr pack'
}

@test 'cut: packk -> pack' {
    correct_in_ctx cut packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut pack'
}

@test 'diff: packk -> pack' {
    correct_in_ctx diff packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff pack'
}

@test 'print: parm -> parameter' {
    correct_in_ctx print parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print parameter'
}

@test 'cat: parm -> parameter' {
    correct_in_ctx cat parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat parameter'
}

@test 'grep: parm -> parameter' {
    correct_in_ctx grep parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep parameter'
}

@test 'sed: parm -> parameter' {
    correct_in_ctx sed parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed parameter'
}

@test 'awk: parm -> parameter' {
    correct_in_ctx awk parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk parameter'
}

@test 'man: parm -> parameter' {
    correct_in_ctx man parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man parameter'
}

@test 'ls: parm -> parameter' {
    correct_in_ctx ls parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls parameter'
}

@test 'head: parm -> parameter' {
    correct_in_ctx head parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head parameter'
}

@test 'tail: parm -> parameter' {
    correct_in_ctx tail parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail parameter'
}

@test 'sort: parm -> parameter' {
    correct_in_ctx sort parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort parameter'
}

@test 'uniq: parm -> parameter' {
    correct_in_ctx uniq parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq parameter'
}

@test 'wc: parm -> parameter' {
    correct_in_ctx wc parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc parameter'
}

@test 'tr: parm -> parameter' {
    correct_in_ctx tr parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr parameter'
}

@test 'cut: parm -> parameter' {
    correct_in_ctx cut parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut parameter'
}

@test 'diff: parm -> parameter' {
    correct_in_ctx diff parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff parameter'
}

@test 'print: parms -> parameters' {
    correct_in_ctx print parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print parameters'
}

@test 'cat: parms -> parameters' {
    correct_in_ctx cat parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat parameters'
}

@test 'grep: parms -> parameters' {
    correct_in_ctx grep parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep parameters'
}

@test 'sed: parms -> parameters' {
    correct_in_ctx sed parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed parameters'
}

@test 'awk: parms -> parameters' {
    correct_in_ctx awk parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk parameters'
}

@test 'man: parms -> parameters' {
    correct_in_ctx man parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man parameters'
}

@test 'ls: parms -> parameters' {
    correct_in_ctx ls parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls parameters'
}

@test 'head: parms -> parameters' {
    correct_in_ctx head parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head parameters'
}

@test 'tail: parms -> parameters' {
    correct_in_ctx tail parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail parameters'
}

@test 'sort: parms -> parameters' {
    correct_in_ctx sort parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort parameters'
}

@test 'uniq: parms -> parameters' {
    correct_in_ctx uniq parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq parameters'
}

@test 'wc: parms -> parameters' {
    correct_in_ctx wc parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc parameters'
}

@test 'tr: parms -> parameters' {
    correct_in_ctx tr parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr parameters'
}

@test 'cut: parms -> parameters' {
    correct_in_ctx cut parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut parameters'
}

@test 'diff: parms -> parameters' {
    correct_in_ctx diff parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff parameters'
}

@test 'print: pata -> PATA' {
    correct_in_ctx print pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print PATA'
}

@test 'cat: pata -> PATA' {
    correct_in_ctx cat pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat PATA'
}

@test 'grep: pata -> PATA' {
    correct_in_ctx grep pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep PATA'
}

@test 'sed: pata -> PATA' {
    correct_in_ctx sed pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed PATA'
}

@test 'awk: pata -> PATA' {
    correct_in_ctx awk pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk PATA'
}

@test 'man: pata -> PATA' {
    correct_in_ctx man pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man PATA'
}

@test 'ls: pata -> PATA' {
    correct_in_ctx ls pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls PATA'
}

@test 'head: pata -> PATA' {
    correct_in_ctx head pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head PATA'
}

@test 'tail: pata -> PATA' {
    correct_in_ctx tail pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail PATA'
}

@test 'sort: pata -> PATA' {
    correct_in_ctx sort pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort PATA'
}

@test 'uniq: pata -> PATA' {
    correct_in_ctx uniq pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq PATA'
}

@test 'wc: pata -> PATA' {
    correct_in_ctx wc pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc PATA'
}

@test 'tr: pata -> PATA' {
    correct_in_ctx tr pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr PATA'
}

@test 'cut: pata -> PATA' {
    correct_in_ctx cut pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut PATA'
}

@test 'diff: pata -> PATA' {
    correct_in_ctx diff pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff PATA'
}

@test 'print: pci -> PCI' {
    correct_in_ctx print pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print PCI'
}

@test 'cat: pci -> PCI' {
    correct_in_ctx cat pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat PCI'
}

@test 'grep: pci -> PCI' {
    correct_in_ctx grep pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep PCI'
}

@test 'sed: pci -> PCI' {
    correct_in_ctx sed pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed PCI'
}

@test 'awk: pci -> PCI' {
    correct_in_ctx awk pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk PCI'
}

@test 'man: pci -> PCI' {
    correct_in_ctx man pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man PCI'
}

@test 'ls: pci -> PCI' {
    correct_in_ctx ls pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls PCI'
}

@test 'head: pci -> PCI' {
    correct_in_ctx head pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head PCI'
}

@test 'tail: pci -> PCI' {
    correct_in_ctx tail pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail PCI'
}

@test 'sort: pci -> PCI' {
    correct_in_ctx sort pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort PCI'
}

@test 'uniq: pci -> PCI' {
    correct_in_ctx uniq pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq PCI'
}

@test 'wc: pci -> PCI' {
    correct_in_ctx wc pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc PCI'
}

@test 'tr: pci -> PCI' {
    correct_in_ctx tr pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr PCI'
}

@test 'cut: pci -> PCI' {
    correct_in_ctx cut pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut PCI'
}

@test 'diff: pci -> PCI' {
    correct_in_ctx diff pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff PCI'
}

@test 'print: prel -> perl' {
    correct_in_ctx print prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print perl'
}

@test 'cat: prel -> perl' {
    correct_in_ctx cat prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat perl'
}

@test 'grep: prel -> perl' {
    correct_in_ctx grep prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep perl'
}

@test 'sed: prel -> perl' {
    correct_in_ctx sed prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed perl'
}

@test 'awk: prel -> perl' {
    correct_in_ctx awk prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk perl'
}

@test 'man: prel -> perl' {
    correct_in_ctx man prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man perl'
}

@test 'ls: prel -> perl' {
    correct_in_ctx ls prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls perl'
}

@test 'head: prel -> perl' {
    correct_in_ctx head prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head perl'
}

@test 'tail: prel -> perl' {
    correct_in_ctx tail prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail perl'
}

@test 'sort: prel -> perl' {
    correct_in_ctx sort prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort perl'
}

@test 'uniq: prel -> perl' {
    correct_in_ctx uniq prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq perl'
}

@test 'wc: prel -> perl' {
    correct_in_ctx wc prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc perl'
}

@test 'tr: prel -> perl' {
    correct_in_ctx tr prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr perl'
}

@test 'cut: prel -> perl' {
    correct_in_ctx cut prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut perl'
}

@test 'diff: prel -> perl' {
    correct_in_ctx diff prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff perl'
}

@test 'print: perm -> permission' {
    correct_in_ctx print perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print permission'
}

@test 'cat: perm -> permission' {
    correct_in_ctx cat perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat permission'
}

@test 'grep: perm -> permission' {
    correct_in_ctx grep perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep permission'
}

@test 'sed: perm -> permission' {
    correct_in_ctx sed perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed permission'
}

@test 'awk: perm -> permission' {
    correct_in_ctx awk perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk permission'
}

@test 'man: perm -> permission' {
    correct_in_ctx man perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man permission'
}

@test 'ls: perm -> permission' {
    correct_in_ctx ls perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls permission'
}

@test 'head: perm -> permission' {
    correct_in_ctx head perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head permission'
}

@test 'tail: perm -> permission' {
    correct_in_ctx tail perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail permission'
}

@test 'sort: perm -> permission' {
    correct_in_ctx sort perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort permission'
}

@test 'uniq: perm -> permission' {
    correct_in_ctx uniq perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq permission'
}

@test 'wc: perm -> permission' {
    correct_in_ctx wc perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc permission'
}

@test 'tr: perm -> permission' {
    correct_in_ctx tr perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr permission'
}

@test 'cut: perm -> permission' {
    correct_in_ctx cut perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut permission'
}

@test 'diff: perm -> permission' {
    correct_in_ctx diff perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff permission'
}

@test 'print: perms -> permissions' {
    correct_in_ctx print perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print permissions'
}

@test 'cat: perms -> permissions' {
    correct_in_ctx cat perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat permissions'
}

@test 'grep: perms -> permissions' {
    correct_in_ctx grep perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep permissions'
}

@test 'sed: perms -> permissions' {
    correct_in_ctx sed perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed permissions'
}

@test 'awk: perms -> permissions' {
    correct_in_ctx awk perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk permissions'
}

@test 'man: perms -> permissions' {
    correct_in_ctx man perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man permissions'
}

@test 'ls: perms -> permissions' {
    correct_in_ctx ls perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls permissions'
}

@test 'head: perms -> permissions' {
    correct_in_ctx head perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head permissions'
}

@test 'tail: perms -> permissions' {
    correct_in_ctx tail perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail permissions'
}

@test 'sort: perms -> permissions' {
    correct_in_ctx sort perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort permissions'
}

@test 'uniq: perms -> permissions' {
    correct_in_ctx uniq perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq permissions'
}

@test 'wc: perms -> permissions' {
    correct_in_ctx wc perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc permissions'
}

@test 'tr: perms -> permissions' {
    correct_in_ctx tr perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr permissions'
}

@test 'cut: perms -> permissions' {
    correct_in_ctx cut perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut permissions'
}

@test 'diff: perms -> permissions' {
    correct_in_ctx diff perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff permissions'
}

@test 'print: phaes -> phase' {
    correct_in_ctx print phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print phase'
}

@test 'cat: phaes -> phase' {
    correct_in_ctx cat phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat phase'
}

@test 'grep: phaes -> phase' {
    correct_in_ctx grep phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep phase'
}

@test 'sed: phaes -> phase' {
    correct_in_ctx sed phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed phase'
}

@test 'awk: phaes -> phase' {
    correct_in_ctx awk phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk phase'
}

@test 'man: phaes -> phase' {
    correct_in_ctx man phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man phase'
}

@test 'ls: phaes -> phase' {
    correct_in_ctx ls phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls phase'
}

@test 'head: phaes -> phase' {
    correct_in_ctx head phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head phase'
}

@test 'tail: phaes -> phase' {
    correct_in_ctx tail phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail phase'
}

@test 'sort: phaes -> phase' {
    correct_in_ctx sort phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort phase'
}

@test 'uniq: phaes -> phase' {
    correct_in_ctx uniq phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq phase'
}

@test 'wc: phaes -> phase' {
    correct_in_ctx wc phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc phase'
}

@test 'tr: phaes -> phase' {
    correct_in_ctx tr phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr phase'
}

@test 'cut: phaes -> phase' {
    correct_in_ctx cut phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut phase'
}

@test 'diff: phaes -> phase' {
    correct_in_ctx diff phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff phase'
}

@test 'print: pid -> PID' {
    correct_in_ctx print pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print PID'
}

@test 'cat: pid -> PID' {
    correct_in_ctx cat pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat PID'
}

@test 'grep: pid -> PID' {
    correct_in_ctx grep pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep PID'
}

@test 'sed: pid -> PID' {
    correct_in_ctx sed pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed PID'
}

@test 'awk: pid -> PID' {
    correct_in_ctx awk pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk PID'
}

@test 'man: pid -> PID' {
    correct_in_ctx man pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man PID'
}

@test 'ls: pid -> PID' {
    correct_in_ctx ls pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls PID'
}

@test 'head: pid -> PID' {
    correct_in_ctx head pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head PID'
}

@test 'tail: pid -> PID' {
    correct_in_ctx tail pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail PID'
}

@test 'sort: pid -> PID' {
    correct_in_ctx sort pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort PID'
}

@test 'uniq: pid -> PID' {
    correct_in_ctx uniq pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq PID'
}

@test 'wc: pid -> PID' {
    correct_in_ctx wc pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc PID'
}

@test 'tr: pid -> PID' {
    correct_in_ctx tr pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr PID'
}

@test 'cut: pid -> PID' {
    correct_in_ctx cut pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut PID'
}

@test 'diff: pid -> PID' {
    correct_in_ctx diff pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff PID'
}

@test 'print: plase -> please' {
    correct_in_ctx print plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print please'
}

@test 'cat: plase -> please' {
    correct_in_ctx cat plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat please'
}

@test 'grep: plase -> please' {
    correct_in_ctx grep plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep please'
}

@test 'sed: plase -> please' {
    correct_in_ctx sed plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed please'
}

@test 'awk: plase -> please' {
    correct_in_ctx awk plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk please'
}

@test 'man: plase -> please' {
    correct_in_ctx man plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man please'
}

@test 'ls: plase -> please' {
    correct_in_ctx ls plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls please'
}

@test 'head: plase -> please' {
    correct_in_ctx head plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head please'
}

@test 'tail: plase -> please' {
    correct_in_ctx tail plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail please'
}

@test 'sort: plase -> please' {
    correct_in_ctx sort plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort please'
}

@test 'uniq: plase -> please' {
    correct_in_ctx uniq plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq please'
}

@test 'wc: plase -> please' {
    correct_in_ctx wc plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc please'
}

@test 'tr: plase -> please' {
    correct_in_ctx tr plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr please'
}

@test 'cut: plase -> please' {
    correct_in_ctx cut plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut please'
}

@test 'diff: plase -> please' {
    correct_in_ctx diff plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff please'
}

@test 'print: opint -> point' {
    correct_in_ctx print opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print point'
}

@test 'cat: opint -> point' {
    correct_in_ctx cat opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat point'
}

@test 'grep: opint -> point' {
    correct_in_ctx grep opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep point'
}

@test 'sed: opint -> point' {
    correct_in_ctx sed opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed point'
}

@test 'awk: opint -> point' {
    correct_in_ctx awk opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk point'
}

@test 'man: opint -> point' {
    correct_in_ctx man opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man point'
}

@test 'ls: opint -> point' {
    correct_in_ctx ls opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls point'
}

@test 'head: opint -> point' {
    correct_in_ctx head opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head point'
}

@test 'tail: opint -> point' {
    correct_in_ctx tail opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail point'
}

@test 'sort: opint -> point' {
    correct_in_ctx sort opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort point'
}

@test 'uniq: opint -> point' {
    correct_in_ctx uniq opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq point'
}

@test 'wc: opint -> point' {
    correct_in_ctx wc opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc point'
}

@test 'tr: opint -> point' {
    correct_in_ctx tr opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr point'
}

@test 'cut: opint -> point' {
    correct_in_ctx cut opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut point'
}

@test 'diff: opint -> point' {
    correct_in_ctx diff opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff point'
}

@test 'print: pooort -> port' {
    correct_in_ctx print pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print port'
}

@test 'cat: pooort -> port' {
    correct_in_ctx cat pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat port'
}

@test 'grep: pooort -> port' {
    correct_in_ctx grep pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep port'
}

@test 'sed: pooort -> port' {
    correct_in_ctx sed pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed port'
}

@test 'awk: pooort -> port' {
    correct_in_ctx awk pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk port'
}

@test 'man: pooort -> port' {
    correct_in_ctx man pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man port'
}

@test 'ls: pooort -> port' {
    correct_in_ctx ls pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls port'
}

@test 'head: pooort -> port' {
    correct_in_ctx head pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head port'
}

@test 'tail: pooort -> port' {
    correct_in_ctx tail pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail port'
}

@test 'sort: pooort -> port' {
    correct_in_ctx sort pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort port'
}

@test 'uniq: pooort -> port' {
    correct_in_ctx uniq pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq port'
}

@test 'wc: pooort -> port' {
    correct_in_ctx wc pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc port'
}

@test 'tr: pooort -> port' {
    correct_in_ctx tr pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr port'
}

@test 'cut: pooort -> port' {
    correct_in_ctx cut pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut port'
}

@test 'diff: pooort -> port' {
    correct_in_ctx diff pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff port'
}

@test 'print: pos -> position' {
    correct_in_ctx print pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print position'
}

@test 'cat: pos -> position' {
    correct_in_ctx cat pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat position'
}

@test 'grep: pos -> position' {
    correct_in_ctx grep pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep position'
}

@test 'sed: pos -> position' {
    correct_in_ctx sed pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed position'
}

@test 'awk: pos -> position' {
    correct_in_ctx awk pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk position'
}

@test 'man: pos -> position' {
    correct_in_ctx man pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man position'
}

@test 'ls: pos -> position' {
    correct_in_ctx ls pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls position'
}

@test 'head: pos -> position' {
    correct_in_ctx head pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head position'
}

@test 'tail: pos -> position' {
    correct_in_ctx tail pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail position'
}

@test 'sort: pos -> position' {
    correct_in_ctx sort pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort position'
}

@test 'uniq: pos -> position' {
    correct_in_ctx uniq pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq position'
}

@test 'wc: pos -> position' {
    correct_in_ctx wc pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc position'
}

@test 'tr: pos -> position' {
    correct_in_ctx tr pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr position'
}

@test 'cut: pos -> position' {
    correct_in_ctx cut pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut position'
}

@test 'diff: pos -> position' {
    correct_in_ctx diff pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff position'
}

@test 'print: posix -> POSIX' {
    correct_in_ctx print posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print POSIX'
}

@test 'cat: posix -> POSIX' {
    correct_in_ctx cat posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat POSIX'
}

@test 'grep: posix -> POSIX' {
    correct_in_ctx grep posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep POSIX'
}

@test 'sed: posix -> POSIX' {
    correct_in_ctx sed posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed POSIX'
}

@test 'awk: posix -> POSIX' {
    correct_in_ctx awk posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk POSIX'
}

@test 'man: posix -> POSIX' {
    correct_in_ctx man posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man POSIX'
}

@test 'ls: posix -> POSIX' {
    correct_in_ctx ls posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls POSIX'
}

@test 'head: posix -> POSIX' {
    correct_in_ctx head posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head POSIX'
}

@test 'tail: posix -> POSIX' {
    correct_in_ctx tail posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail POSIX'
}

@test 'sort: posix -> POSIX' {
    correct_in_ctx sort posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort POSIX'
}

@test 'uniq: posix -> POSIX' {
    correct_in_ctx uniq posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq POSIX'
}

@test 'wc: posix -> POSIX' {
    correct_in_ctx wc posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc POSIX'
}

@test 'tr: posix -> POSIX' {
    correct_in_ctx tr posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr POSIX'
}

@test 'cut: posix -> POSIX' {
    correct_in_ctx cut posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut POSIX'
}

@test 'diff: posix -> POSIX' {
    correct_in_ctx diff posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff POSIX'
}

@test 'print: pirnt -> print' {
    correct_in_ctx print pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print print'
}

@test 'cat: pirnt -> print' {
    correct_in_ctx cat pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat print'
}

@test 'grep: pirnt -> print' {
    correct_in_ctx grep pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep print'
}

@test 'sed: pirnt -> print' {
    correct_in_ctx sed pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed print'
}

@test 'awk: pirnt -> print' {
    correct_in_ctx awk pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk print'
}

@test 'man: pirnt -> print' {
    correct_in_ctx man pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man print'
}

@test 'ls: pirnt -> print' {
    correct_in_ctx ls pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls print'
}

@test 'head: pirnt -> print' {
    correct_in_ctx head pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head print'
}

@test 'tail: pirnt -> print' {
    correct_in_ctx tail pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail print'
}

@test 'sort: pirnt -> print' {
    correct_in_ctx sort pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort print'
}

@test 'uniq: pirnt -> print' {
    correct_in_ctx uniq pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq print'
}

@test 'wc: pirnt -> print' {
    correct_in_ctx wc pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc print'
}

@test 'tr: pirnt -> print' {
    correct_in_ctx tr pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr print'
}

@test 'cut: pirnt -> print' {
    correct_in_ctx cut pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut print'
}

@test 'diff: pirnt -> print' {
    correct_in_ctx diff pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff print'
}

@test 'print: porbe -> probe' {
    correct_in_ctx print porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print probe'
}

@test 'cat: porbe -> probe' {
    correct_in_ctx cat porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat probe'
}

@test 'grep: porbe -> probe' {
    correct_in_ctx grep porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep probe'
}

@test 'sed: porbe -> probe' {
    correct_in_ctx sed porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed probe'
}

@test 'awk: porbe -> probe' {
    correct_in_ctx awk porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk probe'
}

@test 'man: porbe -> probe' {
    correct_in_ctx man porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man probe'
}

@test 'ls: porbe -> probe' {
    correct_in_ctx ls porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls probe'
}

@test 'head: porbe -> probe' {
    correct_in_ctx head porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head probe'
}

@test 'tail: porbe -> probe' {
    correct_in_ctx tail porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail probe'
}

@test 'sort: porbe -> probe' {
    correct_in_ctx sort porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort probe'
}

@test 'uniq: porbe -> probe' {
    correct_in_ctx uniq porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq probe'
}

@test 'wc: porbe -> probe' {
    correct_in_ctx wc porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc probe'
}

@test 'tr: porbe -> probe' {
    correct_in_ctx tr porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr probe'
}

@test 'cut: porbe -> probe' {
    correct_in_ctx cut porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut probe'
}

@test 'diff: porbe -> probe' {
    correct_in_ctx diff porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff probe'
}

@test 'print: projcet -> project' {
    correct_in_ctx print projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print project'
}

@test 'cat: projcet -> project' {
    correct_in_ctx cat projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat project'
}

@test 'grep: projcet -> project' {
    correct_in_ctx grep projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep project'
}

@test 'sed: projcet -> project' {
    correct_in_ctx sed projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed project'
}

@test 'awk: projcet -> project' {
    correct_in_ctx awk projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk project'
}

@test 'man: projcet -> project' {
    correct_in_ctx man projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man project'
}

@test 'ls: projcet -> project' {
    correct_in_ctx ls projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls project'
}

@test 'head: projcet -> project' {
    correct_in_ctx head projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head project'
}

@test 'tail: projcet -> project' {
    correct_in_ctx tail projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail project'
}

@test 'sort: projcet -> project' {
    correct_in_ctx sort projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort project'
}

@test 'uniq: projcet -> project' {
    correct_in_ctx uniq projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq project'
}

@test 'wc: projcet -> project' {
    correct_in_ctx wc projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc project'
}

@test 'tr: projcet -> project' {
    correct_in_ctx tr projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr project'
}

@test 'cut: projcet -> project' {
    correct_in_ctx cut projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut project'
}

@test 'diff: projcet -> project' {
    correct_in_ctx diff projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff project'
}

@test 'print: props -> properties' {
    correct_in_ctx print props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print properties'
}

@test 'cat: props -> properties' {
    correct_in_ctx cat props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat properties'
}

@test 'grep: props -> properties' {
    correct_in_ctx grep props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep properties'
}

@test 'sed: props -> properties' {
    correct_in_ctx sed props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed properties'
}

@test 'awk: props -> properties' {
    correct_in_ctx awk props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk properties'
}

@test 'man: props -> properties' {
    correct_in_ctx man props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man properties'
}

@test 'ls: props -> properties' {
    correct_in_ctx ls props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls properties'
}

@test 'head: props -> properties' {
    correct_in_ctx head props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head properties'
}

@test 'tail: props -> properties' {
    correct_in_ctx tail props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail properties'
}

@test 'sort: props -> properties' {
    correct_in_ctx sort props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort properties'
}

@test 'uniq: props -> properties' {
    correct_in_ctx uniq props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq properties'
}

@test 'wc: props -> properties' {
    correct_in_ctx wc props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc properties'
}

@test 'tr: props -> properties' {
    correct_in_ctx tr props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr properties'
}

@test 'cut: props -> properties' {
    correct_in_ctx cut props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut properties'
}

@test 'diff: props -> properties' {
    correct_in_ctx diff props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff properties'
}

@test 'print: prop -> property' {
    correct_in_ctx print prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print property'
}

@test 'cat: prop -> property' {
    correct_in_ctx cat prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat property'
}

@test 'grep: prop -> property' {
    correct_in_ctx grep prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep property'
}

@test 'sed: prop -> property' {
    correct_in_ctx sed prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed property'
}

@test 'awk: prop -> property' {
    correct_in_ctx awk prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk property'
}

@test 'man: prop -> property' {
    correct_in_ctx man prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man property'
}

@test 'ls: prop -> property' {
    correct_in_ctx ls prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls property'
}

@test 'head: prop -> property' {
    correct_in_ctx head prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head property'
}

@test 'tail: prop -> property' {
    correct_in_ctx tail prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail property'
}

@test 'sort: prop -> property' {
    correct_in_ctx sort prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort property'
}

@test 'uniq: prop -> property' {
    correct_in_ctx uniq prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq property'
}

@test 'wc: prop -> property' {
    correct_in_ctx wc prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc property'
}

@test 'tr: prop -> property' {
    correct_in_ctx tr prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr property'
}

@test 'cut: prop -> property' {
    correct_in_ctx cut prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut property'
}

@test 'diff: prop -> property' {
    correct_in_ctx diff prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff property'
}

@test 'print: rpoxy -> proxy' {
    correct_in_ctx print rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print proxy'
}

@test 'cat: rpoxy -> proxy' {
    correct_in_ctx cat rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat proxy'
}

@test 'grep: rpoxy -> proxy' {
    correct_in_ctx grep rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep proxy'
}

@test 'sed: rpoxy -> proxy' {
    correct_in_ctx sed rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed proxy'
}

@test 'awk: rpoxy -> proxy' {
    correct_in_ctx awk rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk proxy'
}

@test 'man: rpoxy -> proxy' {
    correct_in_ctx man rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man proxy'
}

@test 'ls: rpoxy -> proxy' {
    correct_in_ctx ls rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls proxy'
}

@test 'head: rpoxy -> proxy' {
    correct_in_ctx head rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head proxy'
}

@test 'tail: rpoxy -> proxy' {
    correct_in_ctx tail rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail proxy'
}

@test 'sort: rpoxy -> proxy' {
    correct_in_ctx sort rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort proxy'
}

@test 'uniq: rpoxy -> proxy' {
    correct_in_ctx uniq rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq proxy'
}

@test 'wc: rpoxy -> proxy' {
    correct_in_ctx wc rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc proxy'
}

@test 'tr: rpoxy -> proxy' {
    correct_in_ctx tr rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr proxy'
}

@test 'cut: rpoxy -> proxy' {
    correct_in_ctx cut rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut proxy'
}

@test 'diff: rpoxy -> proxy' {
    correct_in_ctx diff rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff proxy'
}

@test 'print: punct -> punctuation' {
    correct_in_ctx print punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print punctuation'
}

@test 'cat: punct -> punctuation' {
    correct_in_ctx cat punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat punctuation'
}

@test 'grep: punct -> punctuation' {
    correct_in_ctx grep punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep punctuation'
}

@test 'sed: punct -> punctuation' {
    correct_in_ctx sed punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed punctuation'
}

@test 'awk: punct -> punctuation' {
    correct_in_ctx awk punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk punctuation'
}

@test 'man: punct -> punctuation' {
    correct_in_ctx man punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man punctuation'
}

@test 'ls: punct -> punctuation' {
    correct_in_ctx ls punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls punctuation'
}

@test 'head: punct -> punctuation' {
    correct_in_ctx head punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head punctuation'
}

@test 'tail: punct -> punctuation' {
    correct_in_ctx tail punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail punctuation'
}

@test 'sort: punct -> punctuation' {
    correct_in_ctx sort punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort punctuation'
}

@test 'uniq: punct -> punctuation' {
    correct_in_ctx uniq punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq punctuation'
}

@test 'wc: punct -> punctuation' {
    correct_in_ctx wc punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc punctuation'
}

@test 'tr: punct -> punctuation' {
    correct_in_ctx tr punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr punctuation'
}

@test 'cut: punct -> punctuation' {
    correct_in_ctx cut punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut punctuation'
}

@test 'diff: punct -> punctuation' {
    correct_in_ctx diff punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff punctuation'
}

@test 'print: radisu -> radius' {
    correct_in_ctx print radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print radius'
}

@test 'cat: radisu -> radius' {
    correct_in_ctx cat radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat radius'
}

@test 'grep: radisu -> radius' {
    correct_in_ctx grep radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep radius'
}

@test 'sed: radisu -> radius' {
    correct_in_ctx sed radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed radius'
}

@test 'awk: radisu -> radius' {
    correct_in_ctx awk radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk radius'
}

@test 'man: radisu -> radius' {
    correct_in_ctx man radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man radius'
}

@test 'ls: radisu -> radius' {
    correct_in_ctx ls radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls radius'
}

@test 'head: radisu -> radius' {
    correct_in_ctx head radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head radius'
}

@test 'tail: radisu -> radius' {
    correct_in_ctx tail radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail radius'
}

@test 'sort: radisu -> radius' {
    correct_in_ctx sort radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort radius'
}

@test 'uniq: radisu -> radius' {
    correct_in_ctx uniq radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq radius'
}

@test 'wc: radisu -> radius' {
    correct_in_ctx wc radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc radius'
}

@test 'tr: radisu -> radius' {
    correct_in_ctx tr radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr radius'
}

@test 'cut: radisu -> radius' {
    correct_in_ctx cut radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut radius'
}

@test 'diff: radisu -> radius' {
    correct_in_ctx diff radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff radius'
}

@test 'print: rnage -> range' {
    correct_in_ctx print rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print range'
}

@test 'cat: rnage -> range' {
    correct_in_ctx cat rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat range'
}

@test 'grep: rnage -> range' {
    correct_in_ctx grep rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep range'
}

@test 'sed: rnage -> range' {
    correct_in_ctx sed rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed range'
}

@test 'awk: rnage -> range' {
    correct_in_ctx awk rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk range'
}

@test 'man: rnage -> range' {
    correct_in_ctx man rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man range'
}

@test 'ls: rnage -> range' {
    correct_in_ctx ls rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls range'
}

@test 'head: rnage -> range' {
    correct_in_ctx head rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head range'
}

@test 'tail: rnage -> range' {
    correct_in_ctx tail rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail range'
}

@test 'sort: rnage -> range' {
    correct_in_ctx sort rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort range'
}

@test 'uniq: rnage -> range' {
    correct_in_ctx uniq rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq range'
}

@test 'wc: rnage -> range' {
    correct_in_ctx wc rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc range'
}

@test 'tr: rnage -> range' {
    correct_in_ctx tr rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr range'
}

@test 'cut: rnage -> range' {
    correct_in_ctx cut rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut range'
}

@test 'diff: rnage -> range' {
    correct_in_ctx diff rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff range'
}

@test 'print: eradme -> README' {
    correct_in_ctx print eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print README'
}

@test 'cat: eradme -> README' {
    correct_in_ctx cat eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat README'
}

@test 'grep: eradme -> README' {
    correct_in_ctx grep eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep README'
}

@test 'sed: eradme -> README' {
    correct_in_ctx sed eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed README'
}

@test 'awk: eradme -> README' {
    correct_in_ctx awk eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk README'
}

@test 'man: eradme -> README' {
    correct_in_ctx man eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man README'
}

@test 'ls: eradme -> README' {
    correct_in_ctx ls eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls README'
}

@test 'head: eradme -> README' {
    correct_in_ctx head eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head README'
}

@test 'tail: eradme -> README' {
    correct_in_ctx tail eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail README'
}

@test 'sort: eradme -> README' {
    correct_in_ctx sort eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort README'
}

@test 'uniq: eradme -> README' {
    correct_in_ctx uniq eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq README'
}

@test 'wc: eradme -> README' {
    correct_in_ctx wc eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc README'
}

@test 'tr: eradme -> README' {
    correct_in_ctx tr eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr README'
}

@test 'cut: eradme -> README' {
    correct_in_ctx cut eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut README'
}

@test 'diff: eradme -> README' {
    correct_in_ctx diff eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff README'
}

@test 'print: rdeo -> redo' {
    correct_in_ctx print rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print redo'
}

@test 'cat: rdeo -> redo' {
    correct_in_ctx cat rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat redo'
}

@test 'grep: rdeo -> redo' {
    correct_in_ctx grep rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep redo'
}

@test 'sed: rdeo -> redo' {
    correct_in_ctx sed rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed redo'
}

@test 'awk: rdeo -> redo' {
    correct_in_ctx awk rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk redo'
}

@test 'man: rdeo -> redo' {
    correct_in_ctx man rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man redo'
}

@test 'ls: rdeo -> redo' {
    correct_in_ctx ls rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls redo'
}

@test 'head: rdeo -> redo' {
    correct_in_ctx head rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head redo'
}

@test 'tail: rdeo -> redo' {
    correct_in_ctx tail rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail redo'
}

@test 'sort: rdeo -> redo' {
    correct_in_ctx sort rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort redo'
}

@test 'uniq: rdeo -> redo' {
    correct_in_ctx uniq rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq redo'
}

@test 'wc: rdeo -> redo' {
    correct_in_ctx wc rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc redo'
}

@test 'tr: rdeo -> redo' {
    correct_in_ctx tr rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr redo'
}

@test 'cut: rdeo -> redo' {
    correct_in_ctx cut rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut redo'
}

@test 'diff: rdeo -> redo' {
    correct_in_ctx diff rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff redo'
}

@test 'print: remoet -> remote' {
    correct_in_ctx print remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print remote'
}

@test 'cat: remoet -> remote' {
    correct_in_ctx cat remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat remote'
}

@test 'grep: remoet -> remote' {
    correct_in_ctx grep remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep remote'
}

@test 'sed: remoet -> remote' {
    correct_in_ctx sed remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed remote'
}

@test 'awk: remoet -> remote' {
    correct_in_ctx awk remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk remote'
}

@test 'man: remoet -> remote' {
    correct_in_ctx man remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man remote'
}

@test 'ls: remoet -> remote' {
    correct_in_ctx ls remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls remote'
}

@test 'head: remoet -> remote' {
    correct_in_ctx head remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head remote'
}

@test 'tail: remoet -> remote' {
    correct_in_ctx tail remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail remote'
}

@test 'sort: remoet -> remote' {
    correct_in_ctx sort remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort remote'
}

@test 'uniq: remoet -> remote' {
    correct_in_ctx uniq remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq remote'
}

@test 'wc: remoet -> remote' {
    correct_in_ctx wc remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc remote'
}

@test 'tr: remoet -> remote' {
    correct_in_ctx tr remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr remote'
}

@test 'cut: remoet -> remote' {
    correct_in_ctx cut remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut remote'
}

@test 'diff: remoet -> remote' {
    correct_in_ctx diff remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff remote'
}

@test 'print: replaec -> replace' {
    correct_in_ctx print replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print replace'
}

@test 'cat: replaec -> replace' {
    correct_in_ctx cat replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat replace'
}

@test 'grep: replaec -> replace' {
    correct_in_ctx grep replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep replace'
}

@test 'sed: replaec -> replace' {
    correct_in_ctx sed replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed replace'
}

@test 'awk: replaec -> replace' {
    correct_in_ctx awk replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk replace'
}

@test 'man: replaec -> replace' {
    correct_in_ctx man replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man replace'
}

@test 'ls: replaec -> replace' {
    correct_in_ctx ls replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls replace'
}

@test 'head: replaec -> replace' {
    correct_in_ctx head replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head replace'
}

@test 'tail: replaec -> replace' {
    correct_in_ctx tail replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail replace'
}

@test 'sort: replaec -> replace' {
    correct_in_ctx sort replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort replace'
}

@test 'uniq: replaec -> replace' {
    correct_in_ctx uniq replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq replace'
}

@test 'wc: replaec -> replace' {
    correct_in_ctx wc replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc replace'
}

@test 'tr: replaec -> replace' {
    correct_in_ctx tr replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr replace'
}

@test 'cut: replaec -> replace' {
    correct_in_ctx cut replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut replace'
}

@test 'diff: replaec -> replace' {
    correct_in_ctx diff replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff replace'
}

@test 'print: repos -> repositories' {
    correct_in_ctx print repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print repositories'
}

@test 'cat: repos -> repositories' {
    correct_in_ctx cat repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat repositories'
}

@test 'grep: repos -> repositories' {
    correct_in_ctx grep repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep repositories'
}

@test 'sed: repos -> repositories' {
    correct_in_ctx sed repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed repositories'
}

@test 'awk: repos -> repositories' {
    correct_in_ctx awk repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk repositories'
}

@test 'man: repos -> repositories' {
    correct_in_ctx man repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man repositories'
}

@test 'ls: repos -> repositories' {
    correct_in_ctx ls repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls repositories'
}

@test 'head: repos -> repositories' {
    correct_in_ctx head repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head repositories'
}

@test 'tail: repos -> repositories' {
    correct_in_ctx tail repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail repositories'
}

@test 'sort: repos -> repositories' {
    correct_in_ctx sort repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort repositories'
}

@test 'uniq: repos -> repositories' {
    correct_in_ctx uniq repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq repositories'
}

@test 'wc: repos -> repositories' {
    correct_in_ctx wc repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc repositories'
}

@test 'tr: repos -> repositories' {
    correct_in_ctx tr repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr repositories'
}

@test 'cut: repos -> repositories' {
    correct_in_ctx cut repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut repositories'
}

@test 'diff: repos -> repositories' {
    correct_in_ctx diff repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff repositories'
}

@test 'print: repo -> repository' {
    correct_in_ctx print repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print repository'
}

@test 'cat: repo -> repository' {
    correct_in_ctx cat repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat repository'
}

@test 'grep: repo -> repository' {
    correct_in_ctx grep repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep repository'
}

@test 'sed: repo -> repository' {
    correct_in_ctx sed repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed repository'
}

@test 'awk: repo -> repository' {
    correct_in_ctx awk repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk repository'
}

@test 'man: repo -> repository' {
    correct_in_ctx man repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man repository'
}

@test 'ls: repo -> repository' {
    correct_in_ctx ls repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls repository'
}

@test 'head: repo -> repository' {
    correct_in_ctx head repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head repository'
}

@test 'tail: repo -> repository' {
    correct_in_ctx tail repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail repository'
}

@test 'sort: repo -> repository' {
    correct_in_ctx sort repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort repository'
}

@test 'uniq: repo -> repository' {
    correct_in_ctx uniq repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq repository'
}

@test 'wc: repo -> repository' {
    correct_in_ctx wc repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc repository'
}

@test 'tr: repo -> repository' {
    correct_in_ctx tr repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr repository'
}

@test 'cut: repo -> repository' {
    correct_in_ctx cut repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut repository'
}

@test 'diff: repo -> repository' {
    correct_in_ctx diff repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff repository'
}

@test 'print: res -> result' {
    correct_in_ctx print res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print result'
}

@test 'cat: res -> result' {
    correct_in_ctx cat res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat result'
}

@test 'grep: res -> result' {
    correct_in_ctx grep res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep result'
}

@test 'sed: res -> result' {
    correct_in_ctx sed res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed result'
}

@test 'awk: res -> result' {
    correct_in_ctx awk res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk result'
}

@test 'man: res -> result' {
    correct_in_ctx man res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man result'
}

@test 'ls: res -> result' {
    correct_in_ctx ls res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls result'
}

@test 'head: res -> result' {
    correct_in_ctx head res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head result'
}

@test 'tail: res -> result' {
    correct_in_ctx tail res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail result'
}

@test 'sort: res -> result' {
    correct_in_ctx sort res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort result'
}

@test 'uniq: res -> result' {
    correct_in_ctx uniq res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq result'
}

@test 'wc: res -> result' {
    correct_in_ctx wc res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc result'
}

@test 'tr: res -> result' {
    correct_in_ctx tr res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr result'
}

@test 'cut: res -> result' {
    correct_in_ctx cut res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut result'
}

@test 'diff: res -> result' {
    correct_in_ctx diff res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff result'
}

@test 'print: rvb -> reverb' {
    correct_in_ctx print rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print reverb'
}

@test 'cat: rvb -> reverb' {
    correct_in_ctx cat rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat reverb'
}

@test 'grep: rvb -> reverb' {
    correct_in_ctx grep rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep reverb'
}

@test 'sed: rvb -> reverb' {
    correct_in_ctx sed rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed reverb'
}

@test 'awk: rvb -> reverb' {
    correct_in_ctx awk rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk reverb'
}

@test 'man: rvb -> reverb' {
    correct_in_ctx man rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man reverb'
}

@test 'ls: rvb -> reverb' {
    correct_in_ctx ls rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls reverb'
}

@test 'head: rvb -> reverb' {
    correct_in_ctx head rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head reverb'
}

@test 'tail: rvb -> reverb' {
    correct_in_ctx tail rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail reverb'
}

@test 'sort: rvb -> reverb' {
    correct_in_ctx sort rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort reverb'
}

@test 'uniq: rvb -> reverb' {
    correct_in_ctx uniq rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq reverb'
}

@test 'wc: rvb -> reverb' {
    correct_in_ctx wc rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc reverb'
}

@test 'tr: rvb -> reverb' {
    correct_in_ctx tr rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr reverb'
}

@test 'cut: rvb -> reverb' {
    correct_in_ctx cut rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut reverb'
}

@test 'diff: rvb -> reverb' {
    correct_in_ctx diff rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff reverb'
}

@test 'print: rvs -> reverse' {
    correct_in_ctx print rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print reverse'
}

@test 'cat: rvs -> reverse' {
    correct_in_ctx cat rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat reverse'
}

@test 'grep: rvs -> reverse' {
    correct_in_ctx grep rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep reverse'
}

@test 'sed: rvs -> reverse' {
    correct_in_ctx sed rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed reverse'
}

@test 'awk: rvs -> reverse' {
    correct_in_ctx awk rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk reverse'
}

@test 'man: rvs -> reverse' {
    correct_in_ctx man rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man reverse'
}

@test 'ls: rvs -> reverse' {
    correct_in_ctx ls rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls reverse'
}

@test 'head: rvs -> reverse' {
    correct_in_ctx head rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head reverse'
}

@test 'tail: rvs -> reverse' {
    correct_in_ctx tail rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail reverse'
}

@test 'sort: rvs -> reverse' {
    correct_in_ctx sort rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort reverse'
}

@test 'uniq: rvs -> reverse' {
    correct_in_ctx uniq rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq reverse'
}

@test 'wc: rvs -> reverse' {
    correct_in_ctx wc rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc reverse'
}

@test 'tr: rvs -> reverse' {
    correct_in_ctx tr rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr reverse'
}

@test 'cut: rvs -> reverse' {
    correct_in_ctx cut rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut reverse'
}

@test 'diff: rvs -> reverse' {
    correct_in_ctx diff rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff reverse'
}

@test 'print: rgb -> RGB' {
    correct_in_ctx print rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print RGB'
}

@test 'cat: rgb -> RGB' {
    correct_in_ctx cat rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat RGB'
}

@test 'grep: rgb -> RGB' {
    correct_in_ctx grep rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep RGB'
}

@test 'sed: rgb -> RGB' {
    correct_in_ctx sed rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed RGB'
}

@test 'awk: rgb -> RGB' {
    correct_in_ctx awk rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk RGB'
}

@test 'man: rgb -> RGB' {
    correct_in_ctx man rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man RGB'
}

@test 'ls: rgb -> RGB' {
    correct_in_ctx ls rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls RGB'
}

@test 'head: rgb -> RGB' {
    correct_in_ctx head rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head RGB'
}

@test 'tail: rgb -> RGB' {
    correct_in_ctx tail rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail RGB'
}

@test 'sort: rgb -> RGB' {
    correct_in_ctx sort rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort RGB'
}

@test 'uniq: rgb -> RGB' {
    correct_in_ctx uniq rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq RGB'
}

@test 'wc: rgb -> RGB' {
    correct_in_ctx wc rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc RGB'
}

@test 'tr: rgb -> RGB' {
    correct_in_ctx tr rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr RGB'
}

@test 'cut: rgb -> RGB' {
    correct_in_ctx cut rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut RGB'
}

@test 'diff: rgb -> RGB' {
    correct_in_ctx diff rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff RGB'
}

@test 'print: rotue -> route' {
    correct_in_ctx print rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print route'
}

@test 'cat: rotue -> route' {
    correct_in_ctx cat rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat route'
}

@test 'grep: rotue -> route' {
    correct_in_ctx grep rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep route'
}

@test 'sed: rotue -> route' {
    correct_in_ctx sed rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed route'
}

@test 'awk: rotue -> route' {
    correct_in_ctx awk rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk route'
}

@test 'man: rotue -> route' {
    correct_in_ctx man rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man route'
}

@test 'ls: rotue -> route' {
    correct_in_ctx ls rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls route'
}

@test 'head: rotue -> route' {
    correct_in_ctx head rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head route'
}

@test 'tail: rotue -> route' {
    correct_in_ctx tail rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail route'
}

@test 'sort: rotue -> route' {
    correct_in_ctx sort rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort route'
}

@test 'uniq: rotue -> route' {
    correct_in_ctx uniq rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq route'
}

@test 'wc: rotue -> route' {
    correct_in_ctx wc rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc route'
}

@test 'tr: rotue -> route' {
    correct_in_ctx tr rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr route'
}

@test 'cut: rotue -> route' {
    correct_in_ctx cut rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut route'
}

@test 'diff: rotue -> route' {
    correct_in_ctx diff rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff route'
}

@test 'print: runnign -> runnning' {
    correct_in_ctx print runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print runnning'
}

@test 'cat: runnign -> runnning' {
    correct_in_ctx cat runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat runnning'
}

@test 'grep: runnign -> runnning' {
    correct_in_ctx grep runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep runnning'
}

@test 'sed: runnign -> runnning' {
    correct_in_ctx sed runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed runnning'
}

@test 'awk: runnign -> runnning' {
    correct_in_ctx awk runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk runnning'
}

@test 'man: runnign -> runnning' {
    correct_in_ctx man runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man runnning'
}

@test 'ls: runnign -> runnning' {
    correct_in_ctx ls runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls runnning'
}

@test 'head: runnign -> runnning' {
    correct_in_ctx head runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head runnning'
}

@test 'tail: runnign -> runnning' {
    correct_in_ctx tail runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail runnning'
}

@test 'sort: runnign -> runnning' {
    correct_in_ctx sort runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort runnning'
}

@test 'uniq: runnign -> runnning' {
    correct_in_ctx uniq runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq runnning'
}

@test 'wc: runnign -> runnning' {
    correct_in_ctx wc runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc runnning'
}

@test 'tr: runnign -> runnning' {
    correct_in_ctx tr runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr runnning'
}

@test 'cut: runnign -> runnning' {
    correct_in_ctx cut runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut runnning'
}

@test 'diff: runnign -> runnning' {
    correct_in_ctx diff runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff runnning'
}

@test 'print: saem -> same' {
    correct_in_ctx print saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print same'
}

@test 'cat: saem -> same' {
    correct_in_ctx cat saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat same'
}

@test 'grep: saem -> same' {
    correct_in_ctx grep saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep same'
}

@test 'sed: saem -> same' {
    correct_in_ctx sed saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed same'
}

@test 'awk: saem -> same' {
    correct_in_ctx awk saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk same'
}

@test 'man: saem -> same' {
    correct_in_ctx man saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man same'
}

@test 'ls: saem -> same' {
    correct_in_ctx ls saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls same'
}

@test 'head: saem -> same' {
    correct_in_ctx head saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head same'
}

@test 'tail: saem -> same' {
    correct_in_ctx tail saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail same'
}

@test 'sort: saem -> same' {
    correct_in_ctx sort saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort same'
}

@test 'uniq: saem -> same' {
    correct_in_ctx uniq saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq same'
}

@test 'wc: saem -> same' {
    correct_in_ctx wc saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc same'
}

@test 'tr: saem -> same' {
    correct_in_ctx tr saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr same'
}

@test 'cut: saem -> same' {
    correct_in_ctx cut saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut same'
}

@test 'diff: saem -> same' {
    correct_in_ctx diff saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff same'
}

@test 'print: sata -> SATA' {
    correct_in_ctx print sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print SATA'
}

@test 'cat: sata -> SATA' {
    correct_in_ctx cat sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat SATA'
}

@test 'grep: sata -> SATA' {
    correct_in_ctx grep sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep SATA'
}

@test 'sed: sata -> SATA' {
    correct_in_ctx sed sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed SATA'
}

@test 'awk: sata -> SATA' {
    correct_in_ctx awk sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk SATA'
}

@test 'man: sata -> SATA' {
    correct_in_ctx man sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man SATA'
}

@test 'ls: sata -> SATA' {
    correct_in_ctx ls sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls SATA'
}

@test 'head: sata -> SATA' {
    correct_in_ctx head sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head SATA'
}

@test 'tail: sata -> SATA' {
    correct_in_ctx tail sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail SATA'
}

@test 'sort: sata -> SATA' {
    correct_in_ctx sort sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort SATA'
}

@test 'uniq: sata -> SATA' {
    correct_in_ctx uniq sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq SATA'
}

@test 'wc: sata -> SATA' {
    correct_in_ctx wc sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc SATA'
}

@test 'tr: sata -> SATA' {
    correct_in_ctx tr sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr SATA'
}

@test 'cut: sata -> SATA' {
    correct_in_ctx cut sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut SATA'
}

@test 'diff: sata -> SATA' {
    correct_in_ctx diff sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff SATA'
}

@test 'print: scoep -> scope' {
    correct_in_ctx print scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print scope'
}

@test 'cat: scoep -> scope' {
    correct_in_ctx cat scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat scope'
}

@test 'grep: scoep -> scope' {
    correct_in_ctx grep scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep scope'
}

@test 'sed: scoep -> scope' {
    correct_in_ctx sed scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed scope'
}

@test 'awk: scoep -> scope' {
    correct_in_ctx awk scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk scope'
}

@test 'man: scoep -> scope' {
    correct_in_ctx man scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man scope'
}

@test 'ls: scoep -> scope' {
    correct_in_ctx ls scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls scope'
}

@test 'head: scoep -> scope' {
    correct_in_ctx head scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head scope'
}

@test 'tail: scoep -> scope' {
    correct_in_ctx tail scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail scope'
}

@test 'sort: scoep -> scope' {
    correct_in_ctx sort scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort scope'
}

@test 'uniq: scoep -> scope' {
    correct_in_ctx uniq scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq scope'
}

@test 'wc: scoep -> scope' {
    correct_in_ctx wc scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc scope'
}

@test 'tr: scoep -> scope' {
    correct_in_ctx tr scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr scope'
}

@test 'cut: scoep -> scope' {
    correct_in_ctx cut scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut scope'
}

@test 'diff: scoep -> scope' {
    correct_in_ctx diff scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff scope'
}

@test 'print: scsi -> SCSI' {
    correct_in_ctx print scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print SCSI'
}

@test 'cat: scsi -> SCSI' {
    correct_in_ctx cat scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat SCSI'
}

@test 'grep: scsi -> SCSI' {
    correct_in_ctx grep scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep SCSI'
}

@test 'sed: scsi -> SCSI' {
    correct_in_ctx sed scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed SCSI'
}

@test 'awk: scsi -> SCSI' {
    correct_in_ctx awk scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk SCSI'
}

@test 'man: scsi -> SCSI' {
    correct_in_ctx man scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man SCSI'
}

@test 'ls: scsi -> SCSI' {
    correct_in_ctx ls scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls SCSI'
}

@test 'head: scsi -> SCSI' {
    correct_in_ctx head scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head SCSI'
}

@test 'tail: scsi -> SCSI' {
    correct_in_ctx tail scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail SCSI'
}

@test 'sort: scsi -> SCSI' {
    correct_in_ctx sort scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort SCSI'
}

@test 'uniq: scsi -> SCSI' {
    correct_in_ctx uniq scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq SCSI'
}

@test 'wc: scsi -> SCSI' {
    correct_in_ctx wc scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc SCSI'
}

@test 'tr: scsi -> SCSI' {
    correct_in_ctx tr scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr SCSI'
}

@test 'cut: scsi -> SCSI' {
    correct_in_ctx cut scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut SCSI'
}

@test 'diff: scsi -> SCSI' {
    correct_in_ctx diff scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff SCSI'
}

@test 'print: searcch -> search' {
    correct_in_ctx print searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print search'
}

@test 'cat: searcch -> search' {
    correct_in_ctx cat searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat search'
}

@test 'grep: searcch -> search' {
    correct_in_ctx grep searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep search'
}

@test 'sed: searcch -> search' {
    correct_in_ctx sed searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed search'
}

@test 'awk: searcch -> search' {
    correct_in_ctx awk searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk search'
}

@test 'man: searcch -> search' {
    correct_in_ctx man searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man search'
}

@test 'ls: searcch -> search' {
    correct_in_ctx ls searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls search'
}

@test 'head: searcch -> search' {
    correct_in_ctx head searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head search'
}

@test 'tail: searcch -> search' {
    correct_in_ctx tail searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail search'
}

@test 'sort: searcch -> search' {
    correct_in_ctx sort searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort search'
}

@test 'uniq: searcch -> search' {
    correct_in_ctx uniq searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq search'
}

@test 'wc: searcch -> search' {
    correct_in_ctx wc searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc search'
}

@test 'tr: searcch -> search' {
    correct_in_ctx tr searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr search'
}

@test 'cut: searcch -> search' {
    correct_in_ctx cut searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut search'
}

@test 'diff: searcch -> search' {
    correct_in_ctx diff searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff search'
}

@test 'print: esd -> sed' {
    correct_in_ctx print esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print sed'
}

@test 'cat: esd -> sed' {
    correct_in_ctx cat esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat sed'
}

@test 'grep: esd -> sed' {
    correct_in_ctx grep esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep sed'
}

@test 'sed: esd -> sed' {
    correct_in_ctx sed esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed sed'
}

@test 'awk: esd -> sed' {
    correct_in_ctx awk esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk sed'
}

@test 'man: esd -> sed' {
    correct_in_ctx man esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man sed'
}

@test 'ls: esd -> sed' {
    correct_in_ctx ls esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls sed'
}

@test 'head: esd -> sed' {
    correct_in_ctx head esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head sed'
}

@test 'tail: esd -> sed' {
    correct_in_ctx tail esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail sed'
}

@test 'sort: esd -> sed' {
    correct_in_ctx sort esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort sed'
}

@test 'uniq: esd -> sed' {
    correct_in_ctx uniq esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq sed'
}

@test 'wc: esd -> sed' {
    correct_in_ctx wc esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc sed'
}

@test 'tr: esd -> sed' {
    correct_in_ctx tr esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr sed'
}

@test 'cut: esd -> sed' {
    correct_in_ctx cut esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut sed'
}

@test 'diff: esd -> sed' {
    correct_in_ctx diff esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff sed'
}

@test 'print: sep -> separated' {
    correct_in_ctx print sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print separated'
}

@test 'cat: sep -> separated' {
    correct_in_ctx cat sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat separated'
}

@test 'grep: sep -> separated' {
    correct_in_ctx grep sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep separated'
}

@test 'sed: sep -> separated' {
    correct_in_ctx sed sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed separated'
}

@test 'awk: sep -> separated' {
    correct_in_ctx awk sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk separated'
}

@test 'man: sep -> separated' {
    correct_in_ctx man sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man separated'
}

@test 'ls: sep -> separated' {
    correct_in_ctx ls sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls separated'
}

@test 'head: sep -> separated' {
    correct_in_ctx head sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head separated'
}

@test 'tail: sep -> separated' {
    correct_in_ctx tail sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail separated'
}

@test 'sort: sep -> separated' {
    correct_in_ctx sort sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort separated'
}

@test 'uniq: sep -> separated' {
    correct_in_ctx uniq sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq separated'
}

@test 'wc: sep -> separated' {
    correct_in_ctx wc sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc separated'
}

@test 'tr: sep -> separated' {
    correct_in_ctx tr sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr separated'
}

@test 'cut: sep -> separated' {
    correct_in_ctx cut sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut separated'
}

@test 'diff: sep -> separated' {
    correct_in_ctx diff sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff separated'
}

@test 'print: est -> set' {
    correct_in_ctx print est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print set'
}

@test 'cat: est -> set' {
    correct_in_ctx cat est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat set'
}

@test 'grep: est -> set' {
    correct_in_ctx grep est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep set'
}

@test 'sed: est -> set' {
    correct_in_ctx sed est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed set'
}

@test 'awk: est -> set' {
    correct_in_ctx awk est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk set'
}

@test 'man: est -> set' {
    correct_in_ctx man est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man set'
}

@test 'ls: est -> set' {
    correct_in_ctx ls est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls set'
}

@test 'head: est -> set' {
    correct_in_ctx head est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head set'
}

@test 'tail: est -> set' {
    correct_in_ctx tail est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail set'
}

@test 'sort: est -> set' {
    correct_in_ctx sort est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort set'
}

@test 'uniq: est -> set' {
    correct_in_ctx uniq est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq set'
}

@test 'wc: est -> set' {
    correct_in_ctx wc est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc set'
}

@test 'tr: est -> set' {
    correct_in_ctx tr est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr set'
}

@test 'cut: est -> set' {
    correct_in_ctx cut est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut set'
}

@test 'diff: est -> set' {
    correct_in_ctx diff est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff set'
}

@test 'print: sahre -> share' {
    correct_in_ctx print sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print share'
}

@test 'cat: sahre -> share' {
    correct_in_ctx cat sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat share'
}

@test 'grep: sahre -> share' {
    correct_in_ctx grep sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep share'
}

@test 'sed: sahre -> share' {
    correct_in_ctx sed sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed share'
}

@test 'awk: sahre -> share' {
    correct_in_ctx awk sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk share'
}

@test 'man: sahre -> share' {
    correct_in_ctx man sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man share'
}

@test 'ls: sahre -> share' {
    correct_in_ctx ls sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls share'
}

@test 'head: sahre -> share' {
    correct_in_ctx head sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head share'
}

@test 'tail: sahre -> share' {
    correct_in_ctx tail sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail share'
}

@test 'sort: sahre -> share' {
    correct_in_ctx sort sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort share'
}

@test 'uniq: sahre -> share' {
    correct_in_ctx uniq sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq share'
}

@test 'wc: sahre -> share' {
    correct_in_ctx wc sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc share'
}

@test 'tr: sahre -> share' {
    correct_in_ctx tr sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr share'
}

@test 'cut: sahre -> share' {
    correct_in_ctx cut sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut share'
}

@test 'diff: sahre -> share' {
    correct_in_ctx diff sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff share'
}

@test 'print: shel -> shell script' {
    correct_in_ctx print shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print shell script'
}

@test 'cat: shel -> shell script' {
    correct_in_ctx cat shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat shell script'
}

@test 'grep: shel -> shell script' {
    correct_in_ctx grep shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep shell script'
}

@test 'sed: shel -> shell script' {
    correct_in_ctx sed shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed shell script'
}

@test 'awk: shel -> shell script' {
    correct_in_ctx awk shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk shell script'
}

@test 'man: shel -> shell script' {
    correct_in_ctx man shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man shell script'
}

@test 'ls: shel -> shell script' {
    correct_in_ctx ls shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls shell script'
}

@test 'head: shel -> shell script' {
    correct_in_ctx head shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head shell script'
}

@test 'tail: shel -> shell script' {
    correct_in_ctx tail shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail shell script'
}

@test 'sort: shel -> shell script' {
    correct_in_ctx sort shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort shell script'
}

@test 'uniq: shel -> shell script' {
    correct_in_ctx uniq shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq shell script'
}

@test 'wc: shel -> shell script' {
    correct_in_ctx wc shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc shell script'
}

@test 'tr: shel -> shell script' {
    correct_in_ctx tr shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr shell script'
}

@test 'cut: shel -> shell script' {
    correct_in_ctx cut shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut shell script'
}

@test 'diff: shel -> shell script' {
    correct_in_ctx diff shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff shell script'
}

@test 'print: shouldnt -> should not' {
    correct_in_ctx print shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print should not'
}

@test 'cat: shouldnt -> should not' {
    correct_in_ctx cat shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat should not'
}

@test 'grep: shouldnt -> should not' {
    correct_in_ctx grep shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep should not'
}

@test 'sed: shouldnt -> should not' {
    correct_in_ctx sed shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed should not'
}

@test 'awk: shouldnt -> should not' {
    correct_in_ctx awk shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk should not'
}

@test 'man: shouldnt -> should not' {
    correct_in_ctx man shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man should not'
}

@test 'ls: shouldnt -> should not' {
    correct_in_ctx ls shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls should not'
}

@test 'head: shouldnt -> should not' {
    correct_in_ctx head shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head should not'
}

@test 'tail: shouldnt -> should not' {
    correct_in_ctx tail shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail should not'
}

@test 'sort: shouldnt -> should not' {
    correct_in_ctx sort shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort should not'
}

@test 'uniq: shouldnt -> should not' {
    correct_in_ctx uniq shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq should not'
}

@test 'wc: shouldnt -> should not' {
    correct_in_ctx wc shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc should not'
}

@test 'tr: shouldnt -> should not' {
    correct_in_ctx tr shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr should not'
}

@test 'cut: shouldnt -> should not' {
    correct_in_ctx cut shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut should not'
}

@test 'diff: shouldnt -> should not' {
    correct_in_ctx diff shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff should not'
}

@test 'print: shwo -> show' {
    correct_in_ctx print shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print show'
}

@test 'cat: shwo -> show' {
    correct_in_ctx cat shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat show'
}

@test 'grep: shwo -> show' {
    correct_in_ctx grep shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep show'
}

@test 'sed: shwo -> show' {
    correct_in_ctx sed shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed show'
}

@test 'awk: shwo -> show' {
    correct_in_ctx awk shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk show'
}

@test 'man: shwo -> show' {
    correct_in_ctx man shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man show'
}

@test 'ls: shwo -> show' {
    correct_in_ctx ls shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls show'
}

@test 'head: shwo -> show' {
    correct_in_ctx head shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head show'
}

@test 'tail: shwo -> show' {
    correct_in_ctx tail shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail show'
}

@test 'sort: shwo -> show' {
    correct_in_ctx sort shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort show'
}

@test 'uniq: shwo -> show' {
    correct_in_ctx uniq shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq show'
}

@test 'wc: shwo -> show' {
    correct_in_ctx wc shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc show'
}

@test 'tr: shwo -> show' {
    correct_in_ctx tr shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr show'
}

@test 'cut: shwo -> show' {
    correct_in_ctx cut shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut show'
}

@test 'diff: shwo -> show' {
    correct_in_ctx diff shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff show'
}

@test 'print: signle -> single' {
    correct_in_ctx print signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print single'
}

@test 'cat: signle -> single' {
    correct_in_ctx cat signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat single'
}

@test 'grep: signle -> single' {
    correct_in_ctx grep signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep single'
}

@test 'sed: signle -> single' {
    correct_in_ctx sed signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed single'
}

@test 'awk: signle -> single' {
    correct_in_ctx awk signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk single'
}

@test 'man: signle -> single' {
    correct_in_ctx man signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man single'
}

@test 'ls: signle -> single' {
    correct_in_ctx ls signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls single'
}

@test 'head: signle -> single' {
    correct_in_ctx head signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head single'
}

@test 'tail: signle -> single' {
    correct_in_ctx tail signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail single'
}

@test 'sort: signle -> single' {
    correct_in_ctx sort signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort single'
}

@test 'uniq: signle -> single' {
    correct_in_ctx uniq signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq single'
}

@test 'wc: signle -> single' {
    correct_in_ctx wc signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc single'
}

@test 'tr: signle -> single' {
    correct_in_ctx tr signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr single'
}

@test 'cut: signle -> single' {
    correct_in_ctx cut signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut single'
}

@test 'diff: signle -> single' {
    correct_in_ctx diff signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff single'
}

@test 'print: soln -> solution' {
    correct_in_ctx print soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print solution'
}

@test 'cat: soln -> solution' {
    correct_in_ctx cat soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat solution'
}

@test 'grep: soln -> solution' {
    correct_in_ctx grep soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep solution'
}

@test 'sed: soln -> solution' {
    correct_in_ctx sed soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed solution'
}

@test 'awk: soln -> solution' {
    correct_in_ctx awk soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk solution'
}

@test 'man: soln -> solution' {
    correct_in_ctx man soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man solution'
}

@test 'ls: soln -> solution' {
    correct_in_ctx ls soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls solution'
}

@test 'head: soln -> solution' {
    correct_in_ctx head soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head solution'
}

@test 'tail: soln -> solution' {
    correct_in_ctx tail soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail solution'
}

@test 'sort: soln -> solution' {
    correct_in_ctx sort soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort solution'
}

@test 'uniq: soln -> solution' {
    correct_in_ctx uniq soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq solution'
}

@test 'wc: soln -> solution' {
    correct_in_ctx wc soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc solution'
}

@test 'tr: soln -> solution' {
    correct_in_ctx tr soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr solution'
}

@test 'cut: soln -> solution' {
    correct_in_ctx cut soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut solution'
}

@test 'diff: soln -> solution' {
    correct_in_ctx diff soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff solution'
}

@test 'print: solns -> solutions' {
    correct_in_ctx print solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print solutions'
}

@test 'cat: solns -> solutions' {
    correct_in_ctx cat solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat solutions'
}

@test 'grep: solns -> solutions' {
    correct_in_ctx grep solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep solutions'
}

@test 'sed: solns -> solutions' {
    correct_in_ctx sed solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed solutions'
}

@test 'awk: solns -> solutions' {
    correct_in_ctx awk solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk solutions'
}

@test 'man: solns -> solutions' {
    correct_in_ctx man solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man solutions'
}

@test 'ls: solns -> solutions' {
    correct_in_ctx ls solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls solutions'
}

@test 'head: solns -> solutions' {
    correct_in_ctx head solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head solutions'
}

@test 'tail: solns -> solutions' {
    correct_in_ctx tail solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail solutions'
}

@test 'sort: solns -> solutions' {
    correct_in_ctx sort solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort solutions'
}

@test 'uniq: solns -> solutions' {
    correct_in_ctx uniq solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq solutions'
}

@test 'wc: solns -> solutions' {
    correct_in_ctx wc solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc solutions'
}

@test 'tr: solns -> solutions' {
    correct_in_ctx tr solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr solutions'
}

@test 'cut: solns -> solutions' {
    correct_in_ctx cut solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut solutions'
}

@test 'diff: solns -> solutions' {
    correct_in_ctx diff solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff solutions'
}

@test 'print: soem -> some' {
    correct_in_ctx print soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print some'
}

@test 'cat: soem -> some' {
    correct_in_ctx cat soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat some'
}

@test 'grep: soem -> some' {
    correct_in_ctx grep soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep some'
}

@test 'sed: soem -> some' {
    correct_in_ctx sed soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed some'
}

@test 'awk: soem -> some' {
    correct_in_ctx awk soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk some'
}

@test 'man: soem -> some' {
    correct_in_ctx man soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man some'
}

@test 'ls: soem -> some' {
    correct_in_ctx ls soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls some'
}

@test 'head: soem -> some' {
    correct_in_ctx head soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head some'
}

@test 'tail: soem -> some' {
    correct_in_ctx tail soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail some'
}

@test 'sort: soem -> some' {
    correct_in_ctx sort soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort some'
}

@test 'uniq: soem -> some' {
    correct_in_ctx uniq soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq some'
}

@test 'wc: soem -> some' {
    correct_in_ctx wc soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc some'
}

@test 'tr: soem -> some' {
    correct_in_ctx tr soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr some'
}

@test 'cut: soem -> some' {
    correct_in_ctx cut soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut some'
}

@test 'diff: soem -> some' {
    correct_in_ctx diff soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff some'
}

@test 'print: osund -> sound' {
    correct_in_ctx print osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print sound'
}

@test 'cat: osund -> sound' {
    correct_in_ctx cat osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat sound'
}

@test 'grep: osund -> sound' {
    correct_in_ctx grep osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep sound'
}

@test 'sed: osund -> sound' {
    correct_in_ctx sed osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed sound'
}

@test 'awk: osund -> sound' {
    correct_in_ctx awk osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk sound'
}

@test 'man: osund -> sound' {
    correct_in_ctx man osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man sound'
}

@test 'ls: osund -> sound' {
    correct_in_ctx ls osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls sound'
}

@test 'head: osund -> sound' {
    correct_in_ctx head osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head sound'
}

@test 'tail: osund -> sound' {
    correct_in_ctx tail osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail sound'
}

@test 'sort: osund -> sound' {
    correct_in_ctx sort osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort sound'
}

@test 'uniq: osund -> sound' {
    correct_in_ctx uniq osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq sound'
}

@test 'wc: osund -> sound' {
    correct_in_ctx wc osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc sound'
}

@test 'tr: osund -> sound' {
    correct_in_ctx tr osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr sound'
}

@test 'cut: osund -> sound' {
    correct_in_ctx cut osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut sound'
}

@test 'diff: osund -> sound' {
    correct_in_ctx diff osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff sound'
}

@test 'print: sourcce -> source' {
    correct_in_ctx print sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print source'
}

@test 'cat: sourcce -> source' {
    correct_in_ctx cat sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat source'
}

@test 'grep: sourcce -> source' {
    correct_in_ctx grep sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep source'
}

@test 'sed: sourcce -> source' {
    correct_in_ctx sed sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed source'
}

@test 'awk: sourcce -> source' {
    correct_in_ctx awk sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk source'
}

@test 'man: sourcce -> source' {
    correct_in_ctx man sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man source'
}

@test 'ls: sourcce -> source' {
    correct_in_ctx ls sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls source'
}

@test 'head: sourcce -> source' {
    correct_in_ctx head sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head source'
}

@test 'tail: sourcce -> source' {
    correct_in_ctx tail sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail source'
}

@test 'sort: sourcce -> source' {
    correct_in_ctx sort sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort source'
}

@test 'uniq: sourcce -> source' {
    correct_in_ctx uniq sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq source'
}

@test 'wc: sourcce -> source' {
    correct_in_ctx wc sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc source'
}

@test 'tr: sourcce -> source' {
    correct_in_ctx tr sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr source'
}

@test 'cut: sourcce -> source' {
    correct_in_ctx cut sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut source'
}

@test 'diff: sourcce -> source' {
    correct_in_ctx diff sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff source'
}

@test 'print: spaec -> space' {
    correct_in_ctx print spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print space'
}

@test 'cat: spaec -> space' {
    correct_in_ctx cat spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat space'
}

@test 'grep: spaec -> space' {
    correct_in_ctx grep spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep space'
}

@test 'sed: spaec -> space' {
    correct_in_ctx sed spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed space'
}

@test 'awk: spaec -> space' {
    correct_in_ctx awk spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk space'
}

@test 'man: spaec -> space' {
    correct_in_ctx man spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man space'
}

@test 'ls: spaec -> space' {
    correct_in_ctx ls spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls space'
}

@test 'head: spaec -> space' {
    correct_in_ctx head spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head space'
}

@test 'tail: spaec -> space' {
    correct_in_ctx tail spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail space'
}

@test 'sort: spaec -> space' {
    correct_in_ctx sort spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort space'
}

@test 'uniq: spaec -> space' {
    correct_in_ctx uniq spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq space'
}

@test 'wc: spaec -> space' {
    correct_in_ctx wc spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc space'
}

@test 'tr: spaec -> space' {
    correct_in_ctx tr spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr space'
}

@test 'cut: spaec -> space' {
    correct_in_ctx cut spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut space'
}

@test 'diff: spaec -> space' {
    correct_in_ctx diff spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff space'
}

@test 'print: spellign -> spelling' {
    correct_in_ctx print spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print spelling'
}

@test 'cat: spellign -> spelling' {
    correct_in_ctx cat spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat spelling'
}

@test 'grep: spellign -> spelling' {
    correct_in_ctx grep spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep spelling'
}

@test 'sed: spellign -> spelling' {
    correct_in_ctx sed spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed spelling'
}

@test 'awk: spellign -> spelling' {
    correct_in_ctx awk spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk spelling'
}

@test 'man: spellign -> spelling' {
    correct_in_ctx man spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man spelling'
}

@test 'ls: spellign -> spelling' {
    correct_in_ctx ls spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls spelling'
}

@test 'head: spellign -> spelling' {
    correct_in_ctx head spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head spelling'
}

@test 'tail: spellign -> spelling' {
    correct_in_ctx tail spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail spelling'
}

@test 'sort: spellign -> spelling' {
    correct_in_ctx sort spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort spelling'
}

@test 'uniq: spellign -> spelling' {
    correct_in_ctx uniq spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq spelling'
}

@test 'wc: spellign -> spelling' {
    correct_in_ctx wc spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc spelling'
}

@test 'tr: spellign -> spelling' {
    correct_in_ctx tr spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr spelling'
}

@test 'cut: spellign -> spelling' {
    correct_in_ctx cut spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut spelling'
}

@test 'diff: spellign -> spelling' {
    correct_in_ctx diff spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff spelling'
}

@test 'print: sql -> SQL' {
    correct_in_ctx print sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print SQL'
}

@test 'cat: sql -> SQL' {
    correct_in_ctx cat sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat SQL'
}

@test 'grep: sql -> SQL' {
    correct_in_ctx grep sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep SQL'
}

@test 'sed: sql -> SQL' {
    correct_in_ctx sed sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed SQL'
}

@test 'awk: sql -> SQL' {
    correct_in_ctx awk sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk SQL'
}

@test 'man: sql -> SQL' {
    correct_in_ctx man sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man SQL'
}

@test 'ls: sql -> SQL' {
    correct_in_ctx ls sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls SQL'
}

@test 'head: sql -> SQL' {
    correct_in_ctx head sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head SQL'
}

@test 'tail: sql -> SQL' {
    correct_in_ctx tail sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail SQL'
}

@test 'sort: sql -> SQL' {
    correct_in_ctx sort sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort SQL'
}

@test 'uniq: sql -> SQL' {
    correct_in_ctx uniq sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq SQL'
}

@test 'wc: sql -> SQL' {
    correct_in_ctx wc sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc SQL'
}

@test 'tr: sql -> SQL' {
    correct_in_ctx tr sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr SQL'
}

@test 'cut: sql -> SQL' {
    correct_in_ctx cut sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut SQL'
}

@test 'diff: sql -> SQL' {
    correct_in_ctx diff sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff SQL'
}

@test 'print: ssh -> SSH' {
    correct_in_ctx print ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print SSH'
}

@test 'cat: ssh -> SSH' {
    correct_in_ctx cat ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat SSH'
}

@test 'grep: ssh -> SSH' {
    correct_in_ctx grep ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep SSH'
}

@test 'sed: ssh -> SSH' {
    correct_in_ctx sed ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed SSH'
}

@test 'awk: ssh -> SSH' {
    correct_in_ctx awk ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk SSH'
}

@test 'man: ssh -> SSH' {
    correct_in_ctx man ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man SSH'
}

@test 'ls: ssh -> SSH' {
    correct_in_ctx ls ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls SSH'
}

@test 'head: ssh -> SSH' {
    correct_in_ctx head ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head SSH'
}

@test 'tail: ssh -> SSH' {
    correct_in_ctx tail ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail SSH'
}

@test 'sort: ssh -> SSH' {
    correct_in_ctx sort ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort SSH'
}

@test 'uniq: ssh -> SSH' {
    correct_in_ctx uniq ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq SSH'
}

@test 'wc: ssh -> SSH' {
    correct_in_ctx wc ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc SSH'
}

@test 'tr: ssh -> SSH' {
    correct_in_ctx tr ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr SSH'
}

@test 'cut: ssh -> SSH' {
    correct_in_ctx cut ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut SSH'
}

@test 'diff: ssh -> SSH' {
    correct_in_ctx diff ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff SSH'
}

@test 'print: ssl -> SSL' {
    correct_in_ctx print ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print SSL'
}

@test 'cat: ssl -> SSL' {
    correct_in_ctx cat ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat SSL'
}

@test 'grep: ssl -> SSL' {
    correct_in_ctx grep ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep SSL'
}

@test 'sed: ssl -> SSL' {
    correct_in_ctx sed ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed SSL'
}

@test 'awk: ssl -> SSL' {
    correct_in_ctx awk ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk SSL'
}

@test 'man: ssl -> SSL' {
    correct_in_ctx man ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man SSL'
}

@test 'ls: ssl -> SSL' {
    correct_in_ctx ls ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls SSL'
}

@test 'head: ssl -> SSL' {
    correct_in_ctx head ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head SSL'
}

@test 'tail: ssl -> SSL' {
    correct_in_ctx tail ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail SSL'
}

@test 'sort: ssl -> SSL' {
    correct_in_ctx sort ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort SSL'
}

@test 'uniq: ssl -> SSL' {
    correct_in_ctx uniq ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq SSL'
}

@test 'wc: ssl -> SSL' {
    correct_in_ctx wc ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc SSL'
}

@test 'tr: ssl -> SSL' {
    correct_in_ctx tr ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr SSL'
}

@test 'cut: ssl -> SSL' {
    correct_in_ctx cut ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut SSL'
}

@test 'diff: ssl -> SSL' {
    correct_in_ctx diff ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff SSL'
}

@test 'print: std -> standard' {
    correct_in_ctx print std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print standard'
}

@test 'cat: std -> standard' {
    correct_in_ctx cat std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat standard'
}

@test 'grep: std -> standard' {
    correct_in_ctx grep std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep standard'
}

@test 'sed: std -> standard' {
    correct_in_ctx sed std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed standard'
}

@test 'awk: std -> standard' {
    correct_in_ctx awk std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk standard'
}

@test 'man: std -> standard' {
    correct_in_ctx man std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man standard'
}

@test 'ls: std -> standard' {
    correct_in_ctx ls std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls standard'
}

@test 'head: std -> standard' {
    correct_in_ctx head std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head standard'
}

@test 'tail: std -> standard' {
    correct_in_ctx tail std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail standard'
}

@test 'sort: std -> standard' {
    correct_in_ctx sort std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort standard'
}

@test 'uniq: std -> standard' {
    correct_in_ctx uniq std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq standard'
}

@test 'wc: std -> standard' {
    correct_in_ctx wc std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc standard'
}

@test 'tr: std -> standard' {
    correct_in_ctx tr std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr standard'
}

@test 'cut: std -> standard' {
    correct_in_ctx cut std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut standard'
}

@test 'diff: std -> standard' {
    correct_in_ctx diff std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff standard'
}

@test 'print: staet -> state' {
    correct_in_ctx print staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print state'
}

@test 'cat: staet -> state' {
    correct_in_ctx cat staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat state'
}

@test 'grep: staet -> state' {
    correct_in_ctx grep staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep state'
}

@test 'sed: staet -> state' {
    correct_in_ctx sed staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed state'
}

@test 'awk: staet -> state' {
    correct_in_ctx awk staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk state'
}

@test 'man: staet -> state' {
    correct_in_ctx man staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man state'
}

@test 'ls: staet -> state' {
    correct_in_ctx ls staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls state'
}

@test 'head: staet -> state' {
    correct_in_ctx head staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head state'
}

@test 'tail: staet -> state' {
    correct_in_ctx tail staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail state'
}

@test 'sort: staet -> state' {
    correct_in_ctx sort staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort state'
}

@test 'uniq: staet -> state' {
    correct_in_ctx uniq staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq state'
}

@test 'wc: staet -> state' {
    correct_in_ctx wc staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc state'
}

@test 'tr: staet -> state' {
    correct_in_ctx tr staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr state'
}

@test 'cut: staet -> state' {
    correct_in_ctx cut staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut state'
}

@test 'diff: staet -> state' {
    correct_in_ctx diff staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff state'
}

@test 'print: staets -> states' {
    correct_in_ctx print staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print states'
}

@test 'cat: staets -> states' {
    correct_in_ctx cat staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat states'
}

@test 'grep: staets -> states' {
    correct_in_ctx grep staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep states'
}

@test 'sed: staets -> states' {
    correct_in_ctx sed staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed states'
}

@test 'awk: staets -> states' {
    correct_in_ctx awk staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk states'
}

@test 'man: staets -> states' {
    correct_in_ctx man staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man states'
}

@test 'ls: staets -> states' {
    correct_in_ctx ls staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls states'
}

@test 'head: staets -> states' {
    correct_in_ctx head staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head states'
}

@test 'tail: staets -> states' {
    correct_in_ctx tail staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail states'
}

@test 'sort: staets -> states' {
    correct_in_ctx sort staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort states'
}

@test 'uniq: staets -> states' {
    correct_in_ctx uniq staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq states'
}

@test 'wc: staets -> states' {
    correct_in_ctx wc staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc states'
}

@test 'tr: staets -> states' {
    correct_in_ctx tr staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr states'
}

@test 'cut: staets -> states' {
    correct_in_ctx cut staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut states'
}

@test 'diff: staets -> states' {
    correct_in_ctx diff staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff states'
}

@test 'print: tsore -> store' {
    correct_in_ctx print tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print store'
}

@test 'cat: tsore -> store' {
    correct_in_ctx cat tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat store'
}

@test 'grep: tsore -> store' {
    correct_in_ctx grep tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep store'
}

@test 'sed: tsore -> store' {
    correct_in_ctx sed tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed store'
}

@test 'awk: tsore -> store' {
    correct_in_ctx awk tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk store'
}

@test 'man: tsore -> store' {
    correct_in_ctx man tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man store'
}

@test 'ls: tsore -> store' {
    correct_in_ctx ls tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls store'
}

@test 'head: tsore -> store' {
    correct_in_ctx head tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head store'
}

@test 'tail: tsore -> store' {
    correct_in_ctx tail tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail store'
}

@test 'sort: tsore -> store' {
    correct_in_ctx sort tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort store'
}

@test 'uniq: tsore -> store' {
    correct_in_ctx uniq tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq store'
}

@test 'wc: tsore -> store' {
    correct_in_ctx wc tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc store'
}

@test 'tr: tsore -> store' {
    correct_in_ctx tr tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr store'
}

@test 'cut: tsore -> store' {
    correct_in_ctx cut tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut store'
}

@test 'diff: tsore -> store' {
    correct_in_ctx diff tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff store'
}

@test 'print: st8 -> straight' {
    correct_in_ctx print st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print straight'
}

@test 'cat: st8 -> straight' {
    correct_in_ctx cat st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat straight'
}

@test 'grep: st8 -> straight' {
    correct_in_ctx grep st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep straight'
}

@test 'sed: st8 -> straight' {
    correct_in_ctx sed st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed straight'
}

@test 'awk: st8 -> straight' {
    correct_in_ctx awk st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk straight'
}

@test 'man: st8 -> straight' {
    correct_in_ctx man st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man straight'
}

@test 'ls: st8 -> straight' {
    correct_in_ctx ls st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls straight'
}

@test 'head: st8 -> straight' {
    correct_in_ctx head st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head straight'
}

@test 'tail: st8 -> straight' {
    correct_in_ctx tail st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail straight'
}

@test 'sort: st8 -> straight' {
    correct_in_ctx sort st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort straight'
}

@test 'uniq: st8 -> straight' {
    correct_in_ctx uniq st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq straight'
}

@test 'wc: st8 -> straight' {
    correct_in_ctx wc st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc straight'
}

@test 'tr: st8 -> straight' {
    correct_in_ctx tr st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr straight'
}

@test 'cut: st8 -> straight' {
    correct_in_ctx cut st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut straight'
}

@test 'diff: st8 -> straight' {
    correct_in_ctx diff st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff straight'
}

@test 'print: stirng -> string' {
    correct_in_ctx print stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print string'
}

@test 'cat: stirng -> string' {
    correct_in_ctx cat stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat string'
}

@test 'grep: stirng -> string' {
    correct_in_ctx grep stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep string'
}

@test 'sed: stirng -> string' {
    correct_in_ctx sed stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed string'
}

@test 'awk: stirng -> string' {
    correct_in_ctx awk stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk string'
}

@test 'man: stirng -> string' {
    correct_in_ctx man stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man string'
}

@test 'ls: stirng -> string' {
    correct_in_ctx ls stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls string'
}

@test 'head: stirng -> string' {
    correct_in_ctx head stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head string'
}

@test 'tail: stirng -> string' {
    correct_in_ctx tail stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail string'
}

@test 'sort: stirng -> string' {
    correct_in_ctx sort stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort string'
}

@test 'uniq: stirng -> string' {
    correct_in_ctx uniq stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq string'
}

@test 'wc: stirng -> string' {
    correct_in_ctx wc stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc string'
}

@test 'tr: stirng -> string' {
    correct_in_ctx tr stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr string'
}

@test 'cut: stirng -> string' {
    correct_in_ctx cut stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut string'
}

@test 'diff: stirng -> string' {
    correct_in_ctx diff stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff string'
}

@test 'print: sub -> substitute' {
    correct_in_ctx print sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print substitute'
}

@test 'cat: sub -> substitute' {
    correct_in_ctx cat sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat substitute'
}

@test 'grep: sub -> substitute' {
    correct_in_ctx grep sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep substitute'
}

@test 'sed: sub -> substitute' {
    correct_in_ctx sed sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed substitute'
}

@test 'awk: sub -> substitute' {
    correct_in_ctx awk sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk substitute'
}

@test 'man: sub -> substitute' {
    correct_in_ctx man sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man substitute'
}

@test 'ls: sub -> substitute' {
    correct_in_ctx ls sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls substitute'
}

@test 'head: sub -> substitute' {
    correct_in_ctx head sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head substitute'
}

@test 'tail: sub -> substitute' {
    correct_in_ctx tail sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail substitute'
}

@test 'sort: sub -> substitute' {
    correct_in_ctx sort sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort substitute'
}

@test 'uniq: sub -> substitute' {
    correct_in_ctx uniq sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq substitute'
}

@test 'wc: sub -> substitute' {
    correct_in_ctx wc sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc substitute'
}

@test 'tr: sub -> substitute' {
    correct_in_ctx tr sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr substitute'
}

@test 'cut: sub -> substitute' {
    correct_in_ctx cut sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut substitute'
}

@test 'diff: sub -> substitute' {
    correct_in_ctx diff sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff substitute'
}

@test 'print: usdo -> sudo' {
    correct_in_ctx print usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print sudo'
}

@test 'cat: usdo -> sudo' {
    correct_in_ctx cat usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat sudo'
}

@test 'grep: usdo -> sudo' {
    correct_in_ctx grep usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep sudo'
}

@test 'sed: usdo -> sudo' {
    correct_in_ctx sed usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed sudo'
}

@test 'awk: usdo -> sudo' {
    correct_in_ctx awk usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk sudo'
}

@test 'man: usdo -> sudo' {
    correct_in_ctx man usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man sudo'
}

@test 'ls: usdo -> sudo' {
    correct_in_ctx ls usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls sudo'
}

@test 'head: usdo -> sudo' {
    correct_in_ctx head usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head sudo'
}

@test 'tail: usdo -> sudo' {
    correct_in_ctx tail usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail sudo'
}

@test 'sort: usdo -> sudo' {
    correct_in_ctx sort usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort sudo'
}

@test 'uniq: usdo -> sudo' {
    correct_in_ctx uniq usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq sudo'
}

@test 'wc: usdo -> sudo' {
    correct_in_ctx wc usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc sudo'
}

@test 'tr: usdo -> sudo' {
    correct_in_ctx tr usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr sudo'
}

@test 'cut: usdo -> sudo' {
    correct_in_ctx cut usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut sudo'
}

@test 'diff: usdo -> sudo' {
    correct_in_ctx diff usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff sudo'
}

@test 'print: sysv -> SYSV' {
    correct_in_ctx print sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print SYSV'
}

@test 'cat: sysv -> SYSV' {
    correct_in_ctx cat sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat SYSV'
}

@test 'grep: sysv -> SYSV' {
    correct_in_ctx grep sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep SYSV'
}

@test 'sed: sysv -> SYSV' {
    correct_in_ctx sed sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed SYSV'
}

@test 'awk: sysv -> SYSV' {
    correct_in_ctx awk sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk SYSV'
}

@test 'man: sysv -> SYSV' {
    correct_in_ctx man sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man SYSV'
}

@test 'ls: sysv -> SYSV' {
    correct_in_ctx ls sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls SYSV'
}

@test 'head: sysv -> SYSV' {
    correct_in_ctx head sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head SYSV'
}

@test 'tail: sysv -> SYSV' {
    correct_in_ctx tail sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail SYSV'
}

@test 'sort: sysv -> SYSV' {
    correct_in_ctx sort sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort SYSV'
}

@test 'uniq: sysv -> SYSV' {
    correct_in_ctx uniq sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq SYSV'
}

@test 'wc: sysv -> SYSV' {
    correct_in_ctx wc sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc SYSV'
}

@test 'tr: sysv -> SYSV' {
    correct_in_ctx tr sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr SYSV'
}

@test 'cut: sysv -> SYSV' {
    correct_in_ctx cut sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut SYSV'
}

@test 'diff: sysv -> SYSV' {
    correct_in_ctx diff sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff SYSV'
}

@test 'print: tahn -> than' {
    correct_in_ctx print tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print than'
}

@test 'cat: tahn -> than' {
    correct_in_ctx cat tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat than'
}

@test 'grep: tahn -> than' {
    correct_in_ctx grep tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep than'
}

@test 'sed: tahn -> than' {
    correct_in_ctx sed tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed than'
}

@test 'awk: tahn -> than' {
    correct_in_ctx awk tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk than'
}

@test 'man: tahn -> than' {
    correct_in_ctx man tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man than'
}

@test 'ls: tahn -> than' {
    correct_in_ctx ls tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls than'
}

@test 'head: tahn -> than' {
    correct_in_ctx head tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head than'
}

@test 'tail: tahn -> than' {
    correct_in_ctx tail tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail than'
}

@test 'sort: tahn -> than' {
    correct_in_ctx sort tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort than'
}

@test 'uniq: tahn -> than' {
    correct_in_ctx uniq tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq than'
}

@test 'wc: tahn -> than' {
    correct_in_ctx wc tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc than'
}

@test 'tr: tahn -> than' {
    correct_in_ctx tr tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr than'
}

@test 'cut: tahn -> than' {
    correct_in_ctx cut tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut than'
}

@test 'diff: tahn -> than' {
    correct_in_ctx diff tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff than'
}

@test 'print: taht -> that' {
    correct_in_ctx print taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print that'
}

@test 'cat: taht -> that' {
    correct_in_ctx cat taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat that'
}

@test 'grep: taht -> that' {
    correct_in_ctx grep taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep that'
}

@test 'sed: taht -> that' {
    correct_in_ctx sed taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed that'
}

@test 'awk: taht -> that' {
    correct_in_ctx awk taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk that'
}

@test 'man: taht -> that' {
    correct_in_ctx man taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man that'
}

@test 'ls: taht -> that' {
    correct_in_ctx ls taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls that'
}

@test 'head: taht -> that' {
    correct_in_ctx head taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head that'
}

@test 'tail: taht -> that' {
    correct_in_ctx tail taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail that'
}

@test 'sort: taht -> that' {
    correct_in_ctx sort taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort that'
}

@test 'uniq: taht -> that' {
    correct_in_ctx uniq taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq that'
}

@test 'wc: taht -> that' {
    correct_in_ctx wc taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc that'
}

@test 'tr: taht -> that' {
    correct_in_ctx tr taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr that'
}

@test 'cut: taht -> that' {
    correct_in_ctx cut taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut that'
}

@test 'diff: taht -> that' {
    correct_in_ctx diff taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff that'
}

@test 'print: teh -> the' {
    correct_in_ctx print teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print the'
}

@test 'cat: teh -> the' {
    correct_in_ctx cat teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat the'
}

@test 'grep: teh -> the' {
    correct_in_ctx grep teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep the'
}

@test 'sed: teh -> the' {
    correct_in_ctx sed teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed the'
}

@test 'awk: teh -> the' {
    correct_in_ctx awk teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk the'
}

@test 'man: teh -> the' {
    correct_in_ctx man teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man the'
}

@test 'ls: teh -> the' {
    correct_in_ctx ls teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls the'
}

@test 'head: teh -> the' {
    correct_in_ctx head teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head the'
}

@test 'tail: teh -> the' {
    correct_in_ctx tail teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail the'
}

@test 'sort: teh -> the' {
    correct_in_ctx sort teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort the'
}

@test 'uniq: teh -> the' {
    correct_in_ctx uniq teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq the'
}

@test 'wc: teh -> the' {
    correct_in_ctx wc teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc the'
}

@test 'tr: teh -> the' {
    correct_in_ctx tr teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr the'
}

@test 'cut: teh -> the' {
    correct_in_ctx cut teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut the'
}

@test 'diff: teh -> the' {
    correct_in_ctx diff teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff the'
}

@test 'print: thier -> their' {
    correct_in_ctx print thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print their'
}

@test 'cat: thier -> their' {
    correct_in_ctx cat thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat their'
}

@test 'grep: thier -> their' {
    correct_in_ctx grep thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep their'
}

@test 'sed: thier -> their' {
    correct_in_ctx sed thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed their'
}

@test 'awk: thier -> their' {
    correct_in_ctx awk thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk their'
}

@test 'man: thier -> their' {
    correct_in_ctx man thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man their'
}

@test 'ls: thier -> their' {
    correct_in_ctx ls thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls their'
}

@test 'head: thier -> their' {
    correct_in_ctx head thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head their'
}

@test 'tail: thier -> their' {
    correct_in_ctx tail thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail their'
}

@test 'sort: thier -> their' {
    correct_in_ctx sort thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort their'
}

@test 'uniq: thier -> their' {
    correct_in_ctx uniq thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq their'
}

@test 'wc: thier -> their' {
    correct_in_ctx wc thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc their'
}

@test 'tr: thier -> their' {
    correct_in_ctx tr thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr their'
}

@test 'cut: thier -> their' {
    correct_in_ctx cut thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut their'
}

@test 'diff: thier -> their' {
    correct_in_ctx diff thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff their'
}

@test 'print: tehn -> then' {
    correct_in_ctx print tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print then'
}

@test 'cat: tehn -> then' {
    correct_in_ctx cat tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat then'
}

@test 'grep: tehn -> then' {
    correct_in_ctx grep tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep then'
}

@test 'sed: tehn -> then' {
    correct_in_ctx sed tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed then'
}

@test 'awk: tehn -> then' {
    correct_in_ctx awk tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk then'
}

@test 'man: tehn -> then' {
    correct_in_ctx man tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man then'
}

@test 'ls: tehn -> then' {
    correct_in_ctx ls tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls then'
}

@test 'head: tehn -> then' {
    correct_in_ctx head tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head then'
}

@test 'tail: tehn -> then' {
    correct_in_ctx tail tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail then'
}

@test 'sort: tehn -> then' {
    correct_in_ctx sort tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort then'
}

@test 'uniq: tehn -> then' {
    correct_in_ctx uniq tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq then'
}

@test 'wc: tehn -> then' {
    correct_in_ctx wc tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc then'
}

@test 'tr: tehn -> then' {
    correct_in_ctx tr tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr then'
}

@test 'cut: tehn -> then' {
    correct_in_ctx cut tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut then'
}

@test 'diff: tehn -> then' {
    correct_in_ctx diff tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff then'
}

@test 'print: tehy -> they' {
    correct_in_ctx print tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print they'
}

@test 'cat: tehy -> they' {
    correct_in_ctx cat tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat they'
}

@test 'grep: tehy -> they' {
    correct_in_ctx grep tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep they'
}

@test 'sed: tehy -> they' {
    correct_in_ctx sed tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed they'
}

@test 'awk: tehy -> they' {
    correct_in_ctx awk tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk they'
}

@test 'man: tehy -> they' {
    correct_in_ctx man tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man they'
}

@test 'ls: tehy -> they' {
    correct_in_ctx ls tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls they'
}

@test 'head: tehy -> they' {
    correct_in_ctx head tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head they'
}

@test 'tail: tehy -> they' {
    correct_in_ctx tail tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail they'
}

@test 'sort: tehy -> they' {
    correct_in_ctx sort tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort they'
}

@test 'uniq: tehy -> they' {
    correct_in_ctx uniq tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq they'
}

@test 'wc: tehy -> they' {
    correct_in_ctx wc tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc they'
}

@test 'tr: tehy -> they' {
    correct_in_ctx tr tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr they'
}

@test 'cut: tehy -> they' {
    correct_in_ctx cut tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut they'
}

@test 'diff: tehy -> they' {
    correct_in_ctx diff tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff they'
}

@test 'print: tihs -> this' {
    correct_in_ctx print tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print this'
}

@test 'cat: tihs -> this' {
    correct_in_ctx cat tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat this'
}

@test 'grep: tihs -> this' {
    correct_in_ctx grep tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep this'
}

@test 'sed: tihs -> this' {
    correct_in_ctx sed tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed this'
}

@test 'awk: tihs -> this' {
    correct_in_ctx awk tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk this'
}

@test 'man: tihs -> this' {
    correct_in_ctx man tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man this'
}

@test 'ls: tihs -> this' {
    correct_in_ctx ls tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls this'
}

@test 'head: tihs -> this' {
    correct_in_ctx head tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head this'
}

@test 'tail: tihs -> this' {
    correct_in_ctx tail tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail this'
}

@test 'sort: tihs -> this' {
    correct_in_ctx sort tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort this'
}

@test 'uniq: tihs -> this' {
    correct_in_ctx uniq tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq this'
}

@test 'wc: tihs -> this' {
    correct_in_ctx wc tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc this'
}

@test 'tr: tihs -> this' {
    correct_in_ctx tr tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr this'
}

@test 'cut: tihs -> this' {
    correct_in_ctx cut tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut this'
}

@test 'diff: tihs -> this' {
    correct_in_ctx diff tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff this'
}

@test 'print: thru -> through' {
    correct_in_ctx print thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print through'
}

@test 'cat: thru -> through' {
    correct_in_ctx cat thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat through'
}

@test 'grep: thru -> through' {
    correct_in_ctx grep thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep through'
}

@test 'sed: thru -> through' {
    correct_in_ctx sed thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed through'
}

@test 'awk: thru -> through' {
    correct_in_ctx awk thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk through'
}

@test 'man: thru -> through' {
    correct_in_ctx man thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man through'
}

@test 'ls: thru -> through' {
    correct_in_ctx ls thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls through'
}

@test 'head: thru -> through' {
    correct_in_ctx head thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head through'
}

@test 'tail: thru -> through' {
    correct_in_ctx tail thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail through'
}

@test 'sort: thru -> through' {
    correct_in_ctx sort thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort through'
}

@test 'uniq: thru -> through' {
    correct_in_ctx uniq thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq through'
}

@test 'wc: thru -> through' {
    correct_in_ctx wc thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc through'
}

@test 'tr: thru -> through' {
    correct_in_ctx tr thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr through'
}

@test 'cut: thru -> through' {
    correct_in_ctx cut thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut through'
}

@test 'diff: thru -> through' {
    correct_in_ctx diff thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff through'
}

@test 'print: tiem -> time' {
    correct_in_ctx print tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print time'
}

@test 'cat: tiem -> time' {
    correct_in_ctx cat tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat time'
}

@test 'grep: tiem -> time' {
    correct_in_ctx grep tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep time'
}

@test 'sed: tiem -> time' {
    correct_in_ctx sed tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed time'
}

@test 'awk: tiem -> time' {
    correct_in_ctx awk tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk time'
}

@test 'man: tiem -> time' {
    correct_in_ctx man tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man time'
}

@test 'ls: tiem -> time' {
    correct_in_ctx ls tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls time'
}

@test 'head: tiem -> time' {
    correct_in_ctx head tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head time'
}

@test 'tail: tiem -> time' {
    correct_in_ctx tail tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail time'
}

@test 'sort: tiem -> time' {
    correct_in_ctx sort tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort time'
}

@test 'uniq: tiem -> time' {
    correct_in_ctx uniq tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq time'
}

@test 'wc: tiem -> time' {
    correct_in_ctx wc tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc time'
}

@test 'tr: tiem -> time' {
    correct_in_ctx tr tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr time'
}

@test 'cut: tiem -> time' {
    correct_in_ctx cut tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut time'
}

@test 'diff: tiem -> time' {
    correct_in_ctx diff tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff time'
}

@test 'print: tls -> TLS' {
    correct_in_ctx print tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print TLS'
}

@test 'cat: tls -> TLS' {
    correct_in_ctx cat tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat TLS'
}

@test 'grep: tls -> TLS' {
    correct_in_ctx grep tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep TLS'
}

@test 'sed: tls -> TLS' {
    correct_in_ctx sed tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed TLS'
}

@test 'awk: tls -> TLS' {
    correct_in_ctx awk tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk TLS'
}

@test 'man: tls -> TLS' {
    correct_in_ctx man tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man TLS'
}

@test 'ls: tls -> TLS' {
    correct_in_ctx ls tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls TLS'
}

@test 'head: tls -> TLS' {
    correct_in_ctx head tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head TLS'
}

@test 'tail: tls -> TLS' {
    correct_in_ctx tail tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail TLS'
}

@test 'sort: tls -> TLS' {
    correct_in_ctx sort tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort TLS'
}

@test 'uniq: tls -> TLS' {
    correct_in_ctx uniq tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq TLS'
}

@test 'wc: tls -> TLS' {
    correct_in_ctx wc tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc TLS'
}

@test 'tr: tls -> TLS' {
    correct_in_ctx tr tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr TLS'
}

@test 'cut: tls -> TLS' {
    correct_in_ctx cut tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut TLS'
}

@test 'diff: tls -> TLS' {
    correct_in_ctx diff tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff TLS'
}

@test 'print: ot -> to' {
    correct_in_ctx print ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print to'
}

@test 'cat: ot -> to' {
    correct_in_ctx cat ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat to'
}

@test 'grep: ot -> to' {
    correct_in_ctx grep ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep to'
}

@test 'sed: ot -> to' {
    correct_in_ctx sed ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed to'
}

@test 'awk: ot -> to' {
    correct_in_ctx awk ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk to'
}

@test 'man: ot -> to' {
    correct_in_ctx man ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man to'
}

@test 'ls: ot -> to' {
    correct_in_ctx ls ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls to'
}

@test 'head: ot -> to' {
    correct_in_ctx head ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head to'
}

@test 'tail: ot -> to' {
    correct_in_ctx tail ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail to'
}

@test 'sort: ot -> to' {
    correct_in_ctx sort ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort to'
}

@test 'uniq: ot -> to' {
    correct_in_ctx uniq ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq to'
}

@test 'wc: ot -> to' {
    correct_in_ctx wc ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc to'
}

@test 'tr: ot -> to' {
    correct_in_ctx tr ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr to'
}

@test 'cut: ot -> to' {
    correct_in_ctx cut ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut to'
}

@test 'diff: ot -> to' {
    correct_in_ctx diff ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff to'
}

@test 'print: tmr -> tomorrow' {
    correct_in_ctx print tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print tomorrow'
}

@test 'cat: tmr -> tomorrow' {
    correct_in_ctx cat tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat tomorrow'
}

@test 'grep: tmr -> tomorrow' {
    correct_in_ctx grep tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep tomorrow'
}

@test 'sed: tmr -> tomorrow' {
    correct_in_ctx sed tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed tomorrow'
}

@test 'awk: tmr -> tomorrow' {
    correct_in_ctx awk tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk tomorrow'
}

@test 'man: tmr -> tomorrow' {
    correct_in_ctx man tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man tomorrow'
}

@test 'ls: tmr -> tomorrow' {
    correct_in_ctx ls tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls tomorrow'
}

@test 'head: tmr -> tomorrow' {
    correct_in_ctx head tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head tomorrow'
}

@test 'tail: tmr -> tomorrow' {
    correct_in_ctx tail tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail tomorrow'
}

@test 'sort: tmr -> tomorrow' {
    correct_in_ctx sort tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort tomorrow'
}

@test 'uniq: tmr -> tomorrow' {
    correct_in_ctx uniq tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq tomorrow'
}

@test 'wc: tmr -> tomorrow' {
    correct_in_ctx wc tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc tomorrow'
}

@test 'tr: tmr -> tomorrow' {
    correct_in_ctx tr tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr tomorrow'
}

@test 'cut: tmr -> tomorrow' {
    correct_in_ctx cut tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut tomorrow'
}

@test 'diff: tmr -> tomorrow' {
    correct_in_ctx diff tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff tomorrow'
}

@test 'print: xfer -> transfer' {
    correct_in_ctx print xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print transfer'
}

@test 'cat: xfer -> transfer' {
    correct_in_ctx cat xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat transfer'
}

@test 'grep: xfer -> transfer' {
    correct_in_ctx grep xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep transfer'
}

@test 'sed: xfer -> transfer' {
    correct_in_ctx sed xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed transfer'
}

@test 'awk: xfer -> transfer' {
    correct_in_ctx awk xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk transfer'
}

@test 'man: xfer -> transfer' {
    correct_in_ctx man xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man transfer'
}

@test 'ls: xfer -> transfer' {
    correct_in_ctx ls xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls transfer'
}

@test 'head: xfer -> transfer' {
    correct_in_ctx head xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head transfer'
}

@test 'tail: xfer -> transfer' {
    correct_in_ctx tail xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail transfer'
}

@test 'sort: xfer -> transfer' {
    correct_in_ctx sort xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort transfer'
}

@test 'uniq: xfer -> transfer' {
    correct_in_ctx uniq xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq transfer'
}

@test 'wc: xfer -> transfer' {
    correct_in_ctx wc xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc transfer'
}

@test 'tr: xfer -> transfer' {
    correct_in_ctx tr xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr transfer'
}

@test 'cut: xfer -> transfer' {
    correct_in_ctx cut xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut transfer'
}

@test 'diff: xfer -> transfer' {
    correct_in_ctx diff xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff transfer'
}

@test 'print: treu -> true' {
    correct_in_ctx print treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print true'
}

@test 'cat: treu -> true' {
    correct_in_ctx cat treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat true'
}

@test 'grep: treu -> true' {
    correct_in_ctx grep treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep true'
}

@test 'sed: treu -> true' {
    correct_in_ctx sed treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed true'
}

@test 'awk: treu -> true' {
    correct_in_ctx awk treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk true'
}

@test 'man: treu -> true' {
    correct_in_ctx man treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man true'
}

@test 'ls: treu -> true' {
    correct_in_ctx ls treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls true'
}

@test 'head: treu -> true' {
    correct_in_ctx head treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head true'
}

@test 'tail: treu -> true' {
    correct_in_ctx tail treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail true'
}

@test 'sort: treu -> true' {
    correct_in_ctx sort treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort true'
}

@test 'uniq: treu -> true' {
    correct_in_ctx uniq treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq true'
}

@test 'wc: treu -> true' {
    correct_in_ctx wc treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc true'
}

@test 'tr: treu -> true' {
    correct_in_ctx tr treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr true'
}

@test 'cut: treu -> true' {
    correct_in_ctx cut treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut true'
}

@test 'diff: treu -> true' {
    correct_in_ctx diff treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff true'
}

@test 'print: tunr -> turn' {
    correct_in_ctx print tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print turn'
}

@test 'cat: tunr -> turn' {
    correct_in_ctx cat tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat turn'
}

@test 'grep: tunr -> turn' {
    correct_in_ctx grep tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep turn'
}

@test 'sed: tunr -> turn' {
    correct_in_ctx sed tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed turn'
}

@test 'awk: tunr -> turn' {
    correct_in_ctx awk tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk turn'
}

@test 'man: tunr -> turn' {
    correct_in_ctx man tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man turn'
}

@test 'ls: tunr -> turn' {
    correct_in_ctx ls tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls turn'
}

@test 'head: tunr -> turn' {
    correct_in_ctx head tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head turn'
}

@test 'tail: tunr -> turn' {
    correct_in_ctx tail tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail turn'
}

@test 'sort: tunr -> turn' {
    correct_in_ctx sort tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort turn'
}

@test 'uniq: tunr -> turn' {
    correct_in_ctx uniq tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq turn'
}

@test 'wc: tunr -> turn' {
    correct_in_ctx wc tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc turn'
}

@test 'tr: tunr -> turn' {
    correct_in_ctx tr tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr turn'
}

@test 'cut: tunr -> turn' {
    correct_in_ctx cut tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut turn'
}

@test 'diff: tunr -> turn' {
    correct_in_ctx diff tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff turn'
}

@test 'print: uefi -> UEFI' {
    correct_in_ctx print uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print UEFI'
}

@test 'cat: uefi -> UEFI' {
    correct_in_ctx cat uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat UEFI'
}

@test 'grep: uefi -> UEFI' {
    correct_in_ctx grep uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep UEFI'
}

@test 'sed: uefi -> UEFI' {
    correct_in_ctx sed uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed UEFI'
}

@test 'awk: uefi -> UEFI' {
    correct_in_ctx awk uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk UEFI'
}

@test 'man: uefi -> UEFI' {
    correct_in_ctx man uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man UEFI'
}

@test 'ls: uefi -> UEFI' {
    correct_in_ctx ls uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls UEFI'
}

@test 'head: uefi -> UEFI' {
    correct_in_ctx head uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head UEFI'
}

@test 'tail: uefi -> UEFI' {
    correct_in_ctx tail uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail UEFI'
}

@test 'sort: uefi -> UEFI' {
    correct_in_ctx sort uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort UEFI'
}

@test 'uniq: uefi -> UEFI' {
    correct_in_ctx uniq uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq UEFI'
}

@test 'wc: uefi -> UEFI' {
    correct_in_ctx wc uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc UEFI'
}

@test 'tr: uefi -> UEFI' {
    correct_in_ctx tr uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr UEFI'
}

@test 'cut: uefi -> UEFI' {
    correct_in_ctx cut uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut UEFI'
}

@test 'diff: uefi -> UEFI' {
    correct_in_ctx diff uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff UEFI'
}

@test 'print: uner -> under' {
    correct_in_ctx print uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print under'
}

@test 'cat: uner -> under' {
    correct_in_ctx cat uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat under'
}

@test 'grep: uner -> under' {
    correct_in_ctx grep uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep under'
}

@test 'sed: uner -> under' {
    correct_in_ctx sed uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed under'
}

@test 'awk: uner -> under' {
    correct_in_ctx awk uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk under'
}

@test 'man: uner -> under' {
    correct_in_ctx man uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man under'
}

@test 'ls: uner -> under' {
    correct_in_ctx ls uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls under'
}

@test 'head: uner -> under' {
    correct_in_ctx head uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head under'
}

@test 'tail: uner -> under' {
    correct_in_ctx tail uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail under'
}

@test 'sort: uner -> under' {
    correct_in_ctx sort uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort under'
}

@test 'uniq: uner -> under' {
    correct_in_ctx uniq uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq under'
}

@test 'wc: uner -> under' {
    correct_in_ctx wc uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc under'
}

@test 'tr: uner -> under' {
    correct_in_ctx tr uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr under'
}

@test 'cut: uner -> under' {
    correct_in_ctx cut uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut under'
}

@test 'diff: uner -> under' {
    correct_in_ctx diff uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff under'
}

@test 'print: unix -> Unix' {
    correct_in_ctx print unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print Unix'
}

@test 'cat: unix -> Unix' {
    correct_in_ctx cat unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat Unix'
}

@test 'grep: unix -> Unix' {
    correct_in_ctx grep unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep Unix'
}

@test 'sed: unix -> Unix' {
    correct_in_ctx sed unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed Unix'
}

@test 'awk: unix -> Unix' {
    correct_in_ctx awk unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk Unix'
}

@test 'man: unix -> Unix' {
    correct_in_ctx man unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man Unix'
}

@test 'ls: unix -> Unix' {
    correct_in_ctx ls unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls Unix'
}

@test 'head: unix -> Unix' {
    correct_in_ctx head unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head Unix'
}

@test 'tail: unix -> Unix' {
    correct_in_ctx tail unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail Unix'
}

@test 'sort: unix -> Unix' {
    correct_in_ctx sort unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort Unix'
}

@test 'uniq: unix -> Unix' {
    correct_in_ctx uniq unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq Unix'
}

@test 'wc: unix -> Unix' {
    correct_in_ctx wc unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc Unix'
}

@test 'tr: unix -> Unix' {
    correct_in_ctx tr unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr Unix'
}

@test 'cut: unix -> Unix' {
    correct_in_ctx cut unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut Unix'
}

@test 'diff: unix -> Unix' {
    correct_in_ctx diff unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff Unix'
}

@test 'print: updatet -> update' {
    correct_in_ctx print updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print update'
}

@test 'cat: updatet -> update' {
    correct_in_ctx cat updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat update'
}

@test 'grep: updatet -> update' {
    correct_in_ctx grep updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep update'
}

@test 'sed: updatet -> update' {
    correct_in_ctx sed updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed update'
}

@test 'awk: updatet -> update' {
    correct_in_ctx awk updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk update'
}

@test 'man: updatet -> update' {
    correct_in_ctx man updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man update'
}

@test 'ls: updatet -> update' {
    correct_in_ctx ls updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls update'
}

@test 'head: updatet -> update' {
    correct_in_ctx head updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head update'
}

@test 'tail: updatet -> update' {
    correct_in_ctx tail updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail update'
}

@test 'sort: updatet -> update' {
    correct_in_ctx sort updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort update'
}

@test 'uniq: updatet -> update' {
    correct_in_ctx uniq updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq update'
}

@test 'wc: updatet -> update' {
    correct_in_ctx wc updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc update'
}

@test 'tr: updatet -> update' {
    correct_in_ctx tr updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr update'
}

@test 'cut: updatet -> update' {
    correct_in_ctx cut updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut update'
}

@test 'diff: updatet -> update' {
    correct_in_ctx diff updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff update'
}

@test 'print: uri -> URI' {
    correct_in_ctx print uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print URI'
}

@test 'cat: uri -> URI' {
    correct_in_ctx cat uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat URI'
}

@test 'grep: uri -> URI' {
    correct_in_ctx grep uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep URI'
}

@test 'sed: uri -> URI' {
    correct_in_ctx sed uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed URI'
}

@test 'awk: uri -> URI' {
    correct_in_ctx awk uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk URI'
}

@test 'man: uri -> URI' {
    correct_in_ctx man uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man URI'
}

@test 'ls: uri -> URI' {
    correct_in_ctx ls uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls URI'
}

@test 'head: uri -> URI' {
    correct_in_ctx head uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head URI'
}

@test 'tail: uri -> URI' {
    correct_in_ctx tail uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail URI'
}

@test 'sort: uri -> URI' {
    correct_in_ctx sort uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort URI'
}

@test 'uniq: uri -> URI' {
    correct_in_ctx uniq uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq URI'
}

@test 'wc: uri -> URI' {
    correct_in_ctx wc uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc URI'
}

@test 'tr: uri -> URI' {
    correct_in_ctx tr uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr URI'
}

@test 'cut: uri -> URI' {
    correct_in_ctx cut uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut URI'
}

@test 'diff: uri -> URI' {
    correct_in_ctx diff uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff URI'
}

@test 'print: url -> URL' {
    correct_in_ctx print url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print URL'
}

@test 'cat: url -> URL' {
    correct_in_ctx cat url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat URL'
}

@test 'grep: url -> URL' {
    correct_in_ctx grep url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep URL'
}

@test 'sed: url -> URL' {
    correct_in_ctx sed url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed URL'
}

@test 'awk: url -> URL' {
    correct_in_ctx awk url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk URL'
}

@test 'man: url -> URL' {
    correct_in_ctx man url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man URL'
}

@test 'ls: url -> URL' {
    correct_in_ctx ls url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls URL'
}

@test 'head: url -> URL' {
    correct_in_ctx head url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head URL'
}

@test 'tail: url -> URL' {
    correct_in_ctx tail url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail URL'
}

@test 'sort: url -> URL' {
    correct_in_ctx sort url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort URL'
}

@test 'uniq: url -> URL' {
    correct_in_ctx uniq url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq URL'
}

@test 'wc: url -> URL' {
    correct_in_ctx wc url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc URL'
}

@test 'tr: url -> URL' {
    correct_in_ctx tr url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr URL'
}

@test 'cut: url -> URL' {
    correct_in_ctx cut url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut URL'
}

@test 'diff: url -> URL' {
    correct_in_ctx diff url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff URL'
}

@test 'print: usb -> USB' {
    correct_in_ctx print usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print USB'
}

@test 'cat: usb -> USB' {
    correct_in_ctx cat usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat USB'
}

@test 'grep: usb -> USB' {
    correct_in_ctx grep usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep USB'
}

@test 'sed: usb -> USB' {
    correct_in_ctx sed usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed USB'
}

@test 'awk: usb -> USB' {
    correct_in_ctx awk usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk USB'
}

@test 'man: usb -> USB' {
    correct_in_ctx man usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man USB'
}

@test 'ls: usb -> USB' {
    correct_in_ctx ls usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls USB'
}

@test 'head: usb -> USB' {
    correct_in_ctx head usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head USB'
}

@test 'tail: usb -> USB' {
    correct_in_ctx tail usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail USB'
}

@test 'sort: usb -> USB' {
    correct_in_ctx sort usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort USB'
}

@test 'uniq: usb -> USB' {
    correct_in_ctx uniq usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq USB'
}

@test 'wc: usb -> USB' {
    correct_in_ctx wc usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc USB'
}

@test 'tr: usb -> USB' {
    correct_in_ctx tr usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr USB'
}

@test 'cut: usb -> USB' {
    correct_in_ctx cut usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut USB'
}

@test 'diff: usb -> USB' {
    correct_in_ctx diff usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff USB'
}

@test 'print: ues -> use' {
    correct_in_ctx print ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print use'
}

@test 'cat: ues -> use' {
    correct_in_ctx cat ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat use'
}

@test 'grep: ues -> use' {
    correct_in_ctx grep ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep use'
}

@test 'sed: ues -> use' {
    correct_in_ctx sed ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed use'
}

@test 'awk: ues -> use' {
    correct_in_ctx awk ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk use'
}

@test 'man: ues -> use' {
    correct_in_ctx man ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man use'
}

@test 'ls: ues -> use' {
    correct_in_ctx ls ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls use'
}

@test 'head: ues -> use' {
    correct_in_ctx head ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head use'
}

@test 'tail: ues -> use' {
    correct_in_ctx tail ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail use'
}

@test 'sort: ues -> use' {
    correct_in_ctx sort ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort use'
}

@test 'uniq: ues -> use' {
    correct_in_ctx uniq ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq use'
}

@test 'wc: ues -> use' {
    correct_in_ctx wc ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc use'
}

@test 'tr: ues -> use' {
    correct_in_ctx tr ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr use'
}

@test 'cut: ues -> use' {
    correct_in_ctx cut ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut use'
}

@test 'diff: ues -> use' {
    correct_in_ctx diff ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff use'
}

@test 'print: suing -> using' {
    correct_in_ctx print suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print using'
}

@test 'cat: suing -> using' {
    correct_in_ctx cat suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat using'
}

@test 'grep: suing -> using' {
    correct_in_ctx grep suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep using'
}

@test 'sed: suing -> using' {
    correct_in_ctx sed suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed using'
}

@test 'awk: suing -> using' {
    correct_in_ctx awk suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk using'
}

@test 'man: suing -> using' {
    correct_in_ctx man suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man using'
}

@test 'ls: suing -> using' {
    correct_in_ctx ls suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls using'
}

@test 'head: suing -> using' {
    correct_in_ctx head suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head using'
}

@test 'tail: suing -> using' {
    correct_in_ctx tail suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail using'
}

@test 'sort: suing -> using' {
    correct_in_ctx sort suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort using'
}

@test 'uniq: suing -> using' {
    correct_in_ctx uniq suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq using'
}

@test 'wc: suing -> using' {
    correct_in_ctx wc suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc using'
}

@test 'tr: suing -> using' {
    correct_in_ctx tr suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr using'
}

@test 'cut: suing -> using' {
    correct_in_ctx cut suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut using'
}

@test 'diff: suing -> using' {
    correct_in_ctx diff suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff using'
}

@test 'print: usu -> usually' {
    correct_in_ctx print usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print usually'
}

@test 'cat: usu -> usually' {
    correct_in_ctx cat usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat usually'
}

@test 'grep: usu -> usually' {
    correct_in_ctx grep usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep usually'
}

@test 'sed: usu -> usually' {
    correct_in_ctx sed usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed usually'
}

@test 'awk: usu -> usually' {
    correct_in_ctx awk usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk usually'
}

@test 'man: usu -> usually' {
    correct_in_ctx man usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man usually'
}

@test 'ls: usu -> usually' {
    correct_in_ctx ls usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls usually'
}

@test 'head: usu -> usually' {
    correct_in_ctx head usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head usually'
}

@test 'tail: usu -> usually' {
    correct_in_ctx tail usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail usually'
}

@test 'sort: usu -> usually' {
    correct_in_ctx sort usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort usually'
}

@test 'uniq: usu -> usually' {
    correct_in_ctx uniq usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq usually'
}

@test 'wc: usu -> usually' {
    correct_in_ctx wc usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc usually'
}

@test 'tr: usu -> usually' {
    correct_in_ctx tr usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr usually'
}

@test 'cut: usu -> usually' {
    correct_in_ctx cut usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut usually'
}

@test 'diff: usu -> usually' {
    correct_in_ctx diff usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff usually'
}

@test 'print: utf-8 -> UTF-8' {
    correct_in_ctx print utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print UTF-8'
}

@test 'cat: utf-8 -> UTF-8' {
    correct_in_ctx cat utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat UTF-8'
}

@test 'grep: utf-8 -> UTF-8' {
    correct_in_ctx grep utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep UTF-8'
}

@test 'sed: utf-8 -> UTF-8' {
    correct_in_ctx sed utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed UTF-8'
}

@test 'awk: utf-8 -> UTF-8' {
    correct_in_ctx awk utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk UTF-8'
}

@test 'man: utf-8 -> UTF-8' {
    correct_in_ctx man utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man UTF-8'
}

@test 'ls: utf-8 -> UTF-8' {
    correct_in_ctx ls utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls UTF-8'
}

@test 'head: utf-8 -> UTF-8' {
    correct_in_ctx head utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head UTF-8'
}

@test 'tail: utf-8 -> UTF-8' {
    correct_in_ctx tail utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail UTF-8'
}

@test 'sort: utf-8 -> UTF-8' {
    correct_in_ctx sort utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort UTF-8'
}

@test 'uniq: utf-8 -> UTF-8' {
    correct_in_ctx uniq utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq UTF-8'
}

@test 'wc: utf-8 -> UTF-8' {
    correct_in_ctx wc utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc UTF-8'
}

@test 'tr: utf-8 -> UTF-8' {
    correct_in_ctx tr utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr UTF-8'
}

@test 'cut: utf-8 -> UTF-8' {
    correct_in_ctx cut utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut UTF-8'
}

@test 'diff: utf-8 -> UTF-8' {
    correct_in_ctx diff utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff UTF-8'
}

@test 'print: vlaue -> value' {
    correct_in_ctx print vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print value'
}

@test 'cat: vlaue -> value' {
    correct_in_ctx cat vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat value'
}

@test 'grep: vlaue -> value' {
    correct_in_ctx grep vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep value'
}

@test 'sed: vlaue -> value' {
    correct_in_ctx sed vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed value'
}

@test 'awk: vlaue -> value' {
    correct_in_ctx awk vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk value'
}

@test 'man: vlaue -> value' {
    correct_in_ctx man vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man value'
}

@test 'ls: vlaue -> value' {
    correct_in_ctx ls vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls value'
}

@test 'head: vlaue -> value' {
    correct_in_ctx head vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head value'
}

@test 'tail: vlaue -> value' {
    correct_in_ctx tail vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail value'
}

@test 'sort: vlaue -> value' {
    correct_in_ctx sort vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort value'
}

@test 'uniq: vlaue -> value' {
    correct_in_ctx uniq vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq value'
}

@test 'wc: vlaue -> value' {
    correct_in_ctx wc vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc value'
}

@test 'tr: vlaue -> value' {
    correct_in_ctx tr vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr value'
}

@test 'cut: vlaue -> value' {
    correct_in_ctx cut vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut value'
}

@test 'diff: vlaue -> value' {
    correct_in_ctx diff vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff value'
}

@test 'print: var -> variable' {
    correct_in_ctx print var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print variable'
}

@test 'cat: var -> variable' {
    correct_in_ctx cat var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat variable'
}

@test 'grep: var -> variable' {
    correct_in_ctx grep var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep variable'
}

@test 'sed: var -> variable' {
    correct_in_ctx sed var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed variable'
}

@test 'awk: var -> variable' {
    correct_in_ctx awk var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk variable'
}

@test 'man: var -> variable' {
    correct_in_ctx man var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man variable'
}

@test 'ls: var -> variable' {
    correct_in_ctx ls var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls variable'
}

@test 'head: var -> variable' {
    correct_in_ctx head var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head variable'
}

@test 'tail: var -> variable' {
    correct_in_ctx tail var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail variable'
}

@test 'sort: var -> variable' {
    correct_in_ctx sort var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort variable'
}

@test 'uniq: var -> variable' {
    correct_in_ctx uniq var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq variable'
}

@test 'wc: var -> variable' {
    correct_in_ctx wc var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc variable'
}

@test 'tr: var -> variable' {
    correct_in_ctx tr var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr variable'
}

@test 'cut: var -> variable' {
    correct_in_ctx cut var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut variable'
}

@test 'diff: var -> variable' {
    correct_in_ctx diff var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff variable'
}

@test 'print: vars -> variables' {
    correct_in_ctx print vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print variables'
}

@test 'cat: vars -> variables' {
    correct_in_ctx cat vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat variables'
}

@test 'grep: vars -> variables' {
    correct_in_ctx grep vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep variables'
}

@test 'sed: vars -> variables' {
    correct_in_ctx sed vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed variables'
}

@test 'awk: vars -> variables' {
    correct_in_ctx awk vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk variables'
}

@test 'man: vars -> variables' {
    correct_in_ctx man vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man variables'
}

@test 'ls: vars -> variables' {
    correct_in_ctx ls vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls variables'
}

@test 'head: vars -> variables' {
    correct_in_ctx head vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head variables'
}

@test 'tail: vars -> variables' {
    correct_in_ctx tail vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail variables'
}

@test 'sort: vars -> variables' {
    correct_in_ctx sort vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort variables'
}

@test 'uniq: vars -> variables' {
    correct_in_ctx uniq vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq variables'
}

@test 'wc: vars -> variables' {
    correct_in_ctx wc vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc variables'
}

@test 'tr: vars -> variables' {
    correct_in_ctx tr vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr variables'
}

@test 'cut: vars -> variables' {
    correct_in_ctx cut vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut variables'
}

@test 'diff: vars -> variables' {
    correct_in_ctx diff vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff variables'
}

@test 'print: vectoor -> vector' {
    correct_in_ctx print vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print vector'
}

@test 'cat: vectoor -> vector' {
    correct_in_ctx cat vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat vector'
}

@test 'grep: vectoor -> vector' {
    correct_in_ctx grep vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep vector'
}

@test 'sed: vectoor -> vector' {
    correct_in_ctx sed vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed vector'
}

@test 'awk: vectoor -> vector' {
    correct_in_ctx awk vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk vector'
}

@test 'man: vectoor -> vector' {
    correct_in_ctx man vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man vector'
}

@test 'ls: vectoor -> vector' {
    correct_in_ctx ls vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls vector'
}

@test 'head: vectoor -> vector' {
    correct_in_ctx head vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head vector'
}

@test 'tail: vectoor -> vector' {
    correct_in_ctx tail vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail vector'
}

@test 'sort: vectoor -> vector' {
    correct_in_ctx sort vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort vector'
}

@test 'uniq: vectoor -> vector' {
    correct_in_ctx uniq vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq vector'
}

@test 'wc: vectoor -> vector' {
    correct_in_ctx wc vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc vector'
}

@test 'tr: vectoor -> vector' {
    correct_in_ctx tr vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr vector'
}

@test 'cut: vectoor -> vector' {
    correct_in_ctx cut vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut vector'
}

@test 'diff: vectoor -> vector' {
    correct_in_ctx diff vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff vector'
}

@test 'print: vverb -> verb' {
    correct_in_ctx print vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print verb'
}

@test 'cat: vverb -> verb' {
    correct_in_ctx cat vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat verb'
}

@test 'grep: vverb -> verb' {
    correct_in_ctx grep vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep verb'
}

@test 'sed: vverb -> verb' {
    correct_in_ctx sed vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed verb'
}

@test 'awk: vverb -> verb' {
    correct_in_ctx awk vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk verb'
}

@test 'man: vverb -> verb' {
    correct_in_ctx man vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man verb'
}

@test 'ls: vverb -> verb' {
    correct_in_ctx ls vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls verb'
}

@test 'head: vverb -> verb' {
    correct_in_ctx head vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head verb'
}

@test 'tail: vverb -> verb' {
    correct_in_ctx tail vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail verb'
}

@test 'sort: vverb -> verb' {
    correct_in_ctx sort vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort verb'
}

@test 'uniq: vverb -> verb' {
    correct_in_ctx uniq vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq verb'
}

@test 'wc: vverb -> verb' {
    correct_in_ctx wc vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc verb'
}

@test 'tr: vverb -> verb' {
    correct_in_ctx tr vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr verb'
}

@test 'cut: vverb -> verb' {
    correct_in_ctx cut vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut verb'
}

@test 'diff: vverb -> verb' {
    correct_in_ctx diff vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff verb'
}

@test 'print: verssion -> version' {
    correct_in_ctx print verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print version'
}

@test 'cat: verssion -> version' {
    correct_in_ctx cat verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat version'
}

@test 'grep: verssion -> version' {
    correct_in_ctx grep verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep version'
}

@test 'sed: verssion -> version' {
    correct_in_ctx sed verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed version'
}

@test 'awk: verssion -> version' {
    correct_in_ctx awk verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk version'
}

@test 'man: verssion -> version' {
    correct_in_ctx man verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man version'
}

@test 'ls: verssion -> version' {
    correct_in_ctx ls verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls version'
}

@test 'head: verssion -> version' {
    correct_in_ctx head verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head version'
}

@test 'tail: verssion -> version' {
    correct_in_ctx tail verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail version'
}

@test 'sort: verssion -> version' {
    correct_in_ctx sort verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort version'
}

@test 'uniq: verssion -> version' {
    correct_in_ctx uniq verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq version'
}

@test 'wc: verssion -> version' {
    correct_in_ctx wc verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc version'
}

@test 'tr: verssion -> version' {
    correct_in_ctx tr verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr version'
}

@test 'cut: verssion -> version' {
    correct_in_ctx cut verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut version'
}

@test 'diff: verssion -> version' {
    correct_in_ctx diff verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff version'
}

@test 'print: Verssion -> Version' {
    correct_in_ctx print Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print Version'
}

@test 'cat: Verssion -> Version' {
    correct_in_ctx cat Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat Version'
}

@test 'grep: Verssion -> Version' {
    correct_in_ctx grep Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep Version'
}

@test 'sed: Verssion -> Version' {
    correct_in_ctx sed Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed Version'
}

@test 'awk: Verssion -> Version' {
    correct_in_ctx awk Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk Version'
}

@test 'man: Verssion -> Version' {
    correct_in_ctx man Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man Version'
}

@test 'ls: Verssion -> Version' {
    correct_in_ctx ls Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls Version'
}

@test 'head: Verssion -> Version' {
    correct_in_ctx head Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head Version'
}

@test 'tail: Verssion -> Version' {
    correct_in_ctx tail Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail Version'
}

@test 'sort: Verssion -> Version' {
    correct_in_ctx sort Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort Version'
}

@test 'uniq: Verssion -> Version' {
    correct_in_ctx uniq Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq Version'
}

@test 'wc: Verssion -> Version' {
    correct_in_ctx wc Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc Version'
}

@test 'tr: Verssion -> Version' {
    correct_in_ctx tr Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr Version'
}

@test 'cut: Verssion -> Version' {
    correct_in_ctx cut Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut Version'
}

@test 'diff: Verssion -> Version' {
    correct_in_ctx diff Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff Version'
}

@test 'print: ivm -> vim' {
    correct_in_ctx print ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print vim'
}

@test 'cat: ivm -> vim' {
    correct_in_ctx cat ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat vim'
}

@test 'grep: ivm -> vim' {
    correct_in_ctx grep ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep vim'
}

@test 'sed: ivm -> vim' {
    correct_in_ctx sed ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed vim'
}

@test 'awk: ivm -> vim' {
    correct_in_ctx awk ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk vim'
}

@test 'man: ivm -> vim' {
    correct_in_ctx man ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man vim'
}

@test 'ls: ivm -> vim' {
    correct_in_ctx ls ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls vim'
}

@test 'head: ivm -> vim' {
    correct_in_ctx head ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head vim'
}

@test 'tail: ivm -> vim' {
    correct_in_ctx tail ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail vim'
}

@test 'sort: ivm -> vim' {
    correct_in_ctx sort ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort vim'
}

@test 'uniq: ivm -> vim' {
    correct_in_ctx uniq ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq vim'
}

@test 'wc: ivm -> vim' {
    correct_in_ctx wc ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc vim'
}

@test 'tr: ivm -> vim' {
    correct_in_ctx tr ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr vim'
}

@test 'cut: ivm -> vim' {
    correct_in_ctx cut ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut vim'
}

@test 'diff: ivm -> vim' {
    correct_in_ctx diff ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff vim'
}

@test 'print: vpn -> VPN' {
    correct_in_ctx print vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print VPN'
}

@test 'cat: vpn -> VPN' {
    correct_in_ctx cat vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat VPN'
}

@test 'grep: vpn -> VPN' {
    correct_in_ctx grep vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep VPN'
}

@test 'sed: vpn -> VPN' {
    correct_in_ctx sed vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed VPN'
}

@test 'awk: vpn -> VPN' {
    correct_in_ctx awk vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk VPN'
}

@test 'man: vpn -> VPN' {
    correct_in_ctx man vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man VPN'
}

@test 'ls: vpn -> VPN' {
    correct_in_ctx ls vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls VPN'
}

@test 'head: vpn -> VPN' {
    correct_in_ctx head vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head VPN'
}

@test 'tail: vpn -> VPN' {
    correct_in_ctx tail vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail VPN'
}

@test 'sort: vpn -> VPN' {
    correct_in_ctx sort vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort VPN'
}

@test 'uniq: vpn -> VPN' {
    correct_in_ctx uniq vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq VPN'
}

@test 'wc: vpn -> VPN' {
    correct_in_ctx wc vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc VPN'
}

@test 'tr: vpn -> VPN' {
    correct_in_ctx tr vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr VPN'
}

@test 'cut: vpn -> VPN' {
    correct_in_ctx cut vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut VPN'
}

@test 'diff: vpn -> VPN' {
    correct_in_ctx diff vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff VPN'
}

@test 'print: wasnt -> was not' {
    correct_in_ctx print wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print was not'
}

@test 'cat: wasnt -> was not' {
    correct_in_ctx cat wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat was not'
}

@test 'grep: wasnt -> was not' {
    correct_in_ctx grep wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep was not'
}

@test 'sed: wasnt -> was not' {
    correct_in_ctx sed wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed was not'
}

@test 'awk: wasnt -> was not' {
    correct_in_ctx awk wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk was not'
}

@test 'man: wasnt -> was not' {
    correct_in_ctx man wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man was not'
}

@test 'ls: wasnt -> was not' {
    correct_in_ctx ls wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls was not'
}

@test 'head: wasnt -> was not' {
    correct_in_ctx head wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head was not'
}

@test 'tail: wasnt -> was not' {
    correct_in_ctx tail wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail was not'
}

@test 'sort: wasnt -> was not' {
    correct_in_ctx sort wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort was not'
}

@test 'uniq: wasnt -> was not' {
    correct_in_ctx uniq wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq was not'
}

@test 'wc: wasnt -> was not' {
    correct_in_ctx wc wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc was not'
}

@test 'tr: wasnt -> was not' {
    correct_in_ctx tr wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr was not'
}

@test 'cut: wasnt -> was not' {
    correct_in_ctx cut wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut was not'
}

@test 'diff: wasnt -> was not' {
    correct_in_ctx diff wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff was not'
}

@test 'print: whitespaec -> whitespace' {
    correct_in_ctx print whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print whitespace'
}

@test 'cat: whitespaec -> whitespace' {
    correct_in_ctx cat whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat whitespace'
}

@test 'grep: whitespaec -> whitespace' {
    correct_in_ctx grep whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep whitespace'
}

@test 'sed: whitespaec -> whitespace' {
    correct_in_ctx sed whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed whitespace'
}

@test 'awk: whitespaec -> whitespace' {
    correct_in_ctx awk whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk whitespace'
}

@test 'man: whitespaec -> whitespace' {
    correct_in_ctx man whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man whitespace'
}

@test 'ls: whitespaec -> whitespace' {
    correct_in_ctx ls whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls whitespace'
}

@test 'head: whitespaec -> whitespace' {
    correct_in_ctx head whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head whitespace'
}

@test 'tail: whitespaec -> whitespace' {
    correct_in_ctx tail whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail whitespace'
}

@test 'sort: whitespaec -> whitespace' {
    correct_in_ctx sort whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort whitespace'
}

@test 'uniq: whitespaec -> whitespace' {
    correct_in_ctx uniq whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq whitespace'
}

@test 'wc: whitespaec -> whitespace' {
    correct_in_ctx wc whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc whitespace'
}

@test 'tr: whitespaec -> whitespace' {
    correct_in_ctx tr whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr whitespace'
}

@test 'cut: whitespaec -> whitespace' {
    correct_in_ctx cut whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut whitespace'
}

@test 'diff: whitespaec -> whitespace' {
    correct_in_ctx diff whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff whitespace'
}

@test 'print: hwy -> why' {
    correct_in_ctx print hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print why'
}

@test 'cat: hwy -> why' {
    correct_in_ctx cat hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat why'
}

@test 'grep: hwy -> why' {
    correct_in_ctx grep hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep why'
}

@test 'sed: hwy -> why' {
    correct_in_ctx sed hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed why'
}

@test 'awk: hwy -> why' {
    correct_in_ctx awk hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk why'
}

@test 'man: hwy -> why' {
    correct_in_ctx man hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man why'
}

@test 'ls: hwy -> why' {
    correct_in_ctx ls hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls why'
}

@test 'head: hwy -> why' {
    correct_in_ctx head hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head why'
}

@test 'tail: hwy -> why' {
    correct_in_ctx tail hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail why'
}

@test 'sort: hwy -> why' {
    correct_in_ctx sort hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort why'
}

@test 'uniq: hwy -> why' {
    correct_in_ctx uniq hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq why'
}

@test 'wc: hwy -> why' {
    correct_in_ctx wc hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc why'
}

@test 'tr: hwy -> why' {
    correct_in_ctx tr hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr why'
}

@test 'cut: hwy -> why' {
    correct_in_ctx cut hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut why'
}

@test 'diff: hwy -> why' {
    correct_in_ctx diff hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff why'
}

@test 'print: wont -> will not' {
    correct_in_ctx print wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print will not'
}

@test 'cat: wont -> will not' {
    correct_in_ctx cat wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat will not'
}

@test 'grep: wont -> will not' {
    correct_in_ctx grep wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep will not'
}

@test 'sed: wont -> will not' {
    correct_in_ctx sed wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed will not'
}

@test 'awk: wont -> will not' {
    correct_in_ctx awk wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk will not'
}

@test 'man: wont -> will not' {
    correct_in_ctx man wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man will not'
}

@test 'ls: wont -> will not' {
    correct_in_ctx ls wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls will not'
}

@test 'head: wont -> will not' {
    correct_in_ctx head wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head will not'
}

@test 'tail: wont -> will not' {
    correct_in_ctx tail wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail will not'
}

@test 'sort: wont -> will not' {
    correct_in_ctx sort wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort will not'
}

@test 'uniq: wont -> will not' {
    correct_in_ctx uniq wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq will not'
}

@test 'wc: wont -> will not' {
    correct_in_ctx wc wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc will not'
}

@test 'tr: wont -> will not' {
    correct_in_ctx tr wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr will not'
}

@test 'cut: wont -> will not' {
    correct_in_ctx cut wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut will not'
}

@test 'diff: wont -> will not' {
    correct_in_ctx diff wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff will not'
}

@test 'print: with -> with' {
    correct_in_ctx print with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print with'
}

@test 'cat: with -> with' {
    correct_in_ctx cat with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat with'
}

@test 'grep: with -> with' {
    correct_in_ctx grep with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep with'
}

@test 'sed: with -> with' {
    correct_in_ctx sed with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed with'
}

@test 'awk: with -> with' {
    correct_in_ctx awk with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk with'
}

@test 'man: with -> with' {
    correct_in_ctx man with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man with'
}

@test 'ls: with -> with' {
    correct_in_ctx ls with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls with'
}

@test 'head: with -> with' {
    correct_in_ctx head with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head with'
}

@test 'tail: with -> with' {
    correct_in_ctx tail with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail with'
}

@test 'sort: with -> with' {
    correct_in_ctx sort with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort with'
}

@test 'uniq: with -> with' {
    correct_in_ctx uniq with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq with'
}

@test 'wc: with -> with' {
    correct_in_ctx wc with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc with'
}

@test 'tr: with -> with' {
    correct_in_ctx tr with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr with'
}

@test 'cut: with -> with' {
    correct_in_ctx cut with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut with'
}

@test 'diff: with -> with' {
    correct_in_ctx diff with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff with'
}

@test 'print: wo -> without' {
    correct_in_ctx print wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print without'
}

@test 'cat: wo -> without' {
    correct_in_ctx cat wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat without'
}

@test 'grep: wo -> without' {
    correct_in_ctx grep wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep without'
}

@test 'sed: wo -> without' {
    correct_in_ctx sed wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed without'
}

@test 'awk: wo -> without' {
    correct_in_ctx awk wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk without'
}

@test 'man: wo -> without' {
    correct_in_ctx man wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man without'
}

@test 'ls: wo -> without' {
    correct_in_ctx ls wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls without'
}

@test 'head: wo -> without' {
    correct_in_ctx head wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head without'
}

@test 'tail: wo -> without' {
    correct_in_ctx tail wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail without'
}

@test 'sort: wo -> without' {
    correct_in_ctx sort wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort without'
}

@test 'uniq: wo -> without' {
    correct_in_ctx uniq wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq without'
}

@test 'wc: wo -> without' {
    correct_in_ctx wc wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc without'
}

@test 'tr: wo -> without' {
    correct_in_ctx tr wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr without'
}

@test 'cut: wo -> without' {
    correct_in_ctx cut wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut without'
}

@test 'diff: wo -> without' {
    correct_in_ctx diff wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff without'
}

@test 'print: wrk -> work' {
    correct_in_ctx print wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print work'
}

@test 'cat: wrk -> work' {
    correct_in_ctx cat wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat work'
}

@test 'grep: wrk -> work' {
    correct_in_ctx grep wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep work'
}

@test 'sed: wrk -> work' {
    correct_in_ctx sed wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed work'
}

@test 'awk: wrk -> work' {
    correct_in_ctx awk wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk work'
}

@test 'man: wrk -> work' {
    correct_in_ctx man wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man work'
}

@test 'ls: wrk -> work' {
    correct_in_ctx ls wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls work'
}

@test 'head: wrk -> work' {
    correct_in_ctx head wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head work'
}

@test 'tail: wrk -> work' {
    correct_in_ctx tail wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail work'
}

@test 'sort: wrk -> work' {
    correct_in_ctx sort wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort work'
}

@test 'uniq: wrk -> work' {
    correct_in_ctx uniq wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq work'
}

@test 'wc: wrk -> work' {
    correct_in_ctx wc wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc work'
}

@test 'tr: wrk -> work' {
    correct_in_ctx tr wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr work'
}

@test 'cut: wrk -> work' {
    correct_in_ctx cut wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut work'
}

@test 'diff: wrk -> work' {
    correct_in_ctx diff wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff work'
}

@test 'print: wouldnt -> would not' {
    correct_in_ctx print wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print would not'
}

@test 'cat: wouldnt -> would not' {
    correct_in_ctx cat wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat would not'
}

@test 'grep: wouldnt -> would not' {
    correct_in_ctx grep wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep would not'
}

@test 'sed: wouldnt -> would not' {
    correct_in_ctx sed wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed would not'
}

@test 'awk: wouldnt -> would not' {
    correct_in_ctx awk wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk would not'
}

@test 'man: wouldnt -> would not' {
    correct_in_ctx man wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man would not'
}

@test 'ls: wouldnt -> would not' {
    correct_in_ctx ls wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls would not'
}

@test 'head: wouldnt -> would not' {
    correct_in_ctx head wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head would not'
}

@test 'tail: wouldnt -> would not' {
    correct_in_ctx tail wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail would not'
}

@test 'sort: wouldnt -> would not' {
    correct_in_ctx sort wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort would not'
}

@test 'uniq: wouldnt -> would not' {
    correct_in_ctx uniq wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq would not'
}

@test 'wc: wouldnt -> would not' {
    correct_in_ctx wc wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc would not'
}

@test 'tr: wouldnt -> would not' {
    correct_in_ctx tr wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr would not'
}

@test 'cut: wouldnt -> would not' {
    correct_in_ctx cut wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut would not'
}

@test 'diff: wouldnt -> would not' {
    correct_in_ctx diff wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff would not'
}

@test 'print: wirte -> write' {
    correct_in_ctx print wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print write'
}

@test 'cat: wirte -> write' {
    correct_in_ctx cat wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat write'
}

@test 'grep: wirte -> write' {
    correct_in_ctx grep wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep write'
}

@test 'sed: wirte -> write' {
    correct_in_ctx sed wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed write'
}

@test 'awk: wirte -> write' {
    correct_in_ctx awk wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk write'
}

@test 'man: wirte -> write' {
    correct_in_ctx man wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man write'
}

@test 'ls: wirte -> write' {
    correct_in_ctx ls wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls write'
}

@test 'head: wirte -> write' {
    correct_in_ctx head wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head write'
}

@test 'tail: wirte -> write' {
    correct_in_ctx tail wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail write'
}

@test 'sort: wirte -> write' {
    correct_in_ctx sort wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort write'
}

@test 'uniq: wirte -> write' {
    correct_in_ctx uniq wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq write'
}

@test 'wc: wirte -> write' {
    correct_in_ctx wc wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc write'
}

@test 'tr: wirte -> write' {
    correct_in_ctx tr wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr write'
}

@test 'cut: wirte -> write' {
    correct_in_ctx cut wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut write'
}

@test 'diff: wirte -> write' {
    correct_in_ctx diff wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff write'
}

@test 'print: xml -> XML' {
    correct_in_ctx print xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print XML'
}

@test 'cat: xml -> XML' {
    correct_in_ctx cat xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat XML'
}

@test 'grep: xml -> XML' {
    correct_in_ctx grep xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep XML'
}

@test 'sed: xml -> XML' {
    correct_in_ctx sed xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed XML'
}

@test 'awk: xml -> XML' {
    correct_in_ctx awk xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk XML'
}

@test 'man: xml -> XML' {
    correct_in_ctx man xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man XML'
}

@test 'ls: xml -> XML' {
    correct_in_ctx ls xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls XML'
}

@test 'head: xml -> XML' {
    correct_in_ctx head xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head XML'
}

@test 'tail: xml -> XML' {
    correct_in_ctx tail xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail XML'
}

@test 'sort: xml -> XML' {
    correct_in_ctx sort xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort XML'
}

@test 'uniq: xml -> XML' {
    correct_in_ctx uniq xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq XML'
}

@test 'wc: xml -> XML' {
    correct_in_ctx wc xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc XML'
}

@test 'tr: xml -> XML' {
    correct_in_ctx tr xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr XML'
}

@test 'cut: xml -> XML' {
    correct_in_ctx cut xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut XML'
}

@test 'diff: xml -> XML' {
    correct_in_ctx diff xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff XML'
}

@test 'print: yaml -> YAML' {
    correct_in_ctx print yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print YAML'
}

@test 'cat: yaml -> YAML' {
    correct_in_ctx cat yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat YAML'
}

@test 'grep: yaml -> YAML' {
    correct_in_ctx grep yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep YAML'
}

@test 'sed: yaml -> YAML' {
    correct_in_ctx sed yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed YAML'
}

@test 'awk: yaml -> YAML' {
    correct_in_ctx awk yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk YAML'
}

@test 'man: yaml -> YAML' {
    correct_in_ctx man yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man YAML'
}

@test 'ls: yaml -> YAML' {
    correct_in_ctx ls yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls YAML'
}

@test 'head: yaml -> YAML' {
    correct_in_ctx head yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head YAML'
}

@test 'tail: yaml -> YAML' {
    correct_in_ctx tail yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail YAML'
}

@test 'sort: yaml -> YAML' {
    correct_in_ctx sort yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort YAML'
}

@test 'uniq: yaml -> YAML' {
    correct_in_ctx uniq yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq YAML'
}

@test 'wc: yaml -> YAML' {
    correct_in_ctx wc yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc YAML'
}

@test 'tr: yaml -> YAML' {
    correct_in_ctx tr yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr YAML'
}

@test 'cut: yaml -> YAML' {
    correct_in_ctx cut yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut YAML'
}

@test 'diff: yaml -> YAML' {
    correct_in_ctx diff yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff YAML'
}

@test 'print: yuor -> your' {
    correct_in_ctx print yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print your'
}

@test 'cat: yuor -> your' {
    correct_in_ctx cat yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat your'
}

@test 'grep: yuor -> your' {
    correct_in_ctx grep yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep your'
}

@test 'sed: yuor -> your' {
    correct_in_ctx sed yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed your'
}

@test 'awk: yuor -> your' {
    correct_in_ctx awk yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk your'
}

@test 'man: yuor -> your' {
    correct_in_ctx man yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man your'
}

@test 'ls: yuor -> your' {
    correct_in_ctx ls yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls your'
}

@test 'head: yuor -> your' {
    correct_in_ctx head yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head your'
}

@test 'tail: yuor -> your' {
    correct_in_ctx tail yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail your'
}

@test 'sort: yuor -> your' {
    correct_in_ctx sort yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort your'
}

@test 'uniq: yuor -> your' {
    correct_in_ctx uniq yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq your'
}

@test 'wc: yuor -> your' {
    correct_in_ctx wc yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc your'
}

@test 'tr: yuor -> your' {
    correct_in_ctx tr yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr your'
}

@test 'cut: yuor -> your' {
    correct_in_ctx cut yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut your'
}

@test 'diff: yuor -> your' {
    correct_in_ctx diff yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff your'
}

@test 'print: zhs -> zsh' {
    correct_in_ctx print zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'print zsh'
}

@test 'cat: zhs -> zsh' {
    correct_in_ctx cat zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cat zsh'
}

@test 'grep: zhs -> zsh' {
    correct_in_ctx grep zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'grep zsh'
}

@test 'sed: zhs -> zsh' {
    correct_in_ctx sed zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sed zsh'
}

@test 'awk: zhs -> zsh' {
    correct_in_ctx awk zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'awk zsh'
}

@test 'man: zhs -> zsh' {
    correct_in_ctx man zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'man zsh'
}

@test 'ls: zhs -> zsh' {
    correct_in_ctx ls zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'ls zsh'
}

@test 'head: zhs -> zsh' {
    correct_in_ctx head zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'head zsh'
}

@test 'tail: zhs -> zsh' {
    correct_in_ctx tail zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tail zsh'
}

@test 'sort: zhs -> zsh' {
    correct_in_ctx sort zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'sort zsh'
}

@test 'uniq: zhs -> zsh' {
    correct_in_ctx uniq zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'uniq zsh'
}

@test 'wc: zhs -> zsh' {
    correct_in_ctx wc zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'wc zsh'
}

@test 'tr: zhs -> zsh' {
    correct_in_ctx tr zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'tr zsh'
}

@test 'cut: zhs -> zsh' {
    correct_in_ctx cut zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'cut zsh'
}

@test 'diff: zhs -> zsh' {
    correct_in_ctx diff zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'diff zsh'
}

