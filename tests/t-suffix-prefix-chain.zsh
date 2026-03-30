#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive suffix alias + prefix chain combination tests
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    ZPWR_EXPAND_QUOTE_DOUBLE=false
    ZPWR_EXPAND_QUOTE_SINGLE=false
    ZPWR_EXPAND_SECOND_POSITION=false
    ZPWR_EXPAND_NATIVE=false
    ZPWR_EXPAND_PRE_EXEC_NATIVE=false
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=false
    ZPWR_EXPAND_TO_HISTORY=false
    ZPWR_CORRECT=false
    ZPWR_CORRECT_EXPAND=false
    ZPWR_EXPAND_SUFFIX=true
    ZPWR_TRACE=false

    alias -s txt=vim
    alias -s py=python
    alias -s json=jq
    alias -s rs=cargo-run
    alias -s go=go-run
    alias -s rb=ruby
    alias -s sh=bash
    alias -s zsh=zsh
    alias -s c=gcc
    alias -s cpp=g++
    alias -s java=javac
    alias -s ts=ts-node
    alias -s yml=yq
    alias -s toml=toml-view
    alias -s conf=less
    alias -s log=tail-f
    alias -s html=open
    alias -s md=glow
    alias -s css=less
    alias -s xml=xmllint
    alias -s csv=csvtool

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# 1. sudo + suffix alias — all extensions
#==============================================================

@test 'prefix chain: sudo file.txt' {
    LBUFFER="sudo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo vim file.txt'
}

@test 'prefix chain: sudo file.py' {
    LBUFFER="sudo file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo python file.py'
}

@test 'prefix chain: sudo file.json' {
    LBUFFER="sudo file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo jq file.json'
}

@test 'prefix chain: sudo file.rs' {
    LBUFFER="sudo file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo cargo-run file.rs'
}

@test 'prefix chain: sudo file.go' {
    LBUFFER="sudo file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo go-run file.go'
}

@test 'prefix chain: sudo file.rb' {
    LBUFFER="sudo file.rb"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo ruby file.rb'
}

@test 'prefix chain: sudo file.sh' {
    LBUFFER="sudo file.sh"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo bash file.sh'
}

@test 'prefix chain: sudo file.c' {
    LBUFFER="sudo file.c"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo gcc file.c'
}

@test 'prefix chain: sudo file.cpp' {
    LBUFFER="sudo file.cpp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo g++ file.cpp'
}

@test 'prefix chain: sudo file.java' {
    LBUFFER="sudo file.java"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo javac file.java'
}

@test 'prefix chain: sudo file.ts' {
    LBUFFER="sudo file.ts"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo ts-node file.ts'
}

@test 'prefix chain: sudo file.yml' {
    LBUFFER="sudo file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo yq file.yml'
}

@test 'prefix chain: sudo file.toml' {
    LBUFFER="sudo file.toml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo toml-view file.toml'
}

@test 'prefix chain: sudo file.conf' {
    LBUFFER="sudo file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo less file.conf'
}

@test 'prefix chain: sudo file.log' {
    LBUFFER="sudo file.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo tail-f file.log'
}

@test 'prefix chain: sudo file.html' {
    LBUFFER="sudo file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo open file.html'
}

@test 'prefix chain: sudo file.md' {
    LBUFFER="sudo file.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo glow file.md'
}

@test 'prefix chain: sudo file.xml' {
    LBUFFER="sudo file.xml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo xmllint file.xml'
}

@test 'prefix chain: sudo file.css' {
    LBUFFER="sudo file.css"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo less file.css'
}

@test 'prefix chain: sudo file.zsh' {
    LBUFFER="sudo file.zsh"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo zsh file.zsh'
}

#==============================================================
# 2. env + suffix alias — all extensions
#==============================================================

@test 'prefix chain: env file.txt' {
    LBUFFER="env file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env vim file.txt'
}

@test 'prefix chain: env file.py' {
    LBUFFER="env file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env python file.py'
}

@test 'prefix chain: env file.json' {
    LBUFFER="env file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env jq file.json'
}

@test 'prefix chain: env file.rs' {
    LBUFFER="env file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env cargo-run file.rs'
}

@test 'prefix chain: env file.go' {
    LBUFFER="env file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env go-run file.go'
}

@test 'prefix chain: env file.rb' {
    LBUFFER="env file.rb"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env ruby file.rb'
}

@test 'prefix chain: env file.sh' {
    LBUFFER="env file.sh"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env bash file.sh'
}

@test 'prefix chain: env file.c' {
    LBUFFER="env file.c"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env gcc file.c'
}

@test 'prefix chain: env file.yml' {
    LBUFFER="env file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env yq file.yml'
}

@test 'prefix chain: env file.toml' {
    LBUFFER="env file.toml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env toml-view file.toml'
}

@test 'prefix chain: env file.conf' {
    LBUFFER="env file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env less file.conf'
}

@test 'prefix chain: env file.html' {
    LBUFFER="env file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env open file.html'
}

@test 'prefix chain: env file.md' {
    LBUFFER="env file.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env glow file.md'
}

#==============================================================
# 3. command + suffix alias
#==============================================================

@test 'prefix chain: command file.txt' {
    LBUFFER="command file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command vim file.txt'
}

@test 'prefix chain: command file.py' {
    LBUFFER="command file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command python file.py'
}

@test 'prefix chain: command file.json' {
    LBUFFER="command file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command jq file.json'
}

@test 'prefix chain: command file.rs' {
    LBUFFER="command file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command cargo-run file.rs'
}

@test 'prefix chain: command file.go' {
    LBUFFER="command file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command go-run file.go'
}

@test 'prefix chain: command file.yml' {
    LBUFFER="command file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command yq file.yml'
}

@test 'prefix chain: command file.html' {
    LBUFFER="command file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command open file.html'
}

@test 'prefix chain: command file.conf' {
    LBUFFER="command file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command less file.conf'
}

#==============================================================
# 4. builtin + suffix alias
#==============================================================

@test 'prefix chain: builtin file.txt' {
    LBUFFER="builtin file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin vim file.txt'
}

@test 'prefix chain: builtin file.py' {
    LBUFFER="builtin file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin python file.py'
}

@test 'prefix chain: builtin file.json' {
    LBUFFER="builtin file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin jq file.json'
}

@test 'prefix chain: builtin file.rs' {
    LBUFFER="builtin file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin cargo-run file.rs'
}

@test 'prefix chain: builtin file.yml' {
    LBUFFER="builtin file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin yq file.yml'
}

@test 'prefix chain: builtin file.html' {
    LBUFFER="builtin file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin open file.html'
}

#==============================================================
# 5. noglob + suffix alias
#==============================================================

@test 'prefix chain: noglob file.txt' {
    LBUFFER="noglob file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob vim file.txt'
}

@test 'prefix chain: noglob file.py' {
    LBUFFER="noglob file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob python file.py'
}

@test 'prefix chain: noglob file.json' {
    LBUFFER="noglob file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob jq file.json'
}

@test 'prefix chain: noglob file.rs' {
    LBUFFER="noglob file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob cargo-run file.rs'
}

@test 'prefix chain: noglob file.yml' {
    LBUFFER="noglob file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob yq file.yml'
}

@test 'prefix chain: noglob file.html' {
    LBUFFER="noglob file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob open file.html'
}

#==============================================================
# 6. nice + suffix alias
#==============================================================

@test 'prefix chain: nice file.txt' {
    LBUFFER="nice file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice vim file.txt'
}

@test 'prefix chain: nice file.py' {
    LBUFFER="nice file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice python file.py'
}

@test 'prefix chain: nice file.rs' {
    LBUFFER="nice file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice cargo-run file.rs'
}

@test 'prefix chain: nice file.go' {
    LBUFFER="nice file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice go-run file.go'
}

@test 'prefix chain: nice file.yml' {
    LBUFFER="nice file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice yq file.yml'
}

@test 'prefix chain: nice file.conf' {
    LBUFFER="nice file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice less file.conf'
}

#==============================================================
# 7. nohup + suffix alias
#==============================================================

@test 'prefix chain: nohup file.txt' {
    LBUFFER="nohup file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup vim file.txt'
}

@test 'prefix chain: nohup file.py' {
    LBUFFER="nohup file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup python file.py'
}

@test 'prefix chain: nohup file.rs' {
    LBUFFER="nohup file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup cargo-run file.rs'
}

@test 'prefix chain: nohup file.go' {
    LBUFFER="nohup file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup go-run file.go'
}

@test 'prefix chain: nohup file.yml' {
    LBUFFER="nohup file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup yq file.yml'
}

@test 'prefix chain: nohup file.html' {
    LBUFFER="nohup file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup open file.html'
}

#==============================================================
# 8. time + suffix alias
#==============================================================

@test 'prefix chain: time file.txt' {
    LBUFFER="time file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time vim file.txt'
}

@test 'prefix chain: time file.py' {
    LBUFFER="time file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time python file.py'
}

@test 'prefix chain: time file.rs' {
    LBUFFER="time file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time cargo-run file.rs'
}

@test 'prefix chain: time file.go' {
    LBUFFER="time file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time go-run file.go'
}

@test 'prefix chain: time file.yml' {
    LBUFFER="time file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time yq file.yml'
}

@test 'prefix chain: time file.conf' {
    LBUFFER="time file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time less file.conf'
}

#==============================================================
# 9. sudo env — double prefix chain
#==============================================================

@test 'prefix chain: sudo env file.txt' {
    LBUFFER="sudo env file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env vim file.txt'
}

@test 'prefix chain: sudo env file.py' {
    LBUFFER="sudo env file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env python file.py'
}

@test 'prefix chain: sudo env file.rs' {
    LBUFFER="sudo env file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env cargo-run file.rs'
}

@test 'prefix chain: sudo env file.go' {
    LBUFFER="sudo env file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env go-run file.go'
}

@test 'prefix chain: sudo env file.yml' {
    LBUFFER="sudo env file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env yq file.yml'
}

@test 'prefix chain: sudo env file.html' {
    LBUFFER="sudo env file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env open file.html'
}

@test 'prefix chain: sudo env file.conf' {
    LBUFFER="sudo env file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env less file.conf'
}

@test 'prefix chain: sudo env file.md' {
    LBUFFER="sudo env file.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env glow file.md'
}

#==============================================================
# 10. time sudo — double prefix chain
#==============================================================

@test 'prefix chain: time sudo file.txt' {
    LBUFFER="time sudo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time sudo vim file.txt'
}

@test 'prefix chain: time sudo file.py' {
    LBUFFER="time sudo file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time sudo python file.py'
}

@test 'prefix chain: time sudo file.rs' {
    LBUFFER="time sudo file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time sudo cargo-run file.rs'
}

@test 'prefix chain: time sudo file.go' {
    LBUFFER="time sudo file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time sudo go-run file.go'
}

@test 'prefix chain: time sudo file.yml' {
    LBUFFER="time sudo file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time sudo yq file.yml'
}

@test 'prefix chain: time sudo file.conf' {
    LBUFFER="time sudo file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time sudo less file.conf'
}

#==============================================================
# 11. sudo with flags
#==============================================================

@test 'prefix chain: sudo -E file.txt' {
    LBUFFER="sudo -E file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E vim file.txt'
}

@test 'prefix chain: sudo -E file.py' {
    LBUFFER="sudo -E file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E python file.py'
}

@test 'prefix chain: sudo -E file.rs' {
    LBUFFER="sudo -E file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E cargo-run file.rs'
}

@test 'prefix chain: sudo -E file.go' {
    LBUFFER="sudo -E file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E go-run file.go'
}

@test 'prefix chain: sudo -E file.yml' {
    LBUFFER="sudo -E file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E yq file.yml'
}

@test 'prefix chain: sudo -E file.conf' {
    LBUFFER="sudo -E file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E less file.conf'
}

@test 'prefix chain: sudo -E file.html' {
    LBUFFER="sudo -E file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E open file.html'
}

@test 'prefix chain: sudo -E file.md' {
    LBUFFER="sudo -E file.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E glow file.md'
}

#==============================================================
# 12. env with flags
#==============================================================

@test 'prefix chain: env -i file.txt' {
    LBUFFER="env -i file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env -i vim file.txt'
}

@test 'prefix chain: env -i file.py' {
    LBUFFER="env -i file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env -i python file.py'
}

@test 'prefix chain: env -i file.rs' {
    LBUFFER="env -i file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env -i cargo-run file.rs'
}

@test 'prefix chain: env -i file.go' {
    LBUFFER="env -i file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env -i go-run file.go'
}

@test 'prefix chain: env -i file.yml' {
    LBUFFER="env -i file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env -i yq file.yml'
}

@test 'prefix chain: env -i file.conf' {
    LBUFFER="env -i file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env -i less file.conf'
}

#==============================================================
# 13. Triple prefix chains
#==============================================================

@test 'prefix chain: builtin command sudo file.txt' {
    LBUFFER="builtin command sudo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo vim file.txt'
}

@test 'prefix chain: builtin command sudo file.py' {
    LBUFFER="builtin command sudo file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo python file.py'
}

@test 'prefix chain: builtin command sudo file.rs' {
    LBUFFER="builtin command sudo file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo cargo-run file.rs'
}

@test 'prefix chain: builtin command sudo file.go' {
    LBUFFER="builtin command sudo file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo go-run file.go'
}

@test 'prefix chain: builtin command sudo file.yml' {
    LBUFFER="builtin command sudo file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo yq file.yml'
}

@test 'prefix chain: builtin command sudo file.conf' {
    LBUFFER="builtin command sudo file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo less file.conf'
}

#==============================================================
# 14. Quad prefix chains with flags
#==============================================================

@test 'prefix chain: builtin command sudo -E env file.txt' {
    LBUFFER='builtin command sudo -E env file.txt'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo -E env vim file.txt'
}

@test 'prefix chain: builtin command sudo -E env file.py' {
    LBUFFER='builtin command sudo -E env file.py'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo -E env python file.py'
}

@test 'prefix chain: builtin command sudo -E env file.rs' {
    LBUFFER='builtin command sudo -E env file.rs'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo -E env cargo-run file.rs'
}

@test 'prefix chain: builtin command sudo -E env file.go' {
    LBUFFER='builtin command sudo -E env file.go'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo -E env go-run file.go'
}

@test 'prefix chain: builtin command sudo -E env file.yml' {
    LBUFFER='builtin command sudo -E env file.yml'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo -E env yq file.yml'
}

@test 'prefix chain: builtin command sudo -E env file.conf' {
    LBUFFER='builtin command sudo -E env file.conf'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command sudo -E env less file.conf'
}

#==============================================================
# 15. Prefix chains with paths
#==============================================================

@test 'prefix chain: sudo /tmp/file.txt with absolute path' {
    LBUFFER="sudo /tmp/file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo vim /tmp/file.txt'
}

@test 'prefix chain: sudo ./file.py with relative path' {
    LBUFFER="sudo ./file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo python ./file.py'
}

@test 'prefix chain: env /usr/local/etc/app.conf with deep path' {
    LBUFFER="env /usr/local/etc/app.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env less /usr/local/etc/app.conf'
}

@test 'prefix chain: sudo ~/notes.md with home path' {
    LBUFFER="sudo ~/notes.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo glow ~/notes.md'
}

@test 'prefix chain: command ../file.rs with parent path' {
    LBUFFER="command ../file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command cargo-run ../file.rs'
}

@test 'prefix chain: sudo env /var/log/app.log with double prefix path' {
    LBUFFER="sudo env /var/log/app.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env tail-f /var/log/app.log'
}

@test 'prefix chain: time ./benchmark.go with relative path' {
    LBUFFER="time ./benchmark.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time go-run ./benchmark.go'
}

@test 'prefix chain: nohup /opt/app/server.py with deep abs path' {
    LBUFFER="nohup /opt/app/server.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup python /opt/app/server.py'
}

#==============================================================
# 16. Prefix chains with multiple-dot filenames
#==============================================================

@test 'prefix chain: sudo file.test.py multi dot with prefix' {
    LBUFFER="sudo file.test.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo python file.test.py'
}

@test 'prefix chain: env docker-compose.override.yml multi dot env' {
    LBUFFER="env docker-compose.override.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env yq docker-compose.override.yml'
}

@test 'prefix chain: command file.spec.ts multi dot command' {
    LBUFFER="command file.spec.ts"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command ts-node file.spec.ts'
}

@test 'prefix chain: time data.backup.json multi dot time' {
    LBUFFER="time data.backup.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time jq data.backup.json'
}

@test 'prefix chain: nohup app.config.yml multi dot nohup' {
    LBUFFER="nohup app.config.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup yq app.config.yml'
}

@test 'prefix chain: nice v1.2.3.txt version dots nice' {
    LBUFFER="nice v1.2.3.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice vim v1.2.3.txt'
}

#==============================================================
# 17. WAS_EXPANDED true for all prefix chain tests
#==============================================================

@test 'prefix chain: WAS_EXPANDED true for sudo file.txt' {
    LBUFFER="sudo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for env file.py' {
    LBUFFER="env file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for command file.rs' {
    LBUFFER="command file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for builtin file.go' {
    LBUFFER="builtin file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for noglob file.yml' {
    LBUFFER="noglob file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for nice file.conf' {
    LBUFFER="nice file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for nohup file.html' {
    LBUFFER="nohup file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for time file.md' {
    LBUFFER="time file.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for sudo env file.json' {
    LBUFFER="sudo env file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'prefix chain: WAS_EXPANDED true for time sudo file.txt' {
    LBUFFER="time sudo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

#==============================================================
# 18. Prefix chain with unknown extension — no expand
#==============================================================

@test 'prefix chain: sudo file.xyz unknown ext no expand' {
    LBUFFER="sudo file.xyz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo file.xyz'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'prefix chain: env file.abc unknown ext no expand' {
    LBUFFER="env file.abc"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env file.abc'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'prefix chain: command file.qqq unknown ext no expand' {
    LBUFFER="command file.qqq"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command file.qqq'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'prefix chain: sudo env file.zzz unknown ext no expand' {
    LBUFFER="sudo env file.zzz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo env file.zzz'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'prefix chain: time file.bak unknown ext no expand' {
    LBUFFER="time file.bak"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time file.bak'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'prefix chain: nohup Makefile no ext no expand' {
    LBUFFER="nohup Makefile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup Makefile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# 19. Prefix chains with hyphenated/underscored filenames
#==============================================================

@test 'prefix chain: sudo my-app.rs hyphen filename' {
    LBUFFER="sudo my-app.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo cargo-run my-app.rs'
}

@test 'prefix chain: env my_script.py underscore filename' {
    LBUFFER="env my_script.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'env python my_script.py'
}

@test 'prefix chain: command CamelCase.java camel case filename' {
    LBUFFER="command CamelCase.java"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command javac CamelCase.java'
}

@test 'prefix chain: sudo file123.go numbered filename' {
    LBUFFER="sudo file123.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo go-run file123.go'
}

@test 'prefix chain: time 2024-report.csv date named filename' {
    LBUFFER="time 2024-report.csv"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time csvtool 2024-report.csv'
}

@test 'prefix chain: nice test_v2.rb versioned underscore filename' {
    LBUFFER="nice test_v2.rb"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice ruby test_v2.rb'
}

#==============================================================
# 20. rlwrap + suffix alias
#==============================================================

@test 'prefix chain: rlwrap file.txt' {
    LBUFFER="rlwrap file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rlwrap vim file.txt'
}

@test 'prefix chain: rlwrap file.py' {
    LBUFFER="rlwrap file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rlwrap python file.py'
}

@test 'prefix chain: rlwrap file.rs' {
    LBUFFER="rlwrap file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rlwrap cargo-run file.rs'
}

@test 'prefix chain: rlwrap file.go' {
    LBUFFER="rlwrap file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rlwrap go-run file.go'
}

@test 'prefix chain: rlwrap file.yml' {
    LBUFFER="rlwrap file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rlwrap yq file.yml'
}

@test 'prefix chain: rlwrap file.json' {
    LBUFFER="rlwrap file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rlwrap jq file.json'
}

#==============================================================
# 21. sudo -E env — triple prefix with flags
#==============================================================

@test 'prefix chain: sudo -E env file.txt triple flag' {
    LBUFFER="sudo -E env file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env vim file.txt'
}

@test 'prefix chain: sudo -E env file.py triple flag' {
    LBUFFER="sudo -E env file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env python file.py'
}

@test 'prefix chain: sudo -E env file.rs triple flag' {
    LBUFFER="sudo -E env file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env cargo-run file.rs'
}

@test 'prefix chain: sudo -E env file.go triple flag' {
    LBUFFER="sudo -E env file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env go-run file.go'
}

@test 'prefix chain: sudo -E env file.yml triple flag' {
    LBUFFER="sudo -E env file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env yq file.yml'
}

@test 'prefix chain: sudo -E env file.json triple flag' {
    LBUFFER="sudo -E env file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env jq file.json'
}

@test 'prefix chain: sudo -E env file.conf triple flag' {
    LBUFFER="sudo -E env file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env less file.conf'
}

@test 'prefix chain: sudo -E env file.html triple flag' {
    LBUFFER="sudo -E env file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sudo -E env open file.html'
}

#==============================================================
# 22. time env — double prefix
#==============================================================

@test 'prefix chain: time env file.txt' {
    LBUFFER="time env file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time env vim file.txt'
}

@test 'prefix chain: time env file.py' {
    LBUFFER="time env file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time env python file.py'
}

@test 'prefix chain: time env file.rs' {
    LBUFFER="time env file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time env cargo-run file.rs'
}

@test 'prefix chain: time env file.go' {
    LBUFFER="time env file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time env go-run file.go'
}

@test 'prefix chain: time env file.yml' {
    LBUFFER="time env file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time env yq file.yml'
}

@test 'prefix chain: time env file.conf' {
    LBUFFER="time env file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'time env less file.conf'
}

#==============================================================
# 23. noglob command — double prefix
#==============================================================

@test 'prefix chain: noglob command file.txt' {
    LBUFFER="noglob command file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob command vim file.txt'
}

@test 'prefix chain: noglob command file.py' {
    LBUFFER="noglob command file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob command python file.py'
}

@test 'prefix chain: noglob command file.rs' {
    LBUFFER="noglob command file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob command cargo-run file.rs'
}

@test 'prefix chain: noglob command file.go' {
    LBUFFER="noglob command file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob command go-run file.go'
}

@test 'prefix chain: noglob command file.yml' {
    LBUFFER="noglob command file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob command yq file.yml'
}

@test 'prefix chain: noglob command file.conf' {
    LBUFFER="noglob command file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'noglob command less file.conf'
}

#==============================================================
# 24. builtin command — double prefix
#==============================================================

@test 'prefix chain: builtin command file.txt' {
    LBUFFER="builtin command file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command vim file.txt'
}

@test 'prefix chain: builtin command file.py' {
    LBUFFER="builtin command file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command python file.py'
}

@test 'prefix chain: builtin command file.rs' {
    LBUFFER="builtin command file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command cargo-run file.rs'
}

@test 'prefix chain: builtin command file.go' {
    LBUFFER="builtin command file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command go-run file.go'
}

@test 'prefix chain: builtin command file.yml' {
    LBUFFER="builtin command file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command yq file.yml'
}

@test 'prefix chain: builtin command file.conf' {
    LBUFFER="builtin command file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command less file.conf'
}

@test 'prefix chain: builtin command file.html' {
    LBUFFER="builtin command file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command open file.html'
}

@test 'prefix chain: builtin command file.md' {
    LBUFFER="builtin command file.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'builtin command glow file.md'
}

#==============================================================
# 25. command sudo — double prefix
#==============================================================

@test 'prefix chain: command sudo file.txt' {
    LBUFFER="command sudo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command sudo vim file.txt'
}

@test 'prefix chain: command sudo file.py' {
    LBUFFER="command sudo file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command sudo python file.py'
}

@test 'prefix chain: command sudo file.rs' {
    LBUFFER="command sudo file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command sudo cargo-run file.rs'
}

@test 'prefix chain: command sudo file.go' {
    LBUFFER="command sudo file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command sudo go-run file.go'
}

@test 'prefix chain: command sudo file.yml' {
    LBUFFER="command sudo file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command sudo yq file.yml'
}

@test 'prefix chain: command sudo file.json' {
    LBUFFER="command sudo file.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'command sudo jq file.json'
}

#==============================================================
# 26. nice sudo — double prefix
#==============================================================

@test 'prefix chain: nice sudo file.txt' {
    LBUFFER="nice sudo file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice sudo vim file.txt'
}

@test 'prefix chain: nice sudo file.py' {
    LBUFFER="nice sudo file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice sudo python file.py'
}

@test 'prefix chain: nice sudo file.rs' {
    LBUFFER="nice sudo file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice sudo cargo-run file.rs'
}

@test 'prefix chain: nice sudo file.go' {
    LBUFFER="nice sudo file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice sudo go-run file.go'
}

@test 'prefix chain: nice sudo file.yml' {
    LBUFFER="nice sudo file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice sudo yq file.yml'
}

@test 'prefix chain: nice sudo file.conf' {
    LBUFFER="nice sudo file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nice sudo less file.conf'
}

#==============================================================
# 27. nohup env — double prefix
#==============================================================

@test 'prefix chain: nohup env file.txt' {
    LBUFFER="nohup env file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup env vim file.txt'
}

@test 'prefix chain: nohup env file.py' {
    LBUFFER="nohup env file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup env python file.py'
}

@test 'prefix chain: nohup env file.rs' {
    LBUFFER="nohup env file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup env cargo-run file.rs'
}

@test 'prefix chain: nohup env file.go' {
    LBUFFER="nohup env file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup env go-run file.go'
}

@test 'prefix chain: nohup env file.yml' {
    LBUFFER="nohup env file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup env yq file.yml'
}

@test 'prefix chain: nohup env file.conf' {
    LBUFFER="nohup env file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nohup env less file.conf'
}
