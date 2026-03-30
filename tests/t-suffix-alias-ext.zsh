#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive suffix alias extension and path tests
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
    alias -s tsx=ts-node
    alias -s jsx=node
    alias -s yml=yq
    alias -s yaml=yq
    alias -s toml=toml-view
    alias -s ini=ini-view
    alias -s conf=less
    alias -s log=tail-f
    alias -s csv=csvtool
    alias -s xml=xmllint
    alias -s html=open
    alias -s css=less
    alias -s md=glow
    alias -s pdf=open
    alias -s sql=sqlite3
    alias -s lua=lua
    alias -s pl=perl
    alias -s r=Rscript
    alias -s R=Rscript
    alias -s scala=scala
    alias -s kt=kotlin
    alias -s swift=swift
    alias -s m=octave
    alias -s hs=runhaskell
    alias -s ex=elixir
    alias -s erl=erl
    alias -s clj=clojure
    alias -s lisp=sbcl
    alias -s ml=ocaml
    alias -s jl=julia
    alias -s dart=dart
    alias -s v=v
    alias -s zig=zig-run
    alias -s nim=nim-run
    alias -s d=rdmd
    alias -s ps1=pwsh
    alias -s bat=cmd
    alias -s awk=awk-f
    alias -s sed=sed-f
    alias -s tf=terraform
    alias -s hcl=terraform
    alias -s dockerfile=docker-build
    alias -s makefile=make-f
    alias -s cmake=cmake-p
    alias -s gradle=gradle
    alias -s sbt=sbt
    alias -s cabal=cabal
    alias -s cargo=cargo
    alias -s gemspec=gem
    alias -s gemfile=bundle
    alias -s lock=less
    alias -s diff=colordiff
    alias -s patch=patch
    alias -s gz=zcat
    alias -s bz2=bzcat
    alias -s xz=xzcat
    alias -s tar=tar-tvf
    alias -s zip=unzip-l

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# 1. Programming language extensions — basic command position
#==============================================================

@test 'suffix ext: file.rs expands to cargo-run file.rs' {
    LBUFFER="file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cargo-run file.rs'
}

@test 'suffix ext: main.go expands to go-run main.go' {
    LBUFFER="main.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'go-run main.go'
}

@test 'suffix ext: script.rb expands to ruby script.rb' {
    LBUFFER="script.rb"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ruby script.rb'
}

@test 'suffix ext: script.sh expands to bash script.sh' {
    LBUFFER="script.sh"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'bash script.sh'
}

@test 'suffix ext: script.zsh expands to zsh script.zsh' {
    LBUFFER="script.zsh"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'zsh script.zsh'
}

@test 'suffix ext: main.c expands to gcc main.c' {
    LBUFFER="main.c"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'gcc main.c'
}

@test 'suffix ext: main.cpp expands to g++ main.cpp' {
    LBUFFER="main.cpp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'g++ main.cpp'
}

@test 'suffix ext: Main.java expands to javac Main.java' {
    LBUFFER="Main.java"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'javac Main.java'
}

@test 'suffix ext: app.ts expands to ts-node app.ts' {
    LBUFFER="app.ts"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ts-node app.ts'
}

@test 'suffix ext: App.tsx expands to ts-node App.tsx' {
    LBUFFER="App.tsx"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ts-node App.tsx'
}

@test 'suffix ext: app.jsx expands to node app.jsx' {
    LBUFFER="app.jsx"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'node app.jsx'
}

@test 'suffix ext: script.pl expands to perl script.pl' {
    LBUFFER="script.pl"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'perl script.pl'
}

@test 'suffix ext: script.lua expands to lua script.lua' {
    LBUFFER="script.lua"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'lua script.lua'
}

@test 'suffix ext: analysis.r expands to Rscript analysis.r' {
    LBUFFER="analysis.r"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Rscript analysis.r'
}

@test 'suffix ext: analysis.R expands to Rscript analysis.R' {
    LBUFFER="analysis.R"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Rscript analysis.R'
}

@test 'suffix ext: App.scala expands to scala App.scala' {
    LBUFFER="App.scala"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'scala App.scala'
}

@test 'suffix ext: App.kt expands to kotlin App.kt' {
    LBUFFER="App.kt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'kotlin App.kt'
}

@test 'suffix ext: main.swift expands to swift main.swift' {
    LBUFFER="main.swift"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'swift main.swift'
}

@test 'suffix ext: calc.m expands to octave calc.m' {
    LBUFFER="calc.m"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'octave calc.m'
}

@test 'suffix ext: Main.hs expands to runhaskell Main.hs' {
    LBUFFER="Main.hs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'runhaskell Main.hs'
}

@test 'suffix ext: app.ex expands to elixir app.ex' {
    LBUFFER="app.ex"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'elixir app.ex'
}

@test 'suffix ext: app.erl expands to erl app.erl' {
    LBUFFER="app.erl"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'erl app.erl'
}

@test 'suffix ext: core.clj expands to clojure core.clj' {
    LBUFFER="core.clj"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'clojure core.clj'
}

@test 'suffix ext: app.lisp expands to sbcl app.lisp' {
    LBUFFER="app.lisp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sbcl app.lisp'
}

@test 'suffix ext: main.ml expands to ocaml main.ml' {
    LBUFFER="main.ml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ocaml main.ml'
}

@test 'suffix ext: main.jl expands to julia main.jl' {
    LBUFFER="main.jl"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'julia main.jl'
}

@test 'suffix ext: app.dart expands to dart app.dart' {
    LBUFFER="app.dart"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'dart app.dart'
}

@test 'suffix ext: main.v expands to v main.v' {
    LBUFFER="main.v"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'v main.v'
}

@test 'suffix ext: main.zig expands to zig-run main.zig' {
    LBUFFER="main.zig"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'zig-run main.zig'
}

@test 'suffix ext: main.nim expands to nim-run main.nim' {
    LBUFFER="main.nim"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'nim-run main.nim'
}

@test 'suffix ext: main.d expands to rdmd main.d' {
    LBUFFER="main.d"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rdmd main.d'
}

#==============================================================
# 2. Config / data extensions
#==============================================================

@test 'suffix ext: config.yml expands to yq config.yml' {
    LBUFFER="config.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq config.yml'
}

@test 'suffix ext: config.yaml expands to yq config.yaml' {
    LBUFFER="config.yaml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq config.yaml'
}

@test 'suffix ext: Cargo.toml expands to toml-view Cargo.toml' {
    LBUFFER="Cargo.toml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'toml-view Cargo.toml'
}

@test 'suffix ext: settings.ini expands to ini-view settings.ini' {
    LBUFFER="settings.ini"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ini-view settings.ini'
}

@test 'suffix ext: nginx.conf expands to less nginx.conf' {
    LBUFFER="nginx.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less nginx.conf'
}

@test 'suffix ext: app.log expands to tail-f app.log' {
    LBUFFER="app.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'tail-f app.log'
}

@test 'suffix ext: data.csv expands to csvtool data.csv' {
    LBUFFER="data.csv"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'csvtool data.csv'
}

@test 'suffix ext: data.xml expands to xmllint data.xml' {
    LBUFFER="data.xml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'xmllint data.xml'
}

@test 'suffix ext: index.html expands to open index.html' {
    LBUFFER="index.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'open index.html'
}

@test 'suffix ext: style.css expands to less style.css' {
    LBUFFER="style.css"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less style.css'
}

@test 'suffix ext: README.md expands to glow README.md' {
    LBUFFER="README.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'glow README.md'
}

@test 'suffix ext: doc.pdf expands to open doc.pdf' {
    LBUFFER="doc.pdf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'open doc.pdf'
}

@test 'suffix ext: query.sql expands to sqlite3 query.sql' {
    LBUFFER="query.sql"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sqlite3 query.sql'
}

#==============================================================
# 3. Scripting / ops extensions
#==============================================================

@test 'suffix ext: script.ps1 expands to pwsh script.ps1' {
    LBUFFER="script.ps1"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'pwsh script.ps1'
}

@test 'suffix ext: script.bat expands to cmd script.bat' {
    LBUFFER="script.bat"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cmd script.bat'
}

@test 'suffix ext: main.tf expands to terraform main.tf' {
    LBUFFER="main.tf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'terraform main.tf'
}

@test 'suffix ext: main.hcl expands to terraform main.hcl' {
    LBUFFER="main.hcl"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'terraform main.hcl'
}

#==============================================================
# 4. Archive / compression extensions
#==============================================================

@test 'suffix ext: data.gz expands to zcat data.gz' {
    LBUFFER="data.gz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'zcat data.gz'
}

@test 'suffix ext: data.bz2 expands to bzcat data.bz2' {
    LBUFFER="data.bz2"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'bzcat data.bz2'
}

@test 'suffix ext: data.xz expands to xzcat data.xz' {
    LBUFFER="data.xz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'xzcat data.xz'
}

@test 'suffix ext: data.tar expands to tar-tvf data.tar' {
    LBUFFER="data.tar"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'tar-tvf data.tar'
}

@test 'suffix ext: data.zip expands to unzip-l data.zip' {
    LBUFFER="data.zip"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'unzip-l data.zip'
}

@test 'suffix ext: changes.diff expands to colordiff changes.diff' {
    LBUFFER="changes.diff"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'colordiff changes.diff'
}

@test 'suffix ext: fix.patch expands to patch fix.patch' {
    LBUFFER="fix.patch"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'patch fix.patch'
}

@test 'suffix ext: yarn.lock expands to less yarn.lock' {
    LBUFFER="yarn.lock"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less yarn.lock'
}

#==============================================================
# 5. WAS_EXPANDED set correctly for each extension
#==============================================================

@test 'suffix ext: WAS_EXPANDED true for .rs' {
    LBUFFER="file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .go' {
    LBUFFER="file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .rb' {
    LBUFFER="file.rb"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .sh' {
    LBUFFER="file.sh"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .c' {
    LBUFFER="file.c"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .cpp' {
    LBUFFER="file.cpp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .java' {
    LBUFFER="file.java"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .ts' {
    LBUFFER="file.ts"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .yml' {
    LBUFFER="file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .toml' {
    LBUFFER="file.toml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .conf' {
    LBUFFER="file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .log' {
    LBUFFER="file.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .csv' {
    LBUFFER="file.csv"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .xml' {
    LBUFFER="file.xml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .html' {
    LBUFFER="file.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .css' {
    LBUFFER="file.css"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .md' {
    LBUFFER="file.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .pdf' {
    LBUFFER="file.pdf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .sql' {
    LBUFFER="file.sql"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'suffix ext: WAS_EXPANDED true for .lua' {
    LBUFFER="file.lua"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

#==============================================================
# 6. Unknown / unregistered extensions — no expansion
#==============================================================

@test 'suffix ext: unknown .abc does not expand' {
    LBUFFER="file.abc"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.abc'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: unknown .foo does not expand' {
    LBUFFER="file.foo"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.foo'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: unknown .qqq does not expand' {
    LBUFFER="file.qqq"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.qqq'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: unknown .zzz does not expand' {
    LBUFFER="file.zzz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.zzz'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: unknown .bak does not expand' {
    LBUFFER="file.bak"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.bak'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: unknown .tmp does not expand' {
    LBUFFER="file.tmp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.tmp'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: unknown .orig does not expand' {
    LBUFFER="file.orig"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.orig'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: unknown .swp does not expand' {
    LBUFFER="file.swp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.swp'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# 7. No extension — no expansion
#==============================================================

@test 'suffix ext: Makefile no ext does not expand' {
    LBUFFER="Makefile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Makefile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: Dockerfile no ext does not expand' {
    LBUFFER="Dockerfile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Dockerfile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: Vagrantfile no ext does not expand' {
    LBUFFER="Vagrantfile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Vagrantfile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: Rakefile no ext does not expand' {
    LBUFFER="Rakefile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Rakefile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: Gemfile no ext does not expand' {
    LBUFFER="Gemfile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Gemfile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: Procfile no ext does not expand' {
    LBUFFER="Procfile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'Procfile'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: LICENSE no ext does not expand' {
    LBUFFER="LICENSE"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'LICENSE'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: CHANGELOG no ext does not expand' {
    LBUFFER="CHANGELOG"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'CHANGELOG'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# 8. Path components — relative, absolute, home, parent
#==============================================================

@test 'suffix ext: ./file.rs relative path expands' {
    LBUFFER="./file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cargo-run ./file.rs'
}

@test 'suffix ext: ../file.go parent path expands' {
    LBUFFER="../file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'go-run ../file.go'
}

@test 'suffix ext: /usr/local/etc/nginx.conf absolute path expands' {
    LBUFFER="/usr/local/etc/nginx.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less /usr/local/etc/nginx.conf'
}

@test 'suffix ext: ~/notes.md home path expands' {
    LBUFFER="~/notes.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'glow ~/notes.md'
}

@test 'suffix ext: /tmp/test.py absolute python expands' {
    LBUFFER="/tmp/test.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'python /tmp/test.py'
}

@test 'suffix ext: ./src/main.rs nested relative expands' {
    LBUFFER="./src/main.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cargo-run ./src/main.rs'
}

@test 'suffix ext: /home/user/project/Cargo.toml deep absolute expands' {
    LBUFFER="/home/user/project/Cargo.toml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'toml-view /home/user/project/Cargo.toml'
}

@test 'suffix ext: ../../../file.txt parent chain expands' {
    LBUFFER="../../../file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'vim ../../../file.txt'
}

@test 'suffix ext: /var/log/syslog.log absolute log expands' {
    LBUFFER="/var/log/syslog.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'tail-f /var/log/syslog.log'
}

@test 'suffix ext: ~/projects/app/index.html home nested expands' {
    LBUFFER="~/projects/app/index.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'open ~/projects/app/index.html'
}

@test 'suffix ext: ./deeply/nested/path/to/file.yml relative deep expands' {
    LBUFFER="./deeply/nested/path/to/file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq ./deeply/nested/path/to/file.yml'
}

@test 'suffix ext: /etc/hosts.conf etc path expands' {
    LBUFFER="/etc/hosts.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less /etc/hosts.conf'
}

#==============================================================
# 9. Multiple dots in filename
#==============================================================

@test 'suffix ext: file.test.py multiple dots expands using last ext' {
    LBUFFER="file.test.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'python file.test.py'
}

@test 'suffix ext: file.spec.ts multiple dots ts expands' {
    LBUFFER="file.spec.ts"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ts-node file.spec.ts'
}

@test 'suffix ext: my.config.yml multiple dots yml expands' {
    LBUFFER="my.config.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq my.config.yml'
}

@test 'suffix ext: app.module.ts multiple dots module expands' {
    LBUFFER="app.module.ts"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ts-node app.module.ts'
}

@test 'suffix ext: data.backup.json multiple dots json expands' {
    LBUFFER="data.backup.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'jq data.backup.json'
}

@test 'suffix ext: archive.tar.gz uses last ext gz' {
    LBUFFER="archive.tar.gz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'zcat archive.tar.gz'
}

@test 'suffix ext: backup.tar.bz2 uses last ext bz2' {
    LBUFFER="backup.tar.bz2"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'bzcat backup.tar.bz2'
}

@test 'suffix ext: data.tar.xz uses last ext xz' {
    LBUFFER="data.tar.xz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'xzcat data.tar.xz'
}

@test 'suffix ext: v1.2.3.txt version dots txt expands' {
    LBUFFER="v1.2.3.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'vim v1.2.3.txt'
}

@test 'suffix ext: docker-compose.override.yml multi dots yml' {
    LBUFFER="docker-compose.override.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq docker-compose.override.yml'
}

#==============================================================
# 10. Does not expand in argument position
#==============================================================

@test 'suffix ext: echo file.rs does not expand in arg position' {
    LBUFFER="echo file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'echo file.rs'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: cat file.py does not expand in arg position' {
    LBUFFER="cat file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cat file.py'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: grep pattern file.log does not expand in arg position' {
    LBUFFER="grep pattern file.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'grep pattern file.log'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: vim file.txt does not expand in arg position' {
    LBUFFER="vim file.txt"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'vim file.txt'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: cp file.json dest does not expand in arg position' {
    LBUFFER="cp file.json dest"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cp file.json dest'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: mv old.rs new.rs does not expand in arg position' {
    LBUFFER="mv old.rs new.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'mv old.rs new.rs'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: rm file.go does not expand in arg position' {
    LBUFFER="rm file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'rm file.go'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: chmod +x file.sh does not expand in arg position' {
    LBUFFER="chmod +x file.sh"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'chmod +x file.sh'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# 11. Trailing space from tab completion — trimmed then expanded
#==============================================================

@test 'suffix ext: file.rs trailing space trimmed then expanded' {
    LBUFFER="file.rs "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cargo-run file.rs'
}

@test 'suffix ext: file.go trailing space trimmed then expanded' {
    LBUFFER="file.go "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'go-run file.go'
}

@test 'suffix ext: file.rb trailing space trimmed then expanded' {
    LBUFFER="file.rb "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ruby file.rb'
}

@test 'suffix ext: file.yml trailing space trimmed then expanded' {
    LBUFFER="file.yml "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq file.yml'
}

@test 'suffix ext: file.toml trailing space trimmed then expanded' {
    LBUFFER="file.toml "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'toml-view file.toml'
}

@test 'suffix ext: file.html trailing space trimmed then expanded' {
    LBUFFER="file.html "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'open file.html'
}

@test 'suffix ext: file.csv trailing space trimmed then expanded' {
    LBUFFER="file.csv "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'csvtool file.csv'
}

@test 'suffix ext: file.xml trailing space trimmed then expanded' {
    LBUFFER="file.xml "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'xmllint file.xml'
}

#==============================================================
# 12. Double trailing space — no expansion
#==============================================================

@test 'suffix ext: file.rs double trailing space no expand' {
    LBUFFER="file.rs  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.rs  '
}

@test 'suffix ext: file.go double trailing space no expand' {
    LBUFFER="file.go  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.go  '
}

@test 'suffix ext: file.py double trailing space no expand' {
    LBUFFER="file.py  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.py  '
}

@test 'suffix ext: file.yml double trailing space no expand' {
    LBUFFER="file.yml  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.yml  '
}

#==============================================================
# 13. WAS_EXPANDED false for unknown extensions
#==============================================================

@test 'suffix ext: WAS_EXPANDED false for .xyz' {
    LBUFFER="file.xyz"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: WAS_EXPANDED false for .bak' {
    LBUFFER="file.bak"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: WAS_EXPANDED false for .tmp' {
    LBUFFER="file.tmp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: WAS_EXPANDED false for no ext Makefile' {
    LBUFFER="Makefile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: WAS_EXPANDED false for no ext Dockerfile' {
    LBUFFER="Dockerfile"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: WAS_EXPANDED false for .orig' {
    LBUFFER="file.orig"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: WAS_EXPANDED false for .swp' {
    LBUFFER="file.swp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: WAS_EXPANDED false for .TXT uppercase' {
    LBUFFER="FILE.TXT"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# 13b. Additional programming language extensions — paths
#==============================================================

@test 'suffix ext: ./src/lib.rs nested rust file' {
    LBUFFER="./src/lib.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cargo-run ./src/lib.rs'
}

@test 'suffix ext: /home/user/app.go absolute go file' {
    LBUFFER="/home/user/app.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'go-run /home/user/app.go'
}

@test 'suffix ext: ../lib/utils.rb parent ruby file' {
    LBUFFER="../lib/utils.rb"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ruby ../lib/utils.rb'
}

@test 'suffix ext: ~/scripts/deploy.sh home shell file' {
    LBUFFER="~/scripts/deploy.sh"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'bash ~/scripts/deploy.sh'
}

@test 'suffix ext: ./test/unit.c relative c file' {
    LBUFFER="./test/unit.c"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'gcc ./test/unit.c'
}

@test 'suffix ext: /opt/src/main.cpp absolute cpp file' {
    LBUFFER="/opt/src/main.cpp"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'g++ /opt/src/main.cpp'
}

@test 'suffix ext: ./src/App.java relative java file' {
    LBUFFER="./src/App.java"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'javac ./src/App.java'
}

@test 'suffix ext: ~/project/index.ts home ts file' {
    LBUFFER="~/project/index.ts"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ts-node ~/project/index.ts'
}

@test 'suffix ext: /etc/app/config.yml absolute yml file' {
    LBUFFER="/etc/app/config.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq /etc/app/config.yml'
}

@test 'suffix ext: ./config/settings.toml relative toml file' {
    LBUFFER="./config/settings.toml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'toml-view ./config/settings.toml'
}

@test 'suffix ext: ../config/app.conf parent conf file' {
    LBUFFER="../config/app.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less ../config/app.conf'
}

@test 'suffix ext: /var/log/nginx/access.log absolute log file' {
    LBUFFER="/var/log/nginx/access.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'tail-f /var/log/nginx/access.log'
}

@test 'suffix ext: ~/data/export.csv home csv file' {
    LBUFFER="~/data/export.csv"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'csvtool ~/data/export.csv'
}

@test 'suffix ext: ./templates/page.html relative html file' {
    LBUFFER="./templates/page.html"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'open ./templates/page.html'
}

@test 'suffix ext: /usr/share/doc/readme.md absolute md file' {
    LBUFFER="/usr/share/doc/readme.md"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'glow /usr/share/doc/readme.md'
}

@test 'suffix ext: ./styles/main.css relative css file' {
    LBUFFER="./styles/main.css"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less ./styles/main.css'
}

@test 'suffix ext: /tmp/data.xml absolute xml file' {
    LBUFFER="/tmp/data.xml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'xmllint /tmp/data.xml'
}

@test 'suffix ext: ~/Documents/report.pdf home pdf file' {
    LBUFFER="~/Documents/report.pdf"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'open ~/Documents/report.pdf'
}

@test 'suffix ext: ./db/schema.sql relative sql file' {
    LBUFFER="./db/schema.sql"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sqlite3 ./db/schema.sql'
}

@test 'suffix ext: /usr/local/lib/helper.lua absolute lua file' {
    LBUFFER="/usr/local/lib/helper.lua"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'lua /usr/local/lib/helper.lua'
}

@test 'suffix ext: ./scripts/process.pl relative perl file' {
    LBUFFER="./scripts/process.pl"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'perl ./scripts/process.pl'
}

#==============================================================
# 13c. More no-expand in argument position
#==============================================================

@test 'suffix ext: ls file.conf does not expand in arg position' {
    LBUFFER="ls file.conf"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ls file.conf'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: wc file.csv does not expand in arg position' {
    LBUFFER="wc file.csv"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'wc file.csv'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: head file.log does not expand in arg position' {
    LBUFFER="head file.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'head file.log'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: diff file.yml old.yml does not expand in arg position' {
    LBUFFER="diff file.yml old.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'diff file.yml old.yml'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: scp file.rs host: does not expand in arg position' {
    LBUFFER="scp file.rs host:"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'scp file.rs host:'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: tar czf file.gz does not expand in arg position' {
    LBUFFER="tar czf file.gz"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'tar czf file.gz'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: git add file.java does not expand in arg position' {
    LBUFFER="git add file.java"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'git add file.java'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: python -m file.py does not expand in arg position' {
    LBUFFER="python -m file.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'python -m file.py'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: source file.zsh does not expand in arg position' {
    LBUFFER="source file.zsh"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'source file.zsh'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: docker run file.yml does not expand in arg position' {
    LBUFFER="docker run file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'docker run file.yml'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# 13d. More trailing space tests
#==============================================================

@test 'suffix ext: file.sh trailing space trimmed then expanded' {
    LBUFFER="file.sh "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'bash file.sh'
}

@test 'suffix ext: file.c trailing space trimmed then expanded' {
    LBUFFER="file.c "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'gcc file.c'
}

@test 'suffix ext: file.java trailing space trimmed then expanded' {
    LBUFFER="file.java "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'javac file.java'
}

@test 'suffix ext: file.conf trailing space trimmed then expanded' {
    LBUFFER="file.conf "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'less file.conf'
}

@test 'suffix ext: file.log trailing space trimmed then expanded' {
    LBUFFER="file.log "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'tail-f file.log'
}

@test 'suffix ext: file.md trailing space trimmed then expanded' {
    LBUFFER="file.md "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'glow file.md'
}

@test 'suffix ext: file.pdf trailing space trimmed then expanded' {
    LBUFFER="file.pdf "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'open file.pdf'
}

@test 'suffix ext: file.sql trailing space trimmed then expanded' {
    LBUFFER="file.sql "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'sqlite3 file.sql'
}

@test 'suffix ext: file.lua trailing space trimmed then expanded' {
    LBUFFER="file.lua "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'lua file.lua'
}

@test 'suffix ext: file.pl trailing space trimmed then expanded' {
    LBUFFER="file.pl "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'perl file.pl'
}

@test 'suffix ext: file.cpp trailing space trimmed then expanded' {
    LBUFFER="file.cpp "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'g++ file.cpp'
}

@test 'suffix ext: file.json trailing space trimmed then expanded' {
    LBUFFER="file.json "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'jq file.json'
}

#==============================================================
# 13e. More double trailing space no expand
#==============================================================

@test 'suffix ext: file.sh double trailing space no expand' {
    LBUFFER="file.sh  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.sh  '
}

@test 'suffix ext: file.c double trailing space no expand' {
    LBUFFER="file.c  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.c  '
}

@test 'suffix ext: file.java double trailing space no expand' {
    LBUFFER="file.java  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.java  '
}

@test 'suffix ext: file.conf double trailing space no expand' {
    LBUFFER="file.conf  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.conf  '
}

@test 'suffix ext: file.html double trailing space no expand' {
    LBUFFER="file.html  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.html  '
}

@test 'suffix ext: file.md double trailing space no expand' {
    LBUFFER="file.md  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.md  '
}

@test 'suffix ext: file.xml double trailing space no expand' {
    LBUFFER="file.xml  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.xml  '
}

@test 'suffix ext: file.json double trailing space no expand' {
    LBUFFER="file.json  "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRightTrim
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'file.json  '
}

#==============================================================
# 14. Filenames with hyphens, underscores, numbers
#==============================================================

@test 'suffix ext: my-file.rs hyphenated expands' {
    LBUFFER="my-file.rs"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'cargo-run my-file.rs'
}

@test 'suffix ext: my_file.go underscored expands' {
    LBUFFER="my_file.go"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'go-run my_file.go'
}

@test 'suffix ext: file123.py numbered expands' {
    LBUFFER="file123.py"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'python file123.py'
}

@test 'suffix ext: 2024-01-01.log date named expands' {
    LBUFFER="2024-01-01.log"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'tail-f 2024-01-01.log'
}

@test 'suffix ext: CamelCase.java case preserved expands' {
    LBUFFER="CamelCase.java"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'javac CamelCase.java'
}

@test 'suffix ext: ALLCAPS.TXT extension case matters no expand' {
    LBUFFER="ALLCAPS.TXT"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ALLCAPS.TXT'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'suffix ext: snake_case_file.yml underscore yml expands' {
    LBUFFER="snake_case_file.yml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'yq snake_case_file.yml'
}

@test 'suffix ext: kebab-case-file.toml hyphen toml expands' {
    LBUFFER="kebab-case-file.toml"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'toml-view kebab-case-file.toml'
}

@test 'suffix ext: file_v2.1.json version in name json expands' {
    LBUFFER="file_v2.1.json"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'jq file_v2.1.json'
}

@test 'suffix ext: test-2024.spec.rb multi special rb expands' {
    LBUFFER="test-2024.spec.rb"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandSuffixAlias
    assert $LBUFFER same_as 'ruby test-2024.spec.rb'
}
