#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Mar 25 2026
##### Purpose: exhaustive dictionary correction tests
##### Notes: tests every misspelling in ZPWR_EXPAND_CORRECT_WORDS
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

    function correct_word() {
        LBUFFER="echo $1"
        ZPWR_VARS[foundIncorrect]=false
        zpwrExpandParseWords "$LBUFFER"
        zpwrExpandCorrectWord
    }
}

@test 'dict echo: aobut -> about' {
    correct_word aobut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo about'
}

@test 'dict echo: abbout -> about' {
    correct_word abbout
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo about'
}

@test 'dict echo: aabout -> about' {
    correct_word aabout
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo about'
}

@test 'dict echo: aka -> AKA' {
    correct_word aka
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo AKA'
}

@test 'dict echo: alll -> all' {
    correct_word alll
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo all'
}

@test 'dict echo: al -> all' {
    correct_word al
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo all'
}

@test 'dict echo: aall -> all' {
    correct_word aall
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo all'
}

@test 'dict echo: laso -> also' {
    correct_word laso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo also'
}

@test 'dict echo: alos -> also' {
    correct_word alos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo also'
}

@test 'dict echo: alsoo -> also' {
    correct_word alsoo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo also'
}

@test 'dict echo: allso -> also' {
    correct_word allso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo also'
}

@test 'dict echo: alternaet -> alternate' {
    correct_word alternaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo alternate'
}

@test 'dict echo: alterntae -> alternate' {
    correct_word alterntae
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo alternate'
}

@test 'dict echo: adn -> and' {
    correct_word adn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo and'
}

@test 'dict echo: nad -> and' {
    correct_word nad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo and'
}

@test 'dict echo: ansi -> ANSI' {
    correct_word ansi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo ANSI'
}

@test 'dict echo: aer -> are' {
    correct_word aer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo are'
}

@test 'dict echo: rea -> are' {
    correct_word rea
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo are'
}

@test 'dict echo: arg -> argument' {
    correct_word arg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo argument'
}

@test 'dict echo: rag -> argument' {
    correct_word rag
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo argument'
}

@test 'dict echo: agr -> argument' {
    correct_word agr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo argument'
}

@test 'dict echo: args -> arguments' {
    correct_word args
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo arguments'
}

@test 'dict echo: rags -> arguments' {
    correct_word rags
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo arguments'
}

@test 'dict echo: agrs -> arguments' {
    correct_word agrs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo arguments'
}

@test 'dict echo: arrayy -> array' {
    correct_word arrayy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo array'
}

@test 'dict echo: ary -> array' {
    correct_word ary
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo array'
}

@test 'dict echo: arr -> array' {
    correct_word arr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo array'
}

@test 'dict echo: aary -> array' {
    correct_word aary
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo array'
}

@test 'dict echo: aray -> array' {
    correct_word aray
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo array'
}

@test 'dict echo: arrray -> array' {
    correct_word arrray
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo array'
}

@test 'dict echo: ascii -> ASCII' {
    correct_word ascii
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo ASCII'
}

@test 'dict echo: auto -> automatically' {
    correct_word auto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo automatically'
}

@test 'dict echo: aws -> AWS' {
    correct_word aws
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo AWS'
}

@test 'dict echo: bkac -> back' {
    correct_word bkac
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo back'
}

@test 'dict echo: bakc -> back' {
    correct_word bakc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo back'
}

@test 'dict echo: abck -> back' {
    correct_word abck
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo back'
}

@test 'dict echo: bg -> background' {
    correct_word bg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo background'
}

@test 'dict echo: bda -> bad' {
    correct_word bda
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bad'
}

@test 'dict echo: abd -> bad' {
    correct_word abd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bad'
}

@test 'dict echo: bw -> bandwidth' {
    correct_word bw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bandwidth'
}

@test 'dict echo: baesd -> based' {
    correct_word baesd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo based'
}

@test 'dict echo: absed -> based' {
    correct_word absed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo based'
}

@test 'dict echo: bahs -> bash' {
    correct_word bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bash'
}

@test 'dict echo: bbash -> bash' {
    correct_word bbash
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bash'
}

@test 'dict echo: baash -> bash' {
    correct_word baash
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bash'
}

@test 'dict echo: bassh -> bash' {
    correct_word bassh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bash'
}

@test 'dict echo: bashh -> bash' {
    correct_word bashh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo bash'
}

@test 'dict echo: bc -> because' {
    correct_word bc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo because'
}

@test 'dict echo: b/c -> because' {
    correct_word b/c
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo because'
}

@test 'dict echo: befor -> before' {
    correct_word befor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo before'
}

@test 'dict echo: beforre -> before' {
    correct_word beforre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo before'
}

@test 'dict echo: befre -> before' {
    correct_word befre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo before'
}

@test 'dict echo: beffooorr -> before' {
    correct_word beffooorr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo before'
}

@test 'dict echo: beforee -> before' {
    correct_word beforee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo before'
}

@test 'dict echo: b4 -> before' {
    correct_word b4
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo before'
}

@test 'dict echo: bets -> best' {
    correct_word bets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo best'
}

@test 'dict echo: bt -> between' {
    correct_word bt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo between'
}

@test 'dict echo: btn -> between' {
    correct_word btn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo between'
}

@test 'dict echo: between -> between' {
    correct_word between
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo between'
}

@test 'dict echo: bianry -> binary' {
    correct_word bianry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo binary'
}

@test 'dict echo: bniary -> binary' {
    correct_word bniary
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo binary'
}

@test 'dict echo: bios -> BIOS' {
    correct_word bios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo BIOS'
}

@test 'dict echo: blokc -> block' {
    correct_word blokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo block'
}

@test 'dict echo: bolck -> block' {
    correct_word bolck
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo block'
}

@test 'dict echo: lbock -> block' {
    correct_word lbock
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo block'
}

@test 'dict echo: berw -> brew' {
    correct_word berw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo brew'
}

@test 'dict echo: brerw -> brew' {
    correct_word brerw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo brew'
}

@test 'dict echo: berww -> brew' {
    correct_word berww
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo brew'
}

@test 'dict echo: brrerw -> brew' {
    correct_word brrerw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo brew'
}

@test 'dict echo: breww -> brew' {
    correct_word breww
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo brew'
}

@test 'dict echo: bbrrew -> brew' {
    correct_word bbrrew
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo brew'
}

@test 'dict echo: brrew -> brew' {
    correct_word brrew
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo brew'
}

@test 'dict echo: bsd -> BSD' {
    correct_word bsd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo BSD'
}

@test 'dict echo: btw -> by the way' {
    correct_word btw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo by the way'
}

@test 'dict echo: cant -> can not' {
    correct_word cant
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo can not'
}

@test 'dict echo: catpure -> capture' {
    correct_word catpure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo capture'
}

@test 'dict echo: catprue -> capture' {
    correct_word catprue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo capture'
}

@test 'dict echo: caputre -> capture' {
    correct_word caputre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo capture'
}

@test 'dict echo: caes -> case' {
    correct_word caes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo case'
}

@test 'dict echo: cdn -> CDN' {
    correct_word cdn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo CDN'
}

@test 'dict echo: cahnge -> change' {
    correct_word cahnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo change'
}

@test 'dict echo: chnage -> change' {
    correct_word chnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo change'
}

@test 'dict echo: chagne -> change' {
    correct_word chagne
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo change'
}

@test 'dict echo: chaeng -> change' {
    correct_word chaeng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo change'
}

@test 'dict echo: changen -> change' {
    correct_word changen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo change'
}

@test 'dict echo: cli -> CLI' {
    correct_word cli
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo CLI'
}

@test 'dict echo: clikc -> click' {
    correct_word clikc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo click'
}

@test 'dict echo: clik -> click' {
    correct_word clik
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo click'
}

@test 'dict echo: cleint -> client' {
    correct_word cleint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo client'
}

@test 'dict echo: cloen -> clone' {
    correct_word cloen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo clone'
}

@test 'dict echo: cloes -> close' {
    correct_word cloes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo close'
}

@test 'dict echo: cmd -> command' {
    correct_word cmd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo command'
}

@test 'dict echo: comand -> command' {
    correct_word comand
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo command'
}

@test 'dict echo: aommnd -> command' {
    correct_word aommnd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo command'
}

@test 'dict echo: commnd -> command' {
    correct_word commnd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo command'
}

@test 'dict echo: comamnd -> command' {
    correct_word comamnd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo command'
}

@test 'dict echo: ocmmand -> command' {
    correct_word ocmmand
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo command'
}

@test 'dict echo: cmds -> commands' {
    correct_word cmds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo commands'
}

@test 'dict echo: comands -> commands' {
    correct_word comands
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo commands'
}

@test 'dict echo: aommnds -> commands' {
    correct_word aommnds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo commands'
}

@test 'dict echo: commnds -> commands' {
    correct_word commnds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo commands'
}

@test 'dict echo: comamnds -> commands' {
    correct_word comamnds
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo commands'
}

@test 'dict echo: ocmmands -> commands' {
    correct_word ocmmands
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo commands'
}

@test 'dict echo: cs -> computer science' {
    correct_word cs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo computer science'
}

@test 'dict echo: compsci -> computer science' {
    correct_word compsci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo computer science'
}

@test 'dict echo: ocunt -> count' {
    correct_word ocunt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo count'
}

@test 'dict echo: coont -> count' {
    correct_word coont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo count'
}

@test 'dict echo: cpu -> CPU' {
    correct_word cpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo CPU'
}

@test 'dict echo: ccreate -> create' {
    correct_word ccreate
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo create'
}

@test 'dict echo: craete -> create' {
    correct_word craete
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo create'
}

@test 'dict echo: css -> CSS' {
    correct_word css
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo CSS'
}

@test 'dict echo: custmo -> custom' {
    correct_word custmo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo custom'
}

@test 'dict echo: cusotm -> custom' {
    correct_word cusotm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo custom'
}

@test 'dict echo: darwin -> Darwin' {
    correct_word darwin
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo Darwin'
}

@test 'dict echo: db -> database' {
    correct_word db
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo database'
}

@test 'dict echo: datab -> database' {
    correct_word datab
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo database'
}

@test 'dict echo: dbs -> databases' {
    correct_word dbs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo databases'
}

@test 'dict echo: databs -> databases' {
    correct_word databs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo databases'
}

@test 'dict echo: ddl -> DDL' {
    correct_word ddl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo DDL'
}

@test 'dict echo: decl -> declaration' {
    correct_word decl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo declaration'
}

@test 'dict echo: delcare -> declare' {
    correct_word delcare
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo declare'
}

@test 'dict echo: declaer -> declare' {
    correct_word declaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo declare'
}

@test 'dict echo: defalut -> default' {
    correct_word defalut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo default'
}

@test 'dict echo: deafult -> default' {
    correct_word deafult
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo default'
}

@test 'dict echo: dly -> delay' {
    correct_word dly
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo delay'
}

@test 'dict echo: deps -> dependencies' {
    correct_word deps
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo dependencies'
}

@test 'dict echo: dependenceis -> dependencies' {
    correct_word dependenceis
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo dependencies'
}

@test 'dict echo: dep -> dependency' {
    correct_word dep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo dependency'
}

@test 'dict echo: dependenc -> dependency' {
    correct_word dependenc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo dependency'
}

@test 'dict echo: dest -> destination' {
    correct_word dest
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo destination'
}

@test 'dict echo: deve -> developer' {
    correct_word deve
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo developer'
}

@test 'dict echo: devs -> developers' {
    correct_word devs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo developers'
}

@test 'dict echo: didt -> did not' {
    correct_word didt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo did not'
}

@test 'dict echo: didnt -> did not' {
    correct_word didnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo did not'
}

@test 'dict echo: dirss -> directories' {
    correct_word dirss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: ddirs -> directories' {
    correct_word ddirs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: dirs -> directories' {
    correct_word dirs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: idrs -> directories' {
    correct_word idrs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: direcotries -> directories' {
    correct_word direcotries
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: direcorties -> directories' {
    correct_word direcorties
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: directroies -> directories' {
    correct_word directroies
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: dirz -> directories' {
    correct_word dirz
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directories'
}

@test 'dict echo: dir -> directory' {
    correct_word dir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directory'
}

@test 'dict echo: ddir -> directory' {
    correct_word ddir
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directory'
}

@test 'dict echo: idr -> directory' {
    correct_word idr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directory'
}

@test 'dict echo: direcotry -> directory' {
    correct_word direcotry
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directory'
}

@test 'dict echo: direcorty -> directory' {
    correct_word direcorty
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directory'
}

@test 'dict echo: directroy -> directory' {
    correct_word directroy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo directory'
}

@test 'dict echo: dist -> distribution' {
    correct_word dist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo distribution'
}

@test 'dict echo: distro -> distribution' {
    correct_word distro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo distribution'
}

@test 'dict echo: dma -> DMA' {
    correct_word dma
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo DMA'
}

@test 'dict echo: dml -> DML' {
    correct_word dml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo DML'
}

@test 'dict echo: dns -> DNS' {
    correct_word dns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo DNS'
}

@test 'dict echo: dont -> do not' {
    correct_word dont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo do not'
}

@test 'dict echo: dokcer -> docker' {
    correct_word dokcer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo docker'
}

@test 'dict echo: docu -> documentation' {
    correct_word docu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo documentation'
}

@test 'dict echo: docs -> documentation' {
    correct_word docs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo documentation'
}

@test 'dict echo: doc -> documentation' {
    correct_word doc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo documentation'
}

@test 'dict echo: doesnt -> does not' {
    correct_word doesnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo does not'
}

@test 'dict echo: dbl -> double' {
    correct_word dbl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo double'
}

@test 'dict echo: doubel -> double' {
    correct_word doubel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo double'
}

@test 'dict echo: dql -> DQL' {
    correct_word dql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo DQL'
}

@test 'dict echo: darg -> drag' {
    correct_word darg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo drag'
}

@test 'dict echo: dorp -> drop' {
    correct_word dorp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo drop'
}

@test 'dict echo: dorpp -> drop' {
    correct_word dorpp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo drop'
}

@test 'dict echo: dropp -> drop' {
    correct_word dropp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo drop'
}

@test 'dict echo: durring -> during' {
    correct_word durring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: durriing -> during' {
    correct_word durriing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: durrring -> during' {
    correct_word durrring
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: durinng -> during' {
    correct_word durinng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: duringg -> during' {
    correct_word duringg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: durinng -> during' {
    correct_word durinng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: duurig -> during' {
    correct_word duurig
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: durign -> during' {
    correct_word durign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: durrgn -> during' {
    correct_word durrgn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo during'
}

@test 'dict echo: eah -> each' {
    correct_word eah
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo each'
}

@test 'dict echo: ehco -> echo' {
    correct_word ehco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict echo: eo -> echo' {
    correct_word eo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict echo: eccho -> echo' {
    correct_word eccho
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict echo: eho -> echo' {
    correct_word eho
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict echo: ceho -> echo' {
    correct_word ceho
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict echo: ecoh -> echo' {
    correct_word ecoh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict echo: eco -> echo' {
    correct_word eco
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict echo: efi -> EFI' {
    correct_word efi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo EFI'
}

@test 'dict echo: ned -> end' {
    correct_word ned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo end'
}

@test 'dict echo: ennd -> end' {
    correct_word ennd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo end'
}

@test 'dict echo: endd -> end' {
    correct_word endd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo end'
}

@test 'dict echo: nedd -> end' {
    correct_word nedd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo end'
}

@test 'dict echo: nned -> end' {
    correct_word nned
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo end'
}

@test 'dict echo: environ -> environment' {
    correct_word environ
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environment'
}

@test 'dict echo: evn -> environment' {
    correct_word evn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environment'
}

@test 'dict echo: env -> environment' {
    correct_word env
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environment'
}

@test 'dict echo: envvar -> environment variable' {
    correct_word envvar
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environment variable'
}

@test 'dict echo: ev -> environment variable' {
    correct_word ev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environment variable'
}

@test 'dict echo: envvars -> environment variables' {
    correct_word envvars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environment variables'
}

@test 'dict echo: evs -> environment variables' {
    correct_word evs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environment variables'
}

@test 'dict echo: environs -> environments' {
    correct_word environs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environments'
}

@test 'dict echo: evns -> environments' {
    correct_word evns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environments'
}

@test 'dict echo: envs -> environments' {
    correct_word envs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo environments'
}

@test 'dict echo: eror -> error' {
    correct_word eror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo error'
}

@test 'dict echo: err -> error' {
    correct_word err
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo error'
}

@test 'dict echo: errroor -> error' {
    correct_word errroor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo error'
}

@test 'dict echo: errror -> error' {
    correct_word errror
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo error'
}

@test 'dict echo: erroor -> error' {
    correct_word erroor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo error'
}

@test 'dict echo: erooor -> error' {
    correct_word erooor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo error'
}

@test 'dict echo: eixt -> exit' {
    correct_word eixt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo exit'
}

@test 'dict echo: exti -> exit' {
    correct_word exti
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo exit'
}

@test 'dict echo: xeit -> exit' {
    correct_word xeit
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo exit'
}

@test 'dict echo: xeti -> exit' {
    correct_word xeti
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo exit'
}

@test 'dict echo: exp -> expansion' {
    correct_word exp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo expansion'
}

@test 'dict echo: fales -> false' {
    correct_word fales
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo false'
}

@test 'dict echo: fals -> false' {
    correct_word fals
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo false'
}

@test 'dict echo: fale -> false' {
    correct_word fale
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo false'
}

@test 'dict echo: flase -> false' {
    correct_word flase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo false'
}

@test 'dict echo: fllase -> false' {
    correct_word fllase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo false'
}

@test 'dict echo: falles -> false' {
    correct_word falles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo false'
}

@test 'dict echo: fied -> field' {
    correct_word fied
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo field'
}

@test 'dict echo: feil -> file' {
    correct_word feil
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo file'
}

@test 'dict echo: fie -> file' {
    correct_word fie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo file'
}

@test 'dict echo: fiel -> file' {
    correct_word fiel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo file'
}

@test 'dict echo: ifle -> file' {
    correct_word ifle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo file'
}

@test 'dict echo: fille -> file' {
    correct_word fille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo file'
}

@test 'dict echo: fillee -> file' {
    correct_word fillee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo file'
}

@test 'dict echo: ifles -> files' {
    correct_word ifles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo files'
}

@test 'dict echo: fies -> files' {
    correct_word fies
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo files'
}

@test 'dict echo: fiess -> files' {
    correct_word fiess
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo files'
}

@test 'dict echo: ffiess -> files' {
    correct_word ffiess
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo files'
}

@test 'dict echo: filles -> files' {
    correct_word filles
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo files'
}

@test 'dict echo: filees -> files' {
    correct_word filees
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo files'
}

@test 'dict echo: fnial -> final' {
    correct_word fnial
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo final'
}

@test 'dict echo: fianl -> final' {
    correct_word fianl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo final'
}

@test 'dict echo: finl -> final' {
    correct_word finl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo final'
}

@test 'dict echo: fingre -> finger' {
    correct_word fingre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo finger'
}

@test 'dict echo: finegr -> finger' {
    correct_word finegr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo finger'
}

@test 'dict echo: figner -> finger' {
    correct_word figner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo finger'
}

@test 'dict echo: firsst -> first' {
    correct_word firsst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo first'
}

@test 'dict echo: firstt -> first' {
    correct_word firstt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo first'
}

@test 'dict echo: firrst -> first' {
    correct_word firrst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo first'
}

@test 'dict echo: firsstt -> first' {
    correct_word firsstt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo first'
}

@test 'dict echo: ffirrst -> first' {
    correct_word ffirrst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo first'
}

@test 'dict echo: forr -> for' {
    correct_word forr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo for'
}

@test 'dict echo: forrr -> for' {
    correct_word forrr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo for'
}

@test 'dict echo: fro -> for' {
    correct_word fro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo for'
}

@test 'dict echo: rfo -> for' {
    correct_word rfo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo for'
}

@test 'dict echo: rof -> for' {
    correct_word rof
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo for'
}

@test 'dict echo: fr -> for' {
    correct_word fr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo for'
}

@test 'dict echo: ofr -> for' {
    correct_word ofr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo for'
}

@test 'dict echo: fg -> foreground' {
    correct_word fg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo foreground'
}

@test 'dict echo: ofund -> found' {
    correct_word ofund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo found'
}

@test 'dict echo: fuond -> found' {
    correct_word fuond
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo found'
}

@test 'dict echo: foudn -> found' {
    correct_word foudn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo found'
}

@test 'dict echo: fxn -> function' {
    correct_word fxn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo function'
}

@test 'dict echo: func -> function' {
    correct_word func
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo function'
}

@test 'dict echo: fn -> function' {
    correct_word fn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo function'
}

@test 'dict echo: fxnal -> functional' {
    correct_word fxnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo functional'
}

@test 'dict echo: funcal -> functional' {
    correct_word funcal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo functional'
}

@test 'dict echo: fnal -> functional' {
    correct_word fnal
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo functional'
}

@test 'dict echo: fxns -> functions' {
    correct_word fxns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo functions'
}

@test 'dict echo: funcs -> functions' {
    correct_word funcs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo functions'
}

@test 'dict echo: fns -> functions' {
    correct_word fns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo functions'
}

@test 'dict echo: gw -> gateway' {
    correct_word gw
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo gateway'
}

@test 'dict echo: igt -> git' {
    correct_word igt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo git'
}

@test 'dict echo: ggit -> git' {
    correct_word ggit
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo git'
}

@test 'dict echo: og -> go' {
    correct_word og
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo go'
}

@test 'dict echo: gpt -> GPT' {
    correct_word gpt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo GPT'
}

@test 'dict echo: gpu -> GPU' {
    correct_word gpu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo GPU'
}

@test 'dict echo: gorup -> group' {
    correct_word gorup
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo group'
}

@test 'dict echo: groop -> group' {
    correct_word groop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo group'
}

@test 'dict echo: gourp -> group' {
    correct_word gourp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo group'
}

@test 'dict echo: grp -> group' {
    correct_word grp
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo group'
}

@test 'dict echo: h2 -> H2' {
    correct_word h2
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo H2'
}

@test 'dict echo: hasnt -> has not' {
    correct_word hasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo has not'
}

@test 'dict echo: havent -> have not' {
    correct_word havent
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo have not'
}

@test 'dict echo: ehre -> here' {
    correct_word ehre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo here'
}

@test 'dict echo: hfs -> HFS' {
    correct_word hfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo HFS'
}

@test 'dict echo: hgih -> high' {
    correct_word hgih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo high'
}

@test 'dict echo: hihg -> high' {
    correct_word hihg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo high'
}

@test 'dict echo: ihgh -> high' {
    correct_word ihgh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo high'
}

@test 'dict echo: hi -> high' {
    correct_word hi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo high'
}

@test 'dict echo: hollld -> hold' {
    correct_word hollld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo hold'
}

@test 'dict echo: holld -> hold' {
    correct_word holld
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo hold'
}

@test 'dict echo: html -> HTML' {
    correct_word html
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo HTML'
}

@test 'dict echo: http -> HTTP' {
    correct_word http
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo HTTP'
}

@test 'dict echo: https -> HTTPS' {
    correct_word https
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo HTTPS'
}

@test 'dict echo: ieee -> IEEE' {
    correct_word ieee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo IEEE'
}

@test 'dict echo: iamges -> images' {
    correct_word iamges
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo images'
}

@test 'dict echo: impl -> implementation' {
    correct_word impl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo implementation'
}

@test 'dict echo: incl -> including' {
    correct_word incl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo including'
}

@test 'dict echo: initi -> initialization' {
    correct_word initi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo initialization'
}

@test 'dict echo: insdie -> inside' {
    correct_word insdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo inside'
}

@test 'dict echo: isndie -> inside' {
    correct_word isndie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo inside'
}

@test 'dict echo: inisde -> inside' {
    correct_word inisde
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo inside'
}

@test 'dict echo: isnide -> inside' {
    correct_word isnide
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo inside'
}

@test 'dict echo: sindie -> inside' {
    correct_word sindie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo inside'
}

@test 'dict echo: insaed -> instead' {
    correct_word insaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo instead'
}

@test 'dict echo: instaed -> instead' {
    correct_word instaed
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo instead'
}

@test 'dict echo: interfaec -> interface' {
    correct_word interfaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo interface'
}

@test 'dict echo: ios -> iOS' {
    correct_word ios
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo iOS'
}

@test 'dict echo: ipad -> iPad' {
    correct_word ipad
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo iPad'
}

@test 'dict echo: iphone -> iPhone' {
    correct_word iphone
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo iPhone'
}

@test 'dict echo: si -> is' {
    correct_word si
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo is'
}

@test 'dict echo: ise -> is' {
    correct_word ise
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo is'
}

@test 'dict echo: isss -> is' {
    correct_word isss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo is'
}

@test 'dict echo: iss -> is' {
    correct_word iss
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo is'
}

@test 'dict echo: iis -> is' {
    correct_word iis
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo is'
}

@test 'dict echo: isnt -> is not' {
    correct_word isnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo is not'
}

@test 'dict echo: sint -> is not' {
    correct_word sint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo is not'
}

@test 'dict echo: iscsi -> iSCSI' {
    correct_word iscsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo iSCSI'
}

@test 'dict echo: iso -> ISO' {
    correct_word iso
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo ISO'
}

@test 'dict echo: js -> JavaScript' {
    correct_word js
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo JavaScript'
}

@test 'dict echo: josn -> JSON' {
    correct_word josn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo JSON'
}

@test 'dict echo: json -> JSON' {
    correct_word json
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo JSON'
}

@test 'dict echo: jsut -> just' {
    correct_word jsut
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo just'
}

@test 'dict echo: jutsi -> just' {
    correct_word jutsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo just'
}

@test 'dict echo: just -> just' {
    correct_word just
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo just'
}

@test 'dict echo: llasst -> last' {
    correct_word llasst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo last'
}

@test 'dict echo: lllast -> last' {
    correct_word lllast
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo last'
}

@test 'dict echo: llast -> last' {
    correct_word llast
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo last'
}

@test 'dict echo: latex -> LaTeX' {
    correct_word latex
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo LaTeX'
}

@test 'dict echo: lyaer -> layer' {
    correct_word lyaer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo layer'
}

@test 'dict echo: layyer -> layer' {
    correct_word layyer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo layer'
}

@test 'dict echo: llayer -> layer' {
    correct_word llayer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo layer'
}

@test 'dict echo: led -> LED' {
    correct_word led
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo LED'
}

@test 'dict echo: lvl -> level' {
    correct_word lvl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo level'
}

@test 'dict echo: lvls -> levels' {
    correct_word lvls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo levels'
}

@test 'dict echo: libs -> libraries' {
    correct_word libs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo libraries'
}

@test 'dict echo: lib -> library' {
    correct_word lib
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo library'
}

@test 'dict echo: liek -> like' {
    correct_word liek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo like'
}

@test 'dict echo: lik -> like' {
    correct_word lik
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo like'
}

@test 'dict echo: llink -> link' {
    correct_word llink
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo link'
}

@test 'dict echo: linnk -> link' {
    correct_word linnk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo link'
}

@test 'dict echo: linkk -> link' {
    correct_word linkk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo link'
}

@test 'dict echo: linux -> Linux' {
    correct_word linux
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo Linux'
}

@test 'dict echo: llist -> list' {
    correct_word llist
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo list'
}

@test 'dict echo: llistt -> list' {
    correct_word llistt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo list'
}

@test 'dict echo: listt -> list' {
    correct_word listt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo list'
}

@test 'dict echo: locaiton -> location' {
    correct_word locaiton
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo location'
}

@test 'dict echo: lcoation -> location' {
    correct_word lcoation
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo location'
}

@test 'dict echo: lokc -> lock' {
    correct_word lokc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo lock'
}

@test 'dict echo: lcok -> lock' {
    correct_word lcok
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo lock'
}

@test 'dict echo: macos -> macOS' {
    correct_word macos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo macOS'
}

@test 'dict echo: maek -> make' {
    correct_word maek
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo make'
}

@test 'dict echo: mbr -> MBR' {
    correct_word mbr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo MBR'
}

@test 'dict echo: msg -> message' {
    correct_word msg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo message'
}

@test 'dict echo: msgs -> messages' {
    correct_word msgs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo messages'
}

@test 'dict echo: midi -> MIDI' {
    correct_word midi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo MIDI'
}

@test 'dict echo: mobille -> mobile' {
    correct_word mobille
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo mobile'
}

@test 'dict echo: moer -> more' {
    correct_word moer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo more'
}

@test 'dict echo: mobo -> motherboard' {
    correct_word mobo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo motherboard'
}

@test 'dict echo: mounr -> mount' {
    correct_word mounr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo mount'
}

@test 'dict echo: mounf -> mount' {
    correct_word mounf
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo mount'
}

@test 'dict echo: moev -> move' {
    correct_word moev
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo move'
}

@test 'dict echo: mysql -> MySQL' {
    correct_word mysql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo MySQL'
}

@test 'dict echo: anme -> name' {
    correct_word anme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo name'
}

@test 'dict echo: naem -> name' {
    correct_word naem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo name'
}

@test 'dict echo: namepsace -> namespace' {
    correct_word namepsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo namespace'
}

@test 'dict echo: naemspace -> namespace' {
    correct_word naemspace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo namespace'
}

@test 'dict echo: naempsace -> namespace' {
    correct_word naempsace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo namespace'
}

@test 'dict echo: newtork -> network' {
    correct_word newtork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo network'
}

@test 'dict echo: entwork -> network' {
    correct_word entwork
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo network'
}

@test 'dict echo: ntework -> network' {
    correct_word ntework
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo network'
}

@test 'dict echo: nextt -> next' {
    correct_word nextt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo next'
}

@test 'dict echo: nexxt -> next' {
    correct_word nexxt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo next'
}

@test 'dict echo: neext -> next' {
    correct_word neext
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo next'
}

@test 'dict echo: nite -> night' {
    correct_word nite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo night'
}

@test 'dict echo: nto -> not' {
    correct_word nto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo not'
}

@test 'dict echo: tno -> not' {
    correct_word tno
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo not'
}

@test 'dict echo: ntfs -> NTFS' {
    correct_word ntfs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo NTFS'
}

@test 'dict echo: numbre -> number' {
    correct_word numbre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo number'
}

@test 'dict echo: numebr -> number' {
    correct_word numebr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo number'
}

@test 'dict echo: nr -> number' {
    correct_word nr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo number'
}

@test 'dict echo: fo -> of' {
    correct_word fo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo of'
}

@test 'dict echo: oof -> of' {
    correct_word oof
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo of'
}

@test 'dict echo: oepn -> open' {
    correct_word oepn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo open'
}

@test 'dict echo: ooopen -> open' {
    correct_word ooopen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo open'
}

@test 'dict echo: oopen -> open' {
    correct_word oopen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo open'
}

@test 'dict echo: oppen -> open' {
    correct_word oppen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo open'
}

@test 'dict echo: opeen -> open' {
    correct_word opeen
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo open'
}

@test 'dict echo: openn -> open' {
    correct_word openn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo open'
}

@test 'dict echo: os -> operating system' {
    correct_word os
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo operating system'
}

@test 'dict echo: ro -> or' {
    correct_word ro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo or'
}

@test 'dict echo: orr -> or' {
    correct_word orr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo or'
}

@test 'dict echo: othe -> other' {
    correct_word othe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo other'
}

@test 'dict echo: toher -> other' {
    correct_word toher
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo other'
}

@test 'dict echo: otuside -> outside' {
    correct_word otuside
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo outside'
}

@test 'dict echo: outsdie -> outside' {
    correct_word outsdie
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo outside'
}

@test 'dict echo: voer -> over' {
    correct_word voer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo over'
}

@test 'dict echo: ovre -> over' {
    correct_word ovre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo over'
}

@test 'dict echo: packk -> pack' {
    correct_word packk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo pack'
}

@test 'dict echo: pacck -> pack' {
    correct_word pacck
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo pack'
}

@test 'dict echo: ppack -> pack' {
    correct_word ppack
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo pack'
}

@test 'dict echo: parm -> parameter' {
    correct_word parm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo parameter'
}

@test 'dict echo: parms -> parameters' {
    correct_word parms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo parameters'
}

@test 'dict echo: pata -> PATA' {
    correct_word pata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo PATA'
}

@test 'dict echo: pci -> PCI' {
    correct_word pci
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo PCI'
}

@test 'dict echo: prel -> perl' {
    correct_word prel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo perl'
}

@test 'dict echo: perm -> permission' {
    correct_word perm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo permission'
}

@test 'dict echo: perms -> permissions' {
    correct_word perms
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo permissions'
}

@test 'dict echo: phaes -> phase' {
    correct_word phaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo phase'
}

@test 'dict echo: phae -> phase' {
    correct_word phae
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo phase'
}

@test 'dict echo: phasee -> phase' {
    correct_word phasee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo phase'
}

@test 'dict echo: pahes -> phase' {
    correct_word pahes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo phase'
}

@test 'dict echo: phasse -> phase' {
    correct_word phasse
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo phase'
}

@test 'dict echo: pid -> PID' {
    correct_word pid
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo PID'
}

@test 'dict echo: plase -> please' {
    correct_word plase
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo please'
}

@test 'dict echo: plz -> please' {
    correct_word plz
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo please'
}

@test 'dict echo: opint -> point' {
    correct_word opint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo point'
}

@test 'dict echo: ponit -> point' {
    correct_word ponit
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo point'
}

@test 'dict echo: pooort -> port' {
    correct_word pooort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo port'
}

@test 'dict echo: poort -> port' {
    correct_word poort
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo port'
}

@test 'dict echo: porrt -> port' {
    correct_word porrt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo port'
}

@test 'dict echo: pport -> port' {
    correct_word pport
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo port'
}

@test 'dict echo: portt -> port' {
    correct_word portt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo port'
}

@test 'dict echo: pportt -> port' {
    correct_word pportt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo port'
}

@test 'dict echo: pos -> position' {
    correct_word pos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo position'
}

@test 'dict echo: posix -> POSIX' {
    correct_word posix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo POSIX'
}

@test 'dict echo: pirnt -> print' {
    correct_word pirnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo print'
}

@test 'dict echo: pritn -> print' {
    correct_word pritn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo print'
}

@test 'dict echo: rpint -> print' {
    correct_word rpint
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo print'
}

@test 'dict echo: prnit -> print' {
    correct_word prnit
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo print'
}

@test 'dict echo: porbe -> probe' {
    correct_word porbe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo probe'
}

@test 'dict echo: rpobe -> probe' {
    correct_word rpobe
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo probe'
}

@test 'dict echo: projcet -> project' {
    correct_word projcet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo project'
}

@test 'dict echo: proejct -> project' {
    correct_word proejct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo project'
}

@test 'dict echo: proeject -> project' {
    correct_word proeject
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo project'
}

@test 'dict echo: porject -> project' {
    correct_word porject
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo project'
}

@test 'dict echo: projeccct -> project' {
    correct_word projeccct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo project'
}

@test 'dict echo: projecct -> project' {
    correct_word projecct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo project'
}

@test 'dict echo: porjecct -> project' {
    correct_word porjecct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo project'
}

@test 'dict echo: props -> properties' {
    correct_word props
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo properties'
}

@test 'dict echo: prop -> property' {
    correct_word prop
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo property'
}

@test 'dict echo: rpoxy -> proxy' {
    correct_word rpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo proxy'
}

@test 'dict echo: poxy -> proxy' {
    correct_word poxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo proxy'
}

@test 'dict echo: proxyy -> proxy' {
    correct_word proxyy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo proxy'
}

@test 'dict echo: proxxy -> proxy' {
    correct_word proxxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo proxy'
}

@test 'dict echo: rrpoxy -> proxy' {
    correct_word rrpoxy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo proxy'
}

@test 'dict echo: punct -> punctuation' {
    correct_word punct
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo punctuation'
}

@test 'dict echo: radisu -> radius' {
    correct_word radisu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo radius'
}

@test 'dict echo: raduis -> radius' {
    correct_word raduis
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo radius'
}

@test 'dict echo: rnage -> range' {
    correct_word rnage
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo range'
}

@test 'dict echo: arnge -> range' {
    correct_word arnge
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo range'
}

@test 'dict echo: eradme -> README' {
    correct_word eradme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo README'
}

@test 'dict echo: readme -> README' {
    correct_word readme
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo README'
}

@test 'dict echo: rdeo -> redo' {
    correct_word rdeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo redo'
}

@test 'dict echo: reod -> redo' {
    correct_word reod
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo redo'
}

@test 'dict echo: edro -> redo' {
    correct_word edro
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo redo'
}

@test 'dict echo: erdo -> redo' {
    correct_word erdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo redo'
}

@test 'dict echo: redoo -> redo' {
    correct_word redoo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo redo'
}

@test 'dict echo: reddo -> redo' {
    correct_word reddo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo redo'
}

@test 'dict echo: remoet -> remote' {
    correct_word remoet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo remote'
}

@test 'dict echo: replaec -> replace' {
    correct_word replaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo replace'
}

@test 'dict echo: relpace -> replace' {
    correct_word relpace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo replace'
}

@test 'dict echo: repos -> repositories' {
    correct_word repos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo repositories'
}

@test 'dict echo: rpeos -> repositories' {
    correct_word rpeos
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo repositories'
}

@test 'dict echo: repo -> repository' {
    correct_word repo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo repository'
}

@test 'dict echo: rpeo -> repository' {
    correct_word rpeo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo repository'
}

@test 'dict echo: res -> result' {
    correct_word res
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo result'
}

@test 'dict echo: resullt -> result' {
    correct_word resullt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo result'
}

@test 'dict echo: resultt -> result' {
    correct_word resultt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo result'
}

@test 'dict echo: rvb -> reverb' {
    correct_word rvb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo reverb'
}

@test 'dict echo: rvs -> reverse' {
    correct_word rvs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo reverse'
}

@test 'dict echo: revrse -> reverse' {
    correct_word revrse
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo reverse'
}

@test 'dict echo: rgb -> RGB' {
    correct_word rgb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo RGB'
}

@test 'dict echo: rotue -> route' {
    correct_word rotue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo route'
}

@test 'dict echo: roote -> route' {
    correct_word roote
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo route'
}

@test 'dict echo: runnign -> runnning' {
    correct_word runnign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo runnning'
}

@test 'dict echo: saem -> same' {
    correct_word saem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo same'
}

@test 'dict echo: sata -> SATA' {
    correct_word sata
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo SATA'
}

@test 'dict echo: scoep -> scope' {
    correct_word scoep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo scope'
}

@test 'dict echo: scsi -> SCSI' {
    correct_word scsi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo SCSI'
}

@test 'dict echo: searcch -> search' {
    correct_word searcch
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo search'
}

@test 'dict echo: searhc -> search' {
    correct_word searhc
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo search'
}

@test 'dict echo: esd -> sed' {
    correct_word esd
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo sed'
}

@test 'dict echo: sep -> separated' {
    correct_word sep
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo separated'
}

@test 'dict echo: separaated -> separated' {
    correct_word separaated
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo separated'
}

@test 'dict echo: est -> set' {
    correct_word est
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo set'
}

@test 'dict echo: esst -> set' {
    correct_word esst
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo set'
}

@test 'dict echo: ste -> set' {
    correct_word ste
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo set'
}

@test 'dict echo: sahre -> share' {
    correct_word sahre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo share'
}

@test 'dict echo: shre -> share' {
    correct_word shre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo share'
}

@test 'dict echo: shel -> shell script' {
    correct_word shel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo shell script'
}

@test 'dict echo: shouldnt -> should not' {
    correct_word shouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo should not'
}

@test 'dict echo: shwo -> show' {
    correct_word shwo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo show'
}

@test 'dict echo: signle -> single' {
    correct_word signle
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo single'
}

@test 'dict echo: singel -> single' {
    correct_word singel
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo single'
}

@test 'dict echo: soln -> solution' {
    correct_word soln
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo solution'
}

@test 'dict echo: solns -> solutions' {
    correct_word solns
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo solutions'
}

@test 'dict echo: soem -> some' {
    correct_word soem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo some'
}

@test 'dict echo: som -> some' {
    correct_word som
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo some'
}

@test 'dict echo: seom -> some' {
    correct_word seom
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo some'
}

@test 'dict echo: osund -> sound' {
    correct_word osund
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo sound'
}

@test 'dict echo: sourcce -> source' {
    correct_word sourcce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo source'
}

@test 'dict echo: soure -> source' {
    correct_word soure
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo source'
}

@test 'dict echo: sourec -> source' {
    correct_word sourec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo source'
}

@test 'dict echo: sourrce -> source' {
    correct_word sourrce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo source'
}

@test 'dict echo: src -> source' {
    correct_word src
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo source'
}

@test 'dict echo: spaec -> space' {
    correct_word spaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo space'
}

@test 'dict echo: spacee -> space' {
    correct_word spacee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo space'
}

@test 'dict echo: spacce -> space' {
    correct_word spacce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo space'
}

@test 'dict echo: sppace -> space' {
    correct_word sppace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo space'
}

@test 'dict echo: spaace -> space' {
    correct_word spaace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo space'
}

@test 'dict echo: spellign -> spelling' {
    correct_word spellign
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo spelling'
}

@test 'dict echo: spelilng -> spelling' {
    correct_word spelilng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo spelling'
}

@test 'dict echo: sql -> SQL' {
    correct_word sql
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo SQL'
}

@test 'dict echo: ssh -> SSH' {
    correct_word ssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo SSH'
}

@test 'dict echo: ssl -> SSL' {
    correct_word ssl
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo SSL'
}

@test 'dict echo: std -> standard' {
    correct_word std
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo standard'
}

@test 'dict echo: staet -> state' {
    correct_word staet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo state'
}

@test 'dict echo: steta -> state' {
    correct_word steta
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo state'
}

@test 'dict echo: sttae -> state' {
    correct_word sttae
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo state'
}

@test 'dict echo: staets -> states' {
    correct_word staets
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo states'
}

@test 'dict echo: stetas -> states' {
    correct_word stetas
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo states'
}

@test 'dict echo: sttaes -> states' {
    correct_word sttaes
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo states'
}

@test 'dict echo: tsore -> store' {
    correct_word tsore
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo store'
}

@test 'dict echo: sotre -> store' {
    correct_word sotre
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo store'
}

@test 'dict echo: stoer -> store' {
    correct_word stoer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo store'
}

@test 'dict echo: st8 -> straight' {
    correct_word st8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo straight'
}

@test 'dict echo: strraight -> straight' {
    correct_word strraight
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo straight'
}

@test 'dict echo: tsriaght -> straight' {
    correct_word tsriaght
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo straight'
}

@test 'dict echo: tsrraight -> straight' {
    correct_word tsrraight
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo straight'
}

@test 'dict echo: sstrraight -> straight' {
    correct_word sstrraight
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo straight'
}

@test 'dict echo: straightt -> straight' {
    correct_word straightt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo straight'
}

@test 'dict echo: stirng -> string' {
    correct_word stirng
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo string'
}

@test 'dict echo: stinrg -> string' {
    correct_word stinrg
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo string'
}

@test 'dict echo: sub -> substitute' {
    correct_word sub
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo substitute'
}

@test 'dict echo: usdo -> sudo' {
    correct_word usdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo sudo'
}

@test 'dict echo: usssdo -> sudo' {
    correct_word usssdo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo sudo'
}

@test 'dict echo: usddo -> sudo' {
    correct_word usddo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo sudo'
}

@test 'dict echo: sysv -> SYSV' {
    correct_word sysv
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo SYSV'
}

@test 'dict echo: tahn -> than' {
    correct_word tahn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo than'
}

@test 'dict echo: taht -> that' {
    correct_word taht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo that'
}

@test 'dict echo: teh -> the' {
    correct_word teh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo the'
}

@test 'dict echo: hte -> the' {
    correct_word hte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo the'
}

@test 'dict echo: eht -> the' {
    correct_word eht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo the'
}

@test 'dict echo: eth -> the' {
    correct_word eth
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo the'
}

@test 'dict echo: te -> the' {
    correct_word te
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo the'
}

@test 'dict echo: th -> the' {
    correct_word th
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo the'
}

@test 'dict echo: thier -> their' {
    correct_word thier
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo their'
}

@test 'dict echo: tehn -> then' {
    correct_word tehn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo then'
}

@test 'dict echo: tehy -> they' {
    correct_word tehy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo they'
}

@test 'dict echo: ethy -> they' {
    correct_word ethy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo they'
}

@test 'dict echo: tihs -> this' {
    correct_word tihs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo this'
}

@test 'dict echo: htis -> this' {
    correct_word htis
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo this'
}

@test 'dict echo: thru -> through' {
    correct_word thru
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo through'
}

@test 'dict echo: throug -> through' {
    correct_word throug
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo through'
}

@test 'dict echo: tiem -> time' {
    correct_word tiem
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo time'
}

@test 'dict echo: tls -> TLS' {
    correct_word tls
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo TLS'
}

@test 'dict echo: ot -> to' {
    correct_word ot
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo to'
}

@test 'dict echo: ttto -> to' {
    correct_word ttto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo to'
}

@test 'dict echo: tto -> to' {
    correct_word tto
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo to'
}

@test 'dict echo: tmr -> tomorrow' {
    correct_word tmr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo tomorrow'
}

@test 'dict echo: xfer -> transfer' {
    correct_word xfer
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo transfer'
}

@test 'dict echo: treu -> true' {
    correct_word treu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo true'
}

@test 'dict echo: ture -> true' {
    correct_word ture
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo true'
}

@test 'dict echo: tunr -> turn' {
    correct_word tunr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo turn'
}

@test 'dict echo: utrn -> turn' {
    correct_word utrn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo turn'
}

@test 'dict echo: uttrn -> turn' {
    correct_word uttrn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo turn'
}

@test 'dict echo: uutrn -> turn' {
    correct_word uutrn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo turn'
}

@test 'dict echo: turrn -> turn' {
    correct_word turrn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo turn'
}

@test 'dict echo: uefi -> UEFI' {
    correct_word uefi
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo UEFI'
}

@test 'dict echo: uner -> under' {
    correct_word uner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo under'
}

@test 'dict echo: udner -> under' {
    correct_word udner
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo under'
}

@test 'dict echo: uder -> under' {
    correct_word uder
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo under'
}

@test 'dict echo: unix -> Unix' {
    correct_word unix
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo Unix'
}

@test 'dict echo: updatet -> update' {
    correct_word updatet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo update'
}

@test 'dict echo: updaet -> update' {
    correct_word updaet
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo update'
}

@test 'dict echo: upd8 -> update' {
    correct_word upd8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo update'
}

@test 'dict echo: uri -> URI' {
    correct_word uri
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo URI'
}

@test 'dict echo: url -> URL' {
    correct_word url
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo URL'
}

@test 'dict echo: usb -> USB' {
    correct_word usb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo USB'
}

@test 'dict echo: ues -> use' {
    correct_word ues
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo use'
}

@test 'dict echo: suing -> using' {
    correct_word suing
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo using'
}

@test 'dict echo: usnig -> using' {
    correct_word usnig
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo using'
}

@test 'dict echo: usu -> usually' {
    correct_word usu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo usually'
}

@test 'dict echo: utf-8 -> UTF-8' {
    correct_word utf-8
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo UTF-8'
}

@test 'dict echo: vlaue -> value' {
    correct_word vlaue
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo value'
}

@test 'dict echo: valeu -> value' {
    correct_word valeu
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo value'
}

@test 'dict echo: var -> variable' {
    correct_word var
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo variable'
}

@test 'dict echo: vra -> variable' {
    correct_word vra
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo variable'
}

@test 'dict echo: vars -> variables' {
    correct_word vars
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo variables'
}

@test 'dict echo: vectoor -> vector' {
    correct_word vectoor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo vector'
}

@test 'dict echo: vverb -> verb' {
    correct_word vverb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo verb'
}

@test 'dict echo: erbb -> verb' {
    correct_word erbb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo verb'
}

@test 'dict echo: vverbb -> verb' {
    correct_word vverbb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo verb'
}

@test 'dict echo: verbb -> verb' {
    correct_word verbb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo verb'
}

@test 'dict echo: veerb -> verb' {
    correct_word veerb
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo verb'
}

@test 'dict echo: verssion -> version' {
    correct_word verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo version'
}

@test 'dict echo: verion -> version' {
    correct_word verion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo version'
}

@test 'dict echo: verison -> version' {
    correct_word verison
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo version'
}

@test 'dict echo: versioon -> version' {
    correct_word versioon
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo version'
}

@test 'dict echo: Verssion -> Version' {
    correct_word Verssion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo Version'
}

@test 'dict echo: Verion -> Version' {
    correct_word Verion
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo Version'
}

@test 'dict echo: Verison -> Version' {
    correct_word Verison
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo Version'
}

@test 'dict echo: ivm -> vim' {
    correct_word ivm
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo vim'
}

@test 'dict echo: vpn -> VPN' {
    correct_word vpn
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo VPN'
}

@test 'dict echo: wasnt -> was not' {
    correct_word wasnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo was not'
}

@test 'dict echo: whitespaec -> whitespace' {
    correct_word whitespaec
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'dict echo: whitespacee -> whitespace' {
    correct_word whitespacee
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'dict echo: whitespacce -> whitespace' {
    correct_word whitespacce
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'dict echo: whitesppace -> whitespace' {
    correct_word whitesppace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'dict echo: whitespaace -> whitespace' {
    correct_word whitespaace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'dict echo: hwy -> why' {
    correct_word hwy
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo why'
}

@test 'dict echo: wyh -> why' {
    correct_word wyh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo why'
}

@test 'dict echo: wont -> will not' {
    correct_word wont
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo will not'
}

@test 'dict echo: with -> with' {
    correct_word with
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo with'
}

@test 'dict echo: wiht -> with' {
    correct_word wiht
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo with'
}

@test 'dict echo: itwh -> with' {
    correct_word itwh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo with'
}

@test 'dict echo: witth -> with' {
    correct_word witth
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo with'
}

@test 'dict echo: iwth -> with' {
    correct_word iwth
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo with'
}

@test 'dict echo: wtih -> with' {
    correct_word wtih
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo with'
}

@test 'dict echo: wo -> without' {
    correct_word wo
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo without'
}

@test 'dict echo: w/o -> without' {
    correct_word w/o
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo without'
}

@test 'dict echo: wrk -> work' {
    correct_word wrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo work'
}

@test 'dict echo: werk -> work' {
    correct_word werk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo work'
}

@test 'dict echo: owrk -> work' {
    correct_word owrk
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo work'
}

@test 'dict echo: wokr -> work' {
    correct_word wokr
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo work'
}

@test 'dict echo: wouldnt -> would not' {
    correct_word wouldnt
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo would not'
}

@test 'dict echo: wirte -> write' {
    correct_word wirte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo write'
}

@test 'dict echo: wrrite -> write' {
    correct_word wrrite
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo write'
}

@test 'dict echo: writte -> write' {
    correct_word writte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo write'
}

@test 'dict echo: wiirrrte -> write' {
    correct_word wiirrrte
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo write'
}

@test 'dict echo: xml -> XML' {
    correct_word xml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo XML'
}

@test 'dict echo: yaml -> YAML' {
    correct_word yaml
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo YAML'
}

@test 'dict echo: yuor -> your' {
    correct_word yuor
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo your'
}

@test 'dict echo: ur -> your' {
    correct_word ur
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo your'
}

@test 'dict echo: zhs -> zsh' {
    correct_word zhs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo zsh'
}

@test 'dict echo: zshh -> zsh' {
    correct_word zshh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo zsh'
}

@test 'dict echo: zzsh -> zsh' {
    correct_word zzsh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo zsh'
}

@test 'dict echo: zssh -> zsh' {
    correct_word zssh
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
    assert $LBUFFER same_as 'echo zsh'
}

