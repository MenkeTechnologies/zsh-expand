#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive spelling correction tests for zsh-expand
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
    ZPWR_EXPAND_SUFFIX=false
    ZPWR_TRACE=false

    function correct_word() {
        LBUFFER="echo $1"
        ZPWR_VARS[foundIncorrect]=false
        zpwrExpandParseWords "$LBUFFER"
        zpwrExpandCorrectWord
    }
}

#==============================================================
# about
#==============================================================

@test 'correct: aabout -> about' {
    correct_word aabout
    assert $LBUFFER same_as 'echo about'
}

#==============================================================
# alternate
#==============================================================

@test 'correct: alterntae -> alternate' {
    correct_word alterntae
    assert $LBUFFER same_as 'echo alternate'
}

#==============================================================
# also
#==============================================================

@test 'correct: alos -> also' {
    correct_word alos
    assert $LBUFFER same_as 'echo also'
}

@test 'correct: allso -> also' {
    correct_word allso
    assert $LBUFFER same_as 'echo also'
}

#==============================================================
# all
#==============================================================

@test 'correct: al -> all' {
    correct_word al
    assert $LBUFFER same_as 'echo all'
}

@test 'correct: aall -> all' {
    correct_word aall
    assert $LBUFFER same_as 'echo all'
}

#==============================================================
# and
#==============================================================

#==============================================================
# are
#==============================================================

@test 'correct: rea -> are' {
    correct_word rea
    assert $LBUFFER same_as 'echo are'
}

#==============================================================
# argument
#==============================================================

@test 'correct: rag -> argument' {
    correct_word rag
    assert $LBUFFER same_as 'echo argument'
}

@test 'correct: agr -> argument' {
    correct_word agr
    assert $LBUFFER same_as 'echo argument'
}

#==============================================================
# arguments
#==============================================================

@test 'correct: rags -> arguments' {
    correct_word rags
    assert $LBUFFER same_as 'echo arguments'
}

@test 'correct: agrs -> arguments' {
    correct_word agrs
    assert $LBUFFER same_as 'echo arguments'
}

#==============================================================
# array
#==============================================================

@test 'correct: arr -> array' {
    correct_word arr
    assert $LBUFFER same_as 'echo array'
}

@test 'correct: aary -> array' {
    correct_word aary
    assert $LBUFFER same_as 'echo array'
}

@test 'correct: aray -> array' {
    correct_word aray
    assert $LBUFFER same_as 'echo array'
}

@test 'correct: arrray -> array' {
    correct_word arrray
    assert $LBUFFER same_as 'echo array'
}

#==============================================================
# AWS
#==============================================================

@test 'correct: aws -> AWS' {
    correct_word aws
    assert $LBUFFER same_as 'echo AWS'
}

#==============================================================
# back
#==============================================================

@test 'correct: bakc -> back' {
    correct_word bakc
    assert $LBUFFER same_as 'echo back'
}

@test 'correct: abck -> back' {
    correct_word abck
    assert $LBUFFER same_as 'echo back'
}

#==============================================================
# bad
#==============================================================

@test 'correct: abd -> bad' {
    correct_word abd
    assert $LBUFFER same_as 'echo bad'
}

#==============================================================
# bandwidth
#==============================================================

@test 'correct: bw -> bandwidth' {
    correct_word bw
    assert $LBUFFER same_as 'echo bandwidth'
}

#==============================================================
# bash
#==============================================================

@test 'correct: baash -> bash' {
    correct_word baash
    assert $LBUFFER same_as 'echo bash'
}

@test 'correct: bassh -> bash' {
    correct_word bassh
    assert $LBUFFER same_as 'echo bash'
}

@test 'correct: bashh -> bash' {
    correct_word bashh
    assert $LBUFFER same_as 'echo bash'
}

#==============================================================
# based
#==============================================================

@test 'correct: baesd -> based' {
    correct_word baesd
    assert $LBUFFER same_as 'echo based'
}

@test 'correct: absed -> based' {
    correct_word absed
    assert $LBUFFER same_as 'echo based'
}

#==============================================================
# because
#==============================================================

@test 'correct: bc -> because' {
    correct_word bc
    assert $LBUFFER same_as 'echo because'
}

#==============================================================
# before
#==============================================================

@test 'correct: beforre -> before' {
    correct_word beforre
    assert $LBUFFER same_as 'echo before'
}

@test 'correct: befre -> before' {
    correct_word befre
    assert $LBUFFER same_as 'echo before'
}

@test 'correct: beffooorr -> before' {
    correct_word beffooorr
    assert $LBUFFER same_as 'echo before'
}

@test 'correct: beforee -> before' {
    correct_word beforee
    assert $LBUFFER same_as 'echo before'
}

#==============================================================
# between
#==============================================================

@test 'correct: bt -> between' {
    correct_word bt
    assert $LBUFFER same_as 'echo between'
}

@test 'correct: between -> between' {
    correct_word between
    assert $LBUFFER same_as 'echo between'
}

#==============================================================
# binary
#==============================================================

@test 'correct: bniary -> binary' {
    correct_word bniary
    assert $LBUFFER same_as 'echo binary'
}

#==============================================================
# BIOS
#==============================================================

@test 'correct: bios -> BIOS' {
    correct_word bios
    assert $LBUFFER same_as 'echo BIOS'
}

#==============================================================
# BSD
#==============================================================

@test 'correct: bsd -> BSD' {
    correct_word bsd
    assert $LBUFFER same_as 'echo BSD'
}

#==============================================================
# block
#==============================================================

@test 'correct: bolck -> block' {
    correct_word bolck
    assert $LBUFFER same_as 'echo block'
}

@test 'correct: lbock -> block' {
    correct_word lbock
    assert $LBUFFER same_as 'echo block'
}

#==============================================================
# brew
#==============================================================

@test 'correct: brerw -> brew' {
    correct_word brerw
    assert $LBUFFER same_as 'echo brew'
}

@test 'correct: berww -> brew' {
    correct_word berww
    assert $LBUFFER same_as 'echo brew'
}

@test 'correct: brrerw -> brew' {
    correct_word brrerw
    assert $LBUFFER same_as 'echo brew'
}

@test 'correct: breww -> brew' {
    correct_word breww
    assert $LBUFFER same_as 'echo brew'
}

@test 'correct: bbrrew -> brew' {
    correct_word bbrrew
    assert $LBUFFER same_as 'echo brew'
}

@test 'correct: brrew -> brew' {
    correct_word brrew
    assert $LBUFFER same_as 'echo brew'
}

#==============================================================
# capture
#==============================================================

@test 'correct: catprue -> capture' {
    correct_word catprue
    assert $LBUFFER same_as 'echo capture'
}

@test 'correct: caputre -> capture' {
    correct_word caputre
    assert $LBUFFER same_as 'echo capture'
}

#==============================================================
# case
#==============================================================

@test 'correct: caes -> case' {
    correct_word caes
    assert $LBUFFER same_as 'echo case'
}

#==============================================================
# CDN
#==============================================================

@test 'correct: cdn -> CDN' {
    correct_word cdn
    assert $LBUFFER same_as 'echo CDN'
}

#==============================================================
# CLI
#==============================================================

@test 'correct: cli -> CLI' {
    correct_word cli
    assert $LBUFFER same_as 'echo CLI'
}

#==============================================================
# change
#==============================================================

@test 'correct: chnage -> change' {
    correct_word chnage
    assert $LBUFFER same_as 'echo change'
}

@test 'correct: chagne -> change' {
    correct_word chagne
    assert $LBUFFER same_as 'echo change'
}

@test 'correct: chaeng -> change' {
    correct_word chaeng
    assert $LBUFFER same_as 'echo change'
}

@test 'correct: changen -> change' {
    correct_word changen
    assert $LBUFFER same_as 'echo change'
}

#==============================================================
# click
#==============================================================

@test 'correct: clikc -> click' {
    correct_word clikc
    assert $LBUFFER same_as 'echo click'
}

@test 'correct: clik -> click' {
    correct_word clik
    assert $LBUFFER same_as 'echo click'
}

#==============================================================
# close
#==============================================================

@test 'correct: cloes -> close' {
    correct_word cloes
    assert $LBUFFER same_as 'echo close'
}

#==============================================================
# command
#==============================================================

@test 'correct: comand -> command' {
    correct_word comand
    assert $LBUFFER same_as 'echo command'
}

@test 'correct: aommnd -> command' {
    correct_word aommnd
    assert $LBUFFER same_as 'echo command'
}

@test 'correct: commnd -> command' {
    correct_word commnd
    assert $LBUFFER same_as 'echo command'
}

@test 'correct: comamnd -> command' {
    correct_word comamnd
    assert $LBUFFER same_as 'echo command'
}

@test 'correct: ocmmand -> command' {
    correct_word ocmmand
    assert $LBUFFER same_as 'echo command'
}

#==============================================================
# commands
#==============================================================

@test 'correct: comands -> commands' {
    correct_word comands
    assert $LBUFFER same_as 'echo commands'
}

@test 'correct: aommnds -> commands' {
    correct_word aommnds
    assert $LBUFFER same_as 'echo commands'
}

@test 'correct: commnds -> commands' {
    correct_word commnds
    assert $LBUFFER same_as 'echo commands'
}

@test 'correct: comamnds -> commands' {
    correct_word comamnds
    assert $LBUFFER same_as 'echo commands'
}

@test 'correct: ocmmands -> commands' {
    correct_word ocmmands
    assert $LBUFFER same_as 'echo commands'
}

#==============================================================
# computer_science
#==============================================================

@test 'correct: compsci -> computer science' {
    correct_word compsci
    assert $LBUFFER same_as 'echo computer science'
}

#==============================================================
# count
#==============================================================

@test 'correct: ocunt -> count' {
    correct_word ocunt
    assert $LBUFFER same_as 'echo count'
}

@test 'correct: coont -> count' {
    correct_word coont
    assert $LBUFFER same_as 'echo count'
}

#==============================================================
# create
#==============================================================

@test 'correct: ccreate -> create' {
    correct_word ccreate
    assert $LBUFFER same_as 'echo create'
}

@test 'correct: craete -> create' {
    correct_word craete
    assert $LBUFFER same_as 'echo create'
}

#==============================================================
# custom
#==============================================================

@test 'correct: custmo -> custom' {
    correct_word custmo
    assert $LBUFFER same_as 'echo custom'
}

@test 'correct: cusotm -> custom' {
    correct_word cusotm
    assert $LBUFFER same_as 'echo custom'
}

#==============================================================
# database
#==============================================================

@test 'correct: datab -> database' {
    correct_word datab
    assert $LBUFFER same_as 'echo database'
}

#==============================================================
# databases
#==============================================================

@test 'correct: dbs -> databases' {
    correct_word dbs
    assert $LBUFFER same_as 'echo databases'
}

@test 'correct: databs -> databases' {
    correct_word databs
    assert $LBUFFER same_as 'echo databases'
}

#==============================================================
# DDL
#==============================================================

@test 'correct: ddl -> DDL' {
    correct_word ddl
    assert $LBUFFER same_as 'echo DDL'
}

#==============================================================
# declare
#==============================================================

@test 'correct: delcare -> declare' {
    correct_word delcare
    assert $LBUFFER same_as 'echo declare'
}

@test 'correct: declaer -> declare' {
    correct_word declaer
    assert $LBUFFER same_as 'echo declare'
}

#==============================================================
# default
#==============================================================

@test 'correct: deafult -> default' {
    correct_word deafult
    assert $LBUFFER same_as 'echo default'
}

#==============================================================
# dependencies
#==============================================================

@test 'correct: dependenceis -> dependencies' {
    correct_word dependenceis
    assert $LBUFFER same_as 'echo dependencies'
}

#==============================================================
# dependency
#==============================================================

@test 'correct: dependenc -> dependency' {
    correct_word dependenc
    assert $LBUFFER same_as 'echo dependency'
}

#==============================================================
# delay
#==============================================================

@test 'correct: dly -> delay' {
    correct_word dly
    assert $LBUFFER same_as 'echo delay'
}

#==============================================================
# developer
#==============================================================

@test 'correct: deve -> developer' {
    correct_word deve
    assert $LBUFFER same_as 'echo developer'
}

#==============================================================
# did_not
#==============================================================

@test 'correct: didnt -> did not' {
    correct_word didnt
    assert $LBUFFER same_as 'echo did not'
}

#==============================================================
# directory
#==============================================================

@test 'correct: ddir -> directory' {
    correct_word ddir
    assert $LBUFFER same_as 'echo directory'
}

@test 'correct: idr -> directory' {
    correct_word idr
    assert $LBUFFER same_as 'echo directory'
}

@test 'correct: direcorty -> directory' {
    correct_word direcorty
    assert $LBUFFER same_as 'echo directory'
}

@test 'correct: directroy -> directory' {
    correct_word directroy
    assert $LBUFFER same_as 'echo directory'
}

#==============================================================
# directories
#==============================================================

@test 'correct: dirss -> directories' {
    correct_word dirss
    assert $LBUFFER same_as 'echo directories'
}

@test 'correct: ddirs -> directories' {
    correct_word ddirs
    assert $LBUFFER same_as 'echo directories'
}

@test 'correct: idrs -> directories' {
    correct_word idrs
    assert $LBUFFER same_as 'echo directories'
}

@test 'correct: direcotries -> directories' {
    correct_word direcotries
    assert $LBUFFER same_as 'echo directories'
}

@test 'correct: direcorties -> directories' {
    correct_word direcorties
    assert $LBUFFER same_as 'echo directories'
}

@test 'correct: directroies -> directories' {
    correct_word directroies
    assert $LBUFFER same_as 'echo directories'
}

@test 'correct: dirz -> directories' {
    correct_word dirz
    assert $LBUFFER same_as 'echo directories'
}

#==============================================================
# distribution
#==============================================================

@test 'correct: distro -> distribution' {
    correct_word distro
    assert $LBUFFER same_as 'echo distribution'
}

#==============================================================
# DMA
#==============================================================

@test 'correct: dma -> DMA' {
    correct_word dma
    assert $LBUFFER same_as 'echo DMA'
}

#==============================================================
# DML
#==============================================================

@test 'correct: dml -> DML' {
    correct_word dml
    assert $LBUFFER same_as 'echo DML'
}

#==============================================================
# DQL
#==============================================================

@test 'correct: dql -> DQL' {
    correct_word dql
    assert $LBUFFER same_as 'echo DQL'
}

#==============================================================
# docker
#==============================================================

#==============================================================
# documentation
#==============================================================

@test 'correct: docu -> documentation' {
    correct_word docu
    assert $LBUFFER same_as 'echo documentation'
}

@test 'correct: docs -> documentation' {
    correct_word docs
    assert $LBUFFER same_as 'echo documentation'
}

#==============================================================
# double
#==============================================================

@test 'correct: doubel -> double' {
    correct_word doubel
    assert $LBUFFER same_as 'echo double'
}

#==============================================================
# drag
#==============================================================

@test 'correct: darg -> drag' {
    correct_word darg
    assert $LBUFFER same_as 'echo drag'
}

#==============================================================
# drop
#==============================================================

@test 'correct: dorp -> drop' {
    correct_word dorp
    assert $LBUFFER same_as 'echo drop'
}

@test 'correct: dorpp -> drop' {
    correct_word dorpp
    assert $LBUFFER same_as 'echo drop'
}

@test 'correct: dropp -> drop' {
    correct_word dropp
    assert $LBUFFER same_as 'echo drop'
}

#==============================================================
# during
#==============================================================

@test 'correct: durring -> during' {
    correct_word durring
    assert $LBUFFER same_as 'echo during'
}

@test 'correct: durriing -> during' {
    correct_word durriing
    assert $LBUFFER same_as 'echo during'
}

@test 'correct: durrring -> during' {
    correct_word durrring
    assert $LBUFFER same_as 'echo during'
}

@test 'correct: durinng -> during' {
    correct_word durinng
    assert $LBUFFER same_as 'echo during'
}

@test 'correct: duringg -> during' {
    correct_word duringg
    assert $LBUFFER same_as 'echo during'
}

@test 'correct: duurig -> during' {
    correct_word duurig
    assert $LBUFFER same_as 'echo during'
}

@test 'correct: durign -> during' {
    correct_word durign
    assert $LBUFFER same_as 'echo during'
}

@test 'correct: durrgn -> during' {
    correct_word durrgn
    assert $LBUFFER same_as 'echo during'
}

#==============================================================
# echo
#==============================================================

@test 'correct: eo -> echo' {
    correct_word eo
    assert $LBUFFER same_as 'echo echo'
}

@test 'correct: eccho -> echo' {
    correct_word eccho
    assert $LBUFFER same_as 'echo echo'
}

@test 'correct: eho -> echo' {
    correct_word eho
    assert $LBUFFER same_as 'echo echo'
}

@test 'correct: ceho -> echo' {
    correct_word ceho
    assert $LBUFFER same_as 'echo echo'
}

@test 'correct: ecoh -> echo' {
    correct_word ecoh
    assert $LBUFFER same_as 'echo echo'
}

@test 'correct: eco -> echo' {
    correct_word eco
    assert $LBUFFER same_as 'echo echo'
}

#==============================================================
# end
#==============================================================

@test 'correct: ennd -> end' {
    correct_word ennd
    assert $LBUFFER same_as 'echo end'
}

@test 'correct: endd -> end' {
    correct_word endd
    assert $LBUFFER same_as 'echo end'
}

@test 'correct: nedd -> end' {
    correct_word nedd
    assert $LBUFFER same_as 'echo end'
}

@test 'correct: nned -> end' {
    correct_word nned
    assert $LBUFFER same_as 'echo end'
}

#==============================================================
# environment
#==============================================================

@test 'correct: env -> environment' {
    correct_word env
    assert $LBUFFER same_as 'echo environment'
}

#==============================================================
# environments
#==============================================================

@test 'correct: environs -> environments' {
    correct_word environs
    assert $LBUFFER same_as 'echo environments'
}

@test 'correct: evns -> environments' {
    correct_word evns
    assert $LBUFFER same_as 'echo environments'
}

@test 'correct: envs -> environments' {
    correct_word envs
    assert $LBUFFER same_as 'echo environments'
}

#==============================================================
# environment_variable
#==============================================================

@test 'correct: envvar -> environment variable' {
    correct_word envvar
    assert $LBUFFER same_as 'echo environment variable'
}

@test 'correct: ev -> environment variable' {
    correct_word ev
    assert $LBUFFER same_as 'echo environment variable'
}

#==============================================================
# environment_variables
#==============================================================

@test 'correct: evs -> environment variables' {
    correct_word evs
    assert $LBUFFER same_as 'echo environment variables'
}

#==============================================================
# error
#==============================================================

@test 'correct: err -> error' {
    correct_word err
    assert $LBUFFER same_as 'echo error'
}

@test 'correct: errroor -> error' {
    correct_word errroor
    assert $LBUFFER same_as 'echo error'
}

@test 'correct: errror -> error' {
    correct_word errror
    assert $LBUFFER same_as 'echo error'
}

@test 'correct: erroor -> error' {
    correct_word erroor
    assert $LBUFFER same_as 'echo error'
}

@test 'correct: erooor -> error' {
    correct_word erooor
    assert $LBUFFER same_as 'echo error'
}

#==============================================================
# exit
#==============================================================

@test 'correct: xeit -> exit' {
    correct_word xeit
    assert $LBUFFER same_as 'echo exit'
}

@test 'correct: xeti -> exit' {
    correct_word xeti
    assert $LBUFFER same_as 'echo exit'
}

#==============================================================
# IEEE
#==============================================================

@test 'correct: ieee -> IEEE' {
    correct_word ieee
    assert $LBUFFER same_as 'echo IEEE'
}

#==============================================================
# false
#==============================================================

@test 'correct: fals -> false' {
    correct_word fals
    assert $LBUFFER same_as 'echo false'
}

@test 'correct: fale -> false' {
    correct_word fale
    assert $LBUFFER same_as 'echo false'
}

@test 'correct: flase -> false' {
    correct_word flase
    assert $LBUFFER same_as 'echo false'
}

@test 'correct: fllase -> false' {
    correct_word fllase
    assert $LBUFFER same_as 'echo false'
}

@test 'correct: falles -> false' {
    correct_word falles
    assert $LBUFFER same_as 'echo false'
}

#==============================================================
# field
#==============================================================

@test 'correct: fied -> field' {
    correct_word fied
    assert $LBUFFER same_as 'echo field'
}

#==============================================================
# file
#==============================================================

@test 'correct: fie -> file' {
    correct_word fie
    assert $LBUFFER same_as 'echo file'
}

@test 'correct: fiel -> file' {
    correct_word fiel
    assert $LBUFFER same_as 'echo file'
}

@test 'correct: ifle -> file' {
    correct_word ifle
    assert $LBUFFER same_as 'echo file'
}

@test 'correct: fille -> file' {
    correct_word fille
    assert $LBUFFER same_as 'echo file'
}

@test 'correct: fillee -> file' {
    correct_word fillee
    assert $LBUFFER same_as 'echo file'
}

#==============================================================
# files
#==============================================================

@test 'correct: fies -> files' {
    correct_word fies
    assert $LBUFFER same_as 'echo files'
}

@test 'correct: fiess -> files' {
    correct_word fiess
    assert $LBUFFER same_as 'echo files'
}

@test 'correct: ffiess -> files' {
    correct_word ffiess
    assert $LBUFFER same_as 'echo files'
}

@test 'correct: filles -> files' {
    correct_word filles
    assert $LBUFFER same_as 'echo files'
}

@test 'correct: filees -> files' {
    correct_word filees
    assert $LBUFFER same_as 'echo files'
}

#==============================================================
# final
#==============================================================

@test 'correct: fnial -> final' {
    correct_word fnial
    assert $LBUFFER same_as 'echo final'
}

@test 'correct: fianl -> final' {
    correct_word fianl
    assert $LBUFFER same_as 'echo final'
}

@test 'correct: finl -> final' {
    correct_word finl
    assert $LBUFFER same_as 'echo final'
}

#==============================================================
# finger
#==============================================================

@test 'correct: fingre -> finger' {
    correct_word fingre
    assert $LBUFFER same_as 'echo finger'
}

@test 'correct: finegr -> finger' {
    correct_word finegr
    assert $LBUFFER same_as 'echo finger'
}

@test 'correct: figner -> finger' {
    correct_word figner
    assert $LBUFFER same_as 'echo finger'
}

#==============================================================
# first
#==============================================================

@test 'correct: firsst -> first' {
    correct_word firsst
    assert $LBUFFER same_as 'echo first'
}

@test 'correct: firstt -> first' {
    correct_word firstt
    assert $LBUFFER same_as 'echo first'
}

@test 'correct: firrst -> first' {
    correct_word firrst
    assert $LBUFFER same_as 'echo first'
}

@test 'correct: firsstt -> first' {
    correct_word firsstt
    assert $LBUFFER same_as 'echo first'
}

@test 'correct: ffirrst -> first' {
    correct_word ffirrst
    assert $LBUFFER same_as 'echo first'
}

#==============================================================
# for
#==============================================================

@test 'correct: forr -> for' {
    correct_word forr
    assert $LBUFFER same_as 'echo for'
}

@test 'correct: forrr -> for' {
    correct_word forrr
    assert $LBUFFER same_as 'echo for'
}

@test 'correct: fro -> for' {
    correct_word fro
    assert $LBUFFER same_as 'echo for'
}

@test 'correct: rfo -> for' {
    correct_word rfo
    assert $LBUFFER same_as 'echo for'
}

@test 'correct: rof -> for' {
    correct_word rof
    assert $LBUFFER same_as 'echo for'
}

@test 'correct: fr -> for' {
    correct_word fr
    assert $LBUFFER same_as 'echo for'
}

@test 'correct: ofr -> for' {
    correct_word ofr
    assert $LBUFFER same_as 'echo for'
}

#==============================================================
# found
#==============================================================

@test 'correct: ofund -> found' {
    correct_word ofund
    assert $LBUFFER same_as 'echo found'
}

@test 'correct: fuond -> found' {
    correct_word fuond
    assert $LBUFFER same_as 'echo found'
}

@test 'correct: foudn -> found' {
    correct_word foudn
    assert $LBUFFER same_as 'echo found'
}

#==============================================================
# function
#==============================================================

@test 'correct: fxn -> function' {
    correct_word fxn
    assert $LBUFFER same_as 'echo function'
}

@test 'correct: func -> function' {
    correct_word func
    assert $LBUFFER same_as 'echo function'
}

#==============================================================
# functional
#==============================================================

@test 'correct: fxnal -> functional' {
    correct_word fxnal
    assert $LBUFFER same_as 'echo functional'
}

@test 'correct: funcal -> functional' {
    correct_word funcal
    assert $LBUFFER same_as 'echo functional'
}

@test 'correct: fnal -> functional' {
    correct_word fnal
    assert $LBUFFER same_as 'echo functional'
}

#==============================================================
# functions
#==============================================================

@test 'correct: fxns -> functions' {
    correct_word fxns
    assert $LBUFFER same_as 'echo functions'
}

@test 'correct: funcs -> functions' {
    correct_word funcs
    assert $LBUFFER same_as 'echo functions'
}

#==============================================================
# git
#==============================================================

#==============================================================
# go
#==============================================================

@test 'correct: og -> go' {
    correct_word og
    assert $LBUFFER same_as 'echo go'
}

#==============================================================
# GPT
#==============================================================

@test 'correct: gpt -> GPT' {
    correct_word gpt
    assert $LBUFFER same_as 'echo GPT'
}

#==============================================================
# GPU
#==============================================================

@test 'correct: gpu -> GPU' {
    correct_word gpu
    assert $LBUFFER same_as 'echo GPU'
}

#==============================================================
# group
#==============================================================

@test 'correct: gorup -> group' {
    correct_word gorup
    assert $LBUFFER same_as 'echo group'
}

@test 'correct: groop -> group' {
    correct_word groop
    assert $LBUFFER same_as 'echo group'
}

@test 'correct: gourp -> group' {
    correct_word gourp
    assert $LBUFFER same_as 'echo group'
}

#==============================================================
# H2
#==============================================================

@test 'correct: h2 -> H2' {
    correct_word h2
    assert $LBUFFER same_as 'echo H2'
}

#==============================================================
# HFS
#==============================================================

@test 'correct: hfs -> HFS' {
    correct_word hfs
    assert $LBUFFER same_as 'echo HFS'
}

#==============================================================
# high
#==============================================================

@test 'correct: hgih -> high' {
    correct_word hgih
    assert $LBUFFER same_as 'echo high'
}

@test 'correct: hihg -> high' {
    correct_word hihg
    assert $LBUFFER same_as 'echo high'
}

@test 'correct: ihgh -> high' {
    correct_word ihgh
    assert $LBUFFER same_as 'echo high'
}

@test 'correct: hi -> high' {
    correct_word hi
    assert $LBUFFER same_as 'echo high'
}

#==============================================================
# hold
#==============================================================

@test 'correct: hollld -> hold' {
    correct_word hollld
    assert $LBUFFER same_as 'echo hold'
}

@test 'correct: holld -> hold' {
    correct_word holld
    assert $LBUFFER same_as 'echo hold'
}

#==============================================================
# implementation
#==============================================================

#==============================================================
# including
#==============================================================

@test 'correct: incl -> including' {
    correct_word incl
    assert $LBUFFER same_as 'echo including'
}

#==============================================================
# interface
#==============================================================

@test 'correct: interfaec -> interface' {
    correct_word interfaec
    assert $LBUFFER same_as 'echo interface'
}

#==============================================================
# iPad
#==============================================================

@test 'correct: ipad -> iPad' {
    correct_word ipad
    assert $LBUFFER same_as 'echo iPad'
}

#==============================================================
# iPhone
#==============================================================

@test 'correct: iphone -> iPhone' {
    correct_word iphone
    assert $LBUFFER same_as 'echo iPhone'
}

#==============================================================
# is
#==============================================================

@test 'correct: si -> is' {
    correct_word si
    assert $LBUFFER same_as 'echo is'
}

@test 'correct: ise -> is' {
    correct_word ise
    assert $LBUFFER same_as 'echo is'
}

@test 'correct: isss -> is' {
    correct_word isss
    assert $LBUFFER same_as 'echo is'
}

@test 'correct: iss -> is' {
    correct_word iss
    assert $LBUFFER same_as 'echo is'
}

@test 'correct: iis -> is' {
    correct_word iis
    assert $LBUFFER same_as 'echo is'
}

#==============================================================
# is_not
#==============================================================

@test 'correct: sint -> is not' {
    correct_word sint
    assert $LBUFFER same_as 'echo is not'
}

#==============================================================
# inside
#==============================================================

@test 'correct: insdie -> inside' {
    correct_word insdie
    assert $LBUFFER same_as 'echo inside'
}

@test 'correct: isndie -> inside' {
    correct_word isndie
    assert $LBUFFER same_as 'echo inside'
}

@test 'correct: inisde -> inside' {
    correct_word inisde
    assert $LBUFFER same_as 'echo inside'
}

@test 'correct: isnide -> inside' {
    correct_word isnide
    assert $LBUFFER same_as 'echo inside'
}

@test 'correct: sindie -> inside' {
    correct_word sindie
    assert $LBUFFER same_as 'echo inside'
}

#==============================================================
# instead
#==============================================================

@test 'correct: insaed -> instead' {
    correct_word insaed
    assert $LBUFFER same_as 'echo instead'
}

@test 'correct: instaed -> instead' {
    correct_word instaed
    assert $LBUFFER same_as 'echo instead'
}

#==============================================================
# iSCSI
#==============================================================

@test 'correct: iscsi -> iSCSI' {
    correct_word iscsi
    assert $LBUFFER same_as 'echo iSCSI'
}

#==============================================================
# ISO
#==============================================================

@test 'correct: iso -> ISO' {
    correct_word iso
    assert $LBUFFER same_as 'echo ISO'
}

#==============================================================
# JSON
#==============================================================

#==============================================================
# just
#==============================================================

@test 'correct: jutsi -> just' {
    correct_word jutsi
    assert $LBUFFER same_as 'echo just'
}

@test 'correct: just -> just' {
    correct_word just
    assert $LBUFFER same_as 'echo just'
}

#==============================================================
# last
#==============================================================

@test 'correct: llasst -> last' {
    correct_word llasst
    assert $LBUFFER same_as 'echo last'
}

@test 'correct: lllast -> last' {
    correct_word lllast
    assert $LBUFFER same_as 'echo last'
}

#==============================================================
# layer
#==============================================================

@test 'correct: lyaer -> layer' {
    correct_word lyaer
    assert $LBUFFER same_as 'echo layer'
}

@test 'correct: layyer -> layer' {
    correct_word layyer
    assert $LBUFFER same_as 'echo layer'
}

@test 'correct: llayer -> layer' {
    correct_word llayer
    assert $LBUFFER same_as 'echo layer'
}

#==============================================================
# LED
#==============================================================

@test 'correct: led -> LED' {
    correct_word led
    assert $LBUFFER same_as 'echo LED'
}

#==============================================================
# levels
#==============================================================

@test 'correct: lvls -> levels' {
    correct_word lvls
    assert $LBUFFER same_as 'echo levels'
}

#==============================================================
# like
#==============================================================

@test 'correct: lik -> like' {
    correct_word lik
    assert $LBUFFER same_as 'echo like'
}

#==============================================================
# link
#==============================================================

@test 'correct: llink -> link' {
    correct_word llink
    assert $LBUFFER same_as 'echo link'
}

@test 'correct: linnk -> link' {
    correct_word linnk
    assert $LBUFFER same_as 'echo link'
}

@test 'correct: linkk -> link' {
    correct_word linkk
    assert $LBUFFER same_as 'echo link'
}

#==============================================================
# list
#==============================================================

@test 'correct: llist -> list' {
    correct_word llist
    assert $LBUFFER same_as 'echo list'
}

@test 'correct: llistt -> list' {
    correct_word llistt
    assert $LBUFFER same_as 'echo list'
}

@test 'correct: listt -> list' {
    correct_word listt
    assert $LBUFFER same_as 'echo list'
}

#==============================================================
# location
#==============================================================

@test 'correct: lcoation -> location' {
    correct_word lcoation
    assert $LBUFFER same_as 'echo location'
}

#==============================================================
# lock
#==============================================================

@test 'correct: lokc -> lock' {
    correct_word lokc
    assert $LBUFFER same_as 'echo lock'
}

@test 'correct: lcok -> lock' {
    correct_word lcok
    assert $LBUFFER same_as 'echo lock'
}

#==============================================================
# make
#==============================================================

#==============================================================
# MBR
#==============================================================

@test 'correct: mbr -> MBR' {
    correct_word mbr
    assert $LBUFFER same_as 'echo MBR'
}

#==============================================================
# mobile
#==============================================================

@test 'correct: mobille -> mobile' {
    correct_word mobille
    assert $LBUFFER same_as 'echo mobile'
}

#==============================================================
# motherboard
#==============================================================

@test 'correct: mobo -> motherboard' {
    correct_word mobo
    assert $LBUFFER same_as 'echo motherboard'
}

#==============================================================
# move
#==============================================================

@test 'correct: moev -> move' {
    correct_word moev
    assert $LBUFFER same_as 'echo move'
}

#==============================================================
# mount
#==============================================================

@test 'correct: mounr -> mount' {
    correct_word mounr
    assert $LBUFFER same_as 'echo mount'
}

@test 'correct: mounf -> mount' {
    correct_word mounf
    assert $LBUFFER same_as 'echo mount'
}

#==============================================================
# MIDI
#==============================================================

@test 'correct: midi -> MIDI' {
    correct_word midi
    assert $LBUFFER same_as 'echo MIDI'
}

#==============================================================
# namespace
#==============================================================

@test 'correct: namepsace -> namespace' {
    correct_word namepsace
    assert $LBUFFER same_as 'echo namespace'
}

@test 'correct: naemspace -> namespace' {
    correct_word naemspace
    assert $LBUFFER same_as 'echo namespace'
}

@test 'correct: naempsace -> namespace' {
    correct_word naempsace
    assert $LBUFFER same_as 'echo namespace'
}

#==============================================================
# name
#==============================================================

@test 'correct: naem -> name' {
    correct_word naem
    assert $LBUFFER same_as 'echo name'
}

#==============================================================
# next
#==============================================================

@test 'correct: nexxt -> next' {
    correct_word nexxt
    assert $LBUFFER same_as 'echo next'
}

@test 'correct: neext -> next' {
    correct_word neext
    assert $LBUFFER same_as 'echo next'
}

#==============================================================
# NTFS
#==============================================================

@test 'correct: ntfs -> NTFS' {
    correct_word ntfs
    assert $LBUFFER same_as 'echo NTFS'
}

#==============================================================
# number
#==============================================================

@test 'correct: numbre -> number' {
    correct_word numbre
    assert $LBUFFER same_as 'echo number'
}

@test 'correct: numebr -> number' {
    correct_word numebr
    assert $LBUFFER same_as 'echo number'
}

#==============================================================
# not
#==============================================================

@test 'correct: tno -> not' {
    correct_word tno
    assert $LBUFFER same_as 'echo not'
}

#==============================================================
# network
#==============================================================

@test 'correct: entwork -> network' {
    correct_word entwork
    assert $LBUFFER same_as 'echo network'
}

@test 'correct: ntework -> network' {
    correct_word ntework
    assert $LBUFFER same_as 'echo network'
}

#==============================================================
# of
#==============================================================

@test 'correct: oof -> of' {
    correct_word oof
    assert $LBUFFER same_as 'echo of'
}

#==============================================================
# open
#==============================================================

@test 'correct: ooopen -> open' {
    correct_word ooopen
    assert $LBUFFER same_as 'echo open'
}

@test 'correct: oopen -> open' {
    correct_word oopen
    assert $LBUFFER same_as 'echo open'
}

@test 'correct: oppen -> open' {
    correct_word oppen
    assert $LBUFFER same_as 'echo open'
}

@test 'correct: opeen -> open' {
    correct_word opeen
    assert $LBUFFER same_as 'echo open'
}

@test 'correct: openn -> open' {
    correct_word openn
    assert $LBUFFER same_as 'echo open'
}

#==============================================================
# or
#==============================================================

@test 'correct: orr -> or' {
    correct_word orr
    assert $LBUFFER same_as 'echo or'
}

#==============================================================
# other
#==============================================================

@test 'correct: toher -> other' {
    correct_word toher
    assert $LBUFFER same_as 'echo other'
}

#==============================================================
# outside
#==============================================================

@test 'correct: otuside -> outside' {
    correct_word otuside
    assert $LBUFFER same_as 'echo outside'
}

@test 'correct: outsdie -> outside' {
    correct_word outsdie
    assert $LBUFFER same_as 'echo outside'
}

#==============================================================
# over
#==============================================================

@test 'correct: voer -> over' {
    correct_word voer
    assert $LBUFFER same_as 'echo over'
}

@test 'correct: ovre -> over' {
    correct_word ovre
    assert $LBUFFER same_as 'echo over'
}

#==============================================================
# pack
#==============================================================

@test 'correct: packk -> pack' {
    correct_word packk
    assert $LBUFFER same_as 'echo pack'
}

@test 'correct: pacck -> pack' {
    correct_word pacck
    assert $LBUFFER same_as 'echo pack'
}

@test 'correct: ppack -> pack' {
    correct_word ppack
    assert $LBUFFER same_as 'echo pack'
}

#==============================================================
# PATA
#==============================================================

@test 'correct: pata -> PATA' {
    correct_word pata
    assert $LBUFFER same_as 'echo PATA'
}

#==============================================================
# PCI
#==============================================================

@test 'correct: pci -> PCI' {
    correct_word pci
    assert $LBUFFER same_as 'echo PCI'
}

#==============================================================
# perl
#==============================================================

@test 'correct: prel -> perl' {
    correct_word prel
    assert $LBUFFER same_as 'echo perl'
}

#==============================================================
# phase
#==============================================================

@test 'correct: phaes -> phase' {
    correct_word phaes
    assert $LBUFFER same_as 'echo phase'
}

@test 'correct: phae -> phase' {
    correct_word phae
    assert $LBUFFER same_as 'echo phase'
}

@test 'correct: phasee -> phase' {
    correct_word phasee
    assert $LBUFFER same_as 'echo phase'
}

@test 'correct: pahes -> phase' {
    correct_word pahes
    assert $LBUFFER same_as 'echo phase'
}

@test 'correct: phasse -> phase' {
    correct_word phasse
    assert $LBUFFER same_as 'echo phase'
}

#==============================================================
# PID
#==============================================================

@test 'correct: pid -> PID' {
    correct_word pid
    assert $LBUFFER same_as 'echo PID'
}

#==============================================================
# please
#==============================================================

@test 'correct: plz -> please' {
    correct_word plz
    assert $LBUFFER same_as 'echo please'
}

#==============================================================
# point
#==============================================================

@test 'correct: opint -> point' {
    correct_word opint
    assert $LBUFFER same_as 'echo point'
}

@test 'correct: ponit -> point' {
    correct_word ponit
    assert $LBUFFER same_as 'echo point'
}

#==============================================================
# port
#==============================================================

@test 'correct: pooort -> port' {
    correct_word pooort
    assert $LBUFFER same_as 'echo port'
}

@test 'correct: poort -> port' {
    correct_word poort
    assert $LBUFFER same_as 'echo port'
}

@test 'correct: porrt -> port' {
    correct_word porrt
    assert $LBUFFER same_as 'echo port'
}

@test 'correct: pport -> port' {
    correct_word pport
    assert $LBUFFER same_as 'echo port'
}

@test 'correct: portt -> port' {
    correct_word portt
    assert $LBUFFER same_as 'echo port'
}

@test 'correct: pportt -> port' {
    correct_word pportt
    assert $LBUFFER same_as 'echo port'
}

#==============================================================
# position
#==============================================================

@test 'correct: pos -> position' {
    correct_word pos
    assert $LBUFFER same_as 'echo position'
}

#==============================================================
# POSIX
#==============================================================

@test 'correct: posix -> POSIX' {
    correct_word posix
    assert $LBUFFER same_as 'echo POSIX'
}

#==============================================================
# print
#==============================================================

@test 'correct: pritn -> print' {
    correct_word pritn
    assert $LBUFFER same_as 'echo print'
}

@test 'correct: rpint -> print' {
    correct_word rpint
    assert $LBUFFER same_as 'echo print'
}

@test 'correct: prnit -> print' {
    correct_word prnit
    assert $LBUFFER same_as 'echo print'
}

#==============================================================
# probe
#==============================================================

@test 'correct: porbe -> probe' {
    correct_word porbe
    assert $LBUFFER same_as 'echo probe'
}

@test 'correct: rpobe -> probe' {
    correct_word rpobe
    assert $LBUFFER same_as 'echo probe'
}

#==============================================================
# project
#==============================================================

@test 'correct: proejct -> project' {
    correct_word proejct
    assert $LBUFFER same_as 'echo project'
}

@test 'correct: proeject -> project' {
    correct_word proeject
    assert $LBUFFER same_as 'echo project'
}

@test 'correct: porject -> project' {
    correct_word porject
    assert $LBUFFER same_as 'echo project'
}

@test 'correct: projeccct -> project' {
    correct_word projeccct
    assert $LBUFFER same_as 'echo project'
}

@test 'correct: projecct -> project' {
    correct_word projecct
    assert $LBUFFER same_as 'echo project'
}

@test 'correct: porjecct -> project' {
    correct_word porjecct
    assert $LBUFFER same_as 'echo project'
}

#==============================================================
# proxy
#==============================================================

@test 'correct: rpoxy -> proxy' {
    correct_word rpoxy
    assert $LBUFFER same_as 'echo proxy'
}

@test 'correct: poxy -> proxy' {
    correct_word poxy
    assert $LBUFFER same_as 'echo proxy'
}

@test 'correct: proxyy -> proxy' {
    correct_word proxyy
    assert $LBUFFER same_as 'echo proxy'
}

@test 'correct: proxxy -> proxy' {
    correct_word proxxy
    assert $LBUFFER same_as 'echo proxy'
}

@test 'correct: rrpoxy -> proxy' {
    correct_word rrpoxy
    assert $LBUFFER same_as 'echo proxy'
}

#==============================================================
# punctuation
#==============================================================

@test 'correct: punct -> punctuation' {
    correct_word punct
    assert $LBUFFER same_as 'echo punctuation'
}

#==============================================================
# radius
#==============================================================

@test 'correct: radisu -> radius' {
    correct_word radisu
    assert $LBUFFER same_as 'echo radius'
}

@test 'correct: raduis -> radius' {
    correct_word raduis
    assert $LBUFFER same_as 'echo radius'
}

#==============================================================
# range
#==============================================================

@test 'correct: rnage -> range' {
    correct_word rnage
    assert $LBUFFER same_as 'echo range'
}

@test 'correct: arnge -> range' {
    correct_word arnge
    assert $LBUFFER same_as 'echo range'
}

#==============================================================
# RGB
#==============================================================

@test 'correct: rgb -> RGB' {
    correct_word rgb
    assert $LBUFFER same_as 'echo RGB'
}

#==============================================================
# README
#==============================================================

@test 'correct: readme -> README' {
    correct_word readme
    assert $LBUFFER same_as 'echo README'
}

#==============================================================
# redo
#==============================================================

@test 'correct: rdeo -> redo' {
    correct_word rdeo
    assert $LBUFFER same_as 'echo redo'
}

@test 'correct: reod -> redo' {
    correct_word reod
    assert $LBUFFER same_as 'echo redo'
}

@test 'correct: edro -> redo' {
    correct_word edro
    assert $LBUFFER same_as 'echo redo'
}

@test 'correct: erdo -> redo' {
    correct_word erdo
    assert $LBUFFER same_as 'echo redo'
}

@test 'correct: redoo -> redo' {
    correct_word redoo
    assert $LBUFFER same_as 'echo redo'
}

@test 'correct: reddo -> redo' {
    correct_word reddo
    assert $LBUFFER same_as 'echo redo'
}

#==============================================================
# replace
#==============================================================

@test 'correct: replaec -> replace' {
    correct_word replaec
    assert $LBUFFER same_as 'echo replace'
}

@test 'correct: relpace -> replace' {
    correct_word relpace
    assert $LBUFFER same_as 'echo replace'
}

#==============================================================
# repository
#==============================================================

@test 'correct: rpeo -> repository' {
    correct_word rpeo
    assert $LBUFFER same_as 'echo repository'
}

#==============================================================
# repositories
#==============================================================

@test 'correct: rpeos -> repositories' {
    correct_word rpeos
    assert $LBUFFER same_as 'echo repositories'
}

#==============================================================
# result
#==============================================================

@test 'correct: resullt -> result' {
    correct_word resullt
    assert $LBUFFER same_as 'echo result'
}

@test 'correct: resultt -> result' {
    correct_word resultt
    assert $LBUFFER same_as 'echo result'
}

#==============================================================
# reverse
#==============================================================

@test 'correct: rvs -> reverse' {
    correct_word rvs
    assert $LBUFFER same_as 'echo reverse'
}

@test 'correct: revrse -> reverse' {
    correct_word revrse
    assert $LBUFFER same_as 'echo reverse'
}

#==============================================================
# reverb
#==============================================================

@test 'correct: rvb -> reverb' {
    correct_word rvb
    assert $LBUFFER same_as 'echo reverb'
}

#==============================================================
# route
#==============================================================

@test 'correct: rotue -> route' {
    correct_word rotue
    assert $LBUFFER same_as 'echo route'
}

@test 'correct: roote -> route' {
    correct_word roote
    assert $LBUFFER same_as 'echo route'
}

#==============================================================
# runnning
#==============================================================

@test 'correct: runnign -> runnning' {
    correct_word runnign
    assert $LBUFFER same_as 'echo runnning'
}

#==============================================================
# SATA
#==============================================================

@test 'correct: sata -> SATA' {
    correct_word sata
    assert $LBUFFER same_as 'echo SATA'
}

#==============================================================
# SCSI
#==============================================================

@test 'correct: scsi -> SCSI' {
    correct_word scsi
    assert $LBUFFER same_as 'echo SCSI'
}

#==============================================================
# scope
#==============================================================

@test 'correct: scoep -> scope' {
    correct_word scoep
    assert $LBUFFER same_as 'echo scope'
}

#==============================================================
# search
#==============================================================

@test 'correct: searhc -> search' {
    correct_word searhc
    assert $LBUFFER same_as 'echo search'
}

#==============================================================
# sed
#==============================================================

@test 'correct: esd -> sed' {
    correct_word esd
    assert $LBUFFER same_as 'echo sed'
}

#==============================================================
# set
#==============================================================

@test 'correct: est -> set' {
    correct_word est
    assert $LBUFFER same_as 'echo set'
}

@test 'correct: esst -> set' {
    correct_word esst
    assert $LBUFFER same_as 'echo set'
}

@test 'correct: ste -> set' {
    correct_word ste
    assert $LBUFFER same_as 'echo set'
}

#==============================================================
# separated
#==============================================================

@test 'correct: separaated -> separated' {
    correct_word separaated
    assert $LBUFFER same_as 'echo separated'
}

#==============================================================
# share
#==============================================================

@test 'correct: sahre -> share' {
    correct_word sahre
    assert $LBUFFER same_as 'echo share'
}

@test 'correct: shre -> share' {
    correct_word shre
    assert $LBUFFER same_as 'echo share'
}

#==============================================================
# show
#==============================================================

#==============================================================
# single
#==============================================================

@test 'correct: signle -> single' {
    correct_word signle
    assert $LBUFFER same_as 'echo single'
}

@test 'correct: singel -> single' {
    correct_word singel
    assert $LBUFFER same_as 'echo single'
}

#==============================================================
# solutions
#==============================================================

@test 'correct: solns -> solutions' {
    correct_word solns
    assert $LBUFFER same_as 'echo solutions'
}

#==============================================================
# some
#==============================================================

@test 'correct: som -> some' {
    correct_word som
    assert $LBUFFER same_as 'echo some'
}

@test 'correct: seom -> some' {
    correct_word seom
    assert $LBUFFER same_as 'echo some'
}

#==============================================================
# sound
#==============================================================

@test 'correct: osund -> sound' {
    correct_word osund
    assert $LBUFFER same_as 'echo sound'
}

#==============================================================
# source
#==============================================================

@test 'correct: sourcce -> source' {
    correct_word sourcce
    assert $LBUFFER same_as 'echo source'
}

@test 'correct: soure -> source' {
    correct_word soure
    assert $LBUFFER same_as 'echo source'
}

@test 'correct: sourec -> source' {
    correct_word sourec
    assert $LBUFFER same_as 'echo source'
}

@test 'correct: sourrce -> source' {
    correct_word sourrce
    assert $LBUFFER same_as 'echo source'
}

#==============================================================
# spelling
#==============================================================

@test 'correct: spellign -> spelling' {
    correct_word spellign
    assert $LBUFFER same_as 'echo spelling'
}

@test 'correct: spelilng -> spelling' {
    correct_word spelilng
    assert $LBUFFER same_as 'echo spelling'
}

#==============================================================
# space
#==============================================================

@test 'correct: spacee -> space' {
    correct_word spacee
    assert $LBUFFER same_as 'echo space'
}

@test 'correct: spacce -> space' {
    correct_word spacce
    assert $LBUFFER same_as 'echo space'
}

@test 'correct: sppace -> space' {
    correct_word sppace
    assert $LBUFFER same_as 'echo space'
}

@test 'correct: spaace -> space' {
    correct_word spaace
    assert $LBUFFER same_as 'echo space'
}

#==============================================================
# SSL
#==============================================================

@test 'correct: ssl -> SSL' {
    correct_word ssl
    assert $LBUFFER same_as 'echo SSL'
}

#==============================================================
# straight
#==============================================================

@test 'correct: st8 -> straight' {
    correct_word st8
    assert $LBUFFER same_as 'echo straight'
}

@test 'correct: strraight -> straight' {
    correct_word strraight
    assert $LBUFFER same_as 'echo straight'
}

@test 'correct: tsriaght -> straight' {
    correct_word tsriaght
    assert $LBUFFER same_as 'echo straight'
}

@test 'correct: tsrraight -> straight' {
    correct_word tsrraight
    assert $LBUFFER same_as 'echo straight'
}

@test 'correct: sstrraight -> straight' {
    correct_word sstrraight
    assert $LBUFFER same_as 'echo straight'
}

@test 'correct: straightt -> straight' {
    correct_word straightt
    assert $LBUFFER same_as 'echo straight'
}

#==============================================================
# state
#==============================================================

@test 'correct: staet -> state' {
    correct_word staet
    assert $LBUFFER same_as 'echo state'
}

@test 'correct: steta -> state' {
    correct_word steta
    assert $LBUFFER same_as 'echo state'
}

@test 'correct: sttae -> state' {
    correct_word sttae
    assert $LBUFFER same_as 'echo state'
}

#==============================================================
# states
#==============================================================

@test 'correct: staets -> states' {
    correct_word staets
    assert $LBUFFER same_as 'echo states'
}

@test 'correct: stetas -> states' {
    correct_word stetas
    assert $LBUFFER same_as 'echo states'
}

@test 'correct: sttaes -> states' {
    correct_word sttaes
    assert $LBUFFER same_as 'echo states'
}

#==============================================================
# store
#==============================================================

@test 'correct: tsore -> store' {
    correct_word tsore
    assert $LBUFFER same_as 'echo store'
}

@test 'correct: sotre -> store' {
    correct_word sotre
    assert $LBUFFER same_as 'echo store'
}

@test 'correct: stoer -> store' {
    correct_word stoer
    assert $LBUFFER same_as 'echo store'
}

#==============================================================
# string
#==============================================================

@test 'correct: stinrg -> string' {
    correct_word stinrg
    assert $LBUFFER same_as 'echo string'
}

#==============================================================
# sudo
#==============================================================

@test 'correct: usssdo -> sudo' {
    correct_word usssdo
    assert $LBUFFER same_as 'echo sudo'
}

@test 'correct: usddo -> sudo' {
    correct_word usddo
    assert $LBUFFER same_as 'echo sudo'
}

#==============================================================
# SYSV
#==============================================================

@test 'correct: sysv -> SYSV' {
    correct_word sysv
    assert $LBUFFER same_as 'echo SYSV'
}

#==============================================================
# that
#==============================================================

#==============================================================
# the
#==============================================================

@test 'correct: eht -> the' {
    correct_word eht
    assert $LBUFFER same_as 'echo the'
}

#==============================================================
# they
#==============================================================

@test 'correct: ethy -> they' {
    correct_word ethy
    assert $LBUFFER same_as 'echo they'
}

#==============================================================
# this
#==============================================================

@test 'correct: htis -> this' {
    correct_word htis
    assert $LBUFFER same_as 'echo this'
}

#==============================================================
# through
#==============================================================

@test 'correct: throug -> through' {
    correct_word throug
    assert $LBUFFER same_as 'echo through'
}

#==============================================================
# TLS
#==============================================================

@test 'correct: tls -> TLS' {
    correct_word tls
    assert $LBUFFER same_as 'echo TLS'
}

#==============================================================
# true
#==============================================================

@test 'correct: ture -> true' {
    correct_word ture
    assert $LBUFFER same_as 'echo true'
}

#==============================================================
# turn
#==============================================================

@test 'correct: tunr -> turn' {
    correct_word tunr
    assert $LBUFFER same_as 'echo turn'
}

@test 'correct: utrn -> turn' {
    correct_word utrn
    assert $LBUFFER same_as 'echo turn'
}

@test 'correct: uttrn -> turn' {
    correct_word uttrn
    assert $LBUFFER same_as 'echo turn'
}

@test 'correct: uutrn -> turn' {
    correct_word uutrn
    assert $LBUFFER same_as 'echo turn'
}

@test 'correct: turrn -> turn' {
    correct_word turrn
    assert $LBUFFER same_as 'echo turn'
}

#==============================================================
# to
#==============================================================

@test 'correct: ttto -> to' {
    correct_word ttto
    assert $LBUFFER same_as 'echo to'
}

@test 'correct: tto -> to' {
    correct_word tto
    assert $LBUFFER same_as 'echo to'
}

#==============================================================
# UEFI
#==============================================================

@test 'correct: uefi -> UEFI' {
    correct_word uefi
    assert $LBUFFER same_as 'echo UEFI'
}

#==============================================================
# under
#==============================================================

@test 'correct: uner -> under' {
    correct_word uner
    assert $LBUFFER same_as 'echo under'
}

@test 'correct: udner -> under' {
    correct_word udner
    assert $LBUFFER same_as 'echo under'
}

@test 'correct: uder -> under' {
    correct_word uder
    assert $LBUFFER same_as 'echo under'
}

#==============================================================
# update
#==============================================================

@test 'correct: updatet -> update' {
    correct_word updatet
    assert $LBUFFER same_as 'echo update'
}

@test 'correct: updaet -> update' {
    correct_word updaet
    assert $LBUFFER same_as 'echo update'
}

#==============================================================
# URI
#==============================================================

@test 'correct: uri -> URI' {
    correct_word uri
    assert $LBUFFER same_as 'echo URI'
}

#==============================================================
# UTF-8
#==============================================================

@test 'correct: utf-8 -> UTF-8' {
    correct_word utf-8
    assert $LBUFFER same_as 'echo UTF-8'
}

#==============================================================
# using
#==============================================================

@test 'correct: suing -> using' {
    correct_word suing
    assert $LBUFFER same_as 'echo using'
}

@test 'correct: usnig -> using' {
    correct_word usnig
    assert $LBUFFER same_as 'echo using'
}

#==============================================================
# value
#==============================================================

@test 'correct: valeu -> value' {
    correct_word valeu
    assert $LBUFFER same_as 'echo value'
}

#==============================================================
# variable
#==============================================================

@test 'correct: vra -> variable' {
    correct_word vra
    assert $LBUFFER same_as 'echo variable'
}

#==============================================================
# vector
#==============================================================

@test 'correct: vectoor -> vector' {
    correct_word vectoor
    assert $LBUFFER same_as 'echo vector'
}

#==============================================================
# verb
#==============================================================

@test 'correct: vverb -> verb' {
    correct_word vverb
    assert $LBUFFER same_as 'echo verb'
}

@test 'correct: erbb -> verb' {
    correct_word erbb
    assert $LBUFFER same_as 'echo verb'
}

@test 'correct: vverbb -> verb' {
    correct_word vverbb
    assert $LBUFFER same_as 'echo verb'
}

@test 'correct: verbb -> verb' {
    correct_word verbb
    assert $LBUFFER same_as 'echo verb'
}

@test 'correct: veerb -> verb' {
    correct_word veerb
    assert $LBUFFER same_as 'echo verb'
}

#==============================================================
# version
#==============================================================

@test 'correct: verion -> version' {
    correct_word verion
    assert $LBUFFER same_as 'echo version'
}

@test 'correct: verison -> version' {
    correct_word verison
    assert $LBUFFER same_as 'echo version'
}

@test 'correct: versioon -> version' {
    correct_word versioon
    assert $LBUFFER same_as 'echo version'
}

#==============================================================
# Version (capitalized)
#==============================================================

@test 'correct: Verssion -> Version' {
    correct_word Verssion
    assert $LBUFFER same_as 'echo Version'
}

@test 'correct: Verion -> Version' {
    correct_word Verion
    assert $LBUFFER same_as 'echo Version'
}

@test 'correct: Verison -> Version' {
    correct_word Verison
    assert $LBUFFER same_as 'echo Version'
}

#==============================================================
# was_not
#==============================================================

#==============================================================
# whitespace
#==============================================================

@test 'correct: whitespaec -> whitespace' {
    correct_word whitespaec
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'correct: whitespacee -> whitespace' {
    correct_word whitespacee
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'correct: whitespacce -> whitespace' {
    correct_word whitespacce
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'correct: whitesppace -> whitespace' {
    correct_word whitesppace
    assert $LBUFFER same_as 'echo whitespace'
}

@test 'correct: whitespaace -> whitespace' {
    correct_word whitespaace
    assert $LBUFFER same_as 'echo whitespace'
}

#==============================================================
# why
#==============================================================

@test 'correct: hwy -> why' {
    correct_word hwy
    assert $LBUFFER same_as 'echo why'
}

@test 'correct: wyh -> why' {
    correct_word wyh
    assert $LBUFFER same_as 'echo why'
}

#==============================================================
# with
#==============================================================

@test 'correct: itwh -> with' {
    correct_word itwh
    assert $LBUFFER same_as 'echo with'
}

@test 'correct: witth -> with' {
    correct_word witth
    assert $LBUFFER same_as 'echo with'
}

@test 'correct: iwth -> with' {
    correct_word iwth
    assert $LBUFFER same_as 'echo with'
}

@test 'correct: wtih -> with' {
    correct_word wtih
    assert $LBUFFER same_as 'echo with'
}

#==============================================================
# without
#==============================================================

@test 'correct: wo -> without' {
    correct_word wo
    assert $LBUFFER same_as 'echo without'
}

#==============================================================
# work
#==============================================================

@test 'correct: werk -> work' {
    correct_word werk
    assert $LBUFFER same_as 'echo work'
}

@test 'correct: owrk -> work' {
    correct_word owrk
    assert $LBUFFER same_as 'echo work'
}

@test 'correct: wokr -> work' {
    correct_word wokr
    assert $LBUFFER same_as 'echo work'
}

#==============================================================
# write
#==============================================================

@test 'correct: wrrite -> write' {
    correct_word wrrite
    assert $LBUFFER same_as 'echo write'
}

@test 'correct: writte -> write' {
    correct_word writte
    assert $LBUFFER same_as 'echo write'
}

@test 'correct: wiirrrte -> write' {
    correct_word wiirrrte
    assert $LBUFFER same_as 'echo write'
}

#==============================================================
# your
#==============================================================

@test 'correct: ur -> your' {
    correct_word ur
    assert $LBUFFER same_as 'echo your'
}

#==============================================================
# zsh
#==============================================================

@test 'correct: zshh -> zsh' {
    correct_word zshh
    assert $LBUFFER same_as 'echo zsh'
}

@test 'correct: zssh -> zsh' {
    correct_word zssh
    assert $LBUFFER same_as 'echo zsh'
}
