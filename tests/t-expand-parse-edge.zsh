#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive zpwrExpandParseWords tests
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
}

#==============================================================
# Single word inputs — common commands (firstword + lastword)
#==============================================================

@test 'single word: ls firstword' {
    zpwrExpandParseWords "ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'single word: ls lastword' {
    zpwrExpandParseWords "ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'single word: cd firstword' {
    zpwrExpandParseWords "cd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cd'
}

@test 'single word: cd lastword' {
    zpwrExpandParseWords "cd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cd'
}

@test 'single word: git firstword' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'single word: git lastword' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'single word: docker firstword' {
    zpwrExpandParseWords "docker"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'single word: docker lastword' {
    zpwrExpandParseWords "docker"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'docker'
}

@test 'single word: kubectl firstword' {
    zpwrExpandParseWords "kubectl"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'single word: kubectl lastword' {
    zpwrExpandParseWords "kubectl"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'kubectl'
}

@test 'single word: npm firstword' {
    zpwrExpandParseWords "npm"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'single word: npm lastword' {
    zpwrExpandParseWords "npm"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'npm'
}

@test 'single word: pip firstword' {
    zpwrExpandParseWords "pip"
    assert $ZPWR_VARS[firstword_partition] same_as 'pip'
}

@test 'single word: pip lastword' {
    zpwrExpandParseWords "pip"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pip'
}

@test 'single word: make firstword' {
    zpwrExpandParseWords "make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'single word: make lastword' {
    zpwrExpandParseWords "make"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'make'
}

@test 'single word: cargo firstword' {
    zpwrExpandParseWords "cargo"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'single word: cargo lastword' {
    zpwrExpandParseWords "cargo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cargo'
}

@test 'single word: go firstword' {
    zpwrExpandParseWords "go"
    assert $ZPWR_VARS[firstword_partition] same_as 'go'
}

@test 'single word: go lastword' {
    zpwrExpandParseWords "go"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'go'
}

@test 'single word: python firstword' {
    zpwrExpandParseWords "python"
    assert $ZPWR_VARS[firstword_partition] same_as 'python'
}

@test 'single word: python lastword' {
    zpwrExpandParseWords "python"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'python'
}

@test 'single word: ruby firstword' {
    zpwrExpandParseWords "ruby"
    assert $ZPWR_VARS[firstword_partition] same_as 'ruby'
}

@test 'single word: ruby lastword' {
    zpwrExpandParseWords "ruby"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ruby'
}

@test 'single word: node firstword' {
    zpwrExpandParseWords "node"
    assert $ZPWR_VARS[firstword_partition] same_as 'node'
}

@test 'single word: node lastword' {
    zpwrExpandParseWords "node"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'node'
}

@test 'single word: java firstword' {
    zpwrExpandParseWords "java"
    assert $ZPWR_VARS[firstword_partition] same_as 'java'
}

@test 'single word: java lastword' {
    zpwrExpandParseWords "java"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'java'
}

@test 'single word: rustc firstword' {
    zpwrExpandParseWords "rustc"
    assert $ZPWR_VARS[firstword_partition] same_as 'rustc'
}

@test 'single word: rustc lastword' {
    zpwrExpandParseWords "rustc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'rustc'
}

@test 'single word: gcc firstword' {
    zpwrExpandParseWords "gcc"
    assert $ZPWR_VARS[firstword_partition] same_as 'gcc'
}

@test 'single word: gcc lastword' {
    zpwrExpandParseWords "gcc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'gcc'
}

@test 'single word: clang firstword' {
    zpwrExpandParseWords "clang"
    assert $ZPWR_VARS[firstword_partition] same_as 'clang'
}

@test 'single word: clang lastword' {
    zpwrExpandParseWords "clang"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'clang'
}

@test 'single word: vim firstword' {
    zpwrExpandParseWords "vim"
    assert $ZPWR_VARS[firstword_partition] same_as 'vim'
}

@test 'single word: vim lastword' {
    zpwrExpandParseWords "vim"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'vim'
}

@test 'single word: emacs firstword' {
    zpwrExpandParseWords "emacs"
    assert $ZPWR_VARS[firstword_partition] same_as 'emacs'
}

@test 'single word: emacs lastword' {
    zpwrExpandParseWords "emacs"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'emacs'
}

@test 'single word: nano firstword' {
    zpwrExpandParseWords "nano"
    assert $ZPWR_VARS[firstword_partition] same_as 'nano'
}

@test 'single word: cat firstword' {
    zpwrExpandParseWords "cat"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'single word: grep firstword' {
    zpwrExpandParseWords "grep"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'single word: sed firstword' {
    zpwrExpandParseWords "sed"
    assert $ZPWR_VARS[firstword_partition] same_as 'sed'
}

@test 'single word: awk firstword' {
    zpwrExpandParseWords "awk"
    assert $ZPWR_VARS[firstword_partition] same_as 'awk'
}

@test 'single word: find firstword' {
    zpwrExpandParseWords "find"
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'single word: sort firstword' {
    zpwrExpandParseWords "sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'single word: uniq firstword' {
    zpwrExpandParseWords "uniq"
    assert $ZPWR_VARS[firstword_partition] same_as 'uniq'
}

@test 'single word: wc firstword' {
    zpwrExpandParseWords "wc"
    assert $ZPWR_VARS[firstword_partition] same_as 'wc'
}

@test 'single word: head firstword' {
    zpwrExpandParseWords "head"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'single word: tail firstword' {
    zpwrExpandParseWords "tail"
    assert $ZPWR_VARS[firstword_partition] same_as 'tail'
}

@test 'single word: tee firstword' {
    zpwrExpandParseWords "tee"
    assert $ZPWR_VARS[firstword_partition] same_as 'tee'
}

@test 'single word: xargs firstword' {
    zpwrExpandParseWords "xargs"
    assert $ZPWR_VARS[firstword_partition] same_as 'xargs'
}

@test 'single word: curl firstword' {
    zpwrExpandParseWords "curl"
    assert $ZPWR_VARS[firstword_partition] same_as 'curl'
}

@test 'single word: wget firstword' {
    zpwrExpandParseWords "wget"
    assert $ZPWR_VARS[firstword_partition] same_as 'wget'
}

@test 'single word: ssh firstword' {
    zpwrExpandParseWords "ssh"
    assert $ZPWR_VARS[firstword_partition] same_as 'ssh'
}

@test 'single word: scp firstword' {
    zpwrExpandParseWords "scp"
    assert $ZPWR_VARS[firstword_partition] same_as 'scp'
}

@test 'single word: rsync firstword' {
    zpwrExpandParseWords "rsync"
    assert $ZPWR_VARS[firstword_partition] same_as 'rsync'
}

@test 'single word: tar firstword' {
    zpwrExpandParseWords "tar"
    assert $ZPWR_VARS[firstword_partition] same_as 'tar'
}

@test 'single word: gzip firstword' {
    zpwrExpandParseWords "gzip"
    assert $ZPWR_VARS[firstword_partition] same_as 'gzip'
}

@test 'single word: zip firstword' {
    zpwrExpandParseWords "zip"
    assert $ZPWR_VARS[firstword_partition] same_as 'zip'
}

@test 'single word: unzip firstword' {
    zpwrExpandParseWords "unzip"
    assert $ZPWR_VARS[firstword_partition] same_as 'unzip'
}

@test 'single word: chmod firstword' {
    zpwrExpandParseWords "chmod"
    assert $ZPWR_VARS[firstword_partition] same_as 'chmod'
}

@test 'single word: chown firstword' {
    zpwrExpandParseWords "chown"
    assert $ZPWR_VARS[firstword_partition] same_as 'chown'
}

@test 'single word: chgrp firstword' {
    zpwrExpandParseWords "chgrp"
    assert $ZPWR_VARS[firstword_partition] same_as 'chgrp'
}

@test 'single word: mkdir firstword' {
    zpwrExpandParseWords "mkdir"
    assert $ZPWR_VARS[firstword_partition] same_as 'mkdir'
}

@test 'single word: rmdir firstword' {
    zpwrExpandParseWords "rmdir"
    assert $ZPWR_VARS[firstword_partition] same_as 'rmdir'
}

@test 'single word: touch firstword' {
    zpwrExpandParseWords "touch"
    assert $ZPWR_VARS[firstword_partition] same_as 'touch'
}

@test 'single word: mv firstword' {
    zpwrExpandParseWords "mv"
    assert $ZPWR_VARS[firstword_partition] same_as 'mv'
}

@test 'single word: cp firstword' {
    zpwrExpandParseWords "cp"
    assert $ZPWR_VARS[firstword_partition] same_as 'cp'
}

@test 'single word: rm firstword' {
    zpwrExpandParseWords "rm"
    assert $ZPWR_VARS[firstword_partition] same_as 'rm'
}

@test 'single word: ln firstword' {
    zpwrExpandParseWords "ln"
    assert $ZPWR_VARS[firstword_partition] same_as 'ln'
}

@test 'single word: df firstword' {
    zpwrExpandParseWords "df"
    assert $ZPWR_VARS[firstword_partition] same_as 'df'
}

@test 'single word: du firstword' {
    zpwrExpandParseWords "du"
    assert $ZPWR_VARS[firstword_partition] same_as 'du'
}

@test 'single word: ps firstword' {
    zpwrExpandParseWords "ps"
    assert $ZPWR_VARS[firstword_partition] same_as 'ps'
}

@test 'single word: top firstword' {
    zpwrExpandParseWords "top"
    assert $ZPWR_VARS[firstword_partition] same_as 'top'
}

@test 'single word: kill firstword' {
    zpwrExpandParseWords "kill"
    assert $ZPWR_VARS[firstword_partition] same_as 'kill'
}

@test 'single word: nice firstword' {
    zpwrExpandParseWords "nice"
    assert $ZPWR_VARS[firstword_partition] same_as 'nice'
}

@test 'single word: time firstword' {
    zpwrExpandParseWords "time"
    assert $ZPWR_VARS[firstword_partition] same_as 'time'
}

@test 'single word: env firstword' {
    zpwrExpandParseWords "env"
    assert $ZPWR_VARS[firstword_partition] same_as 'env'
}

@test 'single word: sudo firstword' {
    zpwrExpandParseWords "sudo"
    assert $ZPWR_VARS[firstword_partition] same_as 'sudo'
}

@test 'single word: su firstword' {
    zpwrExpandParseWords "su"
    assert $ZPWR_VARS[firstword_partition] same_as 'su'
}

@test 'single word: bash firstword' {
    zpwrExpandParseWords "bash"
    assert $ZPWR_VARS[firstword_partition] same_as 'bash'
}

@test 'single word: zsh firstword' {
    zpwrExpandParseWords "zsh"
    assert $ZPWR_VARS[firstword_partition] same_as 'zsh'
}

@test 'single word: fish firstword' {
    zpwrExpandParseWords "fish"
    assert $ZPWR_VARS[firstword_partition] same_as 'fish'
}

@test 'single word: sh firstword' {
    zpwrExpandParseWords "sh"
    assert $ZPWR_VARS[firstword_partition] same_as 'sh'
}

@test 'single word: echo firstword' {
    zpwrExpandParseWords "echo"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'single word: echo lastword' {
    zpwrExpandParseWords "echo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'echo'
}

@test 'single word: pwd firstword' {
    zpwrExpandParseWords "pwd"
    assert $ZPWR_VARS[firstword_partition] same_as 'pwd'
}

@test 'single word: whoami firstword' {
    zpwrExpandParseWords "whoami"
    assert $ZPWR_VARS[firstword_partition] same_as 'whoami'
}

@test 'single word: hostname firstword' {
    zpwrExpandParseWords "hostname"
    assert $ZPWR_VARS[firstword_partition] same_as 'hostname'
}

@test 'single word: date firstword' {
    zpwrExpandParseWords "date"
    assert $ZPWR_VARS[firstword_partition] same_as 'date'
}

@test 'single word: cal firstword' {
    zpwrExpandParseWords "cal"
    assert $ZPWR_VARS[firstword_partition] same_as 'cal'
}

@test 'single word: man firstword' {
    zpwrExpandParseWords "man"
    assert $ZPWR_VARS[firstword_partition] same_as 'man'
}

@test 'single word: which firstword' {
    zpwrExpandParseWords "which"
    assert $ZPWR_VARS[firstword_partition] same_as 'which'
}

@test 'single word: type firstword' {
    zpwrExpandParseWords "type"
    assert $ZPWR_VARS[firstword_partition] same_as 'type'
}

#==============================================================
# Two word inputs — command + argument
#==============================================================

@test 'two words: git status firstword' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two words: git status lastword' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'two words: git log firstword' {
    zpwrExpandParseWords "git log"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two words: git log lastword' {
    zpwrExpandParseWords "git log"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'log'
}

@test 'two words: docker ps firstword' {
    zpwrExpandParseWords "docker ps"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two words: docker ps lastword' {
    zpwrExpandParseWords "docker ps"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ps'
}

@test 'two words: npm install firstword' {
    zpwrExpandParseWords "npm install"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'two words: npm install lastword' {
    zpwrExpandParseWords "npm install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'two words: pip install firstword' {
    zpwrExpandParseWords "pip install"
    assert $ZPWR_VARS[firstword_partition] same_as 'pip'
}

@test 'two words: pip install lastword' {
    zpwrExpandParseWords "pip install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'two words: make clean firstword' {
    zpwrExpandParseWords "make clean"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'two words: make clean lastword' {
    zpwrExpandParseWords "make clean"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'clean'
}

@test 'two words: ls -la firstword' {
    zpwrExpandParseWords "ls -la"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'two words: ls -la lastword' {
    zpwrExpandParseWords "ls -la"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-la'
}

@test 'two words: grep -r firstword' {
    zpwrExpandParseWords "grep -r"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'two words: grep -r lastword' {
    zpwrExpandParseWords "grep -r"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-r'
}

@test 'two words: find . firstword' {
    zpwrExpandParseWords "find ."
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'two words: find . lastword' {
    zpwrExpandParseWords "find ."
    assert $ZPWR_VARS[lastword_lbuffer] same_as '.'
}

@test 'two words: sort -n firstword' {
    zpwrExpandParseWords "sort -n"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'two words: sort -n lastword' {
    zpwrExpandParseWords "sort -n"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-n'
}

@test 'two words: cat file firstword' {
    zpwrExpandParseWords "cat file"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'two words: cat file lastword' {
    zpwrExpandParseWords "cat file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two words: echo hello firstword' {
    zpwrExpandParseWords "echo hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'two words: echo hello lastword' {
    zpwrExpandParseWords "echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'two words: cd /tmp firstword' {
    zpwrExpandParseWords "cd /tmp"
    assert $ZPWR_VARS[firstword_partition] same_as 'cd'
}

@test 'two words: cd /tmp lastword' {
    zpwrExpandParseWords "cd /tmp"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/tmp'
}

@test 'two words: sudo apt firstword' {
    zpwrExpandParseWords "sudo apt"
    assert $ZPWR_VARS[firstword_partition] same_as 'sudo'
}

@test 'two words: sudo apt lastword' {
    zpwrExpandParseWords "sudo apt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'apt'
}

@test 'two words: man bash firstword' {
    zpwrExpandParseWords "man bash"
    assert $ZPWR_VARS[firstword_partition] same_as 'man'
}

@test 'two words: man bash lastword' {
    zpwrExpandParseWords "man bash"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'bash'
}

@test 'two words: kill -9 lastword' {
    zpwrExpandParseWords "kill -9"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-9'
}

@test 'two words: chmod 755 lastword' {
    zpwrExpandParseWords "chmod 755"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '755'
}

@test 'two words: mkdir -p lastword' {
    zpwrExpandParseWords "mkdir -p"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-p'
}

@test 'two words: rm -rf lastword' {
    zpwrExpandParseWords "rm -rf"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-rf'
}

@test 'two words: tar xzf lastword' {
    zpwrExpandParseWords "tar xzf"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'xzf'
}

@test 'two words: ssh user@host lastword' {
    zpwrExpandParseWords "ssh user@host"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'user@host'
}

#==============================================================
# Three or more words
#==============================================================

@test 'three words: sudo git status firstword' {
    zpwrExpandParseWords "sudo git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'sudo'
}

@test 'three words: sudo git status lastword' {
    zpwrExpandParseWords "sudo git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'three words: git commit -m firstword' {
    zpwrExpandParseWords "git commit -m"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'three words: git commit -m lastword' {
    zpwrExpandParseWords "git commit -m"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-m'
}

@test 'four words: docker run -it ubuntu firstword' {
    zpwrExpandParseWords "docker run -it ubuntu"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'four words: docker run -it ubuntu lastword' {
    zpwrExpandParseWords "docker run -it ubuntu"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ubuntu'
}

@test 'five words: kubectl get pods -n default firstword' {
    zpwrExpandParseWords "kubectl get pods -n default"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'five words: kubectl get pods -n default lastword' {
    zpwrExpandParseWords "kubectl get pods -n default"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'default'
}

@test 'long command: find . -name *.txt -exec grep hello lastword' {
    zpwrExpandParseWords "find . -name *.txt -exec grep hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

#==============================================================
# After pipe |
#==============================================================

@test 'pipe: cat file | grep firstword' {
    zpwrExpandParseWords "cat file | grep"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe: cat file | grep lastword' {
    zpwrExpandParseWords "cat file | grep"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'grep'
}

@test 'pipe: cat file | grep foo firstword' {
    zpwrExpandParseWords "cat file | grep foo"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe: cat file | grep foo lastword' {
    zpwrExpandParseWords "cat file | grep foo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'foo'
}

@test 'pipe: ls | sort firstword' {
    zpwrExpandParseWords "ls | sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'pipe: ls | sort lastword' {
    zpwrExpandParseWords "ls | sort"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'sort'
}

@test 'pipe: ps aux | grep foo firstword' {
    zpwrExpandParseWords "ps aux | grep foo"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe: ps aux | grep foo lastword' {
    zpwrExpandParseWords "ps aux | grep foo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'foo'
}

@test 'pipe: echo hi | wc firstword' {
    zpwrExpandParseWords "echo hi | wc"
    assert $ZPWR_VARS[firstword_partition] same_as 'wc'
}

@test 'pipe: echo hi | wc lastword' {
    zpwrExpandParseWords "echo hi | wc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'wc'
}

@test 'pipe: dmesg | tail firstword' {
    zpwrExpandParseWords "dmesg | tail"
    assert $ZPWR_VARS[firstword_partition] same_as 'tail'
}

@test 'pipe: dmesg | tail lastword' {
    zpwrExpandParseWords "dmesg | tail"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'tail'
}

@test 'pipe: git log | head firstword' {
    zpwrExpandParseWords "git log | head"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'pipe: git log | head lastword' {
    zpwrExpandParseWords "git log | head"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'head'
}

@test 'pipe: cat /etc/passwd | cut -d: -f1 firstword' {
    zpwrExpandParseWords "cat /etc/passwd | cut -d: -f1"
    assert $ZPWR_VARS[firstword_partition] same_as 'cut'
}

@test 'pipe: cat /etc/passwd | cut -d: -f1 lastword' {
    zpwrExpandParseWords "cat /etc/passwd | cut -d: -f1"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-f1'
}

@test 'pipe: ls -la | awk firstword' {
    zpwrExpandParseWords "ls -la | awk"
    assert $ZPWR_VARS[firstword_partition] same_as 'awk'
}

@test 'pipe: echo test | tr firstword' {
    zpwrExpandParseWords "echo test | tr"
    assert $ZPWR_VARS[firstword_partition] same_as 'tr'
}

@test 'pipe: env | sort firstword' {
    zpwrExpandParseWords "env | sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'pipe: history | grep ssh firstword' {
    zpwrExpandParseWords "history | grep ssh"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe: history | grep ssh lastword' {
    zpwrExpandParseWords "history | grep ssh"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ssh'
}

#==============================================================
# After semicolon ;
#==============================================================

@test 'semicolon: ls; git firstword' {
    zpwrExpandParseWords "ls; git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'semicolon: ls; git lastword' {
    zpwrExpandParseWords "ls; git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'semicolon: echo hi; pwd firstword' {
    zpwrExpandParseWords "echo hi; pwd"
    assert $ZPWR_VARS[firstword_partition] same_as 'pwd'
}

@test 'semicolon: echo hi; pwd lastword' {
    zpwrExpandParseWords "echo hi; pwd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pwd'
}

@test 'semicolon: cd /tmp; ls firstword' {
    zpwrExpandParseWords "cd /tmp; ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'semicolon: cd /tmp; ls lastword' {
    zpwrExpandParseWords "cd /tmp; ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'semicolon: cd /tmp; ls -la firstword' {
    zpwrExpandParseWords "cd /tmp; ls -la"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'semicolon: cd /tmp; ls -la lastword' {
    zpwrExpandParseWords "cd /tmp; ls -la"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-la'
}

@test 'semicolon: mkdir foo; cd foo firstword' {
    zpwrExpandParseWords "mkdir foo; cd foo"
    assert $ZPWR_VARS[firstword_partition] same_as 'cd'
}

@test 'semicolon: mkdir foo; cd foo lastword' {
    zpwrExpandParseWords "mkdir foo; cd foo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'foo'
}

@test 'semicolon: make; make install firstword' {
    zpwrExpandParseWords "make; make install"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'semicolon: make; make install lastword' {
    zpwrExpandParseWords "make; make install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'semicolon: echo a; echo b; echo c firstword' {
    zpwrExpandParseWords "echo a; echo b; echo c"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'semicolon: echo a; echo b; echo c lastword' {
    zpwrExpandParseWords "echo a; echo b; echo c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

#==============================================================
# After && (logical AND)
#==============================================================

@test 'and: make && git firstword' {
    zpwrExpandParseWords "make && git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'and: make && git lastword' {
    zpwrExpandParseWords "make && git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'and: make && make install firstword' {
    zpwrExpandParseWords "make && make install"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'and: make && make install lastword' {
    zpwrExpandParseWords "make && make install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'and: cd /tmp && ls -la firstword' {
    zpwrExpandParseWords "cd /tmp && ls -la"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'and: cd /tmp && ls -la lastword' {
    zpwrExpandParseWords "cd /tmp && ls -la"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-la'
}

@test 'and: git add . && git commit firstword' {
    zpwrExpandParseWords "git add . && git commit"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'and: git add . && git commit lastword' {
    zpwrExpandParseWords "git add . && git commit"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'commit'
}

@test 'and: configure && make && make install firstword' {
    zpwrExpandParseWords "configure && make && make install"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'and: configure && make && make install lastword' {
    zpwrExpandParseWords "configure && make && make install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'and: true && echo success firstword' {
    zpwrExpandParseWords "true && echo success"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'and: true && echo success lastword' {
    zpwrExpandParseWords "true && echo success"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'success'
}

#==============================================================
# After || (logical OR)
#==============================================================

@test 'or: ls || echo firstword' {
    zpwrExpandParseWords "ls || echo"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'or: ls || echo lastword' {
    zpwrExpandParseWords "ls || echo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'echo'
}

@test 'or: ls || echo hello firstword' {
    zpwrExpandParseWords "ls || echo hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'or: ls || echo hello lastword' {
    zpwrExpandParseWords "ls || echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'or: false || true firstword' {
    zpwrExpandParseWords "false || true"
    assert $ZPWR_VARS[firstword_partition] same_as 'true'
}

@test 'or: test -f file || touch file firstword' {
    zpwrExpandParseWords "test -f file || touch file"
    assert $ZPWR_VARS[firstword_partition] same_as 'touch'
}

@test 'or: test -f file || touch file lastword' {
    zpwrExpandParseWords "test -f file || touch file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'or: cmd1 || cmd2 || cmd3 firstword' {
    zpwrExpandParseWords "cmd1 || cmd2 || cmd3"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd3'
}

@test 'or: cmd1 || cmd2 || cmd3 lastword' {
    zpwrExpandParseWords "cmd1 || cmd2 || cmd3"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd3'
}

#==============================================================
# After ( subshell
#==============================================================

@test 'subshell: (cmd firstword' {
    zpwrExpandParseWords "(cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'subshell: (cmd lastword' {
    zpwrExpandParseWords "(cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'subshell: (echo hello firstword' {
    zpwrExpandParseWords "(echo hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'subshell: (echo hello lastword' {
    zpwrExpandParseWords "(echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'subshell: ls; (git firstword' {
    zpwrExpandParseWords "ls; (git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'subshell: ls; (git lastword' {
    zpwrExpandParseWords "ls; (git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'subshell: (cd /tmp && ls firstword' {
    zpwrExpandParseWords "(cd /tmp && ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'subshell: (cd /tmp && ls lastword' {
    zpwrExpandParseWords "(cd /tmp && ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

#==============================================================
# After { brace group
#==============================================================

@test 'brace: { cmd firstword' {
    zpwrExpandParseWords "{ cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'brace: { cmd lastword' {
    zpwrExpandParseWords "{ cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'brace: { echo hello firstword' {
    zpwrExpandParseWords "{ echo hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'brace: { echo hello lastword' {
    zpwrExpandParseWords "{ echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'brace: ls; { git firstword' {
    zpwrExpandParseWords "ls; { git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'brace: ls; { git lastword' {
    zpwrExpandParseWords "ls; { git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

#==============================================================
# Multiple separators — complex chains
#==============================================================

@test 'chain: a; b | c firstword' {
    zpwrExpandParseWords "a; b | c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'chain: a; b | c lastword' {
    zpwrExpandParseWords "a; b | c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'chain: a; b | c && d firstword' {
    zpwrExpandParseWords "a; b | c && d"
    assert $ZPWR_VARS[firstword_partition] same_as 'd'
}

@test 'chain: a; b | c && d lastword' {
    zpwrExpandParseWords "a; b | c && d"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'd'
}

@test 'chain: a; b | c && d || e firstword' {
    zpwrExpandParseWords "a; b | c && d || e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'chain: a; b | c && d || e; f firstword' {
    zpwrExpandParseWords "a; b | c && d || e; f"
    assert $ZPWR_VARS[firstword_partition] same_as 'f'
}

@test 'chain: a; b | c && d || e; f lastword' {
    zpwrExpandParseWords "a; b | c && d || e; f"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'f'
}

@test 'chain: echo a | grep b; cat c | wc firstword' {
    zpwrExpandParseWords "echo a | grep b; cat c | wc"
    assert $ZPWR_VARS[firstword_partition] same_as 'wc'
}

@test 'chain: echo a | grep b; cat c | wc lastword' {
    zpwrExpandParseWords "echo a | grep b; cat c | wc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'wc'
}

@test 'chain: ls && pwd || whoami firstword' {
    zpwrExpandParseWords "ls && pwd || whoami"
    assert $ZPWR_VARS[firstword_partition] same_as 'whoami'
}

@test 'chain: ls && pwd || whoami; date firstword' {
    zpwrExpandParseWords "ls && pwd || whoami; date"
    assert $ZPWR_VARS[firstword_partition] same_as 'date'
}

@test 'chain: (echo a; echo b) | grep a firstword' {
    zpwrExpandParseWords "(echo a; echo b) | grep a"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'chain: (echo a; echo b) | grep a lastword' {
    zpwrExpandParseWords "(echo a; echo b) | grep a"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'a'
}

#==============================================================
# Nested pipes — multiple pipes in chain
#==============================================================

@test 'nested pipe: a | b | c firstword' {
    zpwrExpandParseWords "a | b | c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'nested pipe: a | b | c lastword' {
    zpwrExpandParseWords "a | b | c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'nested pipe: a | b | c | d firstword' {
    zpwrExpandParseWords "a | b | c | d"
    assert $ZPWR_VARS[firstword_partition] same_as 'd'
}

@test 'nested pipe: a | b | c | d lastword' {
    zpwrExpandParseWords "a | b | c | d"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'd'
}

@test 'nested pipe: cat f | grep x | sort | uniq firstword' {
    zpwrExpandParseWords "cat f | grep x | sort | uniq"
    assert $ZPWR_VARS[firstword_partition] same_as 'uniq'
}

@test 'nested pipe: cat f | grep x | sort | uniq lastword' {
    zpwrExpandParseWords "cat f | grep x | sort | uniq"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'uniq'
}

@test 'nested pipe: ps aux | grep node | awk firstword' {
    zpwrExpandParseWords "ps aux | grep node | awk"
    assert $ZPWR_VARS[firstword_partition] same_as 'awk'
}

@test 'nested pipe: cat f | sort | uniq -c | sort -rn | head firstword' {
    zpwrExpandParseWords "cat f | sort | uniq -c | sort -rn | head"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'nested pipe: cat f | sort | uniq -c | sort -rn | head lastword' {
    zpwrExpandParseWords "cat f | sort | uniq -c | sort -rn | head"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'head'
}

@test 'nested pipe: echo hello | tr a-z A-Z | rev firstword' {
    zpwrExpandParseWords "echo hello | tr a-z A-Z | rev"
    assert $ZPWR_VARS[firstword_partition] same_as 'rev'
}

#==============================================================
# With assignments (VAR=val) — should be removed
#==============================================================

@test 'assign: FOO=bar cmd firstword' {
    zpwrExpandParseWords "FOO=bar cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: FOO=bar cmd lastword' {
    zpwrExpandParseWords "FOO=bar cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'assign: FOO=bar cmd arg firstword' {
    zpwrExpandParseWords "FOO=bar cmd arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: FOO=bar cmd arg lastword' {
    zpwrExpandParseWords "FOO=bar cmd arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'assign: A=1 B=2 cmd firstword' {
    zpwrExpandParseWords "A=1 B=2 cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: A=1 B=2 cmd lastword' {
    zpwrExpandParseWords "A=1 B=2 cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'assign: PATH=/usr/bin cmd firstword' {
    zpwrExpandParseWords "PATH=/usr/bin cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: PATH=/usr/bin cmd lastword' {
    zpwrExpandParseWords "PATH=/usr/bin cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'assign: CC=gcc make firstword' {
    zpwrExpandParseWords "CC=gcc make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'assign: LANG=C sort firstword' {
    zpwrExpandParseWords "LANG=C sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'assign: LANG=C sort lastword' {
    zpwrExpandParseWords "LANG=C sort"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'sort'
}

@test 'assign: A=1 B=2 C=3 env firstword' {
    zpwrExpandParseWords "A=1 B=2 C=3 env"
    assert $ZPWR_VARS[firstword_partition] same_as 'env'
}

@test 'assign: HOME=/tmp ls -la firstword' {
    zpwrExpandParseWords "HOME=/tmp ls -la"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'assign: HOME=/tmp ls -la lastword' {
    zpwrExpandParseWords "HOME=/tmp ls -la"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-la'
}

@test 'assign: EDITOR=vim git commit firstword' {
    zpwrExpandParseWords "EDITOR=vim git commit"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'assign: EDITOR=vim git commit lastword' {
    zpwrExpandParseWords "EDITOR=vim git commit"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'commit'
}

#==============================================================
# With redirections — should be removed
#==============================================================

@test 'redir: echo foo > file firstword' {
    zpwrExpandParseWords "echo foo > file"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'redir: cmd < input firstword' {
    zpwrExpandParseWords "cmd < input"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'redir: cmd &> /dev/null firstword' {
    zpwrExpandParseWords "cmd &> /dev/null"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

#==============================================================
# lastword_remove_special — bracket/paren/brace removal
#==============================================================

@test 'remove_special: plain word git unchanged' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'git'
}

@test 'remove_special: plain word hello unchanged' {
    zpwrExpandParseWords "hello"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'hello'
}

@test 'remove_special: plain word ls unchanged' {
    zpwrExpandParseWords "ls"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'ls'
}

@test 'remove_special: square brackets arr[0]' {
    zpwrExpandParseWords "echo arr[0]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arr0'
}

@test 'remove_special: square brackets arr[1]' {
    zpwrExpandParseWords "echo arr[1]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arr1'
}

@test 'remove_special: square brackets arr[idx]' {
    zpwrExpandParseWords "echo arr[idx]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arridx'
}

@test 'remove_special: parentheses func(arg)' {
    zpwrExpandParseWords "func(arg)"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'funcarg'
}

@test 'remove_special: parentheses func()' {
    zpwrExpandParseWords "func()"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as ''
}

@test 'remove_special: curly braces hash{key}' {
    zpwrExpandParseWords "echo hash{key}"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'hashkey'
}

@test 'remove_special: mixed a[1](2){3}' {
    zpwrExpandParseWords "echo a[1](2){3}"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'a123'
}

@test 'remove_special: empty brackets arr[]' {
    zpwrExpandParseWords "echo arr[]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arr'
}

@test 'remove_special: nested brackets a[b[c]]' {
    zpwrExpandParseWords "echo a[b[c]]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'abc'
}

@test 'remove_special: path without specials /usr/bin' {
    zpwrExpandParseWords "ls /usr/bin"
    assert $ZPWR_VARS[lastword_remove_special] same_as '/usr/bin'
}

@test 'remove_special: dotfile .bashrc' {
    zpwrExpandParseWords "cat .bashrc"
    assert $ZPWR_VARS[lastword_remove_special] same_as '.bashrc'
}

@test 'remove_special: flag --verbose' {
    zpwrExpandParseWords "cmd --verbose"
    assert $ZPWR_VARS[lastword_remove_special] same_as '--verbose'
}

@test 'remove_special: flag -v' {
    zpwrExpandParseWords "cmd -v"
    assert $ZPWR_VARS[lastword_remove_special] same_as '-v'
}

@test 'remove_special: number 42' {
    zpwrExpandParseWords "echo 42"
    assert $ZPWR_VARS[lastword_remove_special] same_as '42'
}

#==============================================================
# Paths as arguments
#==============================================================

@test 'path: ls /usr/local/bin firstword' {
    zpwrExpandParseWords "ls /usr/local/bin"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'path: ls /usr/local/bin lastword' {
    zpwrExpandParseWords "ls /usr/local/bin"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/usr/local/bin'
}

@test 'path: cd /var/log lastword' {
    zpwrExpandParseWords "cd /var/log"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/var/log'
}

@test 'path: cat /etc/hosts lastword' {
    zpwrExpandParseWords "cat /etc/hosts"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/etc/hosts'
}

@test 'path: vim /home/user/.vimrc lastword' {
    zpwrExpandParseWords "vim /home/user/.vimrc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/home/user/.vimrc'
}

@test 'path: relative ./script lastword' {
    zpwrExpandParseWords "bash ./script"
    assert $ZPWR_VARS[lastword_lbuffer] same_as './script'
}

@test 'path: parent ../parent lastword' {
    zpwrExpandParseWords "cd ../parent"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '../parent'
}

@test 'path: file with extension file.txt lastword' {
    zpwrExpandParseWords "cat file.txt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file.txt'
}

@test 'path: script.sh lastword' {
    zpwrExpandParseWords "bash script.sh"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'script.sh'
}

@test 'path: index.html lastword' {
    zpwrExpandParseWords "vim index.html"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'index.html'
}

@test 'path: deep nested /a/b/c/d/e lastword' {
    zpwrExpandParseWords "ls /a/b/c/d/e"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/a/b/c/d/e'
}

#==============================================================
# Flags as last word
#==============================================================

@test 'flag: cmd -v lastword' {
    zpwrExpandParseWords "cmd -v"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-v'
}

@test 'flag: cmd --help lastword' {
    zpwrExpandParseWords "cmd --help"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--help'
}

@test 'flag: cmd --version lastword' {
    zpwrExpandParseWords "cmd --version"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--version'
}

@test 'flag: grep -rn lastword' {
    zpwrExpandParseWords "grep -rn"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-rn'
}

@test 'flag: ls --color=auto lastword' {
    zpwrExpandParseWords "ls --color=auto"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'flag: cmd -vvv lastword' {
    zpwrExpandParseWords "cmd -vvv"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-vvv'
}

@test 'flag: cmd --config=value lastword' {
    zpwrExpandParseWords "cmd --config=value"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'flag: cmd --output=/tmp/out lastword' {
    zpwrExpandParseWords "cmd --output=/tmp/out"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'flag: curl -fsSL lastword' {
    zpwrExpandParseWords "curl -fsSL"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-fsSL'
}

@test 'flag: tar -xzvf lastword' {
    zpwrExpandParseWords "tar -xzvf"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-xzvf'
}

#==============================================================
# Numbers as arguments
#==============================================================

@test 'number: echo 42 lastword' {
    zpwrExpandParseWords "echo 42"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '42'
}

@test 'number: kill -9 1234 lastword' {
    zpwrExpandParseWords "kill -9 1234"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '1234'
}

@test 'number: echo 0 lastword' {
    zpwrExpandParseWords "echo 0"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '0'
}

@test 'number: echo 999999 lastword' {
    zpwrExpandParseWords "echo 999999"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '999999'
}

@test 'number: sleep 5 lastword' {
    zpwrExpandParseWords "sleep 5"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '5'
}

@test 'number: head -n 100 lastword' {
    zpwrExpandParseWords "head -n 100"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '100'
}

#==============================================================
# Double-dash terminator
#==============================================================

@test 'double-dash: cmd -- arg firstword' {
    zpwrExpandParseWords "cmd -- arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'double-dash: cmd -- arg lastword' {
    zpwrExpandParseWords "cmd -- arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'double-dash: git checkout -- file lastword' {
    zpwrExpandParseWords "git checkout -- file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'double-dash: ssh host -- ls lastword' {
    zpwrExpandParseWords "ssh host -- ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

#==============================================================
# Mixed separators with pipes
#==============================================================

@test 'mixed: cmd1; cmd2 | cmd3 firstword' {
    zpwrExpandParseWords "cmd1; cmd2 | cmd3"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd3'
}

@test 'mixed: cmd1; cmd2 | cmd3 lastword' {
    zpwrExpandParseWords "cmd1; cmd2 | cmd3"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd3'
}

@test 'mixed: cmd1; cmd2 | cmd3 && cmd4 firstword' {
    zpwrExpandParseWords "cmd1; cmd2 | cmd3 && cmd4"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd4'
}

@test 'mixed: echo a | grep b && cat c firstword' {
    zpwrExpandParseWords "echo a | grep b && cat c"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'mixed: echo a | grep b && cat c lastword' {
    zpwrExpandParseWords "echo a | grep b && cat c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'mixed: ls; echo hi | wc -l && pwd firstword' {
    zpwrExpandParseWords "ls; echo hi | wc -l && pwd"
    assert $ZPWR_VARS[firstword_partition] same_as 'pwd'
}

@test 'mixed: ls; echo hi | wc -l && pwd lastword' {
    zpwrExpandParseWords "ls; echo hi | wc -l && pwd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pwd'
}

#==============================================================
# Assignments combined with separators
#==============================================================

@test 'assign+sep: ls; FOO=bar cmd firstword' {
    zpwrExpandParseWords "ls; FOO=bar cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign+sep: ls; FOO=bar cmd lastword' {
    zpwrExpandParseWords "ls; FOO=bar cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'assign+pipe: FOO=bar cmd | grep firstword' {
    zpwrExpandParseWords "FOO=bar cmd | grep"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'assign+and: FOO=bar cmd && BAR=baz other firstword' {
    zpwrExpandParseWords "FOO=bar cmd && BAR=baz other"
    assert $ZPWR_VARS[firstword_partition] same_as 'other'
}

@test 'assign+and: FOO=bar cmd && BAR=baz other lastword' {
    zpwrExpandParseWords "FOO=bar cmd && BAR=baz other"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'other'
}

#==============================================================
# Very long commands with many words
#==============================================================

@test 'long: find . -type f -name *.log -mtime +7 -exec rm firstword' {
    zpwrExpandParseWords "find . -type f -name *.log -mtime +7 -exec rm"
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'long: find . -type f -name *.log -mtime +7 -exec rm lastword' {
    zpwrExpandParseWords "find . -type f -name *.log -mtime +7 -exec rm"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'rm'
}

@test 'long: docker run --rm -it -v /host:/container -p 8080:80 -e FOO=bar ubuntu bash firstword' {
    zpwrExpandParseWords "docker run --rm -it -v /host:/container -p 8080:80 -e FOO=bar ubuntu bash"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'long: docker run --rm -it -v /host:/container -p 8080:80 -e FOO=bar ubuntu bash lastword' {
    zpwrExpandParseWords "docker run --rm -it -v /host:/container -p 8080:80 -e FOO=bar ubuntu bash"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'bash'
}

@test 'long: kubectl get pods -n kube-system -o wide --sort-by=.metadata.name lastword' {
    zpwrExpandParseWords "kubectl get pods -n kube-system -o wide --sort-by=.metadata.name"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'wide'
}

@test 'long: rsync -avz --progress --exclude=node_modules src/ dest/ lastword' {
    zpwrExpandParseWords "rsync -avz --progress --exclude=node_modules src/ dest/"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dest/'
}

@test 'long: git log --oneline --graph --all --decorate firstword' {
    zpwrExpandParseWords "git log --oneline --graph --all --decorate"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'long: git log --oneline --graph --all --decorate lastword' {
    zpwrExpandParseWords "git log --oneline --graph --all --decorate"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--decorate'
}

#==============================================================
# Special characters in words
#==============================================================

@test 'special: user@host lastword' {
    zpwrExpandParseWords "ssh user@host"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'user@host'
}

@test 'special: user@host:path lastword' {
    zpwrExpandParseWords "scp user@host:path"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'user@host:path'
}

@test 'special: url http://example.com lastword' {
    zpwrExpandParseWords "curl http://example.com"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'http://example.com'
}

@test 'special: colon-separated PATH-like /a:/b:/c lastword' {
    zpwrExpandParseWords "echo /a:/b:/c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/a:/b:/c'
}

@test 'special: tilde ~ lastword' {
    zpwrExpandParseWords "cd ~"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '~'
}

@test 'special: tilde expansion ~/Documents lastword' {
    zpwrExpandParseWords "cd ~/Documents"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '~/Documents'
}

@test 'special: glob star *.txt lastword' {
    zpwrExpandParseWords "ls *.txt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '*.txt'
}

@test 'special: glob question mark file?.txt lastword' {
    zpwrExpandParseWords "ls file?.txt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file?.txt'
}

@test 'special: percent %1 lastword' {
    zpwrExpandParseWords "fg %1"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '%1'
}

@test 'special: hash comment removed #comment lastword' {
    zpwrExpandParseWords "echo word"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'word'
}

@test 'special: exclamation !$ lastword' {
    zpwrExpandParseWords "echo !$"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '!$'
}

@test 'special: comma-separated a,b,c lastword' {
    zpwrExpandParseWords "echo a,b,c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'a,b,c'
}

#==============================================================
# Edge: pipe with args after pipe
#==============================================================

@test 'pipe+args: cat f | grep -i pattern firstword' {
    zpwrExpandParseWords "cat f | grep -i pattern"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe+args: cat f | grep -i pattern lastword' {
    zpwrExpandParseWords "cat f | grep -i pattern"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pattern'
}

@test 'pipe+args: ls -la | awk -F: lastword' {
    zpwrExpandParseWords "ls -la | awk -F:"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-F:'
}

@test 'pipe+args: ps | sort -k2 lastword' {
    zpwrExpandParseWords "ps | sort -k2"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-k2'
}

@test 'pipe+args: env | grep -E ^PATH firstword' {
    zpwrExpandParseWords "env | grep -E ^PATH"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe+args: env | grep -E ^PATH lastword' {
    zpwrExpandParseWords "env | grep -E ^PATH"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '^PATH'
}

#==============================================================
# Edge: semicolon with spaces variations
#==============================================================

@test 'semi-space: ls ;git firstword' {
    zpwrExpandParseWords "ls ;git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'semi-space: a ;b ;c firstword' {
    zpwrExpandParseWords "a ;b ;c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

#==============================================================
# Edge: assignment with complex values
#==============================================================

@test 'assign-complex: LD_LIBRARY_PATH=/usr/lib:/usr/local/lib cmd firstword' {
    zpwrExpandParseWords "LD_LIBRARY_PATH=/usr/lib:/usr/local/lib cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign-complex: CFLAGS=-O2 LDFLAGS=-L/lib make firstword' {
    zpwrExpandParseWords "CFLAGS=-O2 LDFLAGS=-L/lib make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'assign-complex: CFLAGS=-O2 LDFLAGS=-L/lib make lastword' {
    zpwrExpandParseWords "CFLAGS=-O2 LDFLAGS=-L/lib make"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'make'
}

@test 'assign-complex: NODE_ENV=production npm start firstword' {
    zpwrExpandParseWords "NODE_ENV=production npm start"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'assign-complex: NODE_ENV=production npm start lastword' {
    zpwrExpandParseWords "NODE_ENV=production npm start"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'start'
}

@test 'assign-complex: GOPATH=/go GOBIN=/go/bin go build firstword' {
    zpwrExpandParseWords "GOPATH=/go GOBIN=/go/bin go build"
    assert $ZPWR_VARS[firstword_partition] same_as 'go'
}

@test 'assign-complex: GOPATH=/go GOBIN=/go/bin go build lastword' {
    zpwrExpandParseWords "GOPATH=/go GOBIN=/go/bin go build"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'build'
}

#==============================================================
# Edge: consecutive separators and resets
#==============================================================

@test 'consec: a && b && c firstword' {
    zpwrExpandParseWords "a && b && c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'consec: a && b && c lastword' {
    zpwrExpandParseWords "a && b && c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'consec: a || b || c || d firstword' {
    zpwrExpandParseWords "a || b || c || d"
    assert $ZPWR_VARS[firstword_partition] same_as 'd'
}

@test 'consec: a; b; c; d; e firstword' {
    zpwrExpandParseWords "a; b; c; d; e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'consec: a; b; c; d; e lastword' {
    zpwrExpandParseWords "a; b; c; d; e"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'e'
}

@test 'consec: a | b | c | d | e firstword' {
    zpwrExpandParseWords "a | b | c | d | e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'consec: a | b | c | d | e lastword' {
    zpwrExpandParseWords "a | b | c | d | e"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'e'
}

#==============================================================
# Edge: remove_special with various combinations
#==============================================================

@test 'remove_special: path /usr/local/bin unchanged' {
    zpwrExpandParseWords "ls /usr/local/bin"
    assert $ZPWR_VARS[lastword_remove_special] same_as '/usr/local/bin'
}

@test 'remove_special: dotted file.tar.gz unchanged' {
    zpwrExpandParseWords "tar file.tar.gz"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'file.tar.gz'
}

@test 'remove_special: hyphenated my-project unchanged' {
    zpwrExpandParseWords "cd my-project"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'my-project'
}

@test 'remove_special: underscore my_file unchanged' {
    zpwrExpandParseWords "cat my_file"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'my_file'
}

@test 'remove_special: at sign user@host unchanged' {
    zpwrExpandParseWords "ssh user@host"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'user@host'
}

@test 'remove_special: equals --flag=val unchanged' {
    zpwrExpandParseWords "cmd --flag=val"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'cmd'
}

@test 'remove_special: colon a:b unchanged' {
    zpwrExpandParseWords "echo a:b"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'a:b'
}

@test 'remove_special: tilde ~ unchanged' {
    zpwrExpandParseWords "cd ~"
    assert $ZPWR_VARS[lastword_remove_special] same_as '~'
}

@test 'remove_special: single bracket [ removed' {
    zpwrExpandParseWords "echo x["
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'x'
}

@test 'remove_special: single paren ( removed' {
    zpwrExpandParseWords "echo x("
    assert $ZPWR_VARS[lastword_remove_special] same_as 'x'
}

@test 'remove_special: single brace { in word' {
    zpwrExpandParseWords "echo x{"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'x'
}

@test 'remove_special: closing bracket ] removed' {
    zpwrExpandParseWords "echo x]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'x'
}

@test 'remove_special: closing paren ) removed' {
    zpwrExpandParseWords "echo x)"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as ''
}

@test 'remove_special: closing brace } removed' {
    zpwrExpandParseWords "echo x}"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as ''
}

#==============================================================
# Pipe followed by command with multiple args
#==============================================================

@test 'pipe-multi: echo a | sed s/a/b/ firstword' {
    zpwrExpandParseWords "echo a | sed s/a/b/"
    assert $ZPWR_VARS[firstword_partition] same_as 'sed'
}

@test 'pipe-multi: echo a | sed s/a/b/ lastword' {
    zpwrExpandParseWords "echo a | sed s/a/b/"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 's/a/b/'
}

@test 'pipe-multi: ls | xargs -I{} cp {} /tmp firstword' {
    zpwrExpandParseWords "ls | xargs -I{} cp {} /tmp"
    assert $ZPWR_VARS[firstword_partition] same_as '}'
}

@test 'pipe-multi: ls | xargs -I{} cp {} /tmp lastword' {
    zpwrExpandParseWords "ls | xargs -I{} cp {} /tmp"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/tmp'
}

#==============================================================
# Semicolon and pipe combinations
#==============================================================

@test 'semi+pipe: a; b | c; d | e firstword' {
    zpwrExpandParseWords "a; b | c; d | e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'semi+pipe: a; b | c; d | e lastword' {
    zpwrExpandParseWords "a; b | c; d | e"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'e'
}

@test 'semi+pipe: git status; git log | head -5 firstword' {
    zpwrExpandParseWords "git status; git log | head -5"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'semi+pipe: git status; git log | head -5 lastword' {
    zpwrExpandParseWords "git status; git log | head -5"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-5'
}

#==============================================================
# Subshell and brace with other separators
#==============================================================

@test 'sub+pipe: (cat f | sort) | uniq firstword' {
    zpwrExpandParseWords "(cat f | sort) | uniq"
    assert $ZPWR_VARS[firstword_partition] same_as 'uniq'
}

@test 'sub+pipe: (cat f | sort) | uniq lastword' {
    zpwrExpandParseWords "(cat f | sort) | uniq"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'uniq'
}

@test 'sub+semi: (echo a; echo b) firstword looks at last partition' {
    zpwrExpandParseWords "(echo a; echo b)"
    assert $ZPWR_VARS[lastword_lbuffer] same_as ')'
}

@test 'brace+and: { cmd1 && cmd2 firstword' {
    zpwrExpandParseWords "{ cmd1 && cmd2"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd2'
}

@test 'brace+and: { cmd1 && cmd2 lastword' {
    zpwrExpandParseWords "{ cmd1 && cmd2"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd2'
}

#==============================================================
# More assignment edge cases
#==============================================================

@test 'assign: single assignment alone FOO=bar firstword' {
    zpwrExpandParseWords "FOO=bar"
    assert "$ZPWR_VARS[lastword_lbuffer]" same_as ''
}

@test 'assign: lowercase var a=1 cmd firstword' {
    zpwrExpandParseWords "a=1 cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: var with underscore MY_VAR=val cmd firstword' {
    zpwrExpandParseWords "MY_VAR=val cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: var with number V1=x cmd firstword' {
    zpwrExpandParseWords "V1=x cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

#==============================================================
# Edge: pipe with no space around it
#==============================================================

@test 'nospace-pipe: a|b firstword' {
    zpwrExpandParseWords "a|b"
    assert $ZPWR_VARS[firstword_partition] same_as 'b'
}

@test 'nospace-pipe: a|b lastword' {
    zpwrExpandParseWords "a|b"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'b'
}

@test 'nospace-pipe: a|b|c firstword' {
    zpwrExpandParseWords "a|b|c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

#==============================================================
# Edge: semicolon with no space
#==============================================================

@test 'nospace-semi: a;b firstword' {
    zpwrExpandParseWords "a;b"
    assert $ZPWR_VARS[firstword_partition] same_as 'b'
}

@test 'nospace-semi: a;b lastword' {
    zpwrExpandParseWords "a;b"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'b'
}

@test 'nospace-semi: a;b;c firstword' {
    zpwrExpandParseWords "a;b;c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

#==============================================================
# Edge: commands with complex real-world patterns
#==============================================================

@test 'realworld: git log --pretty=format:%H firstword' {
    zpwrExpandParseWords "git log --pretty=format:%H"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'realworld: git log --pretty=format:%H lastword' {
    zpwrExpandParseWords "git log --pretty=format:%H"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'log'
}

@test 'realworld: docker exec -it container_name bash firstword' {
    zpwrExpandParseWords "docker exec -it container_name bash"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'realworld: docker exec -it container_name bash lastword' {
    zpwrExpandParseWords "docker exec -it container_name bash"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'bash'
}

@test 'realworld: npm run build && npm test firstword' {
    zpwrExpandParseWords "npm run build && npm test"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'realworld: npm run build && npm test lastword' {
    zpwrExpandParseWords "npm run build && npm test"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'test'
}

@test 'realworld: cargo build --release && cargo test firstword' {
    zpwrExpandParseWords "cargo build --release && cargo test"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'realworld: cargo build --release && cargo test lastword' {
    zpwrExpandParseWords "cargo build --release && cargo test"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'test'
}

@test 'realworld: python -m pytest -v --cov=src firstword' {
    zpwrExpandParseWords "python -m pytest -v --cov=src"
    assert $ZPWR_VARS[firstword_partition] same_as 'python'
}

@test 'realworld: python -m pytest -v --cov=src lastword' {
    zpwrExpandParseWords "python -m pytest -v --cov=src"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-v'
}

@test 'realworld: ssh -i key.pem user@host lastword' {
    zpwrExpandParseWords "ssh -i key.pem user@host"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'user@host'
}

@test 'realworld: rsync -avz src/ user@host:/dest lastword' {
    zpwrExpandParseWords "rsync -avz src/ user@host:/dest"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'user@host:/dest'
}

@test 'realworld: curl -X POST -H Content-Type lastword' {
    zpwrExpandParseWords "curl -X POST -H Content-Type"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'Content-Type'
}

@test 'realworld: kubectl apply -f deployment.yaml lastword' {
    zpwrExpandParseWords "kubectl apply -f deployment.yaml"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'deployment.yaml'
}

@test 'realworld: terraform plan -var-file=prod.tfvars lastword' {
    zpwrExpandParseWords "terraform plan -var-file=prod.tfvars"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'plan'
}

@test 'realworld: aws s3 cp s3://bucket/key . lastword' {
    zpwrExpandParseWords "aws s3 cp s3://bucket/key ."
    assert $ZPWR_VARS[lastword_lbuffer] same_as '.'
}

@test 'realworld: make -j4 CFLAGS=-O2 all lastword' {
    zpwrExpandParseWords "make -j4 CFLAGS=-O2 all"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'all'
}

#==============================================================
# Edge: remove_special after pipe/separator
#==============================================================

@test 'remove_special after pipe: ls | grep arr[0] strips brackets' {
    zpwrExpandParseWords "ls | grep arr[0]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arr0'
}

@test 'remove_special after semi: ls; echo func() strips parens' {
    zpwrExpandParseWords "ls; echo func()"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as ''
}

@test 'remove_special after and: a && echo x{y} strips braces' {
    zpwrExpandParseWords "a && echo x{y}"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'xy'
}

@test 'remove_special: single word with all three a[b](c){d}' {
    zpwrExpandParseWords "a[b](c){d}"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'abcd'
}

#==============================================================
# Edge: whitespace variations
#==============================================================

@test 'whitespace: extra spaces between words' {
    zpwrExpandParseWords "git  status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'whitespace: extra spaces firstword' {
    zpwrExpandParseWords "git  status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'whitespace: triple space between words' {
    zpwrExpandParseWords "echo   hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'whitespace: spaces around pipe' {
    zpwrExpandParseWords "ls  |  sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'whitespace: spaces around semicolon' {
    zpwrExpandParseWords "ls  ;  git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'whitespace: spaces around &&' {
    zpwrExpandParseWords "ls  &&  git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'whitespace: spaces around ||' {
    zpwrExpandParseWords "ls  ||  git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}
