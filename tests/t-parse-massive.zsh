#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Mar 25 2026
##### Purpose: massive parseWords tests
##### Notes: comprehensive tests for zpwrExpandParseWords
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

@test 'single: ls firstword' {
    zpwrExpandParseWords "ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'single: ls lastword' {
    zpwrExpandParseWords "ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'single: git firstword' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'single: git lastword' {
    zpwrExpandParseWords "git"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'git'
}

@test 'single: echo firstword' {
    zpwrExpandParseWords "echo"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'single: echo lastword' {
    zpwrExpandParseWords "echo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'echo'
}

@test 'single: cat firstword' {
    zpwrExpandParseWords "cat"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'single: cat lastword' {
    zpwrExpandParseWords "cat"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cat'
}

@test 'single: grep firstword' {
    zpwrExpandParseWords "grep"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'single: grep lastword' {
    zpwrExpandParseWords "grep"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'grep'
}

@test 'single: sed firstword' {
    zpwrExpandParseWords "sed"
    assert $ZPWR_VARS[firstword_partition] same_as 'sed'
}

@test 'single: sed lastword' {
    zpwrExpandParseWords "sed"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'sed'
}

@test 'single: awk firstword' {
    zpwrExpandParseWords "awk"
    assert $ZPWR_VARS[firstword_partition] same_as 'awk'
}

@test 'single: awk lastword' {
    zpwrExpandParseWords "awk"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'awk'
}

@test 'single: find firstword' {
    zpwrExpandParseWords "find"
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'single: find lastword' {
    zpwrExpandParseWords "find"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'find'
}

@test 'single: make firstword' {
    zpwrExpandParseWords "make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'single: make lastword' {
    zpwrExpandParseWords "make"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'make'
}

@test 'single: cmake firstword' {
    zpwrExpandParseWords "cmake"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmake'
}

@test 'single: cmake lastword' {
    zpwrExpandParseWords "cmake"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmake'
}

@test 'single: gcc firstword' {
    zpwrExpandParseWords "gcc"
    assert $ZPWR_VARS[firstword_partition] same_as 'gcc'
}

@test 'single: gcc lastword' {
    zpwrExpandParseWords "gcc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'gcc'
}

@test 'single: python firstword' {
    zpwrExpandParseWords "python"
    assert $ZPWR_VARS[firstword_partition] same_as 'python'
}

@test 'single: python lastword' {
    zpwrExpandParseWords "python"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'python'
}

@test 'single: ruby firstword' {
    zpwrExpandParseWords "ruby"
    assert $ZPWR_VARS[firstword_partition] same_as 'ruby'
}

@test 'single: ruby lastword' {
    zpwrExpandParseWords "ruby"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ruby'
}

@test 'single: node firstword' {
    zpwrExpandParseWords "node"
    assert $ZPWR_VARS[firstword_partition] same_as 'node'
}

@test 'single: node lastword' {
    zpwrExpandParseWords "node"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'node'
}

@test 'single: perl firstword' {
    zpwrExpandParseWords "perl"
    assert $ZPWR_VARS[firstword_partition] same_as 'perl'
}

@test 'single: perl lastword' {
    zpwrExpandParseWords "perl"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'perl'
}

@test 'single: java firstword' {
    zpwrExpandParseWords "java"
    assert $ZPWR_VARS[firstword_partition] same_as 'java'
}

@test 'single: java lastword' {
    zpwrExpandParseWords "java"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'java'
}

@test 'single: cargo firstword' {
    zpwrExpandParseWords "cargo"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'single: cargo lastword' {
    zpwrExpandParseWords "cargo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cargo'
}

@test 'single: npm firstword' {
    zpwrExpandParseWords "npm"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'single: npm lastword' {
    zpwrExpandParseWords "npm"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'npm'
}

@test 'single: yarn firstword' {
    zpwrExpandParseWords "yarn"
    assert $ZPWR_VARS[firstword_partition] same_as 'yarn'
}

@test 'single: yarn lastword' {
    zpwrExpandParseWords "yarn"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'yarn'
}

@test 'single: pip firstword' {
    zpwrExpandParseWords "pip"
    assert $ZPWR_VARS[firstword_partition] same_as 'pip'
}

@test 'single: pip lastword' {
    zpwrExpandParseWords "pip"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pip'
}

@test 'single: brew firstword' {
    zpwrExpandParseWords "brew"
    assert $ZPWR_VARS[firstword_partition] same_as 'brew'
}

@test 'single: brew lastword' {
    zpwrExpandParseWords "brew"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'brew'
}

@test 'single: apt firstword' {
    zpwrExpandParseWords "apt"
    assert $ZPWR_VARS[firstword_partition] same_as 'apt'
}

@test 'single: apt lastword' {
    zpwrExpandParseWords "apt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'apt'
}

@test 'single: pacman firstword' {
    zpwrExpandParseWords "pacman"
    assert $ZPWR_VARS[firstword_partition] same_as 'pacman'
}

@test 'single: pacman lastword' {
    zpwrExpandParseWords "pacman"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pacman'
}

@test 'single: dnf firstword' {
    zpwrExpandParseWords "dnf"
    assert $ZPWR_VARS[firstword_partition] same_as 'dnf'
}

@test 'single: dnf lastword' {
    zpwrExpandParseWords "dnf"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dnf'
}

@test 'single: yum firstword' {
    zpwrExpandParseWords "yum"
    assert $ZPWR_VARS[firstword_partition] same_as 'yum'
}

@test 'single: yum lastword' {
    zpwrExpandParseWords "yum"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'yum'
}

@test 'single: zypper firstword' {
    zpwrExpandParseWords "zypper"
    assert $ZPWR_VARS[firstword_partition] same_as 'zypper'
}

@test 'single: zypper lastword' {
    zpwrExpandParseWords "zypper"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'zypper'
}

@test 'single: docker firstword' {
    zpwrExpandParseWords "docker"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'single: docker lastword' {
    zpwrExpandParseWords "docker"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'docker'
}

@test 'single: kubectl firstword' {
    zpwrExpandParseWords "kubectl"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'single: kubectl lastword' {
    zpwrExpandParseWords "kubectl"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'kubectl'
}

@test 'single: terraform firstword' {
    zpwrExpandParseWords "terraform"
    assert $ZPWR_VARS[firstword_partition] same_as 'terraform'
}

@test 'single: terraform lastword' {
    zpwrExpandParseWords "terraform"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'terraform'
}

@test 'single: ansible firstword' {
    zpwrExpandParseWords "ansible"
    assert $ZPWR_VARS[firstword_partition] same_as 'ansible'
}

@test 'single: ansible lastword' {
    zpwrExpandParseWords "ansible"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ansible'
}

@test 'single: vagrant firstword' {
    zpwrExpandParseWords "vagrant"
    assert $ZPWR_VARS[firstword_partition] same_as 'vagrant'
}

@test 'single: vagrant lastword' {
    zpwrExpandParseWords "vagrant"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'vagrant'
}

@test 'single: packer firstword' {
    zpwrExpandParseWords "packer"
    assert $ZPWR_VARS[firstword_partition] same_as 'packer'
}

@test 'single: packer lastword' {
    zpwrExpandParseWords "packer"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'packer'
}

@test 'single: consul firstword' {
    zpwrExpandParseWords "consul"
    assert $ZPWR_VARS[firstword_partition] same_as 'consul'
}

@test 'single: consul lastword' {
    zpwrExpandParseWords "consul"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'consul'
}

@test 'single: vault firstword' {
    zpwrExpandParseWords "vault"
    assert $ZPWR_VARS[firstword_partition] same_as 'vault'
}

@test 'single: vault lastword' {
    zpwrExpandParseWords "vault"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'vault'
}

@test 'single: helm firstword' {
    zpwrExpandParseWords "helm"
    assert $ZPWR_VARS[firstword_partition] same_as 'helm'
}

@test 'single: helm lastword' {
    zpwrExpandParseWords "helm"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'helm'
}

@test 'two: ls -la firstword' {
    zpwrExpandParseWords "ls -la"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'two: ls -la lastword' {
    zpwrExpandParseWords "ls -la"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-la'
}

@test 'two: git status firstword' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git status lastword' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'two: git log firstword' {
    zpwrExpandParseWords "git log"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git log lastword' {
    zpwrExpandParseWords "git log"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'log'
}

@test 'two: git diff firstword' {
    zpwrExpandParseWords "git diff"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git diff lastword' {
    zpwrExpandParseWords "git diff"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'diff'
}

@test 'two: git add firstword' {
    zpwrExpandParseWords "git add"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git add lastword' {
    zpwrExpandParseWords "git add"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'add'
}

@test 'two: git commit firstword' {
    zpwrExpandParseWords "git commit"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git commit lastword' {
    zpwrExpandParseWords "git commit"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'commit'
}

@test 'two: git push firstword' {
    zpwrExpandParseWords "git push"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git push lastword' {
    zpwrExpandParseWords "git push"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'push'
}

@test 'two: git pull firstword' {
    zpwrExpandParseWords "git pull"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git pull lastword' {
    zpwrExpandParseWords "git pull"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pull'
}

@test 'two: git branch firstword' {
    zpwrExpandParseWords "git branch"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git branch lastword' {
    zpwrExpandParseWords "git branch"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'branch'
}

@test 'two: git checkout firstword' {
    zpwrExpandParseWords "git checkout"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git checkout lastword' {
    zpwrExpandParseWords "git checkout"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'checkout'
}

@test 'two: git merge firstword' {
    zpwrExpandParseWords "git merge"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git merge lastword' {
    zpwrExpandParseWords "git merge"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'merge'
}

@test 'two: git rebase firstword' {
    zpwrExpandParseWords "git rebase"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git rebase lastword' {
    zpwrExpandParseWords "git rebase"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'rebase'
}

@test 'two: git stash firstword' {
    zpwrExpandParseWords "git stash"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git stash lastword' {
    zpwrExpandParseWords "git stash"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'stash'
}

@test 'two: git clone firstword' {
    zpwrExpandParseWords "git clone"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git clone lastword' {
    zpwrExpandParseWords "git clone"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'clone'
}

@test 'two: git fetch firstword' {
    zpwrExpandParseWords "git fetch"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'two: git fetch lastword' {
    zpwrExpandParseWords "git fetch"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'fetch'
}

@test 'two: docker ps firstword' {
    zpwrExpandParseWords "docker ps"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker ps lastword' {
    zpwrExpandParseWords "docker ps"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ps'
}

@test 'two: docker images firstword' {
    zpwrExpandParseWords "docker images"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker images lastword' {
    zpwrExpandParseWords "docker images"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'images'
}

@test 'two: docker build firstword' {
    zpwrExpandParseWords "docker build"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker build lastword' {
    zpwrExpandParseWords "docker build"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'build'
}

@test 'two: docker run firstword' {
    zpwrExpandParseWords "docker run"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker run lastword' {
    zpwrExpandParseWords "docker run"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'run'
}

@test 'two: docker exec firstword' {
    zpwrExpandParseWords "docker exec"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker exec lastword' {
    zpwrExpandParseWords "docker exec"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'exec'
}

@test 'two: docker logs firstword' {
    zpwrExpandParseWords "docker logs"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker logs lastword' {
    zpwrExpandParseWords "docker logs"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'logs'
}

@test 'two: docker stop firstword' {
    zpwrExpandParseWords "docker stop"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker stop lastword' {
    zpwrExpandParseWords "docker stop"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'stop'
}

@test 'two: docker rm firstword' {
    zpwrExpandParseWords "docker rm"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker rm lastword' {
    zpwrExpandParseWords "docker rm"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'rm'
}

@test 'two: docker rmi firstword' {
    zpwrExpandParseWords "docker rmi"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker rmi lastword' {
    zpwrExpandParseWords "docker rmi"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'rmi'
}

@test 'two: docker pull firstword' {
    zpwrExpandParseWords "docker pull"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker pull lastword' {
    zpwrExpandParseWords "docker pull"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pull'
}

@test 'two: docker push firstword' {
    zpwrExpandParseWords "docker push"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker push lastword' {
    zpwrExpandParseWords "docker push"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'push'
}

@test 'two: docker compose firstword' {
    zpwrExpandParseWords "docker compose"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'two: docker compose lastword' {
    zpwrExpandParseWords "docker compose"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'compose'
}

@test 'two: kubectl get firstword' {
    zpwrExpandParseWords "kubectl get"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'two: kubectl get lastword' {
    zpwrExpandParseWords "kubectl get"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'get'
}

@test 'two: kubectl describe firstword' {
    zpwrExpandParseWords "kubectl describe"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'two: kubectl describe lastword' {
    zpwrExpandParseWords "kubectl describe"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'describe'
}

@test 'two: kubectl apply firstword' {
    zpwrExpandParseWords "kubectl apply"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'two: kubectl apply lastword' {
    zpwrExpandParseWords "kubectl apply"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'apply'
}

@test 'two: kubectl delete firstword' {
    zpwrExpandParseWords "kubectl delete"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'two: kubectl delete lastword' {
    zpwrExpandParseWords "kubectl delete"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'delete'
}

@test 'two: kubectl logs firstword' {
    zpwrExpandParseWords "kubectl logs"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'two: kubectl logs lastword' {
    zpwrExpandParseWords "kubectl logs"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'logs'
}

@test 'two: npm install firstword' {
    zpwrExpandParseWords "npm install"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'two: npm install lastword' {
    zpwrExpandParseWords "npm install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'two: npm run firstword' {
    zpwrExpandParseWords "npm run"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'two: npm run lastword' {
    zpwrExpandParseWords "npm run"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'run'
}

@test 'two: npm test firstword' {
    zpwrExpandParseWords "npm test"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'two: npm test lastword' {
    zpwrExpandParseWords "npm test"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'test'
}

@test 'two: npm start firstword' {
    zpwrExpandParseWords "npm start"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'two: npm start lastword' {
    zpwrExpandParseWords "npm start"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'start'
}

@test 'two: pip install firstword' {
    zpwrExpandParseWords "pip install"
    assert $ZPWR_VARS[firstword_partition] same_as 'pip'
}

@test 'two: pip install lastword' {
    zpwrExpandParseWords "pip install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'two: pip list firstword' {
    zpwrExpandParseWords "pip list"
    assert $ZPWR_VARS[firstword_partition] same_as 'pip'
}

@test 'two: pip list lastword' {
    zpwrExpandParseWords "pip list"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'list'
}

@test 'two: cargo build firstword' {
    zpwrExpandParseWords "cargo build"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'two: cargo build lastword' {
    zpwrExpandParseWords "cargo build"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'build'
}

@test 'two: cargo test firstword' {
    zpwrExpandParseWords "cargo test"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'two: cargo test lastword' {
    zpwrExpandParseWords "cargo test"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'test'
}

@test 'two: cargo run firstword' {
    zpwrExpandParseWords "cargo run"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'two: cargo run lastword' {
    zpwrExpandParseWords "cargo run"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'run'
}

@test 'two: make all firstword' {
    zpwrExpandParseWords "make all"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'two: make all lastword' {
    zpwrExpandParseWords "make all"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'all'
}

@test 'two: make clean firstword' {
    zpwrExpandParseWords "make clean"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'two: make clean lastword' {
    zpwrExpandParseWords "make clean"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'clean'
}

@test 'two: make install firstword' {
    zpwrExpandParseWords "make install"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'two: make install lastword' {
    zpwrExpandParseWords "make install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'two: echo hello firstword' {
    zpwrExpandParseWords "echo hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'two: echo hello lastword' {
    zpwrExpandParseWords "echo hello"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'two: cat file firstword' {
    zpwrExpandParseWords "cat file"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'two: cat file lastword' {
    zpwrExpandParseWords "cat file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: grep pattern firstword' {
    zpwrExpandParseWords "grep pattern"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'two: grep pattern lastword' {
    zpwrExpandParseWords "grep pattern"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pattern'
}

@test 'two: sed script firstword' {
    zpwrExpandParseWords "sed script"
    assert $ZPWR_VARS[firstword_partition] same_as 'sed'
}

@test 'two: sed script lastword' {
    zpwrExpandParseWords "sed script"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'script'
}

@test 'two: awk program firstword' {
    zpwrExpandParseWords "awk program"
    assert $ZPWR_VARS[firstword_partition] same_as 'awk'
}

@test 'two: awk program lastword' {
    zpwrExpandParseWords "awk program"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'program'
}

@test 'two: find path firstword' {
    zpwrExpandParseWords "find path"
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'two: find path lastword' {
    zpwrExpandParseWords "find path"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'path'
}

@test 'two: sort file firstword' {
    zpwrExpandParseWords "sort file"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'two: sort file lastword' {
    zpwrExpandParseWords "sort file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: head file firstword' {
    zpwrExpandParseWords "head file"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'two: head file lastword' {
    zpwrExpandParseWords "head file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: tail file firstword' {
    zpwrExpandParseWords "tail file"
    assert $ZPWR_VARS[firstword_partition] same_as 'tail'
}

@test 'two: tail file lastword' {
    zpwrExpandParseWords "tail file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: wc file firstword' {
    zpwrExpandParseWords "wc file"
    assert $ZPWR_VARS[firstword_partition] same_as 'wc'
}

@test 'two: wc file lastword' {
    zpwrExpandParseWords "wc file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: chmod 755 firstword' {
    zpwrExpandParseWords "chmod 755"
    assert $ZPWR_VARS[firstword_partition] same_as 'chmod'
}

@test 'two: chmod 755 lastword' {
    zpwrExpandParseWords "chmod 755"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '755'
}

@test 'two: chown root firstword' {
    zpwrExpandParseWords "chown root"
    assert $ZPWR_VARS[firstword_partition] same_as 'chown'
}

@test 'two: chown root lastword' {
    zpwrExpandParseWords "chown root"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'root'
}

@test 'two: mkdir dir firstword' {
    zpwrExpandParseWords "mkdir dir"
    assert $ZPWR_VARS[firstword_partition] same_as 'mkdir'
}

@test 'two: mkdir dir lastword' {
    zpwrExpandParseWords "mkdir dir"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dir'
}

@test 'two: rmdir dir firstword' {
    zpwrExpandParseWords "rmdir dir"
    assert $ZPWR_VARS[firstword_partition] same_as 'rmdir'
}

@test 'two: rmdir dir lastword' {
    zpwrExpandParseWords "rmdir dir"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dir'
}

@test 'two: touch file firstword' {
    zpwrExpandParseWords "touch file"
    assert $ZPWR_VARS[firstword_partition] same_as 'touch'
}

@test 'two: touch file lastword' {
    zpwrExpandParseWords "touch file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: cp src firstword' {
    zpwrExpandParseWords "cp src"
    assert $ZPWR_VARS[firstword_partition] same_as 'cp'
}

@test 'two: cp src lastword' {
    zpwrExpandParseWords "cp src"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'src'
}

@test 'two: mv old firstword' {
    zpwrExpandParseWords "mv old"
    assert $ZPWR_VARS[firstword_partition] same_as 'mv'
}

@test 'two: mv old lastword' {
    zpwrExpandParseWords "mv old"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'old'
}

@test 'two: rm file firstword' {
    zpwrExpandParseWords "rm file"
    assert $ZPWR_VARS[firstword_partition] same_as 'rm'
}

@test 'two: rm file lastword' {
    zpwrExpandParseWords "rm file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: ssh host firstword' {
    zpwrExpandParseWords "ssh host"
    assert $ZPWR_VARS[firstword_partition] same_as 'ssh'
}

@test 'two: ssh host lastword' {
    zpwrExpandParseWords "ssh host"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'host'
}

@test 'two: scp file firstword' {
    zpwrExpandParseWords "scp file"
    assert $ZPWR_VARS[firstword_partition] same_as 'scp'
}

@test 'two: scp file lastword' {
    zpwrExpandParseWords "scp file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'two: rsync src firstword' {
    zpwrExpandParseWords "rsync src"
    assert $ZPWR_VARS[firstword_partition] same_as 'rsync'
}

@test 'two: rsync src lastword' {
    zpwrExpandParseWords "rsync src"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'src'
}

@test 'two: curl url firstword' {
    zpwrExpandParseWords "curl url"
    assert $ZPWR_VARS[firstword_partition] same_as 'curl'
}

@test 'two: curl url lastword' {
    zpwrExpandParseWords "curl url"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'url'
}

@test 'two: wget url firstword' {
    zpwrExpandParseWords "wget url"
    assert $ZPWR_VARS[firstword_partition] same_as 'wget'
}

@test 'two: wget url lastword' {
    zpwrExpandParseWords "wget url"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'url'
}

@test 'two: python script.py firstword' {
    zpwrExpandParseWords "python script.py"
    assert $ZPWR_VARS[firstword_partition] same_as 'python'
}

@test 'two: python script.py lastword' {
    zpwrExpandParseWords "python script.py"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'script.py'
}

@test 'two: ruby script.rb firstword' {
    zpwrExpandParseWords "ruby script.rb"
    assert $ZPWR_VARS[firstword_partition] same_as 'ruby'
}

@test 'two: ruby script.rb lastword' {
    zpwrExpandParseWords "ruby script.rb"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'script.rb'
}

@test 'two: node app.js firstword' {
    zpwrExpandParseWords "node app.js"
    assert $ZPWR_VARS[firstword_partition] same_as 'node'
}

@test 'two: node app.js lastword' {
    zpwrExpandParseWords "node app.js"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'app.js'
}

@test 'two: perl script.pl firstword' {
    zpwrExpandParseWords "perl script.pl"
    assert $ZPWR_VARS[firstword_partition] same_as 'perl'
}

@test 'two: perl script.pl lastword' {
    zpwrExpandParseWords "perl script.pl"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'script.pl'
}

@test 'two: java Main firstword' {
    zpwrExpandParseWords "java Main"
    assert $ZPWR_VARS[firstword_partition] same_as 'java'
}

@test 'two: java Main lastword' {
    zpwrExpandParseWords "java Main"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'Main'
}

@test 'pipe: ls | grep foo firstword' {
    zpwrExpandParseWords "ls | grep foo"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe: ls | grep foo lastword' {
    zpwrExpandParseWords "ls | grep foo"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'foo'
}

@test 'pipe: cat file | head firstword' {
    zpwrExpandParseWords "cat file | head"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'pipe: cat file | head lastword' {
    zpwrExpandParseWords "cat file | head"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'head'
}

@test 'pipe: ps aux | sort firstword' {
    zpwrExpandParseWords "ps aux | sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'pipe: ps aux | sort lastword' {
    zpwrExpandParseWords "ps aux | sort"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'sort'
}

@test 'pipe: echo hello | tr a b firstword' {
    zpwrExpandParseWords "echo hello | tr a b"
    assert $ZPWR_VARS[firstword_partition] same_as 'tr'
}

@test 'pipe: echo hello | tr a b lastword' {
    zpwrExpandParseWords "echo hello | tr a b"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'b'
}

@test 'pipe: find . | xargs ls firstword' {
    zpwrExpandParseWords "find . | xargs ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'xargs'
}

@test 'pipe: find . | xargs ls lastword' {
    zpwrExpandParseWords "find . | xargs ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'pipe: git log | head -20 firstword' {
    zpwrExpandParseWords "git log | head -20"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'pipe: git log | head -20 lastword' {
    zpwrExpandParseWords "git log | head -20"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-20'
}

@test 'pipe: docker ps | grep running firstword' {
    zpwrExpandParseWords "docker ps | grep running"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe: docker ps | grep running lastword' {
    zpwrExpandParseWords "docker ps | grep running"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'running'
}

@test 'pipe: history | tail -50 firstword' {
    zpwrExpandParseWords "history | tail -50"
    assert $ZPWR_VARS[firstword_partition] same_as 'tail'
}

@test 'pipe: history | tail -50 lastword' {
    zpwrExpandParseWords "history | tail -50"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-50'
}

@test 'pipe: env | sort firstword' {
    zpwrExpandParseWords "env | sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'pipe: env | sort lastword' {
    zpwrExpandParseWords "env | sort"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'sort'
}

@test 'pipe: df -h | grep disk firstword' {
    zpwrExpandParseWords "df -h | grep disk"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'pipe: df -h | grep disk lastword' {
    zpwrExpandParseWords "df -h | grep disk"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'disk'
}

@test 'pipe: mount | column firstword' {
    zpwrExpandParseWords "mount | column"
    assert $ZPWR_VARS[firstword_partition] same_as 'column'
}

@test 'pipe: mount | column lastword' {
    zpwrExpandParseWords "mount | column"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'column'
}

@test 'pipe: who | sort firstword' {
    zpwrExpandParseWords "who | sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'pipe: who | sort lastword' {
    zpwrExpandParseWords "who | sort"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'sort'
}

@test 'pipe: ls | sort | uniq firstword' {
    zpwrExpandParseWords "ls | sort | uniq"
    assert $ZPWR_VARS[firstword_partition] same_as 'uniq'
}

@test 'pipe: ls | sort | uniq lastword' {
    zpwrExpandParseWords "ls | sort | uniq"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'uniq'
}

@test 'pipe: cat f | grep a | wc firstword' {
    zpwrExpandParseWords "cat f | grep a | wc"
    assert $ZPWR_VARS[firstword_partition] same_as 'wc'
}

@test 'pipe: cat f | grep a | wc lastword' {
    zpwrExpandParseWords "cat f | grep a | wc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'wc'
}

@test 'pipe: ps | sort | head | tail firstword' {
    zpwrExpandParseWords "ps | sort | head | tail"
    assert $ZPWR_VARS[firstword_partition] same_as 'tail'
}

@test 'pipe: ps | sort | head | tail lastword' {
    zpwrExpandParseWords "ps | sort | head | tail"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'tail'
}

@test 'pipe: echo a | tr a b | sed s/b/c/ firstword' {
    zpwrExpandParseWords "echo a | tr a b | sed s/b/c/"
    assert $ZPWR_VARS[firstword_partition] same_as 'sed'
}

@test 'pipe: echo a | tr a b | sed s/b/c/ lastword' {
    zpwrExpandParseWords "echo a | tr a b | sed s/b/c/"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 's/b/c/'
}

@test 'pipe: find . | sort | uniq | wc firstword' {
    zpwrExpandParseWords "find . | sort | uniq | wc"
    assert $ZPWR_VARS[firstword_partition] same_as 'wc'
}

@test 'pipe: find . | sort | uniq | wc lastword' {
    zpwrExpandParseWords "find . | sort | uniq | wc"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'wc'
}

@test 'pipe: ls -la | awk NR firstword' {
    zpwrExpandParseWords "ls -la | awk NR"
    assert $ZPWR_VARS[firstword_partition] same_as 'awk'
}

@test 'pipe: ls -la | awk NR lastword' {
    zpwrExpandParseWords "ls -la | awk NR"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'NR'
}

@test 'pipe: cat /etc/hosts | cut -f1 firstword' {
    zpwrExpandParseWords "cat /etc/hosts | cut -f1"
    assert $ZPWR_VARS[firstword_partition] same_as 'cut'
}

@test 'pipe: cat /etc/hosts | cut -f1 lastword' {
    zpwrExpandParseWords "cat /etc/hosts | cut -f1"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-f1'
}

@test 'pipe: dmesg | tail firstword' {
    zpwrExpandParseWords "dmesg | tail"
    assert $ZPWR_VARS[firstword_partition] same_as 'tail'
}

@test 'pipe: dmesg | tail lastword' {
    zpwrExpandParseWords "dmesg | tail"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'tail'
}

@test 'semi: cd /tmp; ls firstword' {
    zpwrExpandParseWords "cd /tmp; ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'semi: cd /tmp; ls lastword' {
    zpwrExpandParseWords "cd /tmp; ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'semi: echo start; make firstword' {
    zpwrExpandParseWords "echo start; make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'semi: echo start; make lastword' {
    zpwrExpandParseWords "echo start; make"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'make'
}

@test 'semi: make clean; make all firstword' {
    zpwrExpandParseWords "make clean; make all"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'semi: make clean; make all lastword' {
    zpwrExpandParseWords "make clean; make all"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'all'
}

@test 'semi: git add .; git commit firstword' {
    zpwrExpandParseWords "git add .; git commit"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'semi: git add .; git commit lastword' {
    zpwrExpandParseWords "git add .; git commit"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'commit'
}

@test 'semi: npm install; npm test firstword' {
    zpwrExpandParseWords "npm install; npm test"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'semi: npm install; npm test lastword' {
    zpwrExpandParseWords "npm install; npm test"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'test'
}

@test 'semi: cd build; cmake .. firstword' {
    zpwrExpandParseWords "cd build; cmake .."
    assert $ZPWR_VARS[firstword_partition] same_as 'cmake'
}

@test 'semi: cd build; cmake .. lastword' {
    zpwrExpandParseWords "cd build; cmake .."
    assert $ZPWR_VARS[lastword_lbuffer] same_as '..'
}

@test 'semi: echo a; echo b; echo c firstword' {
    zpwrExpandParseWords "echo a; echo b; echo c"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'semi: echo a; echo b; echo c lastword' {
    zpwrExpandParseWords "echo a; echo b; echo c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'semi: ls; pwd; whoami firstword' {
    zpwrExpandParseWords "ls; pwd; whoami"
    assert $ZPWR_VARS[firstword_partition] same_as 'whoami'
}

@test 'semi: ls; pwd; whoami lastword' {
    zpwrExpandParseWords "ls; pwd; whoami"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'whoami'
}

@test 'semi: mkdir dir; cd dir; ls firstword' {
    zpwrExpandParseWords "mkdir dir; cd dir; ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'semi: mkdir dir; cd dir; ls lastword' {
    zpwrExpandParseWords "mkdir dir; cd dir; ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'semi: docker stop c; docker rm c firstword' {
    zpwrExpandParseWords "docker stop c; docker rm c"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'semi: docker stop c; docker rm c lastword' {
    zpwrExpandParseWords "docker stop c; docker rm c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'and: make && make install firstword' {
    zpwrExpandParseWords "make && make install"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'and: make && make install lastword' {
    zpwrExpandParseWords "make && make install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'and: cd dir && ls firstword' {
    zpwrExpandParseWords "cd dir && ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'and: cd dir && ls lastword' {
    zpwrExpandParseWords "cd dir && ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'and: git pull && git log firstword' {
    zpwrExpandParseWords "git pull && git log"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'and: git pull && git log lastword' {
    zpwrExpandParseWords "git pull && git log"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'log'
}

@test 'and: npm install && npm start firstword' {
    zpwrExpandParseWords "npm install && npm start"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'and: npm install && npm start lastword' {
    zpwrExpandParseWords "npm install && npm start"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'start'
}

@test 'and: mkdir dir && cd dir firstword' {
    zpwrExpandParseWords "mkdir dir && cd dir"
    assert $ZPWR_VARS[firstword_partition] same_as 'cd'
}

@test 'and: mkdir dir && cd dir lastword' {
    zpwrExpandParseWords "mkdir dir && cd dir"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dir'
}

@test 'and: cmake .. && make firstword' {
    zpwrExpandParseWords "cmake .. && make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'and: cmake .. && make lastword' {
    zpwrExpandParseWords "cmake .. && make"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'make'
}

@test 'and: cargo build && cargo test firstword' {
    zpwrExpandParseWords "cargo build && cargo test"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'and: cargo build && cargo test lastword' {
    zpwrExpandParseWords "cargo build && cargo test"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'test'
}

@test 'and: docker build . && docker run img firstword' {
    zpwrExpandParseWords "docker build . && docker run img"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'and: docker build . && docker run img lastword' {
    zpwrExpandParseWords "docker build . && docker run img"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'img'
}

@test 'and: make clean && make all && make test firstword' {
    zpwrExpandParseWords "make clean && make all && make test"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'and: make clean && make all && make test lastword' {
    zpwrExpandParseWords "make clean && make all && make test"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'test'
}

@test 'and: pip install req && python app firstword' {
    zpwrExpandParseWords "pip install req && python app"
    assert $ZPWR_VARS[firstword_partition] same_as 'python'
}

@test 'and: pip install req && python app lastword' {
    zpwrExpandParseWords "pip install req && python app"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'app'
}

@test 'or: cmd1 || cmd2 firstword' {
    zpwrExpandParseWords "cmd1 || cmd2"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd2'
}

@test 'or: cmd1 || cmd2 lastword' {
    zpwrExpandParseWords "cmd1 || cmd2"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd2'
}

@test 'or: make || echo failed firstword' {
    zpwrExpandParseWords "make || echo failed"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'or: make || echo failed lastword' {
    zpwrExpandParseWords "make || echo failed"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'failed'
}

@test 'or: git pull || git fetch firstword' {
    zpwrExpandParseWords "git pull || git fetch"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'or: git pull || git fetch lastword' {
    zpwrExpandParseWords "git pull || git fetch"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'fetch'
}

@test 'or: which cmd || apt install firstword' {
    zpwrExpandParseWords "which cmd || apt install"
    assert $ZPWR_VARS[firstword_partition] same_as 'apt'
}

@test 'or: which cmd || apt install lastword' {
    zpwrExpandParseWords "which cmd || apt install"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'install'
}

@test 'or: ls file || touch file firstword' {
    zpwrExpandParseWords "ls file || touch file"
    assert $ZPWR_VARS[firstword_partition] same_as 'touch'
}

@test 'or: ls file || touch file lastword' {
    zpwrExpandParseWords "ls file || touch file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'or: curl url || wget url firstword' {
    zpwrExpandParseWords "curl url || wget url"
    assert $ZPWR_VARS[firstword_partition] same_as 'wget'
}

@test 'or: curl url || wget url lastword' {
    zpwrExpandParseWords "curl url || wget url"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'url'
}

@test 'or: python3 -V || python -V firstword' {
    zpwrExpandParseWords "python3 -V || python -V"
    assert $ZPWR_VARS[firstword_partition] same_as 'python'
}

@test 'or: python3 -V || python -V lastword' {
    zpwrExpandParseWords "python3 -V || python -V"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-V'
}

@test 'or: npm test || echo failed firstword' {
    zpwrExpandParseWords "npm test || echo failed"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'or: npm test || echo failed lastword' {
    zpwrExpandParseWords "npm test || echo failed"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'failed'
}

@test 'or: ping host || echo down firstword' {
    zpwrExpandParseWords "ping host || echo down"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'or: ping host || echo down lastword' {
    zpwrExpandParseWords "ping host || echo down"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'down'
}

@test 'or: test -f file || echo missing firstword' {
    zpwrExpandParseWords "test -f file || echo missing"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'or: test -f file || echo missing lastword' {
    zpwrExpandParseWords "test -f file || echo missing"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'missing'
}

@test 'leading-0sp: ls arg firstword' {
    zpwrExpandParseWords "  ls arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'leading-0sp: ls arg lastword' {
    zpwrExpandParseWords "  ls arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-0sp: git arg firstword' {
    zpwrExpandParseWords "  git arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'leading-0sp: git arg lastword' {
    zpwrExpandParseWords "  git arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-0sp: echo arg firstword' {
    zpwrExpandParseWords "  echo arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'leading-0sp: echo arg lastword' {
    zpwrExpandParseWords "  echo arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-0sp: cat arg firstword' {
    zpwrExpandParseWords "  cat arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'leading-0sp: cat arg lastword' {
    zpwrExpandParseWords "  cat arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-0sp: make arg firstword' {
    zpwrExpandParseWords "  make arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'leading-0sp: make arg lastword' {
    zpwrExpandParseWords "  make arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-1sp: ls arg firstword' {
    zpwrExpandParseWords " ls arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'leading-1sp: ls arg lastword' {
    zpwrExpandParseWords " ls arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-1sp: git arg firstword' {
    zpwrExpandParseWords " git arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'leading-1sp: git arg lastword' {
    zpwrExpandParseWords " git arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-1sp: echo arg firstword' {
    zpwrExpandParseWords " echo arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'leading-1sp: echo arg lastword' {
    zpwrExpandParseWords " echo arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-1sp: cat arg firstword' {
    zpwrExpandParseWords " cat arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'leading-1sp: cat arg lastword' {
    zpwrExpandParseWords " cat arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-1sp: make arg firstword' {
    zpwrExpandParseWords " make arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'leading-1sp: make arg lastword' {
    zpwrExpandParseWords " make arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-2sp: ls arg firstword' {
    zpwrExpandParseWords "  ls arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'leading-2sp: ls arg lastword' {
    zpwrExpandParseWords "  ls arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-2sp: git arg firstword' {
    zpwrExpandParseWords "  git arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'leading-2sp: git arg lastword' {
    zpwrExpandParseWords "  git arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-2sp: echo arg firstword' {
    zpwrExpandParseWords "  echo arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'leading-2sp: echo arg lastword' {
    zpwrExpandParseWords "  echo arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-2sp: cat arg firstword' {
    zpwrExpandParseWords "  cat arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'leading-2sp: cat arg lastword' {
    zpwrExpandParseWords "  cat arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-2sp: make arg firstword' {
    zpwrExpandParseWords "  make arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'leading-2sp: make arg lastword' {
    zpwrExpandParseWords "  make arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-3sp: ls arg firstword' {
    zpwrExpandParseWords "   ls arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'leading-3sp: ls arg lastword' {
    zpwrExpandParseWords "   ls arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-3sp: git arg firstword' {
    zpwrExpandParseWords "   git arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'leading-3sp: git arg lastword' {
    zpwrExpandParseWords "   git arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-3sp: echo arg firstword' {
    zpwrExpandParseWords "   echo arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'leading-3sp: echo arg lastword' {
    zpwrExpandParseWords "   echo arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-3sp: cat arg firstword' {
    zpwrExpandParseWords "   cat arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'leading-3sp: cat arg lastword' {
    zpwrExpandParseWords "   cat arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-3sp: make arg firstword' {
    zpwrExpandParseWords "   make arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'leading-3sp: make arg lastword' {
    zpwrExpandParseWords "   make arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-4sp: ls arg firstword' {
    zpwrExpandParseWords "    ls arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'leading-4sp: ls arg lastword' {
    zpwrExpandParseWords "    ls arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-4sp: git arg firstword' {
    zpwrExpandParseWords "    git arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'leading-4sp: git arg lastword' {
    zpwrExpandParseWords "    git arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-4sp: echo arg firstword' {
    zpwrExpandParseWords "    echo arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'leading-4sp: echo arg lastword' {
    zpwrExpandParseWords "    echo arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-4sp: cat arg firstword' {
    zpwrExpandParseWords "    cat arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'leading-4sp: cat arg lastword' {
    zpwrExpandParseWords "    cat arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-4sp: make arg firstword' {
    zpwrExpandParseWords "    make arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'leading-4sp: make arg lastword' {
    zpwrExpandParseWords "    make arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-5sp: ls arg firstword' {
    zpwrExpandParseWords "     ls arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'leading-5sp: ls arg lastword' {
    zpwrExpandParseWords "     ls arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-5sp: git arg firstword' {
    zpwrExpandParseWords "     git arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'leading-5sp: git arg lastword' {
    zpwrExpandParseWords "     git arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-5sp: echo arg firstword' {
    zpwrExpandParseWords "     echo arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'leading-5sp: echo arg lastword' {
    zpwrExpandParseWords "     echo arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-5sp: cat arg firstword' {
    zpwrExpandParseWords "     cat arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'cat'
}

@test 'leading-5sp: cat arg lastword' {
    zpwrExpandParseWords "     cat arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'leading-5sp: make arg firstword' {
    zpwrExpandParseWords "     make arg"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'leading-5sp: make arg lastword' {
    zpwrExpandParseWords "     make arg"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg'
}

@test 'remove_special: echo word' {
    zpwrExpandParseWords "echo word"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'word'
}

@test 'remove_special: echo abc[0]' {
    zpwrExpandParseWords "echo abc[0]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'abc0'
}

@test 'remove_special: echo arr[idx]' {
    zpwrExpandParseWords "echo arr[idx]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arridx'
}

@test 'remove_special: echo hash{key}' {
    zpwrExpandParseWords "echo hash{key}"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'hashkey'
}

@test 'remove_special: echo x[0][1]' {
    zpwrExpandParseWords "echo x[0][1]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'x01'
}

@test 'remove_special: echo simple' {
    zpwrExpandParseWords "echo simple"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'simple'
}

@test 'remove_special: echo no-special' {
    zpwrExpandParseWords "echo no-special"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'no-special'
}

@test 'remove_special: echo with_under' {
    zpwrExpandParseWords "echo with_under"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'with_under'
}

@test 'remove_special: echo with.dot' {
    zpwrExpandParseWords "echo with.dot"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'with.dot'
}

@test 'remove_special: echo with:colon' {
    zpwrExpandParseWords "echo with:colon"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'with:colon'
}

@test 'remove_special: echo with@at' {
    zpwrExpandParseWords "echo with@at"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'with@at'
}

@test 'remove_special: echo path/to/file' {
    zpwrExpandParseWords "echo path/to/file"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'path/to/file'
}

@test 'remove_special: echo 123' {
    zpwrExpandParseWords "echo 123"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as '123'
}

@test 'remove_special: echo -flag' {
    zpwrExpandParseWords "echo -flag"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as '-flag'
}

@test 'remove_special: echo --long-flag' {
    zpwrExpandParseWords "echo --long-flag"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as '--long-flag'
}

@test 'mixed: a; b && c firstword' {
    zpwrExpandParseWords "a; b && c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'mixed: a; b && c lastword' {
    zpwrExpandParseWords "a; b && c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'mixed: a && b; c firstword' {
    zpwrExpandParseWords "a && b; c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'mixed: a && b; c lastword' {
    zpwrExpandParseWords "a && b; c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'mixed: a | b; c firstword' {
    zpwrExpandParseWords "a | b; c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'mixed: a | b; c lastword' {
    zpwrExpandParseWords "a | b; c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'mixed: a; b | c; d firstword' {
    zpwrExpandParseWords "a; b | c; d"
    assert $ZPWR_VARS[firstword_partition] same_as 'd'
}

@test 'mixed: a; b | c; d lastword' {
    zpwrExpandParseWords "a; b | c; d"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'd'
}

@test 'mixed: a && b || c firstword' {
    zpwrExpandParseWords "a && b || c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'mixed: a && b || c lastword' {
    zpwrExpandParseWords "a && b || c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'mixed: a || b && c firstword' {
    zpwrExpandParseWords "a || b && c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'mixed: a || b && c lastword' {
    zpwrExpandParseWords "a || b && c"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'c'
}

@test 'mixed: a; b; c; d; e firstword' {
    zpwrExpandParseWords "a; b; c; d; e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'mixed: a; b; c; d; e lastword' {
    zpwrExpandParseWords "a; b; c; d; e"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'e'
}

@test 'mixed: a && b && c && d firstword' {
    zpwrExpandParseWords "a && b && c && d"
    assert $ZPWR_VARS[firstword_partition] same_as 'd'
}

@test 'mixed: a && b && c && d lastword' {
    zpwrExpandParseWords "a && b && c && d"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'd'
}

@test 'mixed: a || b || c || d firstword' {
    zpwrExpandParseWords "a || b || c || d"
    assert $ZPWR_VARS[firstword_partition] same_as 'd'
}

@test 'mixed: a || b || c || d lastword' {
    zpwrExpandParseWords "a || b || c || d"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'd'
}

@test 'mixed: a | b | c | d | e firstword' {
    zpwrExpandParseWords "a | b | c | d | e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'mixed: a | b | c | d | e lastword' {
    zpwrExpandParseWords "a | b | c | d | e"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'e'
}

@test 'mixed: a; b | c && d || e firstword' {
    zpwrExpandParseWords "a; b | c && d || e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'mixed: a; b | c && d || e lastword' {
    zpwrExpandParseWords "a; b | c && d || e"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'e'
}

@test 'three: git log --oneline firstword' {
    zpwrExpandParseWords "git log --oneline"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'three: git log --oneline lastword' {
    zpwrExpandParseWords "git log --oneline"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--oneline'
}

@test 'three: git commit -m firstword' {
    zpwrExpandParseWords "git commit -m"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'three: git commit -m lastword' {
    zpwrExpandParseWords "git commit -m"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-m'
}

@test 'three: git push origin firstword' {
    zpwrExpandParseWords "git push origin"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'three: git push origin lastword' {
    zpwrExpandParseWords "git push origin"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'origin'
}

@test 'three: docker exec -it firstword' {
    zpwrExpandParseWords "docker exec -it"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'three: docker exec -it lastword' {
    zpwrExpandParseWords "docker exec -it"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-it'
}

@test 'three: kubectl get pods firstword' {
    zpwrExpandParseWords "kubectl get pods"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'three: kubectl get pods lastword' {
    zpwrExpandParseWords "kubectl get pods"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pods'
}

@test 'three: npm run build firstword' {
    zpwrExpandParseWords "npm run build"
    assert $ZPWR_VARS[firstword_partition] same_as 'npm'
}

@test 'three: npm run build lastword' {
    zpwrExpandParseWords "npm run build"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'build'
}

@test 'three: pip install flask firstword' {
    zpwrExpandParseWords "pip install flask"
    assert $ZPWR_VARS[firstword_partition] same_as 'pip'
}

@test 'three: pip install flask lastword' {
    zpwrExpandParseWords "pip install flask"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'flask'
}

@test 'three: cargo build --release firstword' {
    zpwrExpandParseWords "cargo build --release"
    assert $ZPWR_VARS[firstword_partition] same_as 'cargo'
}

@test 'three: cargo build --release lastword' {
    zpwrExpandParseWords "cargo build --release"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--release'
}

@test 'three: make -j4 all firstword' {
    zpwrExpandParseWords "make -j4 all"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'three: make -j4 all lastword' {
    zpwrExpandParseWords "make -j4 all"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'all'
}

@test 'three: grep -rn pattern firstword' {
    zpwrExpandParseWords "grep -rn pattern"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'three: grep -rn pattern lastword' {
    zpwrExpandParseWords "grep -rn pattern"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pattern'
}

@test 'three: find . -name firstword' {
    zpwrExpandParseWords "find . -name"
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'three: find . -name lastword' {
    zpwrExpandParseWords "find . -name"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-name'
}

@test 'three: tar -xzf archive firstword' {
    zpwrExpandParseWords "tar -xzf archive"
    assert $ZPWR_VARS[firstword_partition] same_as 'tar'
}

@test 'three: tar -xzf archive lastword' {
    zpwrExpandParseWords "tar -xzf archive"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'archive'
}

@test 'three: ssh -i key firstword' {
    zpwrExpandParseWords "ssh -i key"
    assert $ZPWR_VARS[firstword_partition] same_as 'ssh'
}

@test 'three: ssh -i key lastword' {
    zpwrExpandParseWords "ssh -i key"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'key'
}

@test 'three: curl -X POST firstword' {
    zpwrExpandParseWords "curl -X POST"
    assert $ZPWR_VARS[firstword_partition] same_as 'curl'
}

@test 'three: curl -X POST lastword' {
    zpwrExpandParseWords "curl -X POST"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'POST'
}

@test 'three: wget -O output firstword' {
    zpwrExpandParseWords "wget -O output"
    assert $ZPWR_VARS[firstword_partition] same_as 'wget'
}

@test 'three: wget -O output lastword' {
    zpwrExpandParseWords "wget -O output"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'output'
}

@test 'three: chmod +x script firstword' {
    zpwrExpandParseWords "chmod +x script"
    assert $ZPWR_VARS[firstword_partition] same_as 'chmod'
}

@test 'three: chmod +x script lastword' {
    zpwrExpandParseWords "chmod +x script"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'script'
}

@test 'three: ln -s target firstword' {
    zpwrExpandParseWords "ln -s target"
    assert $ZPWR_VARS[firstword_partition] same_as 'ln'
}

@test 'three: ln -s target lastword' {
    zpwrExpandParseWords "ln -s target"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'target'
}

@test 'three: du -sh dir firstword' {
    zpwrExpandParseWords "du -sh dir"
    assert $ZPWR_VARS[firstword_partition] same_as 'du'
}

@test 'three: du -sh dir lastword' {
    zpwrExpandParseWords "du -sh dir"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dir'
}

@test 'three: ps aux --sort firstword' {
    zpwrExpandParseWords "ps aux --sort"
    assert $ZPWR_VARS[firstword_partition] same_as 'ps'
}

@test 'three: ps aux --sort lastword' {
    zpwrExpandParseWords "ps aux --sort"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--sort'
}

@test 'three: kill -9 pid firstword' {
    zpwrExpandParseWords "kill -9 pid"
    assert $ZPWR_VARS[firstword_partition] same_as 'kill'
}

@test 'three: kill -9 pid lastword' {
    zpwrExpandParseWords "kill -9 pid"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pid'
}

@test 'three: nice -n 10 firstword' {
    zpwrExpandParseWords "nice -n 10"
    assert $ZPWR_VARS[firstword_partition] same_as 'nice'
}

@test 'three: nice -n 10 lastword' {
    zpwrExpandParseWords "nice -n 10"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '10'
}

@test 'three: head -n 20 firstword' {
    zpwrExpandParseWords "head -n 20"
    assert $ZPWR_VARS[firstword_partition] same_as 'head'
}

@test 'three: head -n 20 lastword' {
    zpwrExpandParseWords "head -n 20"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '20'
}

@test 'three: tail -f log firstword' {
    zpwrExpandParseWords "tail -f log"
    assert $ZPWR_VARS[firstword_partition] same_as 'tail'
}

@test 'three: tail -f log lastword' {
    zpwrExpandParseWords "tail -f log"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'log'
}

@test 'three: tee -a file firstword' {
    zpwrExpandParseWords "tee -a file"
    assert $ZPWR_VARS[firstword_partition] same_as 'tee'
}

@test 'three: tee -a file lastword' {
    zpwrExpandParseWords "tee -a file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'three: diff -u file1 firstword' {
    zpwrExpandParseWords "diff -u file1"
    assert $ZPWR_VARS[firstword_partition] same_as 'diff'
}

@test 'three: diff -u file1 lastword' {
    zpwrExpandParseWords "diff -u file1"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file1'
}

@test 'three: test -f file firstword' {
    zpwrExpandParseWords "test -f file"
    assert $ZPWR_VARS[firstword_partition] same_as 'test'
}

@test 'three: test -f file lastword' {
    zpwrExpandParseWords "test -f file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file'
}

@test 'three: strings -a binary firstword' {
    zpwrExpandParseWords "strings -a binary"
    assert $ZPWR_VARS[firstword_partition] same_as 'strings'
}

@test 'three: strings -a binary lastword' {
    zpwrExpandParseWords "strings -a binary"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'binary'
}

@test 'three: file --mime type firstword' {
    zpwrExpandParseWords "file --mime type"
    assert $ZPWR_VARS[firstword_partition] same_as 'file'
}

@test 'three: file --mime type lastword' {
    zpwrExpandParseWords "file --mime type"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'type'
}

@test 'group: { ls } firstword' {
    zpwrExpandParseWords "{ ls }"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'group: { ls } lastword' {
    zpwrExpandParseWords "{ ls }"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '}'
}

@test 'group: { echo hello } firstword' {
    zpwrExpandParseWords "{ echo hello }"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'group: { echo hello } lastword' {
    zpwrExpandParseWords "{ echo hello }"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '}'
}

@test 'group: { cmd1; cmd2 } firstword' {
    zpwrExpandParseWords "{ cmd1; cmd2 }"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd2'
}

@test 'group: { cmd1; cmd2 } lastword' {
    zpwrExpandParseWords "{ cmd1; cmd2 }"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '}'
}

@test 'group: { a && b } firstword' {
    zpwrExpandParseWords "{ a && b }"
    assert $ZPWR_VARS[firstword_partition] same_as 'b'
}

@test 'group: { a && b } lastword' {
    zpwrExpandParseWords "{ a && b }"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '}'
}

@test 'assign: FOO=bar cmd firstword' {
    zpwrExpandParseWords "FOO=bar cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: FOO=bar cmd lastword' {
    zpwrExpandParseWords "FOO=bar cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'assign: FOO=bar BAZ=qux cmd firstword' {
    zpwrExpandParseWords "FOO=bar BAZ=qux cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: FOO=bar BAZ=qux cmd lastword' {
    zpwrExpandParseWords "FOO=bar BAZ=qux cmd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'cmd'
}

@test 'assign: CC=gcc make firstword' {
    zpwrExpandParseWords "CC=gcc make"
    assert $ZPWR_VARS[firstword_partition] same_as 'make'
}

@test 'assign: CC=gcc make lastword' {
    zpwrExpandParseWords "CC=gcc make"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'make'
}

@test 'assign: HOME=/tmp ls firstword' {
    zpwrExpandParseWords "HOME=/tmp ls"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'assign: HOME=/tmp ls lastword' {
    zpwrExpandParseWords "HOME=/tmp ls"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'ls'
}

@test 'assign: VAR=val cmd arg1 arg2 firstword' {
    zpwrExpandParseWords "VAR=val cmd arg1 arg2"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'assign: VAR=val cmd arg1 arg2 lastword' {
    zpwrExpandParseWords "VAR=val cmd arg1 arg2"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'arg2'
}

@test 'long: git log --oneline --graph --all --decorate firstword' {
    zpwrExpandParseWords "git log --oneline --graph --all --decorate"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'long: git log --oneline --graph --all --decorate lastword' {
    zpwrExpandParseWords "git log --oneline --graph --all --decorate"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--decorate'
}

@test 'long: docker run --rm -it ubuntu bash firstword' {
    zpwrExpandParseWords "docker run --rm -it ubuntu bash"
    assert $ZPWR_VARS[firstword_partition] same_as 'docker'
}

@test 'long: docker run --rm -it ubuntu bash lastword' {
    zpwrExpandParseWords "docker run --rm -it ubuntu bash"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'bash'
}

@test 'long: kubectl get pods -n kube-system -o wide firstword' {
    zpwrExpandParseWords "kubectl get pods -n kube-system -o wide"
    assert $ZPWR_VARS[firstword_partition] same_as 'kubectl'
}

@test 'long: kubectl get pods -n kube-system -o wide lastword' {
    zpwrExpandParseWords "kubectl get pods -n kube-system -o wide"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'wide'
}

@test 'long: rsync -avz --progress src/ dest/ firstword' {
    zpwrExpandParseWords "rsync -avz --progress src/ dest/"
    assert $ZPWR_VARS[firstword_partition] same_as 'rsync'
}

@test 'long: rsync -avz --progress src/ dest/ lastword' {
    zpwrExpandParseWords "rsync -avz --progress src/ dest/"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dest/'
}

@test 'long: curl -X POST -H Content-Type -d data url firstword' {
    zpwrExpandParseWords "curl -X POST -H Content-Type -d data url"
    assert $ZPWR_VARS[firstword_partition] same_as 'curl'
}

@test 'long: curl -X POST -H Content-Type -d data url lastword' {
    zpwrExpandParseWords "curl -X POST -H Content-Type -d data url"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'url'
}

@test 'long: find . -name pattern -exec grep pat firstword' {
    zpwrExpandParseWords "find . -name pattern -exec grep pat"
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'long: find . -name pattern -exec grep pat lastword' {
    zpwrExpandParseWords "find . -name pattern -exec grep pat"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'pat'
}

@test 'long: ps aux --sort=-%mem firstword' {
    zpwrExpandParseWords "ps aux --sort=-%mem"
    assert $ZPWR_VARS[firstword_partition] same_as 'ps'
}

@test 'long: ps aux --sort=-%mem lastword' {
    zpwrExpandParseWords "ps aux --sort=-%mem"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'aux'
}

@test 'long: tar -czvf archive.tar.gz dir1 dir2 firstword' {
    zpwrExpandParseWords "tar -czvf archive.tar.gz dir1 dir2"
    assert $ZPWR_VARS[firstword_partition] same_as 'tar'
}

@test 'long: tar -czvf archive.tar.gz dir1 dir2 lastword' {
    zpwrExpandParseWords "tar -czvf archive.tar.gz dir1 dir2"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dir2'
}

@test 'long: sort -t, -k2 -n data.csv firstword' {
    zpwrExpandParseWords "sort -t, -k2 -n data.csv"
    assert $ZPWR_VARS[firstword_partition] same_as 'sort'
}

@test 'long: sort -t, -k2 -n data.csv lastword' {
    zpwrExpandParseWords "sort -t, -k2 -n data.csv"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'data.csv'
}

@test 'long: dd if=/dev/zero of=file bs=1M firstword' {
    zpwrExpandParseWords "dd if=/dev/zero of=file bs=1M"
    assert $ZPWR_VARS[firstword_partition] same_as 'dd'
}

@test 'long: dd if=/dev/zero of=file bs=1M lastword' {
    zpwrExpandParseWords "dd if=/dev/zero of=file bs=1M"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'dd'
}

@test 'long: tmux new-session -d -s main firstword' {
    zpwrExpandParseWords "tmux new-session -d -s main"
    assert $ZPWR_VARS[firstword_partition] same_as 'tmux'
}

@test 'long: tmux new-session -d -s main lastword' {
    zpwrExpandParseWords "tmux new-session -d -s main"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'main'
}

@test 'long: lsof -i -P -n firstword' {
    zpwrExpandParseWords "lsof -i -P -n"
    assert $ZPWR_VARS[firstword_partition] same_as 'lsof'
}

@test 'long: lsof -i -P -n lastword' {
    zpwrExpandParseWords "lsof -i -P -n"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-n'
}

@test 'long: strace -e trace=open -p 1234 firstword' {
    zpwrExpandParseWords "strace -e trace=open -p 1234"
    assert $ZPWR_VARS[firstword_partition] same_as 'strace'
}

@test 'long: strace -e trace=open -p 1234 lastword' {
    zpwrExpandParseWords "strace -e trace=open -p 1234"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '1234'
}

@test 'long: screen -S session -dm bash firstword' {
    zpwrExpandParseWords "screen -S session -dm bash"
    assert $ZPWR_VARS[firstword_partition] same_as 'screen'
}

@test 'long: screen -S session -dm bash lastword' {
    zpwrExpandParseWords "screen -S session -dm bash"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'bash'
}

@test 'long: xargs -P4 process firstword' {
    zpwrExpandParseWords "xargs -P4 process"
    assert $ZPWR_VARS[firstword_partition] same_as 'xargs'
}

@test 'long: xargs -P4 process lastword' {
    zpwrExpandParseWords "xargs -P4 process"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'process'
}

@test 'long: grep -rnI pattern src/ firstword' {
    zpwrExpandParseWords "grep -rnI pattern src/"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
}

@test 'long: grep -rnI pattern src/ lastword' {
    zpwrExpandParseWords "grep -rnI pattern src/"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'src/'
}

@test 'long: sed -E s/old/new/g input.txt firstword' {
    zpwrExpandParseWords "sed -E s/old/new/g input.txt"
    assert $ZPWR_VARS[firstword_partition] same_as 'sed'
}

@test 'long: sed -E s/old/new/g input.txt lastword' {
    zpwrExpandParseWords "sed -E s/old/new/g input.txt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'input.txt'
}

@test 'long: awk -F: NR /etc/passwd firstword' {
    zpwrExpandParseWords "awk -F: NR /etc/passwd"
    assert $ZPWR_VARS[firstword_partition] same_as 'awk'
}

@test 'long: awk -F: NR /etc/passwd lastword' {
    zpwrExpandParseWords "awk -F: NR /etc/passwd"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/etc/passwd'
}

@test 'long: cut -d, -f1,3 data.csv firstword' {
    zpwrExpandParseWords "cut -d, -f1,3 data.csv"
    assert $ZPWR_VARS[firstword_partition] same_as 'cut'
}

@test 'long: cut -d, -f1,3 data.csv lastword' {
    zpwrExpandParseWords "cut -d, -f1,3 data.csv"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'data.csv'
}

#==============================================================
# 1,180-token extreme chain — 5 full loops, 12 builtin perms,
# all 30 prefix commands duplicated with different flag combos
#==============================================================

@test 'extreme1180: lastword is gco' {
    zpwrExpandParseWords "nocorrect time -p command -p builtin eval noglob coproc exec -cl -a p1 nocorrect builtin eval noglob coproc time -l command -p nocorrect noglob builtin eval coproc time -v command builtin nocorrect eval noglob coproc eval nocorrect noglob builtin coproc noglob nocorrect builtin eval coproc time -p command -p exec -c -a p2 builtin eval nocorrect noglob coproc coproc nocorrect noglob builtin eval time -l command -p builtin eval nocorrect noglob coproc time -v command -p eval noglob nocorrect builtin coproc noglob coproc nocorrect builtin eval time -p command nocorrect eval noglob builtin coproc sudo -kE -u root env -0iv -C /tmp VAR1=a VAR2=b doas -n -u deploy env FOO=bar BAZ=qux LANG=C sudo -ABbHnPS -g wheel -h h1 -p pw -R /ch -r r1 -T 60 -t t1 -u admin env -i HOME=/r1 PATH=/b1 TERM=x1 doas -s -C /etc/d1 env -u DISPLAY TERM=xterm-256 sudo -kKi -u nobody env -v -C /var CC=gcc CFLAGS=-O2 sudo -kE -u daemon env -0i -C /opt RUST_LOG=debug doas -n -u _www env -i SHELL=/bin/zsh EDITOR=vim nice -n 10 nohup nice -n 5 nohup nice -n 1 nohup nice -n 19 nohup nice -n 15 nohup nice -n 12 nohup rlwrap -acirN -f /d1 -s 500 -b x -H /h1 -p red -S p1 timeout -k 5 -s TERM 30 strace -cCdDfFhikqrtTvVwxXyYzZ -a 80 -b 32 -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc -s 256 -S time -u 40 -U 80 ltrace -cCdDfFhikqrtTvVwxXyYzZ -a 60 -b 16 -e malloc -E MALLOC -I 2 -o /t2 -O 25 -p 2 -P /lib -s 128 -S calls -u 20 -U 40 ionice -t -c 2 -n 7 caffeinate -dimsu -t 60 -w 1234 setsid -cf chrt -f 10 taskset -c 0-3 watch -dgtecxbp -n 2 flock -nsux -w 10 -E 2 /tmp/lk1 chroot /nr1 runuser -l -u deploy -g staff -G docker unshare -fmnpuUirC -- cpulimit -l 50 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p sudo -kE -u www env -0i -C /v2 PATH=/b2 GOPATH=/go doas -n -u _httpd nice -n 8 nohup nice -n 3 nohup rlwrap -acN -f /d2 -s 1000 -b y -H /h2 -p blue -S p2 timeout -k 10 -s KILL 60 strace -cfkqrTvV -e trace=file -s 512 -o /t3 ltrace -cfhikrtTvV -e open -s 64 -a 40 -o /t4 ionice -c 1 -n 3 caffeinate -im -t 120 setsid -f chrt -r 20 taskset -c 0-7 watch -dx -n 5 flock -nx -w 3 -E 3 /tmp/lk2 chroot /nr2 runuser -u op -g sys unshare -mn -- cpulimit -l 75 pkexec fakeroot unbuffer chronic valgrind torify torsocks proxychains4 daemonize firejail sem systemd-run nocorrect noglob builtin eval coproc time -v command exec -l -a p3 sudo -kE -u test env -i RUST_LOG=trace NODE_ENV=prod doas -n -u _test nice -n 7 nohup nice -n 2 nohup rlwrap -air -f /d3 -s 200 -b z -H /h3 -p green -S p3 timeout -k 2 -s HUP 15 strace -cf -e trace=open -s 64 -o /t5 ltrace -cf -e free -s 32 -a 20 -o /t6 ionice -t -c 3 -n 0 caffeinate -d -t 30 setsid -cfw chrt -i 0 taskset -c 0 watch -dt -n 1 flock -su -w 1 -E 1 /tmp/lk3 chroot /nr3 runuser -l -u svc -g svc unshare -fpU -- cpulimit -l 25 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run builtin eval nocorrect noglob coproc time -l command -p exec -c -a p4 sudo -kKnP -u op -T 120 -r mgr -t user_t env -0iv -C /run DB=pg REDIS=6379 doas -s -C /etc/d2 nice -n 14 nohup nice -n 9 nohup nice -n 4 nohup rlwrap -aciN -f /d4 -s 750 -b w -H /h4 -p cyan -S p4 timeout -k 8 -s USR1 45 strace -dDfFhikwxXyYzZ -a 100 -b 64 -e trace=desc -E PATH -I 3 -o /t7 -O 75 -p 3 -P /dev -s 384 -S calls -u 60 -U 100 ltrace -dDfFhikwxXyYzZ -a 80 -b 48 -e write -E HOME -I 4 -o /t8 -O 50 -p 4 -P /sys -s 192 -S time -u 30 -U 60 ionice -t -c 2 -n 5 caffeinate -dimsu -t 90 -w 5678 setsid -cf chrt -b 5 taskset -c 0-15 watch -dgtecxbp -n 3 flock -nsux -w 15 -E 4 /tmp/lk4 chroot /nr4 runuser -l -u admin -g adm -G wheel unshare -fmnpuUirC -- cpulimit -l 90 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p exec -cl -a p5 sudo -kE -u root env -0iv -C /final VAR=last FINAL=yes doas -n -u root nice -n 0 nohup time -v gco"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'gco'
}

@test 'extreme1180: firstword is nocorrect' {
    zpwrExpandParseWords "nocorrect time -p command -p builtin eval noglob coproc exec -cl -a p1 nocorrect builtin eval noglob coproc time -l command -p nocorrect noglob builtin eval coproc time -v command builtin nocorrect eval noglob coproc eval nocorrect noglob builtin coproc noglob nocorrect builtin eval coproc time -p command -p exec -c -a p2 builtin eval nocorrect noglob coproc coproc nocorrect noglob builtin eval time -l command -p builtin eval nocorrect noglob coproc time -v command -p eval noglob nocorrect builtin coproc noglob coproc nocorrect builtin eval time -p command nocorrect eval noglob builtin coproc sudo -kE -u root env -0iv -C /tmp VAR1=a VAR2=b doas -n -u deploy env FOO=bar BAZ=qux LANG=C sudo -ABbHnPS -g wheel -h h1 -p pw -R /ch -r r1 -T 60 -t t1 -u admin env -i HOME=/r1 PATH=/b1 TERM=x1 doas -s -C /etc/d1 env -u DISPLAY TERM=xterm-256 sudo -kKi -u nobody env -v -C /var CC=gcc CFLAGS=-O2 sudo -kE -u daemon env -0i -C /opt RUST_LOG=debug doas -n -u _www env -i SHELL=/bin/zsh EDITOR=vim nice -n 10 nohup nice -n 5 nohup nice -n 1 nohup nice -n 19 nohup nice -n 15 nohup nice -n 12 nohup rlwrap -acirN -f /d1 -s 500 -b x -H /h1 -p red -S p1 timeout -k 5 -s TERM 30 strace -cCdDfFhikqrtTvVwxXyYzZ -a 80 -b 32 -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc -s 256 -S time -u 40 -U 80 ltrace -cCdDfFhikqrtTvVwxXyYzZ -a 60 -b 16 -e malloc -E MALLOC -I 2 -o /t2 -O 25 -p 2 -P /lib -s 128 -S calls -u 20 -U 40 ionice -t -c 2 -n 7 caffeinate -dimsu -t 60 -w 1234 setsid -cf chrt -f 10 taskset -c 0-3 watch -dgtecxbp -n 2 flock -nsux -w 10 -E 2 /tmp/lk1 chroot /nr1 runuser -l -u deploy -g staff -G docker unshare -fmnpuUirC -- cpulimit -l 50 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p sudo -kE -u www env -0i -C /v2 PATH=/b2 GOPATH=/go doas -n -u _httpd nice -n 8 nohup nice -n 3 nohup rlwrap -acN -f /d2 -s 1000 -b y -H /h2 -p blue -S p2 timeout -k 10 -s KILL 60 strace -cfkqrTvV -e trace=file -s 512 -o /t3 ltrace -cfhikrtTvV -e open -s 64 -a 40 -o /t4 ionice -c 1 -n 3 caffeinate -im -t 120 setsid -f chrt -r 20 taskset -c 0-7 watch -dx -n 5 flock -nx -w 3 -E 3 /tmp/lk2 chroot /nr2 runuser -u op -g sys unshare -mn -- cpulimit -l 75 pkexec fakeroot unbuffer chronic valgrind torify torsocks proxychains4 daemonize firejail sem systemd-run nocorrect noglob builtin eval coproc time -v command exec -l -a p3 sudo -kE -u test env -i RUST_LOG=trace NODE_ENV=prod doas -n -u _test nice -n 7 nohup nice -n 2 nohup rlwrap -air -f /d3 -s 200 -b z -H /h3 -p green -S p3 timeout -k 2 -s HUP 15 strace -cf -e trace=open -s 64 -o /t5 ltrace -cf -e free -s 32 -a 20 -o /t6 ionice -t -c 3 -n 0 caffeinate -d -t 30 setsid -cfw chrt -i 0 taskset -c 0 watch -dt -n 1 flock -su -w 1 -E 1 /tmp/lk3 chroot /nr3 runuser -l -u svc -g svc unshare -fpU -- cpulimit -l 25 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run builtin eval nocorrect noglob coproc time -l command -p exec -c -a p4 sudo -kKnP -u op -T 120 -r mgr -t user_t env -0iv -C /run DB=pg REDIS=6379 doas -s -C /etc/d2 nice -n 14 nohup nice -n 9 nohup nice -n 4 nohup rlwrap -aciN -f /d4 -s 750 -b w -H /h4 -p cyan -S p4 timeout -k 8 -s USR1 45 strace -dDfFhikwxXyYzZ -a 100 -b 64 -e trace=desc -E PATH -I 3 -o /t7 -O 75 -p 3 -P /dev -s 384 -S calls -u 60 -U 100 ltrace -dDfFhikwxXyYzZ -a 80 -b 48 -e write -E HOME -I 4 -o /t8 -O 50 -p 4 -P /sys -s 192 -S time -u 30 -U 60 ionice -t -c 2 -n 5 caffeinate -dimsu -t 90 -w 5678 setsid -cf chrt -b 5 taskset -c 0-15 watch -dgtecxbp -n 3 flock -nsux -w 15 -E 4 /tmp/lk4 chroot /nr4 runuser -l -u admin -g adm -G wheel unshare -fmnpuUirC -- cpulimit -l 90 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p exec -cl -a p5 sudo -kE -u root env -0iv -C /final VAR=last FINAL=yes doas -n -u root nice -n 0 nohup time -v gco"
    assert $ZPWR_VARS[firstword_partition] same_as 'nocorrect'
}

@test 'extreme1180: cachedRegexMatched is true' {
    zpwrExpandParseWords "nocorrect time -p command -p builtin eval noglob coproc exec -cl -a p1 nocorrect builtin eval noglob coproc time -l command -p nocorrect noglob builtin eval coproc time -v command builtin nocorrect eval noglob coproc eval nocorrect noglob builtin coproc noglob nocorrect builtin eval coproc time -p command -p exec -c -a p2 builtin eval nocorrect noglob coproc coproc nocorrect noglob builtin eval time -l command -p builtin eval nocorrect noglob coproc time -v command -p eval noglob nocorrect builtin coproc noglob coproc nocorrect builtin eval time -p command nocorrect eval noglob builtin coproc sudo -kE -u root env -0iv -C /tmp VAR1=a VAR2=b doas -n -u deploy env FOO=bar BAZ=qux LANG=C sudo -ABbHnPS -g wheel -h h1 -p pw -R /ch -r r1 -T 60 -t t1 -u admin env -i HOME=/r1 PATH=/b1 TERM=x1 doas -s -C /etc/d1 env -u DISPLAY TERM=xterm-256 sudo -kKi -u nobody env -v -C /var CC=gcc CFLAGS=-O2 sudo -kE -u daemon env -0i -C /opt RUST_LOG=debug doas -n -u _www env -i SHELL=/bin/zsh EDITOR=vim nice -n 10 nohup nice -n 5 nohup nice -n 1 nohup nice -n 19 nohup nice -n 15 nohup nice -n 12 nohup rlwrap -acirN -f /d1 -s 500 -b x -H /h1 -p red -S p1 timeout -k 5 -s TERM 30 strace -cCdDfFhikqrtTvVwxXyYzZ -a 80 -b 32 -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc -s 256 -S time -u 40 -U 80 ltrace -cCdDfFhikqrtTvVwxXyYzZ -a 60 -b 16 -e malloc -E MALLOC -I 2 -o /t2 -O 25 -p 2 -P /lib -s 128 -S calls -u 20 -U 40 ionice -t -c 2 -n 7 caffeinate -dimsu -t 60 -w 1234 setsid -cf chrt -f 10 taskset -c 0-3 watch -dgtecxbp -n 2 flock -nsux -w 10 -E 2 /tmp/lk1 chroot /nr1 runuser -l -u deploy -g staff -G docker unshare -fmnpuUirC -- cpulimit -l 50 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p sudo -kE -u www env -0i -C /v2 PATH=/b2 GOPATH=/go doas -n -u _httpd nice -n 8 nohup nice -n 3 nohup rlwrap -acN -f /d2 -s 1000 -b y -H /h2 -p blue -S p2 timeout -k 10 -s KILL 60 strace -cfkqrTvV -e trace=file -s 512 -o /t3 ltrace -cfhikrtTvV -e open -s 64 -a 40 -o /t4 ionice -c 1 -n 3 caffeinate -im -t 120 setsid -f chrt -r 20 taskset -c 0-7 watch -dx -n 5 flock -nx -w 3 -E 3 /tmp/lk2 chroot /nr2 runuser -u op -g sys unshare -mn -- cpulimit -l 75 pkexec fakeroot unbuffer chronic valgrind torify torsocks proxychains4 daemonize firejail sem systemd-run nocorrect noglob builtin eval coproc time -v command exec -l -a p3 sudo -kE -u test env -i RUST_LOG=trace NODE_ENV=prod doas -n -u _test nice -n 7 nohup nice -n 2 nohup rlwrap -air -f /d3 -s 200 -b z -H /h3 -p green -S p3 timeout -k 2 -s HUP 15 strace -cf -e trace=open -s 64 -o /t5 ltrace -cf -e free -s 32 -a 20 -o /t6 ionice -t -c 3 -n 0 caffeinate -d -t 30 setsid -cfw chrt -i 0 taskset -c 0 watch -dt -n 1 flock -su -w 1 -E 1 /tmp/lk3 chroot /nr3 runuser -l -u svc -g svc unshare -fpU -- cpulimit -l 25 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run builtin eval nocorrect noglob coproc time -l command -p exec -c -a p4 sudo -kKnP -u op -T 120 -r mgr -t user_t env -0iv -C /run DB=pg REDIS=6379 doas -s -C /etc/d2 nice -n 14 nohup nice -n 9 nohup nice -n 4 nohup rlwrap -aciN -f /d4 -s 750 -b w -H /h4 -p cyan -S p4 timeout -k 8 -s USR1 45 strace -dDfFhikwxXyYzZ -a 100 -b 64 -e trace=desc -E PATH -I 3 -o /t7 -O 75 -p 3 -P /dev -s 384 -S calls -u 60 -U 100 ltrace -dDfFhikwxXyYzZ -a 80 -b 48 -e write -E HOME -I 4 -o /t8 -O 50 -p 4 -P /sys -s 192 -S time -u 30 -U 60 ionice -t -c 2 -n 5 caffeinate -dimsu -t 90 -w 5678 setsid -cf chrt -b 5 taskset -c 0-15 watch -dgtecxbp -n 3 flock -nsux -w 15 -E 4 /tmp/lk4 chroot /nr4 runuser -l -u admin -g adm -G wheel unshare -fmnpuUirC -- cpulimit -l 90 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p exec -cl -a p5 sudo -kE -u root env -0iv -C /final VAR=last FINAL=yes doas -n -u root nice -n 0 nohup time -v gco"
    assert $ZPWR_VARS[cachedRegexMatched] same_as 'true'
}

@test 'extreme1180: alias expands through full chain' {
    alias gco="git checkout"
    LBUFFER="nocorrect time -p command -p builtin eval noglob coproc exec -cl -a p1 nocorrect builtin eval noglob coproc time -l command -p nocorrect noglob builtin eval coproc time -v command builtin nocorrect eval noglob coproc eval nocorrect noglob builtin coproc noglob nocorrect builtin eval coproc time -p command -p exec -c -a p2 builtin eval nocorrect noglob coproc coproc nocorrect noglob builtin eval time -l command -p builtin eval nocorrect noglob coproc time -v command -p eval noglob nocorrect builtin coproc noglob coproc nocorrect builtin eval time -p command nocorrect eval noglob builtin coproc sudo -kE -u root env -0iv -C /tmp VAR1=a VAR2=b doas -n -u deploy env FOO=bar BAZ=qux LANG=C sudo -ABbHnPS -g wheel -h h1 -p pw -R /ch -r r1 -T 60 -t t1 -u admin env -i HOME=/r1 PATH=/b1 TERM=x1 doas -s -C /etc/d1 env -u DISPLAY TERM=xterm-256 sudo -kKi -u nobody env -v -C /var CC=gcc CFLAGS=-O2 sudo -kE -u daemon env -0i -C /opt RUST_LOG=debug doas -n -u _www env -i SHELL=/bin/zsh EDITOR=vim nice -n 10 nohup nice -n 5 nohup nice -n 1 nohup nice -n 19 nohup nice -n 15 nohup nice -n 12 nohup rlwrap -acirN -f /d1 -s 500 -b x -H /h1 -p red -S p1 timeout -k 5 -s TERM 30 strace -cCdDfFhikqrtTvVwxXyYzZ -a 80 -b 32 -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc -s 256 -S time -u 40 -U 80 ltrace -cCdDfFhikqrtTvVwxXyYzZ -a 60 -b 16 -e malloc -E MALLOC -I 2 -o /t2 -O 25 -p 2 -P /lib -s 128 -S calls -u 20 -U 40 ionice -t -c 2 -n 7 caffeinate -dimsu -t 60 -w 1234 setsid -cf chrt -f 10 taskset -c 0-3 watch -dgtecxbp -n 2 flock -nsux -w 10 -E 2 /tmp/lk1 chroot /nr1 runuser -l -u deploy -g staff -G docker unshare -fmnpuUirC -- cpulimit -l 50 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p sudo -kE -u www env -0i -C /v2 PATH=/b2 GOPATH=/go doas -n -u _httpd nice -n 8 nohup nice -n 3 nohup rlwrap -acN -f /d2 -s 1000 -b y -H /h2 -p blue -S p2 timeout -k 10 -s KILL 60 strace -cfkqrTvV -e trace=file -s 512 -o /t3 ltrace -cfhikrtTvV -e open -s 64 -a 40 -o /t4 ionice -c 1 -n 3 caffeinate -im -t 120 setsid -f chrt -r 20 taskset -c 0-7 watch -dx -n 5 flock -nx -w 3 -E 3 /tmp/lk2 chroot /nr2 runuser -u op -g sys unshare -mn -- cpulimit -l 75 pkexec fakeroot unbuffer chronic valgrind torify torsocks proxychains4 daemonize firejail sem systemd-run nocorrect noglob builtin eval coproc time -v command exec -l -a p3 sudo -kE -u test env -i RUST_LOG=trace NODE_ENV=prod doas -n -u _test nice -n 7 nohup nice -n 2 nohup rlwrap -air -f /d3 -s 200 -b z -H /h3 -p green -S p3 timeout -k 2 -s HUP 15 strace -cf -e trace=open -s 64 -o /t5 ltrace -cf -e free -s 32 -a 20 -o /t6 ionice -t -c 3 -n 0 caffeinate -d -t 30 setsid -cfw chrt -i 0 taskset -c 0 watch -dt -n 1 flock -su -w 1 -E 1 /tmp/lk3 chroot /nr3 runuser -l -u svc -g svc unshare -fpU -- cpulimit -l 25 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run builtin eval nocorrect noglob coproc time -l command -p exec -c -a p4 sudo -kKnP -u op -T 120 -r mgr -t user_t env -0iv -C /run DB=pg REDIS=6379 doas -s -C /etc/d2 nice -n 14 nohup nice -n 9 nohup nice -n 4 nohup rlwrap -aciN -f /d4 -s 750 -b w -H /h4 -p cyan -S p4 timeout -k 8 -s USR1 45 strace -dDfFhikwxXyYzZ -a 100 -b 64 -e trace=desc -E PATH -I 3 -o /t7 -O 75 -p 3 -P /dev -s 384 -S calls -u 60 -U 100 ltrace -dDfFhikwxXyYzZ -a 80 -b 48 -e write -E HOME -I 4 -o /t8 -O 50 -p 4 -P /sys -s 192 -S time -u 30 -U 60 ionice -t -c 2 -n 5 caffeinate -dimsu -t 90 -w 5678 setsid -cf chrt -b 5 taskset -c 0-15 watch -dgtecxbp -n 3 flock -nsux -w 15 -E 4 /tmp/lk4 chroot /nr4 runuser -l -u admin -g adm -G wheel unshare -fmnpuUirC -- cpulimit -l 90 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run nocorrect builtin eval noglob coproc time -p command -p exec -cl -a p5 sudo -kE -u root env -0iv -C /final VAR=last FINAL=yes doas -n -u root nice -n 0 nohup time -v gco"
    ZPWR_EXPAND=true
    ZPWR_EXPAND_SECOND_POSITION=true
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert "$LBUFFER" matches 'git checkout$'
    unalias gco
}

#==============================================================
# ~100KB / 20K-token stress test — 107 full loops through the
# entire wrapper stack, approaching OS ARG_MAX limits.
# LBUFFER has no kernel limit (it is just a string in memory);
# ARG_MAX only applies at execve() time.
#==============================================================

@test 'stress100k: 20K tokens expand through 107 loops' {
    alias gco="git checkout"
    local BLOCK="nocorrect builtin eval noglob coproc time -p command -p sudo -kE -u root env -0iv -C /tmp VAR1=a doas -n -u deploy env FOO=bar LANG=C sudo -ABbHnPS -g wheel -h h1 -p pw -R /ch -r r1 -T 60 -t t1 -u admin env -i HOME=/r1 PATH=/b1 TERM=x1 nice -n 10 nohup nice -n 5 nohup rlwrap -acirN -f /d1 -s 500 -b x -H /h1 -p red -S p1 timeout -k 5 -s TERM 30 strace -cCdDfFhikqrtTvVwxXyYzZ -a 80 -b 32 -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc -s 256 -S time -u 40 -U 80 ltrace -cCdDfFhikqrtTvVwxXyYzZ -a 60 -b 16 -e malloc -E MALLOC -I 2 -o /t2 -O 25 -p 2 -P /lib -s 128 -S calls -u 20 -U 40 ionice -t -c 2 -n 7 caffeinate -dimsu -t 60 -w 1234 setsid -cf chrt -f 10 taskset -c 0-3 watch -dgtecxbp -n 2 flock -nsux -w 10 -E 2 /tmp/lk1 chroot /nr1 runuser -l -u deploy -g staff -G docker unshare -fmnpuUirC -- cpulimit -l 50 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run "
    LBUFFER=""
    for i in {1..107}; do
        LBUFFER+="$BLOCK"
    done
    LBUFFER+="gco"
    ZPWR_EXPAND=true
    ZPWR_EXPAND_SECOND_POSITION=true
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandRegexMatchOnCommandPosition
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert "$LBUFFER" matches 'git checkout$'
    unalias gco
}

@test 'stress100k: lastword is gco at 100KB' {
    local BLOCK="nocorrect builtin eval noglob coproc time -p command -p sudo -kE -u root env -0iv -C /tmp VAR1=a doas -n -u deploy env FOO=bar LANG=C sudo -ABbHnPS -g wheel -h h1 -p pw -R /ch -r r1 -T 60 -t t1 -u admin env -i HOME=/r1 PATH=/b1 TERM=x1 nice -n 10 nohup nice -n 5 nohup rlwrap -acirN -f /d1 -s 500 -b x -H /h1 -p red -S p1 timeout -k 5 -s TERM 30 strace -cCdDfFhikqrtTvVwxXyYzZ -a 80 -b 32 -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc -s 256 -S time -u 40 -U 80 ltrace -cCdDfFhikqrtTvVwxXyYzZ -a 60 -b 16 -e malloc -E MALLOC -I 2 -o /t2 -O 25 -p 2 -P /lib -s 128 -S calls -u 20 -U 40 ionice -t -c 2 -n 7 caffeinate -dimsu -t 60 -w 1234 setsid -cf chrt -f 10 taskset -c 0-3 watch -dgtecxbp -n 2 flock -nsux -w 10 -E 2 /tmp/lk1 chroot /nr1 runuser -l -u deploy -g staff -G docker unshare -fmnpuUirC -- cpulimit -l 50 pkexec fakeroot unbuffer chronic valgrind torify torsocks tsocks proxychains4 daemonize firejail sem systemd-run "
    local input=""
    for i in {1..107}; do
        input+="$BLOCK"
    done
    input+="gco"
    zpwrExpandParseWords "$input"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'gco'
}
