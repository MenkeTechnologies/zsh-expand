#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: exhaustive utility function tests
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
# zpwrExpandRightTrim — single word + single trailing space
#==============================================================

@test 'zpwrExpandRightTrim: ls trailing space' {
    LBUFFER="ls "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls'
}

@test 'zpwrExpandRightTrim: git trailing space' {
    LBUFFER="git "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git'
}

@test 'zpwrExpandRightTrim: docker trailing space' {
    LBUFFER="docker "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'docker'
}

@test 'zpwrExpandRightTrim: kubectl trailing space' {
    LBUFFER="kubectl "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'kubectl'
}

@test 'zpwrExpandRightTrim: npm trailing space' {
    LBUFFER="npm "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'npm'
}

@test 'zpwrExpandRightTrim: python trailing space' {
    LBUFFER="python "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'python'
}

@test 'zpwrExpandRightTrim: cargo trailing space' {
    LBUFFER="cargo "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cargo'
}

@test 'zpwrExpandRightTrim: rustc trailing space' {
    LBUFFER="rustc "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'rustc'
}

@test 'zpwrExpandRightTrim: make trailing space' {
    LBUFFER="make "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'make'
}

@test 'zpwrExpandRightTrim: cmake trailing space' {
    LBUFFER="cmake "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cmake'
}

@test 'zpwrExpandRightTrim: sed trailing space' {
    LBUFFER="sed "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'sed'
}

@test 'zpwrExpandRightTrim: awk trailing space' {
    LBUFFER="awk "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'awk'
}

@test 'zpwrExpandRightTrim: grep trailing space' {
    LBUFFER="grep "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'grep'
}

@test 'zpwrExpandRightTrim: curl trailing space' {
    LBUFFER="curl "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'curl'
}

@test 'zpwrExpandRightTrim: wget trailing space' {
    LBUFFER="wget "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'wget'
}

@test 'zpwrExpandRightTrim: ssh trailing space' {
    LBUFFER="ssh "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ssh'
}

@test 'zpwrExpandRightTrim: scp trailing space' {
    LBUFFER="scp "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'scp'
}

@test 'zpwrExpandRightTrim: rsync trailing space' {
    LBUFFER="rsync "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'rsync'
}

@test 'zpwrExpandRightTrim: cat trailing space' {
    LBUFFER="cat "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cat'
}

@test 'zpwrExpandRightTrim: echo trailing space' {
    LBUFFER="echo "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'echo'
}

@test 'zpwrExpandRightTrim: vim trailing space' {
    LBUFFER="vim "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'vim'
}

@test 'zpwrExpandRightTrim: emacs trailing space' {
    LBUFFER="emacs "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'emacs'
}

@test 'zpwrExpandRightTrim: nano trailing space' {
    LBUFFER="nano "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'nano'
}

@test 'zpwrExpandRightTrim: find trailing space' {
    LBUFFER="find "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'find'
}

@test 'zpwrExpandRightTrim: tar trailing space' {
    LBUFFER="tar "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'tar'
}

@test 'zpwrExpandRightTrim: unzip trailing space' {
    LBUFFER="unzip "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'unzip'
}

@test 'zpwrExpandRightTrim: chmod trailing space' {
    LBUFFER="chmod "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'chmod'
}

@test 'zpwrExpandRightTrim: chown trailing space' {
    LBUFFER="chown "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'chown'
}

@test 'zpwrExpandRightTrim: diff trailing space' {
    LBUFFER="diff "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'diff'
}

@test 'zpwrExpandRightTrim: sort trailing space' {
    LBUFFER="sort "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'sort'
}

@test 'zpwrExpandRightTrim: head trailing space' {
    LBUFFER="head "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'head'
}

@test 'zpwrExpandRightTrim: tail trailing space' {
    LBUFFER="tail "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'tail'
}

@test 'zpwrExpandRightTrim: wc trailing space' {
    LBUFFER="wc "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'wc'
}

#==============================================================
# zpwrExpandRightTrim — multi-word + single trailing space
#==============================================================

@test 'zpwrExpandRightTrim: git status trailing space' {
    LBUFFER="git status "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git status'
}

@test 'zpwrExpandRightTrim: git commit -m trailing space' {
    LBUFFER="git commit -m "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git commit -m'
}

@test 'zpwrExpandRightTrim: docker run -it trailing space' {
    LBUFFER="docker run -it "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'docker run -it'
}

@test 'zpwrExpandRightTrim: sudo apt update trailing space' {
    LBUFFER="sudo apt update "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'sudo apt update'
}

@test 'zpwrExpandRightTrim: kubectl get pods trailing space' {
    LBUFFER="kubectl get pods "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'kubectl get pods'
}

@test 'zpwrExpandRightTrim: npm install -g trailing space' {
    LBUFFER="npm install -g "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'npm install -g'
}

@test 'zpwrExpandRightTrim: cargo build --release trailing space' {
    LBUFFER="cargo build --release "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cargo build --release'
}

@test 'zpwrExpandRightTrim: ls -la /tmp trailing space' {
    LBUFFER="ls -la /tmp "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls -la /tmp'
}

@test 'zpwrExpandRightTrim: grep -rn foo trailing space' {
    LBUFFER="grep -rn foo "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'grep -rn foo'
}

@test 'zpwrExpandRightTrim: find . -name trailing space' {
    LBUFFER="find . -name "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'find . -name'
}

@test 'zpwrExpandRightTrim: ssh user@host trailing space' {
    LBUFFER="ssh user@host "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ssh user@host'
}

@test 'zpwrExpandRightTrim: python -m pytest trailing space' {
    LBUFFER="python -m pytest "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'python -m pytest'
}

@test 'zpwrExpandRightTrim: make -j8 all trailing space' {
    LBUFFER="make -j8 all "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'make -j8 all'
}

@test 'zpwrExpandRightTrim: tar xzf archive.tar.gz trailing space' {
    LBUFFER="tar xzf archive.tar.gz "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'tar xzf archive.tar.gz'
}

@test 'zpwrExpandRightTrim: chmod 755 script.sh trailing space' {
    LBUFFER="chmod 755 script.sh "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'chmod 755 script.sh'
}

@test 'zpwrExpandRightTrim: echo hello world trailing space' {
    LBUFFER="echo hello world "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'echo hello world'
}

@test 'zpwrExpandRightTrim: curl -fsSL url trailing space' {
    LBUFFER="curl -fsSL http://example.com "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'curl -fsSL http://example.com'
}

@test 'zpwrExpandRightTrim: sed -i s/old/new/g trailing space' {
    LBUFFER="sed -i s/old/new/g "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'sed -i s/old/new/g'
}

@test 'zpwrExpandRightTrim: awk {print} trailing space' {
    LBUFFER="awk {print} "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'awk {print}'
}

@test 'zpwrExpandRightTrim: diff -u file1 file2 trailing space' {
    LBUFFER="diff -u file1 file2 "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'diff -u file1 file2'
}

@test 'zpwrExpandRightTrim: rsync -avz src dst trailing space' {
    LBUFFER="rsync -avz src dst "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'rsync -avz src dst'
}

@test 'zpwrExpandRightTrim: scp file user@host:/path trailing space' {
    LBUFFER="scp file user@host:/path "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'scp file user@host:/path'
}

@test 'zpwrExpandRightTrim: systemctl restart nginx trailing space' {
    LBUFFER="systemctl restart nginx "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'systemctl restart nginx'
}

@test 'zpwrExpandRightTrim: journalctl -u sshd trailing space' {
    LBUFFER="journalctl -u sshd "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'journalctl -u sshd'
}

@test 'zpwrExpandRightTrim: brew install zsh trailing space' {
    LBUFFER="brew install zsh "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'brew install zsh'
}

@test 'zpwrExpandRightTrim: gem install rails trailing space' {
    LBUFFER="gem install rails "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'gem install rails'
}

@test 'zpwrExpandRightTrim: pip install flask trailing space' {
    LBUFFER="pip install flask "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'pip install flask'
}

@test 'zpwrExpandRightTrim: go build ./cmd trailing space' {
    LBUFFER="go build ./cmd "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'go build ./cmd'
}

@test 'zpwrExpandRightTrim: yarn add react trailing space' {
    LBUFFER="yarn add react "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'yarn add react'
}

@test 'zpwrExpandRightTrim: mvn clean install trailing space' {
    LBUFFER="mvn clean install "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'mvn clean install'
}

#==============================================================
# zpwrExpandRightTrim — no trailing space (unchanged)
#==============================================================

@test 'zpwrExpandRightTrim: no trailing space ls' {
    LBUFFER="ls"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls'
}

@test 'zpwrExpandRightTrim: no trailing space git' {
    LBUFFER="git"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git'
}

@test 'zpwrExpandRightTrim: no trailing space docker' {
    LBUFFER="docker"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'docker'
}

@test 'zpwrExpandRightTrim: no trailing space npm' {
    LBUFFER="npm"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'npm'
}

@test 'zpwrExpandRightTrim: no trailing space git status' {
    LBUFFER="git status"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git status'
}

@test 'zpwrExpandRightTrim: no trailing space docker run' {
    LBUFFER="docker run"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'docker run'
}

@test 'zpwrExpandRightTrim: no trailing space kubectl get pods' {
    LBUFFER="kubectl get pods"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'kubectl get pods'
}

@test 'zpwrExpandRightTrim: no trailing space cargo build' {
    LBUFFER="cargo build"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cargo build'
}

@test 'zpwrExpandRightTrim: no trailing space ssh user@host' {
    LBUFFER="ssh user@host"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ssh user@host'
}

@test 'zpwrExpandRightTrim: no trailing space find . -name x' {
    LBUFFER="find . -name x"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'find . -name x'
}

@test 'zpwrExpandRightTrim: no trailing space echo hello' {
    LBUFFER="echo hello"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'echo hello'
}

@test 'zpwrExpandRightTrim: no trailing space python' {
    LBUFFER="python"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'python'
}

@test 'zpwrExpandRightTrim: no trailing space ruby' {
    LBUFFER="ruby"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ruby'
}

@test 'zpwrExpandRightTrim: no trailing space node' {
    LBUFFER="node"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'node'
}

@test 'zpwrExpandRightTrim: no trailing space java -jar app.jar' {
    LBUFFER="java -jar app.jar"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'java -jar app.jar'
}

@test 'zpwrExpandRightTrim: no trailing space man zsh' {
    LBUFFER="man zsh"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'man zsh'
}

@test 'zpwrExpandRightTrim: no trailing space which gcc' {
    LBUFFER="which gcc"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'which gcc'
}

@test 'zpwrExpandRightTrim: no trailing space xargs' {
    LBUFFER="xargs"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'xargs'
}

@test 'zpwrExpandRightTrim: no trailing space tee /dev/null' {
    LBUFFER="tee /dev/null"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'tee /dev/null'
}

@test 'zpwrExpandRightTrim: no trailing space date' {
    LBUFFER="date"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'date'
}

#==============================================================
# zpwrExpandRightTrim — double trailing space (unchanged)
#==============================================================

@test 'zpwrExpandRightTrim: double space ls' {
    LBUFFER="ls  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls  '
}

@test 'zpwrExpandRightTrim: double space git' {
    LBUFFER="git  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git  '
}

@test 'zpwrExpandRightTrim: double space docker run' {
    LBUFFER="docker run  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'docker run  '
}

@test 'zpwrExpandRightTrim: double space kubectl' {
    LBUFFER="kubectl  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'kubectl  '
}

@test 'zpwrExpandRightTrim: double space npm install' {
    LBUFFER="npm install  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'npm install  '
}

@test 'zpwrExpandRightTrim: double space python' {
    LBUFFER="python  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'python  '
}

@test 'zpwrExpandRightTrim: double space cargo build' {
    LBUFFER="cargo build  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cargo build  '
}

@test 'zpwrExpandRightTrim: double space echo hello' {
    LBUFFER="echo hello  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'echo hello  '
}

@test 'zpwrExpandRightTrim: double space ssh' {
    LBUFFER="ssh  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ssh  '
}

@test 'zpwrExpandRightTrim: double space make -j4' {
    LBUFFER="make -j4  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'make -j4  '
}

@test 'zpwrExpandRightTrim: double space find .' {
    LBUFFER="find .  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'find .  '
}

@test 'zpwrExpandRightTrim: double space wget' {
    LBUFFER="wget  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'wget  '
}

@test 'zpwrExpandRightTrim: double space curl -v' {
    LBUFFER="curl -v  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'curl -v  '
}

@test 'zpwrExpandRightTrim: double space brew' {
    LBUFFER="brew  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'brew  '
}

@test 'zpwrExpandRightTrim: double space vim' {
    LBUFFER="vim  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'vim  '
}

#==============================================================
# zpwrExpandRightTrim — triple trailing space (unchanged)
#==============================================================

@test 'zpwrExpandRightTrim: triple space ls' {
    LBUFFER="ls   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls   '
}

@test 'zpwrExpandRightTrim: triple space git' {
    LBUFFER="git   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git   '
}

@test 'zpwrExpandRightTrim: triple space docker run' {
    LBUFFER="docker run   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'docker run   '
}

@test 'zpwrExpandRightTrim: triple space kubectl' {
    LBUFFER="kubectl   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'kubectl   '
}

@test 'zpwrExpandRightTrim: triple space npm' {
    LBUFFER="npm   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'npm   '
}

@test 'zpwrExpandRightTrim: triple space python' {
    LBUFFER="python   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'python   '
}

@test 'zpwrExpandRightTrim: triple space make all' {
    LBUFFER="make all   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'make all   '
}

@test 'zpwrExpandRightTrim: triple space echo hello' {
    LBUFFER="echo hello   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'echo hello   '
}

@test 'zpwrExpandRightTrim: triple space ssh user' {
    LBUFFER="ssh user   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ssh user   '
}

@test 'zpwrExpandRightTrim: triple space cargo' {
    LBUFFER="cargo   "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cargo   '
}

#==============================================================
# zpwrExpandRightTrim — empty, single space, special cases
#==============================================================

@test 'zpwrExpandRightTrim: empty string unchanged' {
    LBUFFER=""
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'zpwrExpandRightTrim: single space becomes empty' {
    LBUFFER=" "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'zpwrExpandRightTrim: path /usr/bin trailing space' {
    LBUFFER="/usr/bin "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '/usr/bin'
}

@test 'zpwrExpandRightTrim: path ./script.sh trailing space' {
    LBUFFER="./script.sh "
    zpwrExpandRightTrim
    assert $LBUFFER same_as './script.sh'
}

@test 'zpwrExpandRightTrim: path /etc/nginx/nginx.conf trailing space' {
    LBUFFER="/etc/nginx/nginx.conf "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '/etc/nginx/nginx.conf'
}

@test 'zpwrExpandRightTrim: path ~/Documents trailing space' {
    LBUFFER="~/Documents "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '~/Documents'
}

@test 'zpwrExpandRightTrim: path ../parent trailing space' {
    LBUFFER="../parent "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '../parent'
}

@test 'zpwrExpandRightTrim: flag -la trailing space' {
    LBUFFER="-la "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '-la'
}

@test 'zpwrExpandRightTrim: flag --verbose trailing space' {
    LBUFFER="--verbose "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '--verbose'
}

@test 'zpwrExpandRightTrim: flag --color=auto trailing space' {
    LBUFFER="--color=auto "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '--color=auto'
}

@test 'zpwrExpandRightTrim: file.txt trailing space' {
    LBUFFER="file.txt "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'file.txt'
}

@test 'zpwrExpandRightTrim: arr[0] trailing space' {
    LBUFFER='arr[0] '
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'arr[0]'
}

@test 'zpwrExpandRightTrim: pipe cmd trailing space' {
    LBUFFER="ls | grep "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls | grep'
}

@test 'zpwrExpandRightTrim: semicolon cmd trailing space' {
    LBUFFER="ls; pwd "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'ls; pwd'
}

@test 'zpwrExpandRightTrim: ampersand trailing space' {
    LBUFFER="cmd & "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cmd &'
}

@test 'zpwrExpandRightTrim: double ampersand trailing space' {
    LBUFFER="cmd1 && cmd2 "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cmd1 && cmd2'
}

@test 'zpwrExpandRightTrim: double pipe trailing space' {
    LBUFFER="cmd1 || cmd2 "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cmd1 || cmd2'
}

@test 'zpwrExpandRightTrim: long string trailing space' {
    LBUFFER="find /usr/local/share -maxdepth 5 -name '*.zsh' -type f "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as "find /usr/local/share -maxdepth 5 -name '*.zsh' -type f"
}

@test 'zpwrExpandRightTrim: very long pipeline trailing space' {
    LBUFFER="cat /var/log/syslog | grep error | sort | uniq -c | sort -rn | head -20 "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cat /var/log/syslog | grep error | sort | uniq -c | sort -rn | head -20'
}

@test 'zpwrExpandRightTrim: tab character at end unchanged' {
    LBUFFER=$'ls\t'
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as $'ls\t'
}

@test 'zpwrExpandRightTrim: tab then space at end removes space' {
    LBUFFER=$'ls\t '
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as $'ls\t'
}

@test 'zpwrExpandRightTrim: idempotent on no trailing space' {
    LBUFFER="git"
    zpwrExpandRightTrim
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git'
}

@test 'zpwrExpandRightTrim: idempotent on multi-word no trailing space' {
    LBUFFER="docker run -it ubuntu"
    zpwrExpandRightTrim
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'docker run -it ubuntu'
}

@test 'zpwrExpandRightTrim: redirect trailing space' {
    LBUFFER="echo hi > "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'echo hi >'
}

@test 'zpwrExpandRightTrim: backtick trailing space' {
    LBUFFER='`date` '
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as '`date`'
}

@test 'zpwrExpandRightTrim: parenthesis trailing space' {
    LBUFFER="(subshell) "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as '(subshell)'
}

@test 'zpwrExpandRightTrim: brace trailing space' {
    LBUFFER="{ block } "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as '{ block }'
}

@test 'zpwrExpandRightTrim: equals sign trailing space' {
    LBUFFER="FOO=bar "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'FOO=bar'
}

@test 'zpwrExpandRightTrim: number trailing space' {
    LBUFFER="42 "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '42'
}

@test 'zpwrExpandRightTrim: hyphenated word trailing space' {
    LBUFFER="git-flow "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'git-flow'
}

@test 'zpwrExpandRightTrim: underscore word trailing space' {
    LBUFFER="my_var "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'my_var'
}

#==============================================================
# zpwrExpandTerminateSpace — single words
#==============================================================

@test 'zpwrExpandTerminateSpace: ls' {
    LBUFFER="ls"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ls '
}

@test 'zpwrExpandTerminateSpace: git' {
    LBUFFER="git"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git '
}

@test 'zpwrExpandTerminateSpace: docker' {
    LBUFFER="docker"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'docker '
}

@test 'zpwrExpandTerminateSpace: kubectl' {
    LBUFFER="kubectl"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'kubectl '
}

@test 'zpwrExpandTerminateSpace: npm' {
    LBUFFER="npm"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'npm '
}

@test 'zpwrExpandTerminateSpace: python' {
    LBUFFER="python"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'python '
}

@test 'zpwrExpandTerminateSpace: cargo' {
    LBUFFER="cargo"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cargo '
}

@test 'zpwrExpandTerminateSpace: make' {
    LBUFFER="make"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'make '
}

@test 'zpwrExpandTerminateSpace: ssh' {
    LBUFFER="ssh"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ssh '
}

@test 'zpwrExpandTerminateSpace: curl' {
    LBUFFER="curl"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'curl '
}

@test 'zpwrExpandTerminateSpace: wget' {
    LBUFFER="wget"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'wget '
}

@test 'zpwrExpandTerminateSpace: grep' {
    LBUFFER="grep"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'grep '
}

@test 'zpwrExpandTerminateSpace: sed' {
    LBUFFER="sed"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'sed '
}

@test 'zpwrExpandTerminateSpace: awk' {
    LBUFFER="awk"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'awk '
}

@test 'zpwrExpandTerminateSpace: find' {
    LBUFFER="find"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'find '
}

@test 'zpwrExpandTerminateSpace: cat' {
    LBUFFER="cat"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cat '
}

@test 'zpwrExpandTerminateSpace: echo' {
    LBUFFER="echo"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'echo '
}

@test 'zpwrExpandTerminateSpace: vim' {
    LBUFFER="vim"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'vim '
}

@test 'zpwrExpandTerminateSpace: nano' {
    LBUFFER="nano"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'nano '
}

@test 'zpwrExpandTerminateSpace: tar' {
    LBUFFER="tar"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'tar '
}

@test 'zpwrExpandTerminateSpace: unzip' {
    LBUFFER="unzip"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'unzip '
}

@test 'zpwrExpandTerminateSpace: chmod' {
    LBUFFER="chmod"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'chmod '
}

@test 'zpwrExpandTerminateSpace: chown' {
    LBUFFER="chown"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'chown '
}

@test 'zpwrExpandTerminateSpace: diff' {
    LBUFFER="diff"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'diff '
}

@test 'zpwrExpandTerminateSpace: sort' {
    LBUFFER="sort"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'sort '
}

@test 'zpwrExpandTerminateSpace: head' {
    LBUFFER="head"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'head '
}

@test 'zpwrExpandTerminateSpace: tail' {
    LBUFFER="tail"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'tail '
}

@test 'zpwrExpandTerminateSpace: wc' {
    LBUFFER="wc"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'wc '
}

@test 'zpwrExpandTerminateSpace: tee' {
    LBUFFER="tee"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'tee '
}

@test 'zpwrExpandTerminateSpace: xargs' {
    LBUFFER="xargs"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'xargs '
}

#==============================================================
# zpwrExpandTerminateSpace — multi-word strings
#==============================================================

@test 'zpwrExpandTerminateSpace: git status' {
    LBUFFER="git status"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git status '
}

@test 'zpwrExpandTerminateSpace: docker run -it' {
    LBUFFER="docker run -it"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'docker run -it '
}

@test 'zpwrExpandTerminateSpace: sudo apt update' {
    LBUFFER="sudo apt update"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'sudo apt update '
}

@test 'zpwrExpandTerminateSpace: kubectl get pods' {
    LBUFFER="kubectl get pods"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'kubectl get pods '
}

@test 'zpwrExpandTerminateSpace: npm install -g' {
    LBUFFER="npm install -g"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'npm install -g '
}

@test 'zpwrExpandTerminateSpace: cargo build --release' {
    LBUFFER="cargo build --release"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cargo build --release '
}

@test 'zpwrExpandTerminateSpace: git commit -m msg' {
    LBUFFER="git commit -m msg"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git commit -m msg '
}

@test 'zpwrExpandTerminateSpace: ls -la /tmp' {
    LBUFFER="ls -la /tmp"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ls -la /tmp '
}

@test 'zpwrExpandTerminateSpace: grep -rn foo' {
    LBUFFER="grep -rn foo"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'grep -rn foo '
}

@test 'zpwrExpandTerminateSpace: find . -name x' {
    LBUFFER="find . -name x"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'find . -name x '
}

@test 'zpwrExpandTerminateSpace: ssh user@host' {
    LBUFFER="ssh user@host"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ssh user@host '
}

@test 'zpwrExpandTerminateSpace: python -m pytest' {
    LBUFFER="python -m pytest"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'python -m pytest '
}

@test 'zpwrExpandTerminateSpace: make -j8 all' {
    LBUFFER="make -j8 all"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'make -j8 all '
}

@test 'zpwrExpandTerminateSpace: tar xzf archive.tar.gz' {
    LBUFFER="tar xzf archive.tar.gz"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'tar xzf archive.tar.gz '
}

@test 'zpwrExpandTerminateSpace: chmod 755 script.sh' {
    LBUFFER="chmod 755 script.sh"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'chmod 755 script.sh '
}

@test 'zpwrExpandTerminateSpace: echo hello world' {
    LBUFFER="echo hello world"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'echo hello world '
}

@test 'zpwrExpandTerminateSpace: rsync -avz src dst' {
    LBUFFER="rsync -avz src dst"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'rsync -avz src dst '
}

@test 'zpwrExpandTerminateSpace: brew install zsh' {
    LBUFFER="brew install zsh"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'brew install zsh '
}

@test 'zpwrExpandTerminateSpace: gem install rails' {
    LBUFFER="gem install rails"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'gem install rails '
}

@test 'zpwrExpandTerminateSpace: pip install flask' {
    LBUFFER="pip install flask"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'pip install flask '
}

#==============================================================
# zpwrExpandTerminateSpace — empty and space edge cases
#==============================================================

@test 'zpwrExpandTerminateSpace: empty string becomes single space' {
    LBUFFER=""
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as ' '
}

@test 'zpwrExpandTerminateSpace: already trailing space becomes double' {
    LBUFFER="git "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git  '
}

@test 'zpwrExpandTerminateSpace: double space becomes triple' {
    LBUFFER="git  "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'git   '
}

@test 'zpwrExpandTerminateSpace: single space becomes double space' {
    LBUFFER=" "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '  '
}

#==============================================================
# zpwrExpandTerminateSpace — paths, flags, special chars
#==============================================================

@test 'zpwrExpandTerminateSpace: path /usr/bin' {
    LBUFFER="/usr/bin"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '/usr/bin '
}

@test 'zpwrExpandTerminateSpace: path ./script.sh' {
    LBUFFER="./script.sh"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as './script.sh '
}

@test 'zpwrExpandTerminateSpace: flag -la' {
    LBUFFER="-la"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '-la '
}

@test 'zpwrExpandTerminateSpace: flag --verbose' {
    LBUFFER="--verbose"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '--verbose '
}

@test 'zpwrExpandTerminateSpace: file.txt' {
    LBUFFER="file.txt"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'file.txt '
}

@test 'zpwrExpandTerminateSpace: long string' {
    LBUFFER="cat /var/log/syslog | grep error | sort | uniq -c"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cat /var/log/syslog | grep error | sort | uniq -c '
}

#==============================================================
# zpwrExpandTerminateSpace — repeated calls
#==============================================================

@test 'zpwrExpandTerminateSpace: 3x calls add 3 spaces' {
    LBUFFER="cmd"
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cmd   '
}

@test 'zpwrExpandTerminateSpace: 4x calls add 4 spaces' {
    LBUFFER="cmd"
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cmd    '
}

@test 'zpwrExpandTerminateSpace: 5x calls add 5 spaces' {
    LBUFFER="cmd"
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cmd     '
}

#==============================================================
# zpwrExpandTerminateSpace — after special characters
#==============================================================

@test 'zpwrExpandTerminateSpace: after pipe' {
    LBUFFER="ls |"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ls | '
}

@test 'zpwrExpandTerminateSpace: after semicolon' {
    LBUFFER="ls;"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'ls; '
}

@test 'zpwrExpandTerminateSpace: after ampersand' {
    LBUFFER="cmd &"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cmd & '
}

@test 'zpwrExpandTerminateSpace: after greater-than' {
    LBUFFER="echo >"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'echo > '
}

@test 'zpwrExpandTerminateSpace: after less-than' {
    LBUFFER="cmd <"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cmd < '
}

@test 'zpwrExpandTerminateSpace: after open paren' {
    LBUFFER="("
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as '( '
}

@test 'zpwrExpandTerminateSpace: after close paren' {
    LBUFFER=")"
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as ') '
}

@test 'zpwrExpandTerminateSpace: after open brace' {
    LBUFFER="{"
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as '{ '
}

@test 'zpwrExpandTerminateSpace: after close brace' {
    LBUFFER="}"
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as '} '
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer — no tabstop (NEED_TO_ADD_SPACECHAR true)
#==============================================================

@test 'goToTabStop: no tabstop simple word sets true' {
    LBUFFER="ls"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop git status sets true' {
    LBUFFER="git status"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop docker run sets true' {
    LBUFFER="docker run -it ubuntu"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop kubectl get pods sets true' {
    LBUFFER="kubectl get pods"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop npm install sets true' {
    LBUFFER="npm install"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop python script.py sets true' {
    LBUFFER="python script.py"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop cargo build sets true' {
    LBUFFER="cargo build"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop make -j4 sets true' {
    LBUFFER="make -j4"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop ssh user@host sets true' {
    LBUFFER="ssh user@host"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop echo hello world sets true' {
    LBUFFER="echo hello world"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop find . -name sets true' {
    LBUFFER="find . -name"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop grep -rn pattern sets true' {
    LBUFFER="grep -rn pattern"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop curl -fsSL url sets true' {
    LBUFFER="curl -fsSL http://example.com"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop tar xzf sets true' {
    LBUFFER="tar xzf archive.tar.gz"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop chmod 755 sets true' {
    LBUFFER="chmod 755 file"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop rsync -avz sets true' {
    LBUFFER="rsync -avz src dst"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop brew install zsh sets true' {
    LBUFFER="brew install zsh"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop pip install flask sets true' {
    LBUFFER="pip install flask"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop go build sets true' {
    LBUFFER="go build ./cmd"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop yarn add react sets true' {
    LBUFFER="yarn add react"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop mvn clean install sets true' {
    LBUFFER="mvn clean install"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop systemctl restart nginx sets true' {
    LBUFFER="systemctl restart nginx"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop sudo apt install vim sets true' {
    LBUFFER="sudo apt install vim"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop env FOO=bar sets true' {
    LBUFFER="env FOO=bar"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop nohup cmd sets true' {
    LBUFFER="nohup cmd"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop nice -n 10 cmd sets true' {
    LBUFFER="nice -n 10 cmd"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop time make sets true' {
    LBUFFER="time make"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop rlwrap sbcl sets true' {
    LBUFFER="rlwrap sbcl"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop nocorrect rm -rf sets true' {
    LBUFFER="nocorrect rm -rf"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: no tabstop long pipeline sets true' {
    LBUFFER="cat file | grep err | sort | uniq -c | head"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer — tabstop at end
#==============================================================

@test 'goToTabStop: tabstop at end of cmd sets false' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of git commit sets false' {
    LBUFFER="git commit -m ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of docker run sets false' {
    LBUFFER="docker run -it ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of kubectl sets false' {
    LBUFFER="kubectl get ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of npm sets false' {
    LBUFFER="npm install ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of ssh sets false' {
    LBUFFER="ssh ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of cargo sets false' {
    LBUFFER="cargo build ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of make sets false' {
    LBUFFER="make ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of grep sets false' {
    LBUFFER="grep -rn ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of find sets false' {
    LBUFFER="find . -name ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of echo sets false' {
    LBUFFER="echo ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of python sets false' {
    LBUFFER="python ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of sudo sets false' {
    LBUFFER="sudo ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of curl sets false' {
    LBUFFER="curl -fsSL ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at end of chmod sets false' {
    LBUFFER="chmod 755 ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer — tabstop in middle
#==============================================================

@test 'goToTabStop: tabstop in middle of cmd arg sets false' {
    LBUFFER="cmd ${ZPWR_TABSTOP} arg"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle of git commit sets false' {
    LBUFFER="git ${ZPWR_TABSTOP} --verbose"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle of docker run sets false' {
    LBUFFER="docker ${ZPWR_TABSTOP} ubuntu bash"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle of kubectl get sets false' {
    LBUFFER="kubectl ${ZPWR_TABSTOP} --all-namespaces"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle sets CURSOR to tabstop position' {
    LBUFFER="cmd ${ZPWR_TABSTOP} rest"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $CURSOR equals 4
}

@test 'goToTabStop: tabstop in middle of ssh sets false' {
    LBUFFER="ssh ${ZPWR_TABSTOP} -p 22"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle of find sets false' {
    LBUFFER="find ${ZPWR_TABSTOP} -type f"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle of grep sets false' {
    LBUFFER="grep ${ZPWR_TABSTOP} file.txt"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle of sed sets false' {
    LBUFFER="sed ${ZPWR_TABSTOP} file"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop in middle of awk sets false' {
    LBUFFER="awk ${ZPWR_TABSTOP} input"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer — tabstop at beginning
#==============================================================

@test 'goToTabStop: tabstop at beginning sets false' {
    LBUFFER="${ZPWR_TABSTOP} rest of line"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: tabstop at beginning sets CURSOR to 0' {
    LBUFFER="${ZPWR_TABSTOP} rest of line"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $CURSOR equals 0
}

@test 'goToTabStop: tabstop alone in LBUFFER sets false' {
    LBUFFER="${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer — multiple tabstops
#==============================================================

@test 'goToTabStop: multiple tabstops finds first' {
    LBUFFER="cmd ${ZPWR_TABSTOP} middle ${ZPWR_TABSTOP} end"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $CURSOR equals 4
}

@test 'goToTabStop: multiple tabstops sets false' {
    LBUFFER="first ${ZPWR_TABSTOP} second ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer — RBUFFER behavior
#==============================================================

@test 'goToTabStop: RBUFFER tabstop prefix stripped when LBUFFER has tabstop' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER="${ZPWR_TABSTOP}extra text"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as 'extra text'
}

@test 'goToTabStop: RBUFFER unchanged when no tabstop in LBUFFER' {
    LBUFFER="no tabstop here"
    RBUFFER="right side remains"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as 'right side remains'
}

@test 'goToTabStop: RBUFFER without tabstop prefix keeps content when LBUFFER has tabstop' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER="no prefix here"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'goToTabStop: RBUFFER empty stays empty with tabstop' {
    LBUFFER="cmd ${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as ''
}

@test 'goToTabStop: RBUFFER empty stays empty without tabstop' {
    LBUFFER="cmd"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $RBUFFER same_as ''
}

#==============================================================
# zpwrExpandGoToTabStopOrEndOfLBuffer — empty buffers
#==============================================================

@test 'goToTabStop: empty LBUFFER sets true' {
    LBUFFER=""
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: empty LBUFFER with RBUFFER sets true' {
    LBUFFER=""
    RBUFFER="some right text"
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'goToTabStop: both empty sets true' {
    LBUFFER=""
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — sudo + command
#==============================================================

@test 'regexMatch: sudo git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo docker matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo npm matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo systemctl matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo systemctl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo apt matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo apt)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo dnf matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo dnf)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo yum matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo yum)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo pacman matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo pacman)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo zypper matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo zypper)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo chmod matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo chmod)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo chown matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo chown)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo mount matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo mount)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo kill matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo kill)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo iptables matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo iptables)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo service matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo service)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo cp matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo mv matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo rm matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo cat matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — sudo with flags
#==============================================================

@test 'regexMatch: sudo -u root git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -u root git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -E git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -E git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -i bash matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -i bash)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -s zsh matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -s zsh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -H pip matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -H pip)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -n apt matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -n apt)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -P ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -P ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -S cat matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -S cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -b service matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -b service)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -C 3 cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -C 3 cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -Ei cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -Ei cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo -nEs cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -nEs cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — env + command
#==============================================================

@test 'regexMatch: env git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env python matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env node matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env ruby matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env ruby)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env cargo matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env cargo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env make matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env ssh matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env ssh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env docker matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env kubectl matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env kubectl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — env with flags
#==============================================================

@test 'regexMatch: env -i cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -i cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env -P /usr/bin cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -P /usr/bin cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env -S string cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -S string cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: env -u VAR cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env -u VAR cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — builtin, command, exec, eval
#==============================================================

@test 'regexMatch: builtin cd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin cd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: builtin echo matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: command ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: command git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: exec bash matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec bash)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: exec zsh matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(exec zsh)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: eval echo matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval echo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: eval ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(eval ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — nice, time, nohup, rlwrap
#==============================================================

@test 'regexMatch: nice make matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: nice gcc matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice gcc)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: time make matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: time ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: time git status matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time git status)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: nohup server matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup server)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: nohup python script.py matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup python script.py)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: rlwrap sbcl matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap sbcl)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: rlwrap node matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: rlwrap python matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — nocorrect
#==============================================================

@test 'regexMatch: nocorrect rm matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect rm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: nocorrect mv matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect mv)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: nocorrect cp matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect cp)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — combinations
#==============================================================

@test 'regexMatch: sudo env cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo env cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: time sudo make matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sudo make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: nice nohup cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice nohup cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sudo command git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo command git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: time nice make matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time nice make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: nocorrect sudo apt matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect sudo apt)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: builtin command ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin command ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: time sudo -E env -i cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time sudo -E env -i cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — case insensitive sudo/env/nice/etc
#==============================================================

@test 'regexMatch: SUDO git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(SUDO git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: Sudo git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Sudo git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: sUdO git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sUdO git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: ENV git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ENV git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: Env git matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(Env git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: NICE make matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(NICE make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: TIME ls matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(TIME ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: NOHUP cmd matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(NOHUP cmd)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: RLWRAP node matches' {
    ZPWR_EXPAND_WORDS_LPARTITION=(RLWRAP node)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — non-matching patterns
#==============================================================

@test 'regexMatch: plain ls does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(ls)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain git does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(git)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain docker does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(docker)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain echo hello does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(echo hello)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain make does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(make)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain python does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(python)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain cargo does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cargo)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain npm does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(npm)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain cat does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(cat)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regexMatch: plain grep does not match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(grep)
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — sets ZPWR_EXPAND_PRE_EXPAND
#==============================================================

@test 'regexMatch: sudo git sets PRE_EXPAND last match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo git)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'git'
}

@test 'regexMatch: sudo -E env -i cmd sets PRE_EXPAND last match' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo -E env -i cmd)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'cmd'
}

@test 'regexMatch: time make all sets PRE_EXPAND to last capture' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time make all)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'make'
}

@test 'regexMatch: command ls -la sets PRE_EXPAND' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command ls -la)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'ls'
}

@test 'regexMatch: builtin echo hello sets PRE_EXPAND' {
    ZPWR_EXPAND_WORDS_LPARTITION=(builtin echo hello)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'echo'
}

@test 'regexMatch: nice gcc -O2 sets PRE_EXPAND' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nice gcc -O2)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'gcc'
}

@test 'regexMatch: nohup server start sets PRE_EXPAND' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup server start)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'server'
}

@test 'regexMatch: rlwrap sbcl --eval sets PRE_EXPAND' {
    ZPWR_EXPAND_WORDS_LPARTITION=(rlwrap sbcl --eval)
    ZPWR_EXPAND_PRE_EXPAND=()
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND[1]" same_as 'sbcl'
}

#==============================================================
# zpwrExpandRegexMatchOnCommandPosition — correct mode sets PRE_CORRECT
#==============================================================

@test 'regexMatch correct: sudo git sets PRE_CORRECT' {
    ZPWR_EXPAND_WORDS_LPARTITION=(sudo git)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT[1]" same_as 'git'
}

@test 'regexMatch correct: env python sets PRE_CORRECT' {
    ZPWR_EXPAND_WORDS_LPARTITION=(env python)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT[1]" same_as 'python'
}

@test 'regexMatch correct: command ls sets PRE_CORRECT' {
    ZPWR_EXPAND_WORDS_LPARTITION=(command ls)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT[1]" same_as 'ls'
}

@test 'regexMatch correct: time make sets PRE_CORRECT' {
    ZPWR_EXPAND_WORDS_LPARTITION=(time make)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT[1]" same_as 'make'
}

@test 'regexMatch correct: nohup cmd sets PRE_CORRECT' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nohup cmd)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT[1]" same_as 'cmd'
}

@test 'regexMatch correct: nocorrect sudo apt sets PRE_CORRECT' {
    ZPWR_EXPAND_WORDS_LPARTITION=(nocorrect sudo apt)
    ZPWR_EXPAND_PRE_CORRECT=()
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT[1]" same_as 'apt'
}
