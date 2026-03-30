#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive alias expansion edge case tests
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

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# zpwrExpandAlias: leading spaces (0-5)
#==============================================================

@test 'zpwrExpandAlias: zero leading spaces' {
    LBUFFER="gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git status'
}

@test 'zpwrExpandAlias: one leading space' {
    LBUFFER=" gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as ' git status'
}

@test 'zpwrExpandAlias: two leading spaces' {
    LBUFFER="  gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as '  git status'
}

@test 'zpwrExpandAlias: three leading spaces' {
    LBUFFER="   gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as '   git status'
}

@test 'zpwrExpandAlias: four leading spaces' {
    LBUFFER="    gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as '    git status'
}

@test 'zpwrExpandAlias: five leading spaces' {
    LBUFFER="     gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as '     git status'
}

#==============================================================
# zpwrExpandAlias: preceding commands
#==============================================================

@test 'zpwrExpandAlias: after sudo' {
    LBUFFER="sudo gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo git status'
}

@test 'zpwrExpandAlias: after env' {
    LBUFFER="env gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'env git status'
}

@test 'zpwrExpandAlias: after time' {
    LBUFFER="time gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'time git status'
}

@test 'zpwrExpandAlias: after nice' {
    LBUFFER="nice gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'nice git status'
}

@test 'zpwrExpandAlias: after nohup' {
    LBUFFER="nohup gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'nohup git status'
}

@test 'zpwrExpandAlias: after command' {
    LBUFFER="command gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'command git status'
}

@test 'zpwrExpandAlias: after builtin' {
    LBUFFER="builtin gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'builtin git status'
}

@test 'zpwrExpandAlias: after exec' {
    LBUFFER="exec gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'exec git status'
}

@test 'zpwrExpandAlias: after eval' {
    LBUFFER="eval gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'eval git status'
}

@test 'zpwrExpandAlias: after rlwrap' {
    LBUFFER="rlwrap gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'rlwrap git status'
}

@test 'zpwrExpandAlias: after nocorrect' {
    LBUFFER="nocorrect gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'nocorrect git status'
}

#==============================================================
# zpwrExpandAlias: after pipe, semicolon, &&, ||
#==============================================================

@test 'zpwrExpandAlias: after pipe' {
    LBUFFER="cat file | gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat file | git status'
}

@test 'zpwrExpandAlias: after semicolon' {
    LBUFFER="echo done; gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo done; git status'
}

@test 'zpwrExpandAlias: after double ampersand' {
    LBUFFER="make && gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'make && git status'
}

@test 'zpwrExpandAlias: after double pipe' {
    LBUFFER="false || gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'false || git status'
}

#==============================================================
# zpwrExpandAlias: alias values with special characters
#==============================================================

@test 'zpwrExpandAlias: value with pipe' {
    LBUFFER="glog"
    ZPWR_VARS[lastword_lbuffer]=glog
    ZPWR_VARS[EXPANDED]='git log --oneline | head'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git log --oneline | head'
}

@test 'zpwrExpandAlias: value with semicolon' {
    LBUFFER="upd"
    ZPWR_VARS[lastword_lbuffer]=upd
    ZPWR_VARS[EXPANDED]='git pull; git push'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git pull; git push'
}

@test 'zpwrExpandAlias: value with double ampersand' {
    LBUFFER="bld"
    ZPWR_VARS[lastword_lbuffer]=bld
    ZPWR_VARS[EXPANDED]='make clean && make'
    zpwrExpandAlias
    assert $LBUFFER same_as 'make clean && make'
}

@test 'zpwrExpandAlias: value with redirection' {
    LBUFFER="devnull"
    ZPWR_VARS[lastword_lbuffer]=devnull
    ZPWR_VARS[EXPANDED]='> /dev/null 2>&1'
    zpwrExpandAlias
    assert $LBUFFER same_as '> /dev/null 2>&1'
}

@test 'zpwrExpandAlias: value with backticks' {
    LBUFFER="mydate"
    ZPWR_VARS[lastword_lbuffer]=mydate
    ZPWR_VARS[EXPANDED]='echo `date`'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo `date`'
}

@test 'zpwrExpandAlias: value with dollar sign' {
    LBUFFER="myenv"
    ZPWR_VARS[lastword_lbuffer]=myenv
    ZPWR_VARS[EXPANDED]='echo $HOME'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo $HOME'
}

@test 'zpwrExpandAlias: value with tilde' {
    LBUFFER="cdhome"
    ZPWR_VARS[lastword_lbuffer]=cdhome
    ZPWR_VARS[EXPANDED]='cd ~'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ~'
}

@test 'zpwrExpandAlias: value with equals sign' {
    LBUFFER="gconf"
    ZPWR_VARS[lastword_lbuffer]=gconf
    ZPWR_VARS[EXPANDED]='git config --global user.name=test'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git config --global user.name=test'
}

@test 'zpwrExpandAlias: value with double dashes' {
    LBUFFER="gcp"
    ZPWR_VARS[lastword_lbuffer]=gcp
    ZPWR_VARS[EXPANDED]='git cherry-pick --no-commit'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git cherry-pick --no-commit'
}

@test 'zpwrExpandAlias: value with single dash flag' {
    LBUFFER="lsa"
    ZPWR_VARS[lastword_lbuffer]=lsa
    ZPWR_VARS[EXPANDED]='ls -a'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls -a'
}

@test 'zpwrExpandAlias: value with path slashes' {
    LBUFFER="cdetc"
    ZPWR_VARS[lastword_lbuffer]=cdetc
    ZPWR_VARS[EXPANDED]='cd /etc/nginx/conf.d'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd /etc/nginx/conf.d'
}

@test 'zpwrExpandAlias: value with quoted string' {
    LBUFFER="hw"
    ZPWR_VARS[lastword_lbuffer]=hw
    ZPWR_VARS[EXPANDED]='echo "hello world"'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo "hello world"'
}

@test 'zpwrExpandAlias: value with numbers' {
    LBUFFER="p8"
    ZPWR_VARS[lastword_lbuffer]=p8
    ZPWR_VARS[EXPANDED]='ping 8.8.8.8'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ping 8.8.8.8'
}

@test 'zpwrExpandAlias: value with underscores' {
    LBUFFER="my_cmd"
    ZPWR_VARS[lastword_lbuffer]=my_cmd
    ZPWR_VARS[EXPANDED]='run_my_script --verbose'
    zpwrExpandAlias
    assert $LBUFFER same_as 'run_my_script --verbose'
}

@test 'zpwrExpandAlias: value with dots' {
    LBUFFER="goup"
    ZPWR_VARS[lastword_lbuffer]=goup
    ZPWR_VARS[EXPANDED]='cd ../..'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ../..'
}

#==============================================================
# zpwrExpandAlias: single character aliases
#==============================================================

@test 'zpwrExpandAlias: single char alias a' {
    LBUFFER="a"
    ZPWR_VARS[lastword_lbuffer]=a
    ZPWR_VARS[EXPANDED]='alias'
    zpwrExpandAlias
    assert $LBUFFER same_as 'alias'
}

@test 'zpwrExpandAlias: single char alias b' {
    LBUFFER="b"
    ZPWR_VARS[lastword_lbuffer]=b
    ZPWR_VARS[EXPANDED]='bundle'
    zpwrExpandAlias
    assert $LBUFFER same_as 'bundle'
}

@test 'zpwrExpandAlias: single char alias c' {
    LBUFFER="c"
    ZPWR_VARS[lastword_lbuffer]=c
    ZPWR_VARS[EXPANDED]='cat'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat'
}

@test 'zpwrExpandAlias: single char alias d' {
    LBUFFER="d"
    ZPWR_VARS[lastword_lbuffer]=d
    ZPWR_VARS[EXPANDED]='docker'
    zpwrExpandAlias
    assert $LBUFFER same_as 'docker'
}

@test 'zpwrExpandAlias: single char alias e' {
    LBUFFER="e"
    ZPWR_VARS[lastword_lbuffer]=e
    ZPWR_VARS[EXPANDED]='echo'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo'
}

@test 'zpwrExpandAlias: single char alias f' {
    LBUFFER="f"
    ZPWR_VARS[lastword_lbuffer]=f
    ZPWR_VARS[EXPANDED]='find'
    zpwrExpandAlias
    assert $LBUFFER same_as 'find'
}

@test 'zpwrExpandAlias: single char alias g' {
    LBUFFER="g"
    ZPWR_VARS[lastword_lbuffer]=g
    ZPWR_VARS[EXPANDED]='git'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git'
}

@test 'zpwrExpandAlias: single char alias h' {
    LBUFFER="h"
    ZPWR_VARS[lastword_lbuffer]=h
    ZPWR_VARS[EXPANDED]='history'
    zpwrExpandAlias
    assert $LBUFFER same_as 'history'
}

@test 'zpwrExpandAlias: single char alias k' {
    LBUFFER="k"
    ZPWR_VARS[lastword_lbuffer]=k
    ZPWR_VARS[EXPANDED]='kubectl'
    zpwrExpandAlias
    assert $LBUFFER same_as 'kubectl'
}

@test 'zpwrExpandAlias: single char alias l' {
    LBUFFER="l"
    ZPWR_VARS[lastword_lbuffer]=l
    ZPWR_VARS[EXPANDED]='less'
    zpwrExpandAlias
    assert $LBUFFER same_as 'less'
}

@test 'zpwrExpandAlias: single char alias m' {
    LBUFFER="m"
    ZPWR_VARS[lastword_lbuffer]=m
    ZPWR_VARS[EXPANDED]='make'
    zpwrExpandAlias
    assert $LBUFFER same_as 'make'
}

@test 'zpwrExpandAlias: single char alias p' {
    LBUFFER="p"
    ZPWR_VARS[lastword_lbuffer]=p
    ZPWR_VARS[EXPANDED]='python'
    zpwrExpandAlias
    assert $LBUFFER same_as 'python'
}

@test 'zpwrExpandAlias: single char alias t' {
    LBUFFER="t"
    ZPWR_VARS[lastword_lbuffer]=t
    ZPWR_VARS[EXPANDED]='tail'
    zpwrExpandAlias
    assert $LBUFFER same_as 'tail'
}

@test 'zpwrExpandAlias: single char alias v' {
    LBUFFER="v"
    ZPWR_VARS[lastword_lbuffer]=v
    ZPWR_VARS[EXPANDED]='vim'
    zpwrExpandAlias
    assert $LBUFFER same_as 'vim'
}

@test 'zpwrExpandAlias: single char alias z' {
    LBUFFER="z"
    ZPWR_VARS[lastword_lbuffer]=z
    ZPWR_VARS[EXPANDED]='zsh'
    zpwrExpandAlias
    assert $LBUFFER same_as 'zsh'
}

#==============================================================
# zpwrExpandAlias: multi-character aliases various lengths
#==============================================================

@test 'zpwrExpandAlias: two char alias ga' {
    LBUFFER="ga"
    ZPWR_VARS[lastword_lbuffer]=ga
    ZPWR_VARS[EXPANDED]='git add'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git add'
}

@test 'zpwrExpandAlias: three char alias gco' {
    LBUFFER="gco"
    ZPWR_VARS[lastword_lbuffer]=gco
    ZPWR_VARS[EXPANDED]='git checkout'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git checkout'
}

@test 'zpwrExpandAlias: four char alias gcob' {
    LBUFFER="gcob"
    ZPWR_VARS[lastword_lbuffer]=gcob
    ZPWR_VARS[EXPANDED]='git checkout -b'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git checkout -b'
}

@test 'zpwrExpandAlias: five char alias gmerge' {
    LBUFFER="gmerg"
    ZPWR_VARS[lastword_lbuffer]=gmerg
    ZPWR_VARS[EXPANDED]='git merge --no-ff'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git merge --no-ff'
}

@test 'zpwrExpandAlias: ten char alias gitlogpret' {
    LBUFFER="gitlogpret"
    ZPWR_VARS[lastword_lbuffer]=gitlogpret
    ZPWR_VARS[EXPANDED]='git log --pretty=format:"%h %s"'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git log --pretty=format:"%h %s"'
}

@test 'zpwrExpandAlias: fifteen char alias dockercontlist' {
    LBUFFER="dockercontlist"
    ZPWR_VARS[lastword_lbuffer]=dockercontlist
    ZPWR_VARS[EXPANDED]='docker container ls --all'
    zpwrExpandAlias
    assert $LBUFFER same_as 'docker container ls --all'
}

@test 'zpwrExpandAlias: twenty char alias kubernetesgetpods01' {
    LBUFFER="kubernetesgetpods01"
    ZPWR_VARS[lastword_lbuffer]=kubernetesgetpods01
    ZPWR_VARS[EXPANDED]='kubectl get pods --all-namespaces -o wide'
    zpwrExpandAlias
    assert $LBUFFER same_as 'kubectl get pods --all-namespaces -o wide'
}

#==============================================================
# zpwrExpandAlias: aliases with hyphens and underscores
#==============================================================

@test 'zpwrExpandAlias: alias name with hyphen' {
    LBUFFER="git-st"
    ZPWR_VARS[lastword_lbuffer]=git-st
    ZPWR_VARS[EXPANDED]='git status --short'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git status --short'
}

@test 'zpwrExpandAlias: alias name with underscore' {
    LBUFFER="git_log"
    ZPWR_VARS[lastword_lbuffer]=git_log
    ZPWR_VARS[EXPANDED]='git log --oneline --graph'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git log --oneline --graph'
}

@test 'zpwrExpandAlias: alias name with multiple hyphens' {
    LBUFFER="docker-compose-up"
    ZPWR_VARS[lastword_lbuffer]=docker-compose-up
    ZPWR_VARS[EXPANDED]='docker compose up -d'
    zpwrExpandAlias
    assert $LBUFFER same_as 'docker compose up -d'
}

@test 'zpwrExpandAlias: alias name with multiple underscores' {
    LBUFFER="my_long_alias"
    ZPWR_VARS[lastword_lbuffer]=my_long_alias
    ZPWR_VARS[EXPANDED]='some long command here'
    zpwrExpandAlias
    assert $LBUFFER same_as 'some long command here'
}

@test 'zpwrExpandAlias: alias name mixing hyphens and underscores' {
    LBUFFER="my-long_alias"
    ZPWR_VARS[lastword_lbuffer]=my-long_alias
    ZPWR_VARS[EXPANDED]='mixed-name command'
    zpwrExpandAlias
    assert $LBUFFER same_as 'mixed-name command'
}

#==============================================================
# zpwrExpandAlias: multiple occurrences (only replace last)
#==============================================================

@test 'zpwrExpandAlias: two occurrences replaces only last' {
    LBUFFER="gs; echo gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'gs; echo git status'
}

@test 'zpwrExpandAlias: three occurrences replaces only last' {
    LBUFFER="gs; gs; gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'gs; gs; git status'
}

@test 'zpwrExpandAlias: alias word in middle not at end is not replaced' {
    LBUFFER="echo gs foo"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo gs foo'
}

@test 'zpwrExpandAlias: replaces last occurrence after pipe' {
    LBUFFER="gs | gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'gs | git status'
}

#==============================================================
# zpwrExpandAlias: WAS_EXPANDED flag
#==============================================================

@test 'zpwrExpandAlias: WAS_EXPANDED true after successful expansion' {
    LBUFFER="ll"
    ZPWR_VARS[lastword_lbuffer]=ll
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'zpwrExpandAlias: WAS_EXPANDED stays false trailing space' {
    LBUFFER="ll "
    ZPWR_VARS[lastword_lbuffer]=ll
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'zpwrExpandAlias: WAS_EXPANDED stays false double trailing space' {
    LBUFFER="ll  "
    ZPWR_VARS[lastword_lbuffer]=ll
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'zpwrExpandAlias: WAS_EXPANDED true with leading space' {
    LBUFFER=" ll"
    ZPWR_VARS[lastword_lbuffer]=ll
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'zpwrExpandAlias: WAS_EXPANDED true after preceding command' {
    LBUFFER="sudo ll"
    ZPWR_VARS[lastword_lbuffer]=ll
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

#==============================================================
# zpwrExpandAlias: trailing space preventing expansion
#==============================================================

@test 'zpwrExpandAlias: single trailing space prevents expansion' {
    LBUFFER="gs "
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias || :
    assert $LBUFFER same_as 'gs '
}

@test 'zpwrExpandAlias: double trailing space prevents expansion' {
    LBUFFER="gs  "
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias || :
    assert $LBUFFER same_as 'gs  '
}

@test 'zpwrExpandAlias: trailing space after preceding cmd prevents expansion' {
    LBUFFER="sudo gs "
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias || :
    assert $LBUFFER same_as 'sudo gs '
}

#==============================================================
# zpwrExpandAlias: empty LBUFFER and just the alias word
#==============================================================

@test 'zpwrExpandAlias: empty LBUFFER no crash' {
    LBUFFER=""
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias || :
    assert $LBUFFER same_as ''
}

@test 'zpwrExpandAlias: LBUFFER is just the alias word' {
    LBUFFER="myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='expanded value here'
    zpwrExpandAlias
    assert $LBUFFER same_as 'expanded value here'
}

@test 'zpwrExpandAlias: LBUFFER is just single char alias' {
    LBUFFER="x"
    ZPWR_VARS[lastword_lbuffer]=x
    ZPWR_VARS[EXPANDED]='xargs'
    zpwrExpandAlias
    assert $LBUFFER same_as 'xargs'
}

#==============================================================
# zpwrExpandAlias: complex command chains
#==============================================================

@test 'zpwrExpandAlias: cmd1 pipe cmd2 && cmd3 semicolon alias' {
    LBUFFER="cat f | grep x && make; gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat f | grep x && make; git status'
}

@test 'zpwrExpandAlias: nested pipes then alias' {
    LBUFFER="ps aux | grep foo | gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ps aux | grep foo | git status'
}

@test 'zpwrExpandAlias: multiple semicolons then alias' {
    LBUFFER="cd /tmp; ls; echo done; gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd /tmp; ls; echo done; git status'
}

@test 'zpwrExpandAlias: double ampersand chain then alias' {
    LBUFFER="mkdir -p foo && cd foo && gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'mkdir -p foo && cd foo && git status'
}

@test 'zpwrExpandAlias: double pipe chain then alias' {
    LBUFFER="false || true || gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'false || true || git status'
}

#==============================================================
# zpwrExpandAlias: empty alias values
#==============================================================

@test 'zpwrExpandAlias: empty expanded value' {
    LBUFFER="noop"
    ZPWR_VARS[lastword_lbuffer]=noop
    ZPWR_VARS[EXPANDED]=''
    zpwrExpandAlias
    assert $LBUFFER same_as ''
}

@test 'zpwrExpandAlias: empty expanded value after sudo' {
    LBUFFER="sudo noop"
    ZPWR_VARS[lastword_lbuffer]=noop
    ZPWR_VARS[EXPANDED]=''
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo '
}

#==============================================================
# zpwrExpandAlias: very long alias values
#==============================================================

@test 'zpwrExpandAlias: long value 50 chars' {
    LBUFFER="lv"
    ZPWR_VARS[lastword_lbuffer]=lv
    ZPWR_VARS[EXPANDED]='git log --pretty=format:"%h %an %s" --abbrev=10'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git log --pretty=format:"%h %an %s" --abbrev=10'
}

@test 'zpwrExpandAlias: long value with many flags' {
    LBUFFER="longcmd"
    ZPWR_VARS[lastword_lbuffer]=longcmd
    ZPWR_VARS[EXPANDED]='rsync -avz --progress --partial --delete --exclude=.git --exclude=node_modules'
    zpwrExpandAlias
    assert $LBUFFER same_as 'rsync -avz --progress --partial --delete --exclude=.git --exclude=node_modules'
}

@test 'zpwrExpandAlias: long value with path and flags' {
    LBUFFER="dockerrun"
    ZPWR_VARS[lastword_lbuffer]=dockerrun
    ZPWR_VARS[EXPANDED]='docker run --rm -it -v /home/user/project:/app -w /app -p 8080:8080 node:latest'
    zpwrExpandAlias
    assert $LBUFFER same_as 'docker run --rm -it -v /home/user/project:/app -w /app -p 8080:8080 node:latest'
}

#==============================================================
# zpwrExpandAlias: additional edge cases
#==============================================================

@test 'zpwrExpandAlias: alias at end after space-semicolon-space' {
    LBUFFER="echo hi ; myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='replaced'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo hi ; replaced'
}

@test 'zpwrExpandAlias: alias after tab-like whitespace' {
    LBUFFER="sudo  gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo  git status'
}

@test 'zpwrExpandAlias: expansion value starts with dash' {
    LBUFFER="myf"
    ZPWR_VARS[lastword_lbuffer]=myf
    ZPWR_VARS[EXPANDED]='-la'
    zpwrExpandAlias
    assert $LBUFFER same_as '-la'
}

@test 'zpwrExpandAlias: expansion value starts with double dash' {
    LBUFFER="myopt"
    ZPWR_VARS[lastword_lbuffer]=myopt
    ZPWR_VARS[EXPANDED]='--verbose --debug'
    zpwrExpandAlias
    assert $LBUFFER same_as '--verbose --debug'
}

@test 'zpwrExpandAlias: alias value is a single character' {
    LBUFFER="mychar"
    ZPWR_VARS[lastword_lbuffer]=mychar
    ZPWR_VARS[EXPANDED]='x'
    zpwrExpandAlias
    assert $LBUFFER same_as 'x'
}

@test 'zpwrExpandAlias: alias value same as alias name' {
    LBUFFER="samename"
    ZPWR_VARS[lastword_lbuffer]=samename
    ZPWR_VARS[EXPANDED]='samename'
    zpwrExpandAlias
    assert $LBUFFER same_as 'samename'
}

@test 'zpwrExpandAlias: sudo with leading space then alias' {
    LBUFFER=" sudo gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as ' sudo git status'
}

@test 'zpwrExpandAlias: three words preceding alias' {
    LBUFFER="sudo env FOO=bar gs"
    ZPWR_VARS[lastword_lbuffer]=gs
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo env FOO=bar git status'
}

@test 'zpwrExpandAlias: value with single quotes inside' {
    LBUFFER="sqalias"
    ZPWR_VARS[lastword_lbuffer]=sqalias
    ZPWR_VARS[EXPANDED]="echo 'hello world'"
    zpwrExpandAlias
    assert $LBUFFER same_as "echo 'hello world'"
}

@test 'zpwrExpandAlias: value with ampersand background' {
    LBUFFER="bgcmd"
    ZPWR_VARS[lastword_lbuffer]=bgcmd
    ZPWR_VARS[EXPANDED]='sleep 100 &'
    zpwrExpandAlias
    assert $LBUFFER same_as 'sleep 100 &'
}

#==============================================================
# zpwrExpandAliasEscape: leading spaces
#==============================================================

@test 'zpwrExpandAliasEscape: zero leading spaces' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ls -la'
}

@test 'zpwrExpandAliasEscape: one leading space' {
    LBUFFER=" ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as ' \ls -la'
}

@test 'zpwrExpandAliasEscape: two leading spaces' {
    LBUFFER="  ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '  \ls -la'
}

@test 'zpwrExpandAliasEscape: three leading spaces' {
    LBUFFER="   ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '   \ls -la'
}

@test 'zpwrExpandAliasEscape: four leading spaces' {
    LBUFFER="    ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '    \ls -la'
}

@test 'zpwrExpandAliasEscape: five leading spaces' {
    LBUFFER="     ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '     \ls -la'
}

#==============================================================
# zpwrExpandAliasEscape: after pipe, semicolon, &&, ||
#==============================================================

@test 'zpwrExpandAliasEscape: after pipe' {
    LBUFFER="cat file | grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep -rn --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cat file | \grep -rn --color=auto'
}

@test 'zpwrExpandAliasEscape: after semicolon' {
    LBUFFER="echo done; ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'echo done; \ls -la'
}

@test 'zpwrExpandAliasEscape: after double ampersand' {
    LBUFFER="make && ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'make && \ls -la'
}

@test 'zpwrExpandAliasEscape: after double pipe' {
    LBUFFER="false || ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'false || \ls -la'
}

#==============================================================
# zpwrExpandAliasEscape: various preceding words
#==============================================================

@test 'zpwrExpandAliasEscape: after sudo' {
    LBUFFER="sudo ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'sudo \ls -la'
}

@test 'zpwrExpandAliasEscape: after env' {
    LBUFFER="env ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'env \ls -la'
}

@test 'zpwrExpandAliasEscape: after time' {
    LBUFFER="time ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'time \ls -la'
}

@test 'zpwrExpandAliasEscape: after nice' {
    LBUFFER="nice ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'nice \ls -la'
}

@test 'zpwrExpandAliasEscape: after nohup' {
    LBUFFER="nohup ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'nohup \ls -la'
}

@test 'zpwrExpandAliasEscape: after command' {
    LBUFFER="command ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'command \ls -la'
}

@test 'zpwrExpandAliasEscape: after builtin' {
    LBUFFER="builtin ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'builtin \ls -la'
}

@test 'zpwrExpandAliasEscape: after exec' {
    LBUFFER="exec ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'exec \ls -la'
}

@test 'zpwrExpandAliasEscape: after eval' {
    LBUFFER="eval ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'eval \ls -la'
}

@test 'zpwrExpandAliasEscape: after nocorrect' {
    LBUFFER="nocorrect ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'nocorrect \ls -la'
}

#==============================================================
# zpwrExpandAliasEscape: various expansion values
#==============================================================

@test 'zpwrExpandAliasEscape: grep with color' {
    LBUFFER="grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\grep --color=auto'
}

@test 'zpwrExpandAliasEscape: mv interactive' {
    LBUFFER="mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\mv -i'
}

@test 'zpwrExpandAliasEscape: cp interactive' {
    LBUFFER="cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -i'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\cp -i'
}

@test 'zpwrExpandAliasEscape: rm interactive' {
    LBUFFER="rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\rm -i'
}

@test 'zpwrExpandAliasEscape: diff with color' {
    LBUFFER="diff"
    ZPWR_VARS[lastword_lbuffer]=diff
    ZPWR_VARS[EXPANDED]='diff --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\diff --color=auto'
}

@test 'zpwrExpandAliasEscape: wget continue' {
    LBUFFER="wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\wget -c'
}

@test 'zpwrExpandAliasEscape: ssh verbose' {
    LBUFFER="ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ssh -v'
}

@test 'zpwrExpandAliasEscape: rsync with flags' {
    LBUFFER="rsync"
    ZPWR_VARS[lastword_lbuffer]=rsync
    ZPWR_VARS[EXPANDED]='rsync -avz --progress'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\rsync -avz --progress'
}

@test 'zpwrExpandAliasEscape: sed extended regex' {
    LBUFFER="sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\sed -E'
}

@test 'zpwrExpandAliasEscape: find with type' {
    LBUFFER="find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find . -type f'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\find . -type f'
}

#==============================================================
# zpwrExpandAliasEscape: single char aliases
#==============================================================

@test 'zpwrExpandAliasEscape: single char g' {
    LBUFFER="g"
    ZPWR_VARS[lastword_lbuffer]=g
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\git status'
}

@test 'zpwrExpandAliasEscape: single char l' {
    LBUFFER="l"
    ZPWR_VARS[lastword_lbuffer]=l
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ls -la'
}

@test 'zpwrExpandAliasEscape: single char v' {
    LBUFFER="v"
    ZPWR_VARS[lastword_lbuffer]=v
    ZPWR_VARS[EXPANDED]='vim -p'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\vim -p'
}

@test 'zpwrExpandAliasEscape: single char r' {
    LBUFFER="r"
    ZPWR_VARS[lastword_lbuffer]=r
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\ruby -e'
}

@test 'zpwrExpandAliasEscape: single char n' {
    LBUFFER="n"
    ZPWR_VARS[lastword_lbuffer]=n
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\node --inspect'
}

#==============================================================
# zpwrExpandAliasEscape: WAS_EXPANDED flag
#==============================================================

@test 'zpwrExpandAliasEscape: WAS_EXPANDED true on success' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'zpwrExpandAliasEscape: WAS_EXPANDED stays false trailing space' {
    LBUFFER="ls "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'zpwrExpandAliasEscape: WAS_EXPANDED true with leading spaces' {
    LBUFFER="  ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'zpwrExpandAliasEscape: WAS_EXPANDED true after pipe' {
    LBUFFER="cat f | ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

#==============================================================
# zpwrExpandAliasEscape: no expand trailing space
#==============================================================

@test 'zpwrExpandAliasEscape: no expand single trailing space grep' {
    LBUFFER="grep "
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color=auto'
    zpwrExpandAliasEscape || :
    assert "$LBUFFER" same_as 'grep '
}

@test 'zpwrExpandAliasEscape: no expand double trailing space' {
    LBUFFER="ls  "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape || :
    assert "$LBUFFER" same_as 'ls  '
}

#==============================================================
# zpwrExpandAliasEscape: complex chains
#==============================================================

@test 'zpwrExpandAliasEscape: after pipe chain' {
    LBUFFER="ps aux | sort | grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color=auto'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'ps aux | sort | \grep --color=auto'
}

@test 'zpwrExpandAliasEscape: after semicolon chain' {
    LBUFFER="cd /tmp; echo hi; ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cd /tmp; echo hi; \ls -la'
}

@test 'zpwrExpandAliasEscape: after mixed chain' {
    LBUFFER="make && cd build; ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'make && cd build; \ls -la'
}

#==============================================================
# zpwrExpandGetAliasValue: simple one-word aliases
#==============================================================

@test 'zpwrExpandGetAliasValue: simple alias cat' {
    alias __zet_cat01='cat -n'
    ZPWR_VARS[lastword_lbuffer]=__zet_cat01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cat -n'
    unalias __zet_cat01
}

@test 'zpwrExpandGetAliasValue: simple alias echo' {
    alias __zet_echo01='echo -e'
    ZPWR_VARS[lastword_lbuffer]=__zet_echo01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo -e'
    unalias __zet_echo01
}

@test 'zpwrExpandGetAliasValue: simple alias vim' {
    alias __zet_vim01='vim -p'
    ZPWR_VARS[lastword_lbuffer]=__zet_vim01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'vim -p'
    unalias __zet_vim01
}

@test 'zpwrExpandGetAliasValue: simple alias cd' {
    alias __zet_cd01='cd -P'
    ZPWR_VARS[lastword_lbuffer]=__zet_cd01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd -P'
    unalias __zet_cd01
}

#==============================================================
# zpwrExpandGetAliasValue: multi-word aliases
#==============================================================

@test 'zpwrExpandGetAliasValue: two word alias value' {
    alias __zet_tw01='git status'
    ZPWR_VARS[lastword_lbuffer]=__zet_tw01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git status'
    unalias __zet_tw01
}

@test 'zpwrExpandGetAliasValue: three word alias value' {
    alias __zet_tw02='git log --oneline'
    ZPWR_VARS[lastword_lbuffer]=__zet_tw02
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git log --oneline'
    unalias __zet_tw02
}

@test 'zpwrExpandGetAliasValue: four word alias value' {
    alias __zet_fw01='git log --oneline --graph'
    ZPWR_VARS[lastword_lbuffer]=__zet_fw01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git log --oneline --graph'
    unalias __zet_fw01
}

@test 'zpwrExpandGetAliasValue: five word alias value' {
    alias __zet_fv01='docker run --rm -it alpine'
    ZPWR_VARS[lastword_lbuffer]=__zet_fv01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'docker run --rm -it alpine'
    unalias __zet_fv01
}

@test 'zpwrExpandGetAliasValue: six word alias value' {
    alias __zet_sv01='git commit -m "initial commit"'
    ZPWR_VARS[lastword_lbuffer]=__zet_sv01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git commit -m "initial commit"'
    unalias __zet_sv01
}

#==============================================================
# zpwrExpandGetAliasValue: aliases with flags
#==============================================================

@test 'zpwrExpandGetAliasValue: single short flag' {
    alias __zet_fl01='ls -l'
    ZPWR_VARS[lastword_lbuffer]=__zet_fl01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -l'
    unalias __zet_fl01
}

@test 'zpwrExpandGetAliasValue: multiple short flags combined' {
    alias __zet_fl02='ls -lahF'
    ZPWR_VARS[lastword_lbuffer]=__zet_fl02
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -lahF'
    unalias __zet_fl02
}

@test 'zpwrExpandGetAliasValue: long flag' {
    alias __zet_fl03='grep --color=auto'
    ZPWR_VARS[lastword_lbuffer]=__zet_fl03
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'grep --color=auto'
    unalias __zet_fl03
}

@test 'zpwrExpandGetAliasValue: mixed short and long flags' {
    alias __zet_fl04='grep -rn --color=auto --include=*.py'
    ZPWR_VARS[lastword_lbuffer]=__zet_fl04
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'grep -rn --color=auto --include=*.py'
    unalias __zet_fl04
}

@test 'zpwrExpandGetAliasValue: multiple long flags' {
    alias __zet_fl05='git log --oneline --graph --decorate --all'
    ZPWR_VARS[lastword_lbuffer]=__zet_fl05
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git log --oneline --graph --decorate --all'
    unalias __zet_fl05
}

#==============================================================
# zpwrExpandGetAliasValue: aliases with paths
#==============================================================

@test 'zpwrExpandGetAliasValue: absolute path' {
    alias __zet_pa01='cd /usr/local/bin'
    ZPWR_VARS[lastword_lbuffer]=__zet_pa01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd /usr/local/bin'
    unalias __zet_pa01
}

@test 'zpwrExpandGetAliasValue: home tilde path' {
    alias __zet_pa02='cd ~/.config'
    ZPWR_VARS[lastword_lbuffer]=__zet_pa02
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd ~/.config'
    unalias __zet_pa02
}

@test 'zpwrExpandGetAliasValue: relative path with dots' {
    alias __zet_pa03='cd ../../lib'
    ZPWR_VARS[lastword_lbuffer]=__zet_pa03
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd ../../lib'
    unalias __zet_pa03
}

@test 'zpwrExpandGetAliasValue: deep path' {
    alias __zet_pa04='cat /var/log/syslog'
    ZPWR_VARS[lastword_lbuffer]=__zet_pa04
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cat /var/log/syslog'
    unalias __zet_pa04
}

#==============================================================
# zpwrExpandGetAliasValue: aliases with env assignments
#==============================================================

@test 'zpwrExpandGetAliasValue: env var assignment' {
    alias __zet_ev01='FOO=bar baz'
    ZPWR_VARS[lastword_lbuffer]=__zet_ev01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'FOO=bar baz'
    unalias __zet_ev01
}

@test 'zpwrExpandGetAliasValue: multiple env var assignments' {
    alias __zet_ev02='CC=gcc CXX=g++ make'
    ZPWR_VARS[lastword_lbuffer]=__zet_ev02
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'CC=gcc CXX=g++ make'
    unalias __zet_ev02
}

@test 'zpwrExpandGetAliasValue: PATH assignment' {
    alias __zet_ev03='PATH=/usr/local/bin:$PATH cmd'
    ZPWR_VARS[lastword_lbuffer]=__zet_ev03
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'PATH=/usr/local/bin:$PATH cmd'
    unalias __zet_ev03
}

#==============================================================
# zpwrExpandGetAliasValue: aliases with redirections
#==============================================================

@test 'zpwrExpandGetAliasValue: stdout redirect' {
    alias __zet_rd01='echo hello > /tmp/out.txt'
    ZPWR_VARS[lastword_lbuffer]=__zet_rd01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo hello > /tmp/out.txt'
    unalias __zet_rd01
}

@test 'zpwrExpandGetAliasValue: stderr redirect' {
    alias __zet_rd02='cmd 2>/dev/null'
    ZPWR_VARS[lastword_lbuffer]=__zet_rd02
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cmd 2>/dev/null'
    unalias __zet_rd02
}

@test 'zpwrExpandGetAliasValue: append redirect' {
    alias __zet_rd03='echo log >> /tmp/log.txt'
    ZPWR_VARS[lastword_lbuffer]=__zet_rd03
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo log >> /tmp/log.txt'
    unalias __zet_rd03
}

@test 'zpwrExpandGetAliasValue: combined redirects' {
    alias __zet_rd04='cmd > /tmp/out 2>&1'
    ZPWR_VARS[lastword_lbuffer]=__zet_rd04
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cmd > /tmp/out 2>&1'
    unalias __zet_rd04
}

#==============================================================
# zpwrExpandGetAliasValue: aliases with pipes
#==============================================================

@test 'zpwrExpandGetAliasValue: single pipe' {
    alias __zet_pp01='ls -la | less'
    ZPWR_VARS[lastword_lbuffer]=__zet_pp01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -la | less'
    unalias __zet_pp01
}

@test 'zpwrExpandGetAliasValue: double pipe chain' {
    alias __zet_pp02='cat file | grep pattern | wc -l'
    ZPWR_VARS[lastword_lbuffer]=__zet_pp02
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cat file | grep pattern | wc -l'
    unalias __zet_pp02
}

@test 'zpwrExpandGetAliasValue: pipe to sort' {
    alias __zet_pp03='du -sh * | sort -rh'
    ZPWR_VARS[lastword_lbuffer]=__zet_pp03
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'du -sh * | sort -rh'
    unalias __zet_pp03
}

@test 'zpwrExpandGetAliasValue: pipe to head' {
    alias __zet_pp04='history | head -20'
    ZPWR_VARS[lastword_lbuffer]=__zet_pp04
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'history | head -20'
    unalias __zet_pp04
}

#==============================================================
# zpwrExpandGetAliasValue: aliases with semicolons
#==============================================================

@test 'zpwrExpandGetAliasValue: semicolon separated commands' {
    alias __zet_sc01='cd /tmp; ls -la'
    ZPWR_VARS[lastword_lbuffer]=__zet_sc01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cd /tmp; ls -la'
    unalias __zet_sc01
}

@test 'zpwrExpandGetAliasValue: multiple semicolons' {
    alias __zet_sc02='echo start; make; echo done'
    ZPWR_VARS[lastword_lbuffer]=__zet_sc02
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo start; make; echo done'
    unalias __zet_sc02
}

@test 'zpwrExpandGetAliasValue: semicolon with redirect' {
    alias __zet_sc03='make 2>&1; echo done'
    ZPWR_VARS[lastword_lbuffer]=__zet_sc03
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'make 2>&1; echo done'
    unalias __zet_sc03
}

#==============================================================
# zpwrExpandGlobalAliases: various global alias values
#==============================================================

@test 'zpwrExpandGlobalAliases: pipe to grep' {
    galiases[__ZTEST_G01]='| grep'
    LBUFFER="ls __ZTEST_G01"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G01
    assert $LBUFFER same_as 'ls | grep'
    unset 'galiases[__ZTEST_G01]'
}

@test 'zpwrExpandGlobalAliases: pipe to less' {
    galiases[__ZTEST_G02]='| less'
    LBUFFER="cat file __ZTEST_G02"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G02
    assert $LBUFFER same_as 'cat file | less'
    unset 'galiases[__ZTEST_G02]'
}

@test 'zpwrExpandGlobalAliases: pipe to head' {
    galiases[__ZTEST_G03]='| head -n 10'
    LBUFFER="dmesg __ZTEST_G03"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G03
    assert $LBUFFER same_as 'dmesg | head -n 10'
    unset 'galiases[__ZTEST_G03]'
}

@test 'zpwrExpandGlobalAliases: pipe to tail' {
    galiases[__ZTEST_G04]='| tail -n 20'
    LBUFFER="journalctl __ZTEST_G04"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G04
    assert $LBUFFER same_as 'journalctl | tail -n 20'
    unset 'galiases[__ZTEST_G04]'
}

@test 'zpwrExpandGlobalAliases: pipe to sort' {
    galiases[__ZTEST_G05]='| sort -n'
    LBUFFER="du -sh * __ZTEST_G05"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G05
    assert $LBUFFER same_as 'du -sh * | sort -n'
    unset 'galiases[__ZTEST_G05]'
}

@test 'zpwrExpandGlobalAliases: pipe to wc' {
    galiases[__ZTEST_G06]='| wc -l'
    LBUFFER="find . -type f __ZTEST_G06"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G06
    assert $LBUFFER same_as 'find . -type f | wc -l'
    unset 'galiases[__ZTEST_G06]'
}

@test 'zpwrExpandGlobalAliases: pipe to tee' {
    galiases[__ZTEST_G07]='| tee /tmp/output.log'
    LBUFFER="make __ZTEST_G07"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G07
    assert $LBUFFER same_as 'make | tee /tmp/output.log'
    unset 'galiases[__ZTEST_G07]'
}

@test 'zpwrExpandGlobalAliases: pipe to xargs' {
    galiases[__ZTEST_G08]='| xargs rm -f'
    LBUFFER="find /tmp -name *.tmp __ZTEST_G08"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G08
    assert $LBUFFER same_as 'find /tmp -name *.tmp | xargs rm -f'
    unset 'galiases[__ZTEST_G08]'
}

@test 'zpwrExpandGlobalAliases: pipe to awk' {
    galiases[__ZTEST_G09]='| awk "{print \$1}"'
    LBUFFER="ps aux __ZTEST_G09"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G09
    assert $LBUFFER same_as 'ps aux | awk "{print \$1}"'
    unset 'galiases[__ZTEST_G09]'
}

@test 'zpwrExpandGlobalAliases: pipe to sed' {
    galiases[__ZTEST_G10]='| sed "s/foo/bar/g"'
    LBUFFER="cat input.txt __ZTEST_G10"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G10
    assert $LBUFFER same_as 'cat input.txt | sed "s/foo/bar/g"'
    unset 'galiases[__ZTEST_G10]'
}

@test 'zpwrExpandGlobalAliases: redirect to devnull' {
    galiases[__ZTEST_G11]='> /dev/null 2>&1'
    LBUFFER="noisy_cmd __ZTEST_G11"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G11
    assert $LBUFFER same_as 'noisy_cmd > /dev/null 2>&1'
    unset 'galiases[__ZTEST_G11]'
}

@test 'zpwrExpandGlobalAliases: stderr redirect' {
    galiases[__ZTEST_G12]='2>/dev/null'
    LBUFFER="cmd __ZTEST_G12"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G12
    assert $LBUFFER same_as 'cmd 2>/dev/null'
    unset 'galiases[__ZTEST_G12]'
}

@test 'zpwrExpandGlobalAliases: pipe to uniq' {
    galiases[__ZTEST_G13]='| sort | uniq -c'
    LBUFFER="cat words.txt __ZTEST_G13"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G13
    assert $LBUFFER same_as 'cat words.txt | sort | uniq -c'
    unset 'galiases[__ZTEST_G13]'
}

@test 'zpwrExpandGlobalAliases: pipe to cat -n' {
    galiases[__ZTEST_G14]='| cat -n'
    LBUFFER="grep pattern file __ZTEST_G14"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G14
    assert $LBUFFER same_as 'grep pattern file | cat -n'
    unset 'galiases[__ZTEST_G14]'
}

@test 'zpwrExpandGlobalAliases: pipe to tr' {
    galiases[__ZTEST_G15]='| tr "[:lower:]" "[:upper:]"'
    LBUFFER="echo hello __ZTEST_G15"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_G15
    assert $LBUFFER same_as 'echo hello | tr "[:lower:]" "[:upper:]"'
    unset 'galiases[__ZTEST_G15]'
}

#==============================================================
# zpwrExpandGlobalAliases: preceding command variations
#==============================================================

@test 'zpwrExpandGlobalAliases: after simple command' {
    galiases[__ZTEST_PC01]='| grep pattern'
    LBUFFER="ls __ZTEST_PC01"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC01
    assert $LBUFFER same_as 'ls | grep pattern'
    unset 'galiases[__ZTEST_PC01]'
}

@test 'zpwrExpandGlobalAliases: after command with flags' {
    galiases[__ZTEST_PC02]='| head -5'
    LBUFFER="ls -la __ZTEST_PC02"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC02
    assert $LBUFFER same_as 'ls -la | head -5'
    unset 'galiases[__ZTEST_PC02]'
}

@test 'zpwrExpandGlobalAliases: after command with path arg' {
    galiases[__ZTEST_PC03]='| wc -l'
    LBUFFER="find /usr/local __ZTEST_PC03"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC03
    assert $LBUFFER same_as 'find /usr/local | wc -l'
    unset 'galiases[__ZTEST_PC03]'
}

@test 'zpwrExpandGlobalAliases: after piped commands' {
    galiases[__ZTEST_PC04]='| tail -1'
    LBUFFER="ps aux | grep node __ZTEST_PC04"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC04
    assert $LBUFFER same_as 'ps aux | grep node | tail -1'
    unset 'galiases[__ZTEST_PC04]'
}

@test 'zpwrExpandGlobalAliases: after sudo command' {
    galiases[__ZTEST_PC05]='| less'
    LBUFFER="sudo dmesg __ZTEST_PC05"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC05
    assert $LBUFFER same_as 'sudo dmesg | less'
    unset 'galiases[__ZTEST_PC05]'
}

@test 'zpwrExpandGlobalAliases: after semicolon command' {
    galiases[__ZTEST_PC06]='| sort'
    LBUFFER="echo start; ls __ZTEST_PC06"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC06
    assert $LBUFFER same_as 'echo start; ls | sort'
    unset 'galiases[__ZTEST_PC06]'
}

@test 'zpwrExpandGlobalAliases: after && command' {
    galiases[__ZTEST_PC07]='| grep error'
    LBUFFER="make && cat build.log __ZTEST_PC07"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC07
    assert $LBUFFER same_as 'make && cat build.log | grep error'
    unset 'galiases[__ZTEST_PC07]'
}

@test 'zpwrExpandGlobalAliases: after command with env var' {
    galiases[__ZTEST_PC08]='| less'
    LBUFFER="LANG=C ls __ZTEST_PC08"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_PC08
    assert $LBUFFER same_as 'LANG=C ls | less'
    unset 'galiases[__ZTEST_PC08]'
}

#==============================================================
# zpwrExpandGlobalAliases: WAS_EXPANDED flag
#==============================================================

@test 'zpwrExpandGlobalAliases: WAS_EXPANDED true on match' {
    galiases[__ZTEST_WE01]='| grep'
    LBUFFER="ls __ZTEST_WE01"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_WE01
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZTEST_WE01]'
}

@test 'zpwrExpandGlobalAliases: WAS_EXPANDED false when not at end' {
    galiases[__ZTEST_WE02]='| grep'
    LBUFFER="ls __ZTEST_WE02 extra"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_WE02 || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unset 'galiases[__ZTEST_WE02]'
}

@test 'zpwrExpandGlobalAliases: WAS_EXPANDED true simple case' {
    galiases[__ZTEST_WE03]='| wc -l'
    LBUFFER="find . __ZTEST_WE03"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_WE03
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZTEST_WE03]'
}

@test 'zpwrExpandGlobalAliases: WAS_EXPANDED true after pipe chain' {
    galiases[__ZTEST_WE04]='| sort -r'
    LBUFFER="cat f | grep x __ZTEST_WE04"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_WE04
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZTEST_WE04]'
}

#==============================================================
# zpwrExpandGlobalAliases: lastword_lbuffer set correctly
#==============================================================

@test 'zpwrExpandGlobalAliases: lastword_lbuffer set to argument' {
    galiases[__ZTEST_LW01]='| grep'
    LBUFFER="ls __ZTEST_LW01"
    zpwrExpandGlobalAliases __ZTEST_LW01
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZTEST_LW01'
    unset 'galiases[__ZTEST_LW01]'
}

@test 'zpwrExpandGlobalAliases: lastword_lbuffer set regardless of other words' {
    galiases[__ZTEST_LW02]='| head'
    LBUFFER="cat file __ZTEST_LW02"
    zpwrExpandGlobalAliases __ZTEST_LW02
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZTEST_LW02'
    unset 'galiases[__ZTEST_LW02]'
}

@test 'zpwrExpandGlobalAliases: lastword_lbuffer preserved on non-expand' {
    galiases[__ZTEST_LW03]='| tail'
    LBUFFER="ls __ZTEST_LW03 extra"
    zpwrExpandGlobalAliases __ZTEST_LW03 || :
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZTEST_LW03'
    unset 'galiases[__ZTEST_LW03]'
}

#==============================================================
# zpwrExpandGlobalAliases: no expansion when not at end
#==============================================================

@test 'zpwrExpandGlobalAliases: alias word in middle not expanded' {
    galiases[__ZTEST_NE01]='| grep'
    LBUFFER="ls __ZTEST_NE01 foo"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_NE01 || :
    assert $LBUFFER same_as 'ls __ZTEST_NE01 foo'
    unset 'galiases[__ZTEST_NE01]'
}

@test 'zpwrExpandGlobalAliases: alias word at start with following word not expanded' {
    galiases[__ZTEST_NE02]='| less'
    LBUFFER="__ZTEST_NE02 bar"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_NE02 || :
    assert $LBUFFER same_as '__ZTEST_NE02 bar'
    unset 'galiases[__ZTEST_NE02]'
}

@test 'zpwrExpandGlobalAliases: trailing space prevents expansion' {
    galiases[__ZTEST_NE03]='| head'
    LBUFFER="ls __ZTEST_NE03 "
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_NE03 || :
    assert $LBUFFER same_as 'ls __ZTEST_NE03 '
    unset 'galiases[__ZTEST_NE03]'
}

@test 'zpwrExpandGlobalAliases: alias word followed by pipe not expanded' {
    galiases[__ZTEST_NE04]='| wc'
    LBUFFER="ls __ZTEST_NE04 | cat"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZTEST_NE04 || :
    assert $LBUFFER same_as 'ls __ZTEST_NE04 | cat'
    unset 'galiases[__ZTEST_NE04]'
}

#==============================================================
# zpwrExpandAlias: additional edge cases for coverage
#==============================================================

@test 'zpwrExpandAlias: alias with numeric name' {
    LBUFFER="42"
    ZPWR_VARS[lastword_lbuffer]=42
    ZPWR_VARS[EXPANDED]='echo forty-two'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo forty-two'
}

@test 'zpwrExpandAlias: alias name starting with number' {
    LBUFFER="2up"
    ZPWR_VARS[lastword_lbuffer]=2up
    ZPWR_VARS[EXPANDED]='cd ../..'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ../..'
}

@test 'zpwrExpandAlias: expansion with hash character' {
    LBUFFER="mycount"
    ZPWR_VARS[lastword_lbuffer]=mycount
    ZPWR_VARS[EXPANDED]='wc -l # count lines'
    zpwrExpandAlias
    assert $LBUFFER same_as 'wc -l # count lines'
}

@test 'zpwrExpandAlias: expansion with glob star' {
    LBUFFER="allpy"
    ZPWR_VARS[lastword_lbuffer]=allpy
    ZPWR_VARS[EXPANDED]='ls *.py'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls *.py'
}

@test 'zpwrExpandAlias: expansion with question mark glob' {
    LBUFFER="anychar"
    ZPWR_VARS[lastword_lbuffer]=anychar
    ZPWR_VARS[EXPANDED]='ls file?.txt'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls file?.txt'
}

@test 'zpwrExpandAlias: expansion with braces' {
    LBUFFER="mkfiles"
    ZPWR_VARS[lastword_lbuffer]=mkfiles
    ZPWR_VARS[EXPANDED]='touch {a,b,c}.txt'
    zpwrExpandAlias
    assert $LBUFFER same_as 'touch {a,b,c}.txt'
}

@test 'zpwrExpandAlias: expansion with subshell' {
    LBUFFER="mysubsh"
    ZPWR_VARS[lastword_lbuffer]=mysubsh
    ZPWR_VARS[EXPANDED]='echo $(date +%Y)'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo $(date +%Y)'
}

@test 'zpwrExpandAlias: expansion with colon' {
    LBUFFER="myport"
    ZPWR_VARS[lastword_lbuffer]=myport
    ZPWR_VARS[EXPANDED]='curl localhost:8080'
    zpwrExpandAlias
    assert $LBUFFER same_as 'curl localhost:8080'
}

@test 'zpwrExpandAlias: expansion with at sign' {
    LBUFFER="myemail"
    ZPWR_VARS[lastword_lbuffer]=myemail
    ZPWR_VARS[EXPANDED]='echo user@example.com'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo user@example.com'
}

@test 'zpwrExpandAlias: expansion with percent' {
    LBUFFER="mypct"
    ZPWR_VARS[lastword_lbuffer]=mypct
    ZPWR_VARS[EXPANDED]='echo 100%'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo 100%'
}

@test 'zpwrExpandAlias: after pipe with leading space' {
    LBUFFER=" cat f | myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='grep pattern'
    zpwrExpandAlias
    assert $LBUFFER same_as ' cat f | grep pattern'
}

@test 'zpwrExpandAlias: after || with leading space' {
    LBUFFER=" false || myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='echo fallback'
    zpwrExpandAlias
    assert $LBUFFER same_as ' false || echo fallback'
}

@test 'zpwrExpandAlias: value with process substitution' {
    LBUFFER="mydiff"
    ZPWR_VARS[lastword_lbuffer]=mydiff
    ZPWR_VARS[EXPANDED]='diff <(cmd1) <(cmd2)'
    zpwrExpandAlias
    assert $LBUFFER same_as 'diff <(cmd1) <(cmd2)'
}

@test 'zpwrExpandAlias: value with here string' {
    LBUFFER="myhere"
    ZPWR_VARS[lastword_lbuffer]=myhere
    ZPWR_VARS[EXPANDED]='cat <<< "hello"'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat <<< "hello"'
}

@test 'zpwrExpandAlias: value containing newline escaped' {
    LBUFFER="mymulti"
    ZPWR_VARS[lastword_lbuffer]=mymulti
    ZPWR_VARS[EXPANDED]='echo line1; echo line2'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo line1; echo line2'
}

#==============================================================
# zpwrExpandAliasEscape: additional edge cases
#==============================================================

@test 'zpwrExpandAliasEscape: cat with number flags' {
    LBUFFER="cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\cat -n'
}

@test 'zpwrExpandAliasEscape: chmod with numeric mode' {
    LBUFFER="chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\chmod 755'
}

@test 'zpwrExpandAliasEscape: chown with user:group' {
    LBUFFER="chown"
    ZPWR_VARS[lastword_lbuffer]=chown
    ZPWR_VARS[EXPANDED]='chown root:root'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\chown root:root'
}

@test 'zpwrExpandAliasEscape: tar with create flags' {
    LBUFFER="tar"
    ZPWR_VARS[lastword_lbuffer]=tar
    ZPWR_VARS[EXPANDED]='tar -czvf'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\tar -czvf'
}

@test 'zpwrExpandAliasEscape: make with parallel flag' {
    LBUFFER="make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\make -j4'
}

@test 'zpwrExpandAliasEscape: df human readable' {
    LBUFFER="df"
    ZPWR_VARS[lastword_lbuffer]=df
    ZPWR_VARS[EXPANDED]='df -h'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\df -h'
}

@test 'zpwrExpandAliasEscape: du summary human' {
    LBUFFER="du"
    ZPWR_VARS[lastword_lbuffer]=du
    ZPWR_VARS[EXPANDED]='du -sh'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\du -sh'
}

@test 'zpwrExpandAliasEscape: ps full listing' {
    LBUFFER="ps"
    ZPWR_VARS[lastword_lbuffer]=ps
    ZPWR_VARS[EXPANDED]='ps aux'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ps aux'
}

@test 'zpwrExpandAliasEscape: top batch mode' {
    LBUFFER="top"
    ZPWR_VARS[lastword_lbuffer]=top
    ZPWR_VARS[EXPANDED]='top -b -n 1'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\top -b -n 1'
}

@test 'zpwrExpandAliasEscape: ip addr' {
    LBUFFER="ip"
    ZPWR_VARS[lastword_lbuffer]=ip
    ZPWR_VARS[EXPANDED]='ip addr show'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ip addr show'
}

@test 'zpwrExpandAliasEscape: empty LBUFFER no crash' {
    LBUFFER=""
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape || :
    assert "$LBUFFER" same_as ''
}

@test 'zpwrExpandAliasEscape: multiple occurrences replaces last only' {
    LBUFFER="ls; echo ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'ls; echo \ls -la'
}

#==============================================================
# zpwrExpandGetAliasValue: additional edge cases
#==============================================================

@test 'zpwrExpandGetAliasValue: alias with ampersand chain' {
    alias __zet_ac01='make && make install'
    ZPWR_VARS[lastword_lbuffer]=__zet_ac01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'make && make install'
    unalias __zet_ac01
}

@test 'zpwrExpandGetAliasValue: alias with double pipe' {
    alias __zet_dp01='cmd || echo failed'
    ZPWR_VARS[lastword_lbuffer]=__zet_dp01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cmd || echo failed'
    unalias __zet_dp01
}

@test 'zpwrExpandGetAliasValue: alias with tilde expansion' {
    alias __zet_td01='ls ~/Downloads'
    ZPWR_VARS[lastword_lbuffer]=__zet_td01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls ~/Downloads'
    unalias __zet_td01
}

@test 'zpwrExpandGetAliasValue: alias with glob star' {
    alias __zet_gl01='rm -f *.o'
    ZPWR_VARS[lastword_lbuffer]=__zet_gl01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'rm -f *.o'
    unalias __zet_gl01
}

@test 'zpwrExpandGetAliasValue: alias single word command' {
    alias __zet_sw01='htop'
    ZPWR_VARS[lastword_lbuffer]=__zet_sw01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'htop'
    unalias __zet_sw01
}

@test 'zpwrExpandGetAliasValue: alias with numeric arg' {
    alias __zet_na01='head -100'
    ZPWR_VARS[lastword_lbuffer]=__zet_na01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'head -100'
    unalias __zet_na01
}

@test 'zpwrExpandGetAliasValue: alias with equals in value' {
    alias __zet_eq01='git config core.autocrlf=true'
    ZPWR_VARS[lastword_lbuffer]=__zet_eq01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git config core.autocrlf=true'
    unalias __zet_eq01
}

@test 'zpwrExpandGetAliasValue: alias with colon in value' {
    alias __zet_co01='ssh user@host:22'
    ZPWR_VARS[lastword_lbuffer]=__zet_co01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ssh user@host:22'
    unalias __zet_co01
}

@test 'zpwrExpandGetAliasValue: alias with underscore name' {
    alias __zet_un_der_score='echo underscored'
    ZPWR_VARS[lastword_lbuffer]=__zet_un_der_score
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo underscored'
    unalias __zet_un_der_score
}

@test 'zpwrExpandGetAliasValue: alias with hyphen in value' {
    alias __zet_hy01='git cherry-pick'
    ZPWR_VARS[lastword_lbuffer]=__zet_hy01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'git cherry-pick'
    unalias __zet_hy01
}

@test 'zpwrExpandGetAliasValue: alias with input redirect' {
    alias __zet_ir01='sort < /tmp/input.txt'
    ZPWR_VARS[lastword_lbuffer]=__zet_ir01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'sort < /tmp/input.txt'
    unalias __zet_ir01
}

@test 'zpwrExpandGetAliasValue: alias with double quoted value inside' {
    alias __zet_dq01='echo "hello world"'
    ZPWR_VARS[lastword_lbuffer]=__zet_dq01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo "hello world"'
    unalias __zet_dq01
}

#==============================================================
# zpwrExpandGlobalAliases: additional edge cases
#==============================================================

@test 'zpwrExpandGlobalAliases: pipe to cut' {
    galiases[__ZTEST_X01]='| cut -d: -f1'
    LBUFFER="cat /etc/passwd __ZTEST_X01"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X01
    assert $LBUFFER same_as 'cat /etc/passwd | cut -d: -f1'
    unset 'galiases[__ZTEST_X01]'
}

@test 'zpwrExpandGlobalAliases: pipe to rev' {
    galiases[__ZTEST_X02]='| rev'
    LBUFFER="echo hello __ZTEST_X02"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X02
    assert $LBUFFER same_as 'echo hello | rev'
    unset 'galiases[__ZTEST_X02]'
}

@test 'zpwrExpandGlobalAliases: pipe to paste' {
    galiases[__ZTEST_X03]='| paste -sd,'
    LBUFFER="seq 10 __ZTEST_X03"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X03
    assert $LBUFFER same_as 'seq 10 | paste -sd,'
    unset 'galiases[__ZTEST_X03]'
}

@test 'zpwrExpandGlobalAliases: pipe to column' {
    galiases[__ZTEST_X04]='| column -t'
    LBUFFER="mount __ZTEST_X04"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X04
    assert $LBUFFER same_as 'mount | column -t'
    unset 'galiases[__ZTEST_X04]'
}

@test 'zpwrExpandGlobalAliases: pipe to nl' {
    galiases[__ZTEST_X05]='| nl -ba'
    LBUFFER="cat script.sh __ZTEST_X05"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X05
    assert $LBUFFER same_as 'cat script.sh | nl -ba'
    unset 'galiases[__ZTEST_X05]'
}

@test 'zpwrExpandGlobalAliases: redirect append' {
    galiases[__ZTEST_X06]='>> /tmp/log.txt'
    LBUFFER="echo entry __ZTEST_X06"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X06
    assert $LBUFFER same_as 'echo entry >> /tmp/log.txt'
    unset 'galiases[__ZTEST_X06]'
}

@test 'zpwrExpandGlobalAliases: pipe to xargs echo' {
    galiases[__ZTEST_X07]='| xargs echo'
    LBUFFER="find . -name *.txt __ZTEST_X07"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X07
    assert $LBUFFER same_as 'find . -name *.txt | xargs echo'
    unset 'galiases[__ZTEST_X07]'
}

@test 'zpwrExpandGlobalAliases: pipe to tac' {
    galiases[__ZTEST_X08]='| tac'
    LBUFFER="cat file.txt __ZTEST_X08"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X08
    assert $LBUFFER same_as 'cat file.txt | tac'
    unset 'galiases[__ZTEST_X08]'
}

@test 'zpwrExpandGlobalAliases: pipe to fmt' {
    galiases[__ZTEST_X09]='| fmt -w 72'
    LBUFFER="cat readme __ZTEST_X09"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X09
    assert $LBUFFER same_as 'cat readme | fmt -w 72'
    unset 'galiases[__ZTEST_X09]'
}

@test 'zpwrExpandGlobalAliases: pipe to sort reverse' {
    galiases[__ZTEST_X10]='| sort -rn'
    LBUFFER="wc -l * __ZTEST_X10"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_X10
    assert $LBUFFER same_as 'wc -l * | sort -rn'
    unset 'galiases[__ZTEST_X10]'
}

#==============================================================
# zpwrExpandAlias: more leading space + preceding command combos
#==============================================================

@test 'zpwrExpandAlias: two leading spaces then sudo' {
    LBUFFER="  sudo myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='expanded cmd'
    zpwrExpandAlias
    assert $LBUFFER same_as '  sudo expanded cmd'
}

@test 'zpwrExpandAlias: one leading space then pipe' {
    LBUFFER=" cat f | myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='grep foo'
    zpwrExpandAlias
    assert $LBUFFER same_as ' cat f | grep foo'
}

@test 'zpwrExpandAlias: three leading spaces then semicolon' {
    LBUFFER="   ls; myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='pwd -P'
    zpwrExpandAlias
    assert $LBUFFER same_as '   ls; pwd -P'
}

@test 'zpwrExpandAlias: expansion to value with double quotes inside' {
    LBUFFER="gitmsg"
    ZPWR_VARS[lastword_lbuffer]=gitmsg
    ZPWR_VARS[EXPANDED]='git commit -m "wip"'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git commit -m "wip"'
}

@test 'zpwrExpandAlias: expansion to value with single quotes inside' {
    LBUFFER="printhello"
    ZPWR_VARS[lastword_lbuffer]=printhello
    ZPWR_VARS[EXPANDED]="echo 'hello world'"
    zpwrExpandAlias
    assert $LBUFFER same_as "echo 'hello world'"
}

@test 'zpwrExpandAlias: alias word appears as substring of another word' {
    LBUFFER="testing"
    ZPWR_VARS[lastword_lbuffer]=testing
    ZPWR_VARS[EXPANDED]='run tests'
    zpwrExpandAlias
    assert $LBUFFER same_as 'run tests'
}

@test 'zpwrExpandAlias: very short expansion single char' {
    LBUFFER="longaliasname"
    ZPWR_VARS[lastword_lbuffer]=longaliasname
    ZPWR_VARS[EXPANDED]='z'
    zpwrExpandAlias
    assert $LBUFFER same_as 'z'
}

@test 'zpwrExpandAlias: after rlwrap with leading space' {
    LBUFFER=" rlwrap myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='node --repl'
    zpwrExpandAlias
    assert $LBUFFER same_as ' rlwrap node --repl'
}

#==============================================================
# zpwrExpandAliasEscape: more coverage
#==============================================================

@test 'zpwrExpandAliasEscape: awk command' {
    LBUFFER="awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\awk -F,'
}

@test 'zpwrExpandAliasEscape: ping count' {
    LBUFFER="ping"
    ZPWR_VARS[lastword_lbuffer]=ping
    ZPWR_VARS[EXPANDED]='ping -c 4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ping -c 4'
}

@test 'zpwrExpandAliasEscape: curl silent' {
    LBUFFER="curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\curl -sS'
}

@test 'zpwrExpandAliasEscape: python module' {
    LBUFFER="python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python -m venv'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\python -m venv'
}

@test 'zpwrExpandAliasEscape: node eval' {
    LBUFFER="node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node -e'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\node -e'
}

@test 'zpwrExpandAliasEscape: after double ampersand chain' {
    LBUFFER="mkdir dir && cd dir && ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'mkdir dir && cd dir && \ls -la'
}

@test 'zpwrExpandAliasEscape: after double pipe chain' {
    LBUFFER="cmd1 || cmd2 || ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd1 || cmd2 || \ls -la'
}

@test 'zpwrExpandAliasEscape: two char alias name' {
    LBUFFER="ll"
    ZPWR_VARS[lastword_lbuffer]=ll
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ls -la'
}

@test 'zpwrExpandAliasEscape: three char alias name' {
    LBUFFER="gst"
    ZPWR_VARS[lastword_lbuffer]=gst
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\git status'
}

@test 'zpwrExpandAliasEscape: value with multiple spaces' {
    LBUFFER="myls"
    ZPWR_VARS[lastword_lbuffer]=myls
    ZPWR_VARS[EXPANDED]='ls -l -a -h'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\ls -l -a -h'
}

#==============================================================
# zpwrExpandGetAliasValue: more coverage
#==============================================================

@test 'zpwrExpandGetAliasValue: alias with background operator' {
    alias __zet_bg01='sleep 60 &'
    ZPWR_VARS[lastword_lbuffer]=__zet_bg01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'sleep 60 &'
    unalias __zet_bg01
}

@test 'zpwrExpandGetAliasValue: alias with subshell' {
    alias __zet_ss01='(cd /tmp && ls)'
    ZPWR_VARS[lastword_lbuffer]=__zet_ss01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as '(cd /tmp && ls)'
    unalias __zet_ss01
}

@test 'zpwrExpandGetAliasValue: alias with command substitution' {
    alias __zet_cs01='echo $(whoami)'
    ZPWR_VARS[lastword_lbuffer]=__zet_cs01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo $(whoami)'
    unalias __zet_cs01
}

@test 'zpwrExpandGetAliasValue: alias with curly braces' {
    alias __zet_cb01='echo ${HOME}'
    ZPWR_VARS[lastword_lbuffer]=__zet_cb01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo ${HOME}'
    unalias __zet_cb01
}

@test 'zpwrExpandGetAliasValue: alias with asterisk glob' {
    alias __zet_ag01='ls -d */'
    ZPWR_VARS[lastword_lbuffer]=__zet_ag01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -d */'
    unalias __zet_ag01
}

@test 'zpwrExpandGetAliasValue: alias with hash comment' {
    alias __zet_hc01='true # noop'
    ZPWR_VARS[lastword_lbuffer]=__zet_hc01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'true # noop'
    unalias __zet_hc01
}

@test 'zpwrExpandGetAliasValue: alias with here-string' {
    alias __zet_hs01='cat <<< hello'
    ZPWR_VARS[lastword_lbuffer]=__zet_hs01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cat <<< hello'
    unalias __zet_hs01
}

@test 'zpwrExpandGetAliasValue: alias with negation' {
    alias __zet_ng01='! true'
    ZPWR_VARS[lastword_lbuffer]=__zet_ng01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as '! true'
    unalias __zet_ng01
}

#==============================================================
# zpwrExpandGlobalAliases: more coverage
#==============================================================

@test 'zpwrExpandGlobalAliases: pipe to grep -v' {
    galiases[__ZTEST_Y01]='| grep -v pattern'
    LBUFFER="ps aux __ZTEST_Y01"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y01
    assert $LBUFFER same_as 'ps aux | grep -v pattern'
    unset 'galiases[__ZTEST_Y01]'
}

@test 'zpwrExpandGlobalAliases: pipe to head -1' {
    galiases[__ZTEST_Y02]='| head -1'
    LBUFFER="ls __ZTEST_Y02"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y02
    assert $LBUFFER same_as 'ls | head -1'
    unset 'galiases[__ZTEST_Y02]'
}

@test 'zpwrExpandGlobalAliases: pipe to tail -f' {
    galiases[__ZTEST_Y03]='| tail -f'
    LBUFFER="cmd __ZTEST_Y03"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y03
    assert $LBUFFER same_as 'cmd | tail -f'
    unset 'galiases[__ZTEST_Y03]'
}

@test 'zpwrExpandGlobalAliases: pipe to sort unique' {
    galiases[__ZTEST_Y04]='| sort -u'
    LBUFFER="cat words __ZTEST_Y04"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y04
    assert $LBUFFER same_as 'cat words | sort -u'
    unset 'galiases[__ZTEST_Y04]'
}

@test 'zpwrExpandGlobalAliases: pipe to wc -w' {
    galiases[__ZTEST_Y05]='| wc -w'
    LBUFFER="cat essay.txt __ZTEST_Y05"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y05
    assert $LBUFFER same_as 'cat essay.txt | wc -w'
    unset 'galiases[__ZTEST_Y05]'
}

@test 'zpwrExpandGlobalAliases: redirect to file' {
    galiases[__ZTEST_Y06]='> output.txt'
    LBUFFER="echo result __ZTEST_Y06"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y06
    assert $LBUFFER same_as 'echo result > output.txt'
    unset 'galiases[__ZTEST_Y06]'
}

@test 'zpwrExpandGlobalAliases: pipe to uniq only' {
    galiases[__ZTEST_Y07]='| uniq'
    LBUFFER="sort file __ZTEST_Y07"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y07
    assert $LBUFFER same_as 'sort file | uniq'
    unset 'galiases[__ZTEST_Y07]'
}

@test 'zpwrExpandGlobalAliases: pipe to grep -c' {
    galiases[__ZTEST_Y08]='| grep -c pattern'
    LBUFFER="cat log __ZTEST_Y08"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y08
    assert $LBUFFER same_as 'cat log | grep -c pattern'
    unset 'galiases[__ZTEST_Y08]'
}

@test 'zpwrExpandGlobalAliases: only alias word in LBUFFER' {
    galiases[__ZTEST_Y09]='| less'
    LBUFFER="__ZTEST_Y09"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y09
    assert $LBUFFER same_as '| less'
    unset 'galiases[__ZTEST_Y09]'
}

@test 'zpwrExpandGlobalAliases: with leading spaces' {
    galiases[__ZTEST_Y10]='| grep x'
    LBUFFER="  ls __ZTEST_Y10"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y10
    assert $LBUFFER same_as '  ls | grep x'
    unset 'galiases[__ZTEST_Y10]'
}

@test 'zpwrExpandGlobalAliases: after semicolon then alias' {
    galiases[__ZTEST_Y11]='| sort'
    LBUFFER="echo hi; ls __ZTEST_Y11"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y11
    assert $LBUFFER same_as 'echo hi; ls | sort'
    unset 'galiases[__ZTEST_Y11]'
}

@test 'zpwrExpandGlobalAliases: after && then alias' {
    galiases[__ZTEST_Y12]='| head'
    LBUFFER="make && cat log __ZTEST_Y12"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y12
    assert $LBUFFER same_as 'make && cat log | head'
    unset 'galiases[__ZTEST_Y12]'
}

@test 'zpwrExpandGlobalAliases: pipe to grep -i case insensitive' {
    galiases[__ZTEST_Y13]='| grep -i error'
    LBUFFER="cat log.txt __ZTEST_Y13"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y13
    assert $LBUFFER same_as 'cat log.txt | grep -i error'
    unset 'galiases[__ZTEST_Y13]'
}

@test 'zpwrExpandGlobalAliases: pipe to wc -c byte count' {
    galiases[__ZTEST_Y14]='| wc -c'
    LBUFFER="cat binary __ZTEST_Y14"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZTEST_Y14
    assert $LBUFFER same_as 'cat binary | wc -c'
    unset 'galiases[__ZTEST_Y14]'
}

@test 'zpwrExpandAlias: expansion with backslash in value' {
    LBUFFER="myesc"
    ZPWR_VARS[lastword_lbuffer]=myesc
    ZPWR_VARS[EXPANDED]='echo \\n'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo \\n'
}

@test 'zpwrExpandAlias: alias after || with three leading spaces' {
    LBUFFER="   cmd1 || myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='fallback cmd'
    zpwrExpandAlias
    assert $LBUFFER same_as '   cmd1 || fallback cmd'
}

@test 'zpwrExpandAliasEscape: ruby with verbose' {
    LBUFFER="ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -w'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\ruby -w'
}

@test 'zpwrExpandGetAliasValue: alias with triple pipe chain' {
    alias __zet_tp01='cmd1 | cmd2 | cmd3 | cmd4'
    ZPWR_VARS[lastword_lbuffer]=__zet_tp01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cmd1 | cmd2 | cmd3 | cmd4'
    unalias __zet_tp01
}
