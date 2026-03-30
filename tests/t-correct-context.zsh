#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: spelling correction context and boundary tests
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
}

#==============================================================
# 1. echo TYPO — diverse misspellings
#==============================================================

@test 'echo: ehco -> echo' {
    LBUFFER="echo ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo echo'
}

@test 'echo: josn -> JSON' {
    LBUFFER="echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JSON'
}

@test 'echo: usdo -> sudo' {
    LBUFFER="echo usdo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo sudo'
}

@test 'echo: teh -> the' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'echo: hte -> the' {
    LBUFFER="echo hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'echo: adn -> and' {
    LBUFFER="echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'
}

@test 'echo: cpu -> CPU' {
    LBUFFER="echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo CPU'
}

@test 'echo: html -> HTML' {
    LBUFFER="echo html"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo HTML'
}

@test 'echo: sql -> SQL' {
    LBUFFER="echo sql"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo SQL'
}

@test 'echo: ssh -> SSH' {
    LBUFFER="echo ssh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo SSH'
}

@test 'echo: url -> URL' {
    LBUFFER="echo url"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo URL'
}

@test 'echo: usb -> USB' {
    LBUFFER="echo usb"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo USB'
}

@test 'echo: macos -> macOS' {
    LBUFFER="echo macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo macOS'
}

@test 'echo: linux -> Linux' {
    LBUFFER="echo linux"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo Linux'
}

@test 'echo: unix -> Unix' {
    LBUFFER="echo unix"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo Unix'
}

@test 'echo: darwin -> Darwin' {
    LBUFFER="echo darwin"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo Darwin'
}

@test 'echo: repo -> repository' {
    LBUFFER="echo repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo repository'
}

@test 'echo: deps -> dependencies' {
    LBUFFER="echo deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo dependencies'
}

@test 'echo: impl -> implementation' {
    LBUFFER="echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo implementation'
}

@test 'echo: fn -> function' {
    LBUFFER="echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo function'
}

@test 'echo: dir -> directory' {
    LBUFFER="echo dir"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo directory'
}

@test 'echo: src -> source' {
    LBUFFER="echo src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo source'
}

@test 'echo: db -> database' {
    LBUFFER="echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo database'
}

@test 'echo: cmd -> command' {
    LBUFFER="echo cmd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo command'
}

@test 'echo: doesnt -> does not' {
    LBUFFER="echo doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo does not'
}

@test 'echo: isnt -> is not' {
    LBUFFER="echo isnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo is not'
}

@test 'echo: cant -> can not' {
    LBUFFER="echo cant"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo can not'
}

@test 'echo: btw -> by the way' {
    LBUFFER="echo btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo by the way'
}

@test 'echo: gpu -> GPU' {
    LBUFFER="echo gpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo GPU'
}

@test 'echo: vpn -> VPN' {
    LBUFFER="echo vpn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo VPN'
}

@test 'echo: dns -> DNS' {
    LBUFFER="echo dns"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo DNS'
}

@test 'echo: ivm -> vim' {
    LBUFFER="echo ivm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo vim'
}

@test 'echo: prel -> perl' {
    LBUFFER="echo prel"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo perl'
}

@test 'echo: msg -> message' {
    LBUFFER="echo msg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo message'
}

@test 'echo: libs -> libraries' {
    LBUFFER="echo libs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo libraries'
}

@test 'echo: yaml -> YAML' {
    LBUFFER="echo yaml"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo YAML'
}

#==============================================================
# 2. print TYPO variations
#==============================================================

@test 'print: teh -> the' {
    LBUFFER="print teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print the'
}

@test 'print: hte -> the' {
    LBUFFER="print hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print the'
}

@test 'print: adn -> and' {
    LBUFFER="print adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print and'
}

@test 'print: josn -> JSON' {
    LBUFFER="print josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print JSON'
}

@test 'print: ehco -> echo' {
    LBUFFER="print ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print echo'
}

@test 'print: bahs -> bash' {
    LBUFFER="print bahs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print bash'
}

@test 'print: usdo -> sudo' {
    LBUFFER="print usdo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print sudo'
}

@test 'print: cpu -> CPU' {
    LBUFFER="print cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print CPU'
}

@test 'print: impl -> implementation' {
    LBUFFER="print impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print implementation'
}

@test 'print: fn -> function' {
    LBUFFER="print fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print function'
}

@test 'print: db -> database' {
    LBUFFER="print db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print database'
}

@test 'print: repo -> repository' {
    LBUFFER="print repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print repository'
}

@test 'print: deps -> dependencies' {
    LBUFFER="print deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print dependencies'
}

@test 'print: macos -> macOS' {
    LBUFFER="print macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print macOS'
}

@test 'print: linux -> Linux' {
    LBUFFER="print linux"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print Linux'
}

@test 'print: doesnt -> does not' {
    LBUFFER="print doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print does not'
}

@test 'print: wirte -> write' {
    LBUFFER="print wirte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print write'
}

@test 'print: ssl -> SSL' {
    LBUFFER="print ssl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print SSL'
}

@test 'print: xml -> XML' {
    LBUFFER="print xml"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print XML'
}

@test 'print: css -> CSS' {
    LBUFFER="print css"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print CSS'
}

#==============================================================
# 3. cat TYPO variations
#==============================================================

@test 'cat: teh -> the' {
    LBUFFER="cat teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat the'
}

@test 'cat: josn -> JSON' {
    LBUFFER="cat josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat JSON'
}

@test 'cat: feil -> file' {
    LBUFFER="cat feil"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat file'
}

@test 'cat: eror -> error' {
    LBUFFER="cat eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat error'
}

@test 'cat: src -> source' {
    LBUFFER="cat src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat source'
}

@test 'cat: msg -> message' {
    LBUFFER="cat msg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat message'
}

@test 'cat: dir -> directory' {
    LBUFFER="cat dir"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat directory'
}

@test 'cat: readme -> README' {
    LBUFFER="cat readme"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat README'
}

@test 'cat: http -> HTTP' {
    LBUFFER="cat http"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat HTTP'
}

@test 'cat: yaml -> YAML' {
    LBUFFER="cat yaml"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat YAML'
}

#==============================================================
# 4. grep TYPO variations
#==============================================================

@test 'grep: teh -> the' {
    LBUFFER="grep teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep the'
}

@test 'grep: eror -> error' {
    LBUFFER="grep eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep error'
}

@test 'grep: fn -> function' {
    LBUFFER="grep fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep function'
}

@test 'grep: feil -> file' {
    LBUFFER="grep feil"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep file'
}

@test 'grep: stirng -> string' {
    LBUFFER="grep stirng"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep string'
}

@test 'grep: src -> source' {
    LBUFFER="grep src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep source'
}

@test 'grep: var -> variable' {
    LBUFFER="grep var"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep variable'
}

@test 'grep: impl -> implementation' {
    LBUFFER="grep impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'grep implementation'
}

#==============================================================
# 5. sed TYPO variations
#==============================================================

@test 'sed: teh -> the' {
    LBUFFER="sed teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sed the'
}

@test 'sed: replaec -> replace' {
    LBUFFER="sed replaec"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sed replace'
}

@test 'sed: stirng -> string' {
    LBUFFER="sed stirng"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sed string'
}

@test 'sed: esd -> sed' {
    LBUFFER="echo esd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo sed'
}

@test 'sed: sub -> substitute' {
    LBUFFER="sed sub"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sed substitute'
}

#==============================================================
# 6. awk TYPO variations
#==============================================================

@test 'awk: teh -> the' {
    LBUFFER="awk teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'awk the'
}

@test 'awk: fied -> field' {
    LBUFFER="awk fied"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'awk field'
}

@test 'awk: pirnt -> print' {
    LBUFFER="awk pirnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'awk print'
}

@test 'awk: sep -> separated' {
    LBUFFER="awk sep"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'awk separated'
}

@test 'awk: var -> variable' {
    LBUFFER="awk var"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'awk variable'
}

#==============================================================
# 7. man TYPO variations
#==============================================================

@test 'man: bahs -> bash' {
    LBUFFER="man bahs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'man bash'
}

@test 'man: prel -> perl' {
    LBUFFER="man prel"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'man perl'
}

@test 'man: zhs -> zsh' {
    LBUFFER="man zhs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'man zsh'
}

@test 'man: ivm -> vim' {
    LBUFFER="man ivm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'man vim'
}

@test 'man: posix -> POSIX' {
    LBUFFER="man posix"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'man POSIX'
}

#==============================================================
# 8. ls TYPO variations
#==============================================================

@test 'ls: feil -> file' {
    LBUFFER="ls feil"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls file'
}

@test 'ls: dir -> directory' {
    LBUFFER="ls dir"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls directory'
}

@test 'ls: src -> source' {
    LBUFFER="ls src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls source'
}

@test 'ls: lib -> library' {
    LBUFFER="ls lib"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls library'
}

@test 'ls: deps -> dependencies' {
    LBUFFER="ls deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls dependencies'
}

#==============================================================
# 9. Multi-arg commands: git commit -m TYPO
#==============================================================

@test 'multi-arg: git commit -m teh -> the' {
    LBUFFER="git commit -m teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m the'
}

@test 'multi-arg: git commit -m josn -> JSON' {
    LBUFFER="git commit -m josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m JSON'
}

@test 'multi-arg: git commit -m deps -> dependencies' {
    LBUFFER="git commit -m deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m dependencies'
}

@test 'multi-arg: git commit -m impl -> implementation' {
    LBUFFER="git commit -m impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m implementation'
}

@test 'multi-arg: git commit -m repo -> repository' {
    LBUFFER="git commit -m repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m repository'
}

#==============================================================
# 10. echo foo bar TYPO (typo as 4th+ word)
#==============================================================

@test '4th word: echo foo bar teh -> the' {
    LBUFFER="echo foo bar teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo foo bar the'
}

@test '4th word: echo foo bar josn -> JSON' {
    LBUFFER="echo foo bar josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo foo bar JSON'
}

@test '4th word: echo foo bar adn -> and' {
    LBUFFER="echo foo bar adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo foo bar and'
}

@test '4th word: echo one two three fn -> function' {
    LBUFFER="echo one two three fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo one two three function'
}

@test '4th word: echo a b c d cpu -> CPU' {
    LBUFFER="echo a b c d cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo a b c d CPU'
}

#==============================================================
# 11. After pipe: cmd | echo TYPO
#==============================================================

@test 'pipe: ls | echo teh -> the' {
    LBUFFER="ls | echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo the'
}

@test 'pipe: ls | echo hte -> the' {
    LBUFFER="ls | echo hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo the'
}

@test 'pipe: ls | echo adn -> and' {
    LBUFFER="ls | echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo and'
}

@test 'pipe: ls | echo josn -> JSON' {
    LBUFFER="ls | echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo JSON'
}

@test 'pipe: ls | echo usdo -> sudo' {
    LBUFFER="ls | echo usdo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo sudo'
}

@test 'pipe: ls | echo cpu -> CPU' {
    LBUFFER="ls | echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo CPU'
}

@test 'pipe: ls | echo url -> URL' {
    LBUFFER="ls | echo url"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo URL'
}

@test 'pipe: cat foo | echo fn -> function' {
    LBUFFER="cat foo | echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo function'
}

@test 'pipe: cat foo | echo db -> database' {
    LBUFFER="cat foo | echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo database'
}

@test 'pipe: cat foo | echo impl -> implementation' {
    LBUFFER="cat foo | echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo implementation'
}

@test 'pipe: cat foo | echo src -> source' {
    LBUFFER="cat foo | echo src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo source'
}

@test 'pipe: cat foo | echo macos -> macOS' {
    LBUFFER="cat foo | echo macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo macOS'
}

@test 'pipe: cat foo | echo linux -> Linux' {
    LBUFFER="cat foo | echo linux"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo Linux'
}

@test 'pipe: cat foo | echo bahs -> bash' {
    LBUFFER="cat foo | echo bahs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo bash'
}

@test 'pipe: cat foo | echo repo -> repository' {
    LBUFFER="cat foo | echo repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo repository'
}

@test 'pipe: cat foo | echo eror -> error' {
    LBUFFER="cat foo | echo eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo error'
}

@test 'pipe: cat foo | echo wirte -> write' {
    LBUFFER="cat foo | echo wirte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo write'
}

@test 'pipe: cat foo | echo doesnt -> does not' {
    LBUFFER="cat foo | echo doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo does not'
}

@test 'pipe: cat foo | echo btw -> by the way' {
    LBUFFER="cat foo | echo btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo by the way'
}

@test 'pipe: cat foo | echo cant -> can not' {
    LBUFFER="cat foo | echo cant"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat foo | echo can not'
}

#==============================================================
# 12. Double pipe: cmd1 | cmd2 | echo TYPO
#==============================================================

@test 'double pipe: a | b | echo teh -> the' {
    LBUFFER="cat f | sort | echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat f | sort | echo the'
}

@test 'double pipe: a | b | echo josn -> JSON' {
    LBUFFER="cat f | sort | echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat f | sort | echo JSON'
}

@test 'double pipe: a | b | echo cpu -> CPU' {
    LBUFFER="cat f | sort | echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat f | sort | echo CPU'
}

@test 'double pipe: a | b | echo fn -> function' {
    LBUFFER="cat f | sort | echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat f | sort | echo function'
}

@test 'double pipe: a | b | echo impl -> implementation' {
    LBUFFER="cat f | sort | echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat f | sort | echo implementation'
}

#==============================================================
# 13. After semicolon: ls; echo TYPO
#==============================================================

@test 'semicolon: ls; echo teh -> the' {
    LBUFFER="ls; echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo the'
}

@test 'semicolon: ls; echo hte -> the' {
    LBUFFER="ls; echo hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo the'
}

@test 'semicolon: ls; echo adn -> and' {
    LBUFFER="ls; echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo and'
}

@test 'semicolon: ls; echo josn -> JSON' {
    LBUFFER="ls; echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo JSON'
}

@test 'semicolon: ls; echo usdo -> sudo' {
    LBUFFER="ls; echo usdo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo sudo'
}

@test 'semicolon: ls; echo ehco -> echo' {
    LBUFFER="ls; echo ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo echo'
}

@test 'semicolon: ls; echo bahs -> bash' {
    LBUFFER="ls; echo bahs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo bash'
}

@test 'semicolon: ls; echo cpu -> CPU' {
    LBUFFER="ls; echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo CPU'
}

@test 'semicolon: ls; echo url -> URL' {
    LBUFFER="ls; echo url"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo URL'
}

@test 'semicolon: ls; echo html -> HTML' {
    LBUFFER="ls; echo html"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo HTML'
}

@test 'semicolon: ls; echo fn -> function' {
    LBUFFER="ls; echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo function'
}

@test 'semicolon: ls; echo db -> database' {
    LBUFFER="ls; echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo database'
}

@test 'semicolon: ls; echo impl -> implementation' {
    LBUFFER="ls; echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo implementation'
}

@test 'semicolon: ls; echo repo -> repository' {
    LBUFFER="ls; echo repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo repository'
}

@test 'semicolon: ls; echo deps -> dependencies' {
    LBUFFER="ls; echo deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo dependencies'
}

@test 'semicolon: ls; echo macos -> macOS' {
    LBUFFER="ls; echo macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo macOS'
}

@test 'semicolon: ls; echo linux -> Linux' {
    LBUFFER="ls; echo linux"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo Linux'
}

@test 'semicolon: ls; echo wirte -> write' {
    LBUFFER="ls; echo wirte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo write'
}

@test 'semicolon: ls; echo eror -> error' {
    LBUFFER="ls; echo eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo error'
}

@test 'semicolon: ls; echo doesnt -> does not' {
    LBUFFER="ls; echo doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo does not'
}

#==============================================================
# 14. Double semicolon: a; b; echo TYPO
#==============================================================

@test 'double semicolon: a; b; echo teh -> the' {
    LBUFFER="ls; pwd; echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; pwd; echo the'
}

@test 'double semicolon: a; b; echo josn -> JSON' {
    LBUFFER="ls; pwd; echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; pwd; echo JSON'
}

@test 'double semicolon: a; b; echo fn -> function' {
    LBUFFER="ls; pwd; echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; pwd; echo function'
}

@test 'double semicolon: a; b; echo cpu -> CPU' {
    LBUFFER="ls; pwd; echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; pwd; echo CPU'
}

@test 'double semicolon: a; b; echo impl -> implementation' {
    LBUFFER="ls; pwd; echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; pwd; echo implementation'
}

#==============================================================
# 15. After && with misspellings
#==============================================================

@test 'and-and: ls && echo teh -> the' {
    LBUFFER="ls && echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo the'
}

@test 'and-and: ls && echo hte -> the' {
    LBUFFER="ls && echo hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo the'
}

@test 'and-and: ls && echo adn -> and' {
    LBUFFER="ls && echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo and'
}

@test 'and-and: ls && echo josn -> JSON' {
    LBUFFER="ls && echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo JSON'
}

@test 'and-and: ls && echo usdo -> sudo' {
    LBUFFER="ls && echo usdo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo sudo'
}

@test 'and-and: ls && echo cpu -> CPU' {
    LBUFFER="ls && echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo CPU'
}

@test 'and-and: ls && echo fn -> function' {
    LBUFFER="ls && echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo function'
}

@test 'and-and: ls && echo db -> database' {
    LBUFFER="ls && echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo database'
}

@test 'and-and: ls && echo impl -> implementation' {
    LBUFFER="ls && echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo implementation'
}

@test 'and-and: ls && echo repo -> repository' {
    LBUFFER="ls && echo repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo repository'
}

@test 'and-and: ls && echo macos -> macOS' {
    LBUFFER="ls && echo macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo macOS'
}

@test 'and-and: ls && echo src -> source' {
    LBUFFER="ls && echo src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo source'
}

@test 'and-and: ls && echo eror -> error' {
    LBUFFER="ls && echo eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo error'
}

@test 'and-and: ls && echo deps -> dependencies' {
    LBUFFER="ls && echo deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo dependencies'
}

@test 'and-and: ls && echo wirte -> write' {
    LBUFFER="ls && echo wirte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo write'
}

#==============================================================
# 16. After || with misspellings
#==============================================================

@test 'or-or: ls || echo teh -> the' {
    LBUFFER="ls || echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo the'
}

@test 'or-or: ls || echo hte -> the' {
    LBUFFER="ls || echo hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo the'
}

@test 'or-or: ls || echo adn -> and' {
    LBUFFER="ls || echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo and'
}

@test 'or-or: ls || echo josn -> JSON' {
    LBUFFER="ls || echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo JSON'
}

@test 'or-or: ls || echo usdo -> sudo' {
    LBUFFER="ls || echo usdo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo sudo'
}

@test 'or-or: ls || echo cpu -> CPU' {
    LBUFFER="ls || echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo CPU'
}

@test 'or-or: ls || echo fn -> function' {
    LBUFFER="ls || echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo function'
}

@test 'or-or: ls || echo db -> database' {
    LBUFFER="ls || echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo database'
}

@test 'or-or: ls || echo impl -> implementation' {
    LBUFFER="ls || echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo implementation'
}

@test 'or-or: ls || echo repo -> repository' {
    LBUFFER="ls || echo repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo repository'
}

@test 'or-or: ls || echo src -> source' {
    LBUFFER="ls || echo src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo source'
}

@test 'or-or: ls || echo macos -> macOS' {
    LBUFFER="ls || echo macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo macOS'
}

@test 'or-or: ls || echo eror -> error' {
    LBUFFER="ls || echo eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo error'
}

@test 'or-or: ls || echo deps -> dependencies' {
    LBUFFER="ls || echo deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo dependencies'
}

@test 'or-or: ls || echo wirte -> write' {
    LBUFFER="ls || echo wirte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo write'
}

#==============================================================
# 17. No correction: valid commands at first position
#==============================================================

@test 'no correct: single word git' {
    LBUFFER="git"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word ls' {
    LBUFFER="ls"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word cd' {
    LBUFFER="cd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word echo' {
    LBUFFER="echo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word cat' {
    LBUFFER="cat"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word grep' {
    LBUFFER="grep"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word sed' {
    LBUFFER="sed"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word awk' {
    LBUFFER="awk"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word man' {
    LBUFFER="man"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word find' {
    LBUFFER="find"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word sort' {
    LBUFFER="sort"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word head' {
    LBUFFER="head"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word tail' {
    LBUFFER="tail"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word wc' {
    LBUFFER="wc"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word cp' {
    LBUFFER="cp"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word mv' {
    LBUFFER="mv"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word rm' {
    LBUFFER="rm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word mkdir' {
    LBUFFER="mkdir"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word touch' {
    LBUFFER="touch"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word chmod' {
    LBUFFER="chmod"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word chown' {
    LBUFFER="chown"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word curl' {
    LBUFFER="curl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word wget' {
    LBUFFER="wget"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word tar' {
    LBUFFER="tar"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word uniq' {
    LBUFFER="uniq"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word diff' {
    LBUFFER="diff"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word whoami' {
    LBUFFER="whoami"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word pwd' {
    LBUFFER="pwd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word date' {
    LBUFFER="date"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word kill' {
    LBUFFER="kill"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 18. Single valid word (not a typo)
#==============================================================

@test 'no correct: single word print' {
    LBUFFER="print"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word env' {
    LBUFFER="env"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: single word sudo' {
    LBUFFER="sudo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 19. After sudo with valid command — no correction
#==============================================================

@test 'no correct: sudo git (valid cmd)' {
    LBUFFER="sudo git"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: sudo ls (valid cmd)' {
    LBUFFER="sudo ls"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: sudo cat (valid cmd)' {
    LBUFFER="sudo cat"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: sudo rm (valid cmd)' {
    LBUFFER="sudo rm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: sudo chmod (valid cmd)' {
    LBUFFER="sudo chmod"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: sudo chown (valid cmd)' {
    LBUFFER="sudo chown"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: env ls (valid cmd)' {
    LBUFFER="env ls"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: env cat (valid cmd)' {
    LBUFFER="env cat"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 20. Blacklisted subcommands — no correction
#==============================================================

@test 'blacklist: sudo docker (blacklisted firstword)' {
    LBUFFER="sudo docker"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo npm (blacklisted firstword)' {
    LBUFFER="sudo npm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo git (blacklisted firstword)' {
    LBUFFER="sudo git"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo pip (blacklisted firstword)' {
    LBUFFER="sudo pip"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo brew (blacklisted firstword)' {
    LBUFFER="sudo brew"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo yarn (blacklisted firstword)' {
    LBUFFER="sudo yarn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo cargo (blacklisted firstword)' {
    LBUFFER="sudo cargo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo kubectl (blacklisted firstword)' {
    LBUFFER="sudo kubectl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo gem (blacklisted firstword)' {
    LBUFFER="sudo gem"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: sudo bundle (blacklisted firstword)' {
    LBUFFER="sudo bundle"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: env docker subcommand (blacklisted)' {
    LBUFFER="env docker"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: env npm subcommand (blacklisted)' {
    LBUFFER="env npm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: docker subcommand no correct' {
    LBUFFER="docker teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: git subcommand no correct' {
    LBUFFER="git teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: npm subcommand no correct' {
    LBUFFER="npm teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: kubectl subcommand no correct' {
    LBUFFER="kubectl teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: pip subcommand no correct' {
    LBUFFER="pip teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: brew subcommand no correct' {
    LBUFFER="brew teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: yarn subcommand no correct' {
    LBUFFER="yarn teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist: go subcommand no correct' {
    LBUFFER="go teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 21. Already correct words — no correction
#==============================================================

@test 'no correct: echo hello (already correct)' {
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: echo world (already correct)' {
    LBUFFER="echo world"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: echo test (already correct)' {
    LBUFFER="echo test"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: echo foo (already correct)' {
    LBUFFER="echo foo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: echo bar (already correct)' {
    LBUFFER="echo bar"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: echo done (already correct)' {
    LBUFFER="echo done"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: echo start (already correct)' {
    LBUFFER="echo start"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: echo finished (already correct)' {
    LBUFFER="echo finished"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 22. Single word typo that is a valid command — no correction
#==============================================================

@test 'no correct: bg alone is valid command' {
    LBUFFER="bg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'no correct: fg alone is valid command' {
    LBUFFER="fg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 23. Typo after assignment: FOO=bar echo TYPO
#==============================================================

@test 'assignment prefix: FOO=bar echo teh -> the' {
    LBUFFER="FOO=bar echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'FOO=bar echo the'
}

@test 'assignment prefix: FOO=bar echo josn -> JSON' {
    LBUFFER="FOO=bar echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'FOO=bar echo JSON'
}

@test 'assignment prefix: X=1 Y=2 echo cpu -> CPU' {
    LBUFFER="X=1 Y=2 echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'X=1 Y=2 echo CPU'
}

#==============================================================
# 24. Empty LBUFFER
#==============================================================

@test 'edge: empty LBUFFER no crash' {
    LBUFFER=""
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 25. Very long LBUFFER with typo at end
#==============================================================

@test 'long prefix: many words then teh -> the' {
    LBUFFER="echo one two three four five six seven eight nine ten teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo one two three four five six seven eight nine ten the'
}

@test 'long prefix: many words then josn -> JSON' {
    LBUFFER="echo alpha beta gamma delta epsilon zeta eta theta josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo alpha beta gamma delta epsilon zeta eta theta JSON'
}

@test 'long prefix: many words then fn -> function' {
    LBUFFER="echo a b c d e f g h i j k l m fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo a b c d e f g h i j k l m function'
}

#==============================================================
# 26. Multiple words before typo
#==============================================================

@test 'multi words: echo first second teh -> the' {
    LBUFFER="echo first second teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo first second the'
}

@test 'multi words: echo -n some text adn -> and' {
    LBUFFER="echo -n some text adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo -n some text and'
}

@test 'multi words: cat file1 file2 feil -> file' {
    LBUFFER="cat file1 file2 feil"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat file1 file2 file'
}

#==============================================================
# 27. Underscore expansion (multi-word corrections) in contexts
#==============================================================

@test 'underscore: print btw -> by the way' {
    LBUFFER="print btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print by the way'
}

@test 'underscore: print cant -> can not' {
    LBUFFER="print cant"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print can not'
}

@test 'underscore: print doesnt -> does not' {
    LBUFFER="print doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'print does not'
}

@test 'underscore: echo isnt -> is not' {
    LBUFFER="echo isnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo is not'
}

@test 'underscore: echo wont -> will not' {
    LBUFFER="echo wont"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo will not'
}

@test 'underscore: echo shouldnt -> should not' {
    LBUFFER="echo shouldnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo should not'
}

@test 'underscore: echo wasnt -> was not' {
    LBUFFER="echo wasnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo was not'
}

@test 'underscore: echo wouldnt -> would not' {
    LBUFFER="echo wouldnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo would not'
}

@test 'underscore: echo havent -> have not' {
    LBUFFER="echo havent"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo have not'
}

@test 'underscore: echo hasnt -> has not' {
    LBUFFER="echo hasnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo has not'
}

@test 'underscore: echo dont -> do not' {
    LBUFFER="echo dont"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo do not'
}

@test 'underscore: echo didnt -> did not' {
    LBUFFER="echo didnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo did not'
}

@test 'underscore: ls; echo btw -> by the way' {
    LBUFFER="ls; echo btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo by the way'
}

@test 'underscore: ls | echo cant -> can not' {
    LBUFFER="ls | echo cant"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls | echo can not'
}

@test 'underscore: ls && echo doesnt -> does not' {
    LBUFFER="ls && echo doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls && echo does not'
}

@test 'underscore: ls || echo isnt -> is not' {
    LBUFFER="ls || echo isnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls || echo is not'
}

#==============================================================
# 28. Typo matching different dictionary entries
#==============================================================

@test 'dict: echo eht -> the' {
    LBUFFER="echo eht"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'dict: echo eth -> the' {
    LBUFFER="echo eth"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'dict: echo nad -> and' {
    LBUFFER="echo nad"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'
}

@test 'dict: echo eccho -> echo' {
    LBUFFER="echo eccho"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict: echo ceho -> echo' {
    LBUFFER="echo ceho"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict: echo ecoh -> echo' {
    LBUFFER="echo ecoh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo echo'
}

@test 'dict: echo bakc -> back' {
    LBUFFER="echo bakc"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo back'
}

@test 'dict: echo abck -> back' {
    LBUFFER="echo abck"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo back'
}

#==============================================================
# 29. foundIncorrect true for known typos in different contexts
#==============================================================

@test 'foundIncorrect true: echo teh' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo josn' {
    LBUFFER="echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo cpu' {
    LBUFFER="echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: print bahs' {
    LBUFFER="print bahs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: cat feil' {
    LBUFFER="cat feil"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: grep eror' {
    LBUFFER="grep eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: ls | echo fn' {
    LBUFFER="ls | echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: ls; echo db' {
    LBUFFER="ls; echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: ls && echo impl' {
    LBUFFER="ls && echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: ls || echo repo' {
    LBUFFER="ls || echo repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo btw' {
    LBUFFER="echo btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo doesnt' {
    LBUFFER="echo doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo macos' {
    LBUFFER="echo macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo linux' {
    LBUFFER="echo linux"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo wirte' {
    LBUFFER="echo wirte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo eror' {
    LBUFFER="echo eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: sudo env teh' {
    LBUFFER="sudo env teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo defalut' {
    LBUFFER="echo defalut"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo fales' {
    LBUFFER="echo fales"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'foundIncorrect true: echo treu' {
    LBUFFER="echo treu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

#==============================================================
# 30. foundIncorrect false for valid words in different contexts
#==============================================================

@test 'foundIncorrect false: echo hello' {
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo world' {
    LBUFFER="echo world"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo running' {
    LBUFFER="echo running"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo complete' {
    LBUFFER="echo complete"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo started' {
    LBUFFER="echo started"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: print testing' {
    LBUFFER="print testing"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: cat results' {
    LBUFFER="cat results"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: ls | echo ok' {
    LBUFFER="ls | echo ok"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: ls; echo finished' {
    LBUFFER="ls; echo finished"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: ls && echo pass' {
    LBUFFER="ls && echo pass"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: ls || echo fallback' {
    LBUFFER="ls || echo fallback"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo correct' {
    LBUFFER="echo correct"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo valid' {
    LBUFFER="echo valid"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo nothing' {
    LBUFFER="echo nothing"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo success' {
    LBUFFER="echo success"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: grep pattern' {
    LBUFFER="grep pattern"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: sed expression' {
    LBUFFER="sed expression"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: awk program' {
    LBUFFER="awk program"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: man manual' {
    LBUFFER="man manual"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo ordinary' {
    LBUFFER="echo ordinary"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 31. foundIncorrect false for unknown gibberish words
#==============================================================

@test 'foundIncorrect false: echo zyxwvuts (gibberish)' {
    LBUFFER="echo zyxwvuts"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo qwxzpl (gibberish)' {
    LBUFFER="echo qwxzpl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo mnbvcxzlk (gibberish)' {
    LBUFFER="echo mnbvcxzlk"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo asdfghjk (gibberish)' {
    LBUFFER="echo asdfghjk"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo xyzpdqmn (gibberish)' {
    LBUFFER="echo xyzpdqmn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo plmokn (gibberish)' {
    LBUFFER="echo plmokn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo wqrtyu (gibberish)' {
    LBUFFER="echo wqrtyu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo ljhgfds (gibberish)' {
    LBUFFER="echo ljhgfds"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo nbvcxz (gibberish)' {
    LBUFFER="echo nbvcxz"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'foundIncorrect false: echo poiuytrew (gibberish)' {
    LBUFFER="echo poiuytrew"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 32. Blacklist behavior — subcommand positions
#==============================================================

@test 'blacklist subcommand: docker run no correct' {
    LBUFFER="docker run"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: git status no correct' {
    LBUFFER="git status"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: npm install no correct' {
    LBUFFER="npm install"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: pip install no correct' {
    LBUFFER="pip install"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: kubectl get no correct' {
    LBUFFER="kubectl get"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: cargo build no correct' {
    LBUFFER="cargo build"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: brew install no correct' {
    LBUFFER="brew install"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: yarn add no correct' {
    LBUFFER="yarn add"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: go build no correct' {
    LBUFFER="go build"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: gem install no correct' {
    LBUFFER="gem install"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: svn commit no correct' {
    LBUFFER="svn commit"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'blacklist subcommand: bundle exec no correct' {
    LBUFFER="bundle exec"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# 33. Global alias — should not correct
#==============================================================

@test 'global alias: word with global alias skips correction' {
    galiases[teh]="something"
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
    unset "galiases[teh]"
}

@test 'global alias: josn with global alias skips correction' {
    galiases[josn]="JSON"
    LBUFFER="echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
    unset "galiases[josn]"
}

#==============================================================
# Additional context corrections — mixed operators
#==============================================================

@test 'mixed: ls; pwd && echo teh -> the' {
    LBUFFER="ls; pwd && echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; pwd && echo the'
}

@test 'mixed: ls; pwd || echo josn -> JSON' {
    LBUFFER="ls; pwd || echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; pwd || echo JSON'
}

@test 'mixed: a | b; echo cpu -> CPU' {
    LBUFFER="a | b; echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'a | b; echo CPU'
}

@test 'mixed: a && b || echo fn -> function' {
    LBUFFER="a && b || echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'a && b || echo function'
}

@test 'mixed: a || b && echo db -> database' {
    LBUFFER="a || b && echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'a || b && echo database'
}

@test 'mixed: a | b | c; echo impl -> implementation' {
    LBUFFER="a | b | c; echo impl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'a | b | c; echo implementation'
}

#==============================================================
# Correction preserves exact prefix spacing
#==============================================================

@test 'spacing: echo  teh (double space) -> the' {
    LBUFFER="echo  teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo  the'
}

@test 'spacing: leading space then echo teh -> the' {
    LBUFFER=" echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as ' echo the'
}

#==============================================================
# More diverse typo variants in echo context
#==============================================================

@test 'echo variant: igt -> git' {
    LBUFFER="echo igt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo git'
}

@test 'echo variant: ggit -> git' {
    LBUFFER="echo ggit"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo git'
}

@test 'echo variant: dokcer -> docker' {
    LBUFFER="echo dokcer"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo docker'
}

@test 'echo variant: mysql -> MySQL' {
    LBUFFER="echo mysql"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo MySQL'
}

@test 'echo variant: aws -> AWS' {
    LBUFFER="echo aws"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo AWS'
}

@test 'echo variant: tls -> TLS' {
    LBUFFER="echo tls"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo TLS'
}

@test 'echo variant: https -> HTTPS' {
    LBUFFER="echo https"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo HTTPS'
}

@test 'echo variant: bios -> BIOS' {
    LBUFFER="echo bios"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo BIOS'
}

@test 'echo variant: ieee -> IEEE' {
    LBUFFER="echo ieee"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo IEEE'
}

@test 'echo variant: gpt -> GPT' {
    LBUFFER="echo gpt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo GPT'
}

@test 'echo variant: pid -> PID' {
    LBUFFER="echo pid"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo PID'
}

@test 'echo variant: rgb -> RGB' {
    LBUFFER="echo rgb"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo RGB'
}

@test 'echo variant: ios -> iOS' {
    LBUFFER="echo ios"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo iOS'
}

@test 'echo variant: ipad -> iPad' {
    LBUFFER="echo ipad"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo iPad'
}

@test 'echo variant: iphone -> iPhone' {
    LBUFFER="echo iphone"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo iPhone'
}

@test 'echo variant: latex -> LaTeX' {
    LBUFFER="echo latex"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo LaTeX'
}

@test 'echo variant: js -> JavaScript' {
    LBUFFER="echo js"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JavaScript'
}

@test 'echo variant: json -> JSON' {
    LBUFFER="echo json"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JSON'
}
