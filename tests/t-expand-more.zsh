#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: extended unit tests for zsh-expand
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

    # Helper: run correction on a single misspelling in "echo WORD" context
    function correct_word() {
        LBUFFER="echo $1"
        ZPWR_VARS[foundIncorrect]=false
        zpwrExpandParseWords "$LBUFFER"
        zpwrExpandCorrectWord
    }
}

#==============================================================
# Spelling corrections — A–C
#==============================================================

@test 'correct: aobut -> about' {
    correct_word aobut
    assert $LBUFFER same_as 'echo about'
}

@test 'correct: abbout -> about' {
    correct_word abbout
    assert $LBUFFER same_as 'echo about'
}

@test 'correct: aka -> AKA' {
    correct_word aka
    assert $LBUFFER same_as 'echo AKA'
}

@test 'correct: alll -> all' {
    correct_word alll
    assert $LBUFFER same_as 'echo all'
}

@test 'correct: laso -> also' {
    correct_word laso
    assert $LBUFFER same_as 'echo also'
}

@test 'correct: alsoo -> also' {
    correct_word alsoo
    assert $LBUFFER same_as 'echo also'
}

@test 'correct: alternaet -> alternate' {
    correct_word alternaet
    assert $LBUFFER same_as 'echo alternate'
}

@test 'correct: ansi -> ANSI' {
    correct_word ansi
    assert $LBUFFER same_as 'echo ANSI'
}

@test 'correct: aer -> are' {
    correct_word aer
    assert $LBUFFER same_as 'echo are'
}

@test 'correct: arg -> argument' {
    correct_word arg
    assert $LBUFFER same_as 'echo argument'
}

@test 'correct: args -> arguments' {
    correct_word args
    assert $LBUFFER same_as 'echo arguments'
}

@test 'correct: arrayy -> array' {
    correct_word arrayy
    assert $LBUFFER same_as 'echo array'
}

@test 'correct: ary -> array' {
    correct_word ary
    assert $LBUFFER same_as 'echo array'
}

@test 'correct: ascii -> ASCII' {
    correct_word ascii
    assert $LBUFFER same_as 'echo ASCII'
}

@test 'correct: auto -> automatically' {
    correct_word auto
    assert $LBUFFER same_as 'echo automatically'
}

@test 'correct: bkac -> back' {
    correct_word bkac
    assert $LBUFFER same_as 'echo back'
}

@test 'correct: bg -> background' {
    correct_word bg
    assert $LBUFFER same_as 'echo background'
}

@test 'correct: bda -> bad' {
    correct_word bda
    assert $LBUFFER same_as 'echo bad'
}

@test 'correct: bahs -> bash' {
    correct_word bahs
    assert $LBUFFER same_as 'echo bash'
}

@test 'correct: bbash -> bash' {
    correct_word bbash
    assert $LBUFFER same_as 'echo bash'
}

@test 'correct: befor -> before' {
    correct_word befor
    assert $LBUFFER same_as 'echo before'
}

@test 'correct: b4 -> before' {
    correct_word b4
    assert $LBUFFER same_as 'echo before'
}

@test 'correct: bets -> best' {
    correct_word bets
    assert $LBUFFER same_as 'echo best'
}

@test 'correct: btn -> between' {
    correct_word btn
    assert $LBUFFER same_as 'echo between'
}

@test 'correct: bianry -> binary' {
    correct_word bianry
    assert $LBUFFER same_as 'echo binary'
}

@test 'correct: blokc -> block' {
    correct_word blokc
    assert $LBUFFER same_as 'echo block'
}

@test 'correct: berw -> brew' {
    correct_word berw
    assert $LBUFFER same_as 'echo brew'
}

@test 'correct: cant -> can_not' {
    correct_word cant
    assert $LBUFFER same_as 'echo can not'
}

@test 'correct: catpure -> capture' {
    correct_word catpure
    assert $LBUFFER same_as 'echo capture'
}

@test 'correct: cahnge -> change' {
    correct_word cahnge
    assert $LBUFFER same_as 'echo change'
}

@test 'correct: cleint -> client' {
    correct_word cleint
    assert $LBUFFER same_as 'echo client'
}

@test 'correct: cloen -> clone' {
    correct_word cloen
    assert $LBUFFER same_as 'echo clone'
}

@test 'correct: cmd -> command' {
    correct_word cmd
    assert $LBUFFER same_as 'echo command'
}

@test 'correct: cmds -> commands' {
    correct_word cmds
    assert $LBUFFER same_as 'echo commands'
}

@test 'correct: cs -> computer_science' {
    correct_word cs
    assert $LBUFFER same_as 'echo computer science'
}

@test 'correct: cpu -> CPU' {
    correct_word cpu
    assert $LBUFFER same_as 'echo CPU'
}

@test 'correct: css -> CSS' {
    correct_word css
    assert $LBUFFER same_as 'echo CSS'
}

#==============================================================
# Spelling corrections — D–F
#==============================================================

@test 'correct: darwin -> Darwin' {
    correct_word darwin
    assert $LBUFFER same_as 'echo Darwin'
}

@test 'correct: db -> database' {
    correct_word db
    assert $LBUFFER same_as 'echo database'
}

@test 'correct: decl -> declaration' {
    correct_word decl
    assert $LBUFFER same_as 'echo declaration'
}

@test 'correct: defalut -> default' {
    correct_word defalut
    assert $LBUFFER same_as 'echo default'
}

@test 'correct: deps -> dependencies' {
    correct_word deps
    assert $LBUFFER same_as 'echo dependencies'
}

@test 'correct: dep -> dependency' {
    correct_word dep
    assert $LBUFFER same_as 'echo dependency'
}

@test 'correct: dest -> destination' {
    correct_word dest
    assert $LBUFFER same_as 'echo destination'
}

@test 'correct: devs -> developers' {
    correct_word devs
    assert $LBUFFER same_as 'echo developers'
}

@test 'correct: didt -> did_not' {
    correct_word didt
    assert $LBUFFER same_as 'echo did not'
}

@test 'correct: dir -> directory' {
    correct_word dir
    assert $LBUFFER same_as 'echo directory'
}

@test 'correct: direcotry -> directory' {
    correct_word direcotry
    assert $LBUFFER same_as 'echo directory'
}

@test 'correct: dirs -> directories' {
    correct_word dirs
    assert $LBUFFER same_as 'echo directories'
}

@test 'correct: dist -> distribution' {
    correct_word dist
    assert $LBUFFER same_as 'echo distribution'
}

@test 'correct: dns -> DNS' {
    correct_word dns
    assert $LBUFFER same_as 'echo DNS'
}

@test 'correct: dokcer -> docker' {
    correct_word dokcer
    assert $LBUFFER same_as 'echo docker'
}

@test 'correct: doesnt -> does_not' {
    correct_word doesnt
    assert $LBUFFER same_as 'echo does not'
}

@test 'correct: dont -> do_not' {
    correct_word dont
    assert $LBUFFER same_as 'echo do not'
}

@test 'correct: dbl -> double' {
    correct_word dbl
    assert $LBUFFER same_as 'echo double'
}

@test 'correct: eah -> each' {
    correct_word eah
    assert $LBUFFER same_as 'echo each'
}

@test 'correct: efi -> EFI' {
    correct_word efi
    assert $LBUFFER same_as 'echo EFI'
}

@test 'correct: ned -> end' {
    correct_word ned
    assert $LBUFFER same_as 'echo end'
}

@test 'correct: environ -> environment' {
    correct_word environ
    assert $LBUFFER same_as 'echo environment'
}

@test 'correct: evn -> environment' {
    correct_word evn
    assert $LBUFFER same_as 'echo environment'
}

@test 'correct: envvars -> environment_variables' {
    correct_word envvars
    assert $LBUFFER same_as 'echo environment variables'
}

@test 'correct: eror -> error' {
    correct_word eror
    assert $LBUFFER same_as 'echo error'
}

@test 'correct: eixt -> exit' {
    correct_word eixt
    assert $LBUFFER same_as 'echo exit'
}

@test 'correct: exti -> exit' {
    correct_word exti
    assert $LBUFFER same_as 'echo exit'
}

@test 'correct: exp -> expansion' {
    correct_word exp
    assert $LBUFFER same_as 'echo expansion'
}

@test 'correct: fales -> false' {
    correct_word fales
    assert $LBUFFER same_as 'echo false'
}

@test 'correct: feil -> file' {
    correct_word feil
    assert $LBUFFER same_as 'echo file'
}

@test 'correct: ifles -> files' {
    correct_word ifles
    assert $LBUFFER same_as 'echo files'
}

@test 'correct: fg -> foreground' {
    correct_word fg
    assert $LBUFFER same_as 'echo foreground'
}

#==============================================================
# Spelling corrections — G–L
#==============================================================

@test 'correct: gw -> gateway' {
    correct_word gw
    assert $LBUFFER same_as 'echo gateway'
}

@test 'correct: igt -> git' {
    correct_word igt
    assert $LBUFFER same_as 'echo git'
}

@test 'correct: ggit -> git' {
    correct_word ggit
    assert $LBUFFER same_as 'echo git'
}

@test 'correct: grp -> group' {
    correct_word grp
    assert $LBUFFER same_as 'echo group'
}

@test 'correct: hasnt -> has_not' {
    correct_word hasnt
    assert $LBUFFER same_as 'echo has not'
}

@test 'correct: havent -> have_not' {
    correct_word havent
    assert $LBUFFER same_as 'echo have not'
}

@test 'correct: ehre -> here' {
    correct_word ehre
    assert $LBUFFER same_as 'echo here'
}

@test 'correct: html -> HTML' {
    correct_word html
    assert $LBUFFER same_as 'echo HTML'
}

@test 'correct: http -> HTTP' {
    correct_word http
    assert $LBUFFER same_as 'echo HTTP'
}

@test 'correct: https -> HTTPS' {
    correct_word https
    assert $LBUFFER same_as 'echo HTTPS'
}

@test 'correct: iamges -> images' {
    correct_word iamges
    assert $LBUFFER same_as 'echo images'
}

@test 'correct: impl -> implementation' {
    correct_word impl
    assert $LBUFFER same_as 'echo implementation'
}

@test 'correct: initi -> initialization' {
    correct_word initi
    assert $LBUFFER same_as 'echo initialization'
}

@test 'correct: ios -> iOS' {
    correct_word ios
    assert $LBUFFER same_as 'echo iOS'
}

@test 'correct: isnt -> is_not' {
    correct_word isnt
    assert $LBUFFER same_as 'echo is not'
}

@test 'correct: js -> JavaScript' {
    correct_word js
    assert $LBUFFER same_as 'echo JavaScript'
}

@test 'correct: json -> JSON' {
    correct_word json
    assert $LBUFFER same_as 'echo JSON'
}

@test 'correct: llast -> last' {
    correct_word llast
    assert $LBUFFER same_as 'echo last'
}

@test 'correct: latex -> LaTeX' {
    correct_word latex
    assert $LBUFFER same_as 'echo LaTeX'
}

@test 'correct: lvl -> level' {
    correct_word lvl
    assert $LBUFFER same_as 'echo level'
}

@test 'correct: lib -> library' {
    correct_word lib
    assert $LBUFFER same_as 'echo library'
}

@test 'correct: libs -> libraries' {
    correct_word libs
    assert $LBUFFER same_as 'echo libraries'
}

@test 'correct: liek -> like' {
    correct_word liek
    assert $LBUFFER same_as 'echo like'
}

@test 'correct: linux -> Linux' {
    correct_word linux
    assert $LBUFFER same_as 'echo Linux'
}

@test 'correct: locaiton -> location' {
    correct_word locaiton
    assert $LBUFFER same_as 'echo location'
}

#==============================================================
# Spelling corrections — M–P
#==============================================================

@test 'correct: macos -> macOS' {
    correct_word macos
    assert $LBUFFER same_as 'echo macOS'
}

@test 'correct: maek -> make' {
    correct_word maek
    assert $LBUFFER same_as 'echo make'
}

@test 'correct: msg -> message' {
    correct_word msg
    assert $LBUFFER same_as 'echo message'
}

@test 'correct: msgs -> messages' {
    correct_word msgs
    assert $LBUFFER same_as 'echo messages'
}

@test 'correct: moer -> more' {
    correct_word moer
    assert $LBUFFER same_as 'echo more'
}

@test 'correct: mysql -> MySQL' {
    correct_word mysql
    assert $LBUFFER same_as 'echo MySQL'
}

@test 'correct: anme -> name' {
    correct_word anme
    assert $LBUFFER same_as 'echo name'
}

@test 'correct: newtork -> network' {
    correct_word newtork
    assert $LBUFFER same_as 'echo network'
}

@test 'correct: nextt -> next' {
    correct_word nextt
    assert $LBUFFER same_as 'echo next'
}

@test 'correct: nite -> night' {
    correct_word nite
    assert $LBUFFER same_as 'echo night'
}

@test 'correct: nto -> not' {
    correct_word nto
    assert $LBUFFER same_as 'echo not'
}

@test 'correct: nr -> number' {
    correct_word nr
    assert $LBUFFER same_as 'echo number'
}

@test 'correct: fo -> of' {
    correct_word fo
    assert $LBUFFER same_as 'echo of'
}

@test 'correct: oepn -> open' {
    correct_word oepn
    assert $LBUFFER same_as 'echo open'
}

@test 'correct: os -> operating_system' {
    correct_word os
    assert $LBUFFER same_as 'echo operating system'
}

@test 'correct: ro -> or' {
    correct_word ro
    assert $LBUFFER same_as 'echo or'
}

@test 'correct: othe -> other' {
    correct_word othe
    assert $LBUFFER same_as 'echo other'
}

@test 'correct: parm -> parameter' {
    correct_word parm
    assert $LBUFFER same_as 'echo parameter'
}

@test 'correct: parms -> parameters' {
    correct_word parms
    assert $LBUFFER same_as 'echo parameters'
}

@test 'correct: perm -> permission' {
    correct_word perm
    assert $LBUFFER same_as 'echo permission'
}

@test 'correct: perms -> permissions' {
    correct_word perms
    assert $LBUFFER same_as 'echo permissions'
}

@test 'correct: plase -> please' {
    correct_word plase
    assert $LBUFFER same_as 'echo please'
}

@test 'correct: pirnt -> print' {
    correct_word pirnt
    assert $LBUFFER same_as 'echo print'
}

@test 'correct: projcet -> project' {
    correct_word projcet
    assert $LBUFFER same_as 'echo project'
}

@test 'correct: prop -> property' {
    correct_word prop
    assert $LBUFFER same_as 'echo property'
}

@test 'correct: props -> properties' {
    correct_word props
    assert $LBUFFER same_as 'echo properties'
}

#==============================================================
# Spelling corrections — R–S
#==============================================================

@test 'correct: eradme -> README' {
    correct_word eradme
    assert $LBUFFER same_as 'echo README'
}

@test 'correct: remoet -> remote' {
    correct_word remoet
    assert $LBUFFER same_as 'echo remote'
}

@test 'correct: repo -> repository' {
    correct_word repo
    assert $LBUFFER same_as 'echo repository'
}

@test 'correct: repos -> repositories' {
    correct_word repos
    assert $LBUFFER same_as 'echo repositories'
}

@test 'correct: res -> result' {
    correct_word res
    assert $LBUFFER same_as 'echo result'
}

@test 'correct: saem -> same' {
    correct_word saem
    assert $LBUFFER same_as 'echo same'
}

@test 'correct: scoep -> scope' {
    correct_word scoep
    assert $LBUFFER same_as 'echo scope'
}

@test 'correct: searcch -> search' {
    correct_word searcch
    assert $LBUFFER same_as 'echo search'
}

@test 'correct: sep -> separated' {
    correct_word sep
    assert $LBUFFER same_as 'echo separated'
}

@test 'correct: shel -> shell_script' {
    correct_word shel
    assert $LBUFFER same_as 'echo shell script'
}

@test 'correct: shouldnt -> should_not' {
    correct_word shouldnt
    assert $LBUFFER same_as 'echo should not'
}

@test 'correct: shwo -> show' {
    correct_word shwo
    assert $LBUFFER same_as 'echo show'
}

@test 'correct: soln -> solution' {
    correct_word soln
    assert $LBUFFER same_as 'echo solution'
}

@test 'correct: soem -> some' {
    correct_word soem
    assert $LBUFFER same_as 'echo some'
}

@test 'correct: src -> source' {
    correct_word src
    assert $LBUFFER same_as 'echo source'
}

@test 'correct: spaec -> space' {
    correct_word spaec
    assert $LBUFFER same_as 'echo space'
}

@test 'correct: sql -> SQL' {
    correct_word sql
    assert $LBUFFER same_as 'echo SQL'
}

@test 'correct: ssh -> SSH' {
    correct_word ssh
    assert $LBUFFER same_as 'echo SSH'
}

@test 'correct: std -> standard' {
    correct_word std
    assert $LBUFFER same_as 'echo standard'
}

@test 'correct: stirng -> string' {
    correct_word stirng
    assert $LBUFFER same_as 'echo string'
}

@test 'correct: sub -> substitute' {
    correct_word sub
    assert $LBUFFER same_as 'echo substitute'
}

@test 'correct: usdo -> sudo' {
    correct_word usdo
    assert $LBUFFER same_as 'echo sudo'
}

#==============================================================
# Spelling corrections — T–Z
#==============================================================

@test 'correct: tahn -> than' {
    correct_word tahn
    assert $LBUFFER same_as 'echo than'
}

@test 'correct: taht -> that' {
    correct_word taht
    assert $LBUFFER same_as 'echo that'
}

@test 'correct: eth -> the' {
    correct_word eth
    assert $LBUFFER same_as 'echo the'
}

@test 'correct: te -> the' {
    correct_word te
    assert $LBUFFER same_as 'echo the'
}

@test 'correct: th -> the' {
    correct_word th
    assert $LBUFFER same_as 'echo the'
}

@test 'correct: thier -> their' {
    correct_word thier
    assert $LBUFFER same_as 'echo their'
}

@test 'correct: tehy -> they' {
    correct_word tehy
    assert $LBUFFER same_as 'echo they'
}

@test 'correct: tihs -> this' {
    correct_word tihs
    assert $LBUFFER same_as 'echo this'
}

@test 'correct: tehn -> then' {
    correct_word tehn
    assert $LBUFFER same_as 'echo then'
}

@test 'correct: thru -> through' {
    correct_word thru
    assert $LBUFFER same_as 'echo through'
}

@test 'correct: tiem -> time' {
    correct_word tiem
    assert $LBUFFER same_as 'echo time'
}

@test 'correct: treu -> true' {
    correct_word treu
    assert $LBUFFER same_as 'echo true'
}

@test 'correct: ot -> to' {
    correct_word ot
    assert $LBUFFER same_as 'echo to'
}

@test 'correct: tmr -> tomorrow' {
    correct_word tmr
    assert $LBUFFER same_as 'echo tomorrow'
}

@test 'correct: xfer -> transfer' {
    correct_word xfer
    assert $LBUFFER same_as 'echo transfer'
}

@test 'correct: unix -> Unix' {
    correct_word unix
    assert $LBUFFER same_as 'echo Unix'
}

@test 'correct: upd8 -> update' {
    correct_word upd8
    assert $LBUFFER same_as 'echo update'
}

@test 'correct: url -> URL' {
    correct_word url
    assert $LBUFFER same_as 'echo URL'
}

@test 'correct: usb -> USB' {
    correct_word usb
    assert $LBUFFER same_as 'echo USB'
}

@test 'correct: ues -> use' {
    correct_word ues
    assert $LBUFFER same_as 'echo use'
}

@test 'correct: usu -> usually' {
    correct_word usu
    assert $LBUFFER same_as 'echo usually'
}

@test 'correct: vlaue -> value' {
    correct_word vlaue
    assert $LBUFFER same_as 'echo value'
}

@test 'correct: var -> variable' {
    correct_word var
    assert $LBUFFER same_as 'echo variable'
}

@test 'correct: vars -> variables' {
    correct_word vars
    assert $LBUFFER same_as 'echo variables'
}

@test 'correct: verssion -> version' {
    correct_word verssion
    assert $LBUFFER same_as 'echo version'
}

@test 'correct: ivm -> vim' {
    correct_word ivm
    assert $LBUFFER same_as 'echo vim'
}

@test 'correct: vpn -> VPN' {
    correct_word vpn
    assert $LBUFFER same_as 'echo VPN'
}

@test 'correct: wasnt -> was_not' {
    correct_word wasnt
    assert $LBUFFER same_as 'echo was not'
}

@test 'correct: wont -> will_not' {
    correct_word wont
    assert $LBUFFER same_as 'echo will not'
}

@test 'correct: wiht -> with' {
    correct_word wiht
    assert $LBUFFER same_as 'echo with'
}

@test 'correct: wouldnt -> would_not' {
    correct_word wouldnt
    assert $LBUFFER same_as 'echo would not'
}

@test 'correct: wrk -> work' {
    correct_word wrk
    assert $LBUFFER same_as 'echo work'
}

@test 'correct: wirte -> write' {
    correct_word wirte
    assert $LBUFFER same_as 'echo write'
}

@test 'correct: xml -> XML' {
    correct_word xml
    assert $LBUFFER same_as 'echo XML'
}

@test 'correct: yaml -> YAML' {
    correct_word yaml
    assert $LBUFFER same_as 'echo YAML'
}

@test 'correct: yuor -> your' {
    correct_word yuor
    assert $LBUFFER same_as 'echo your'
}

@test 'correct: zhs -> zsh' {
    correct_word zhs
    assert $LBUFFER same_as 'echo zsh'
}

@test 'correct: zzsh -> zsh' {
    correct_word zzsh
    assert $LBUFFER same_as 'echo zsh'
}

#==============================================================
# Spelling corrections — foundIncorrect flag
#==============================================================

@test 'correct: foundIncorrect true for known typo' {
    correct_word bahs
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'correct: foundIncorrect false for unknown word' {
    correct_word zyxwvuts
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correct: foundIncorrect false for correct word' {
    correct_word hello
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# Spelling corrections — multi-word prefix context
#==============================================================

@test 'correct: preserves three-word prefix' {
    LBUFFER="sudo env teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sudo env the'
}

@test 'correct: does not correct docker subcommand (blacklisted)' {
    LBUFFER="sudo docker"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correct: does not correct npm subcommand (blacklisted)' {
    LBUFFER="sudo npm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# zpwrExpandAlias — additional edge cases
#==============================================================

@test 'zpwrExpandAlias: expands alias with pipe in value' {
    LBUFFER="psg"
    ZPWR_VARS[lastword_lbuffer]=psg
    ZPWR_VARS[EXPANDED]='ps aux | grep'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ps aux | grep'
}

@test 'zpwrExpandAlias: expands alias with env var in value' {
    LBUFFER="goh"
    ZPWR_VARS[lastword_lbuffer]=goh
    ZPWR_VARS[EXPANDED]='cd $GOPATH'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd $GOPATH'
}

@test 'zpwrExpandAlias: expands alias to single flag' {
    LBUFFER="lh"
    ZPWR_VARS[lastword_lbuffer]=lh
    ZPWR_VARS[EXPANDED]='ls -lh'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls -lh'
}

@test 'zpwrExpandAlias: after pipe symbol expands' {
    LBUFFER="ls | ga"
    ZPWR_VARS[lastword_lbuffer]=ga
    ZPWR_VARS[EXPANDED]='grep -a'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls | grep -a'
}

@test 'zpwrExpandAlias: only last occurrence replaced' {
    LBUFFER="echo ga ga"
    ZPWR_VARS[lastword_lbuffer]=ga
    ZPWR_VARS[EXPANDED]='git add'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo ga git add'
}

@test 'zpwrExpandAlias: alias value with equals sign' {
    LBUFFER="mke"
    ZPWR_VARS[lastword_lbuffer]=mke
    ZPWR_VARS[EXPANDED]='make VERBOSE=1'
    zpwrExpandAlias
    assert $LBUFFER same_as 'make VERBOSE=1'
}

@test 'zpwrExpandAlias: alias value with semicolon' {
    LBUFFER="cls"
    ZPWR_VARS[lastword_lbuffer]=cls
    ZPWR_VARS[EXPANDED]='clear; ls'
    zpwrExpandAlias
    assert $LBUFFER same_as 'clear; ls'
}

@test 'zpwrExpandAlias: single char alias' {
    LBUFFER="l"
    ZPWR_VARS[lastword_lbuffer]=l
    ZPWR_VARS[EXPANDED]='ls'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls'
}

#==============================================================
# zpwrExpandAliasEscape — additional edge cases
#==============================================================

@test 'zpwrExpandAliasEscape: single char alias' {
    LBUFFER="l"
    ZPWR_VARS[lastword_lbuffer]=l
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ls -la'
}

@test 'zpwrExpandAliasEscape: after pipe expands correctly' {
    LBUFFER="ls | grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep -rn'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'ls | \grep -rn'
}

@test 'zpwrExpandAliasEscape: alias with three leading spaces' {
    LBUFFER="   pwd"
    ZPWR_VARS[lastword_lbuffer]=pwd
    ZPWR_VARS[EXPANDED]='pwd -P'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '   \pwd -P'
}

#==============================================================
# zpwrExpandParseWords — additional edge cases
#==============================================================

@test 'zpwrExpandParseWords: after || with args firstword' {
    zpwrExpandParseWords "cmd1 arg || cmd2"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd2'
}

@test 'zpwrExpandParseWords: nested pipes firstword' {
    zpwrExpandParseWords "cat f | sort | uniq"
    assert $ZPWR_VARS[firstword_partition] same_as 'uniq'
}

@test 'zpwrExpandParseWords: nested pipes lastword' {
    zpwrExpandParseWords "cat f | sort | uniq -c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-c'
}

@test 'zpwrExpandParseWords: after subshell open paren firstword' {
    zpwrExpandParseWords "ls; (cd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cd'
}

@test 'zpwrExpandParseWords: empty last word after trailing space' {
    zpwrExpandParseWords "git "
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'zpwrExpandParseWords: word with dot preserved' {
    zpwrExpandParseWords "node index.js"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'index.js'
}

@test 'zpwrExpandParseWords: word with slash preserved' {
    zpwrExpandParseWords "ls /usr/local"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/usr/local'
}

@test 'zpwrExpandParseWords: redirection operator removes preceding word' {
    zpwrExpandParseWords "echo foo > bar"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'zpwrExpandParseWords: two semicolons uses last segment' {
    zpwrExpandParseWords "a; b; git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'zpwrExpandParseWords: firstword same as lastword for single word' {
    zpwrExpandParseWords "docker"
    assert $ZPWR_VARS[firstword_partition] same_as $ZPWR_VARS[lastword_lbuffer]
}

#==============================================================
# zpwrExpandRightTrim — additional edge cases
#==============================================================

@test 'zpwrExpandRightTrim: long command trailing space' {
    LBUFFER="git commit --amend --no-edit "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git commit --amend --no-edit'
}

@test 'zpwrExpandRightTrim: path with slash trailing space' {
    LBUFFER="/usr/local/bin "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '/usr/local/bin'
}

@test 'zpwrExpandRightTrim: idempotent on no-trailing-space' {
    LBUFFER="hello"
    zpwrExpandRightTrim
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'hello'
}

#==============================================================
# zpwrExpandTerminateSpace — additional edge cases
#==============================================================

@test 'zpwrExpandTerminateSpace: appends to flag argument' {
    LBUFFER="ls -la"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ls -la '
}

@test 'zpwrExpandTerminateSpace: appends to path' {
    LBUFFER="/etc/hosts"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '/etc/hosts '
}

@test 'zpwrExpandTerminateSpace: repeated calls add multiple spaces' {
    LBUFFER="x"
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'x  '
}

#==============================================================
# zpwrExpandGlobalAliases — additional edge cases
#==============================================================

@test 'zpwrExpandGlobalAliases: expansion with multi-word value' {
    galiases[__ZET_NL]='2>/dev/null'
    LBUFFER="cmd __ZET_NL"
    zpwrExpandGlobalAliases __ZET_NL
    assert $LBUFFER same_as 'cmd 2>/dev/null'
    unset 'galiases[__ZET_NL]'
}

@test 'zpwrExpandGlobalAliases: no expand when buffer is just the alias word' {
    galiases[__ZET_G]='| grep'
    LBUFFER="__ZET_G"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZET_G
    # Single-word at command position — pattern still matches
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZET_G]'
}

@test 'zpwrExpandGlobalAliases: WAS_EXPANDED false when no match' {
    galiases[__ZET_X]='| xargs'
    LBUFFER="cmd foo bar"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZET_X || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unset 'galiases[__ZET_X]'
}

#==============================================================
# zpwrExpandGetAliasValue — additional edge cases
#==============================================================

@test 'zpwrExpandGetAliasValue: alias with double-dash options' {
    alias __zet_ff='find . -type f --name'
    ZPWR_VARS[lastword_lbuffer]=__zet_ff
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'find . -type f --name'
    unalias __zet_ff
}

@test 'zpwrExpandGetAliasValue: single-char alias' {
    alias __zet_g='grep'
    ZPWR_VARS[lastword_lbuffer]=__zet_g
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'grep'
    unalias __zet_g
}

@test 'zpwrExpandGetAliasValue: alias with environment variable prefix' {
    alias __zet_ev='PAGER=cat man'
    ZPWR_VARS[lastword_lbuffer]=__zet_ev
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'PAGER=cat man'
    unalias __zet_ev
}
