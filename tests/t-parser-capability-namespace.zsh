#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: Capability, namespace, resource-limit, and deep sudo/env stacks.
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
    ZPWR_EXPAND_SUFFIX=false
    ZPWR_TRACE=false

    function _assert_tail_git() {
        zpwrExpandParseWords "$1"
        zpwrExpandRegexMatchOnCommandPosition
        assert $state equals 0
        assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    }

    function _assert_tail_str() {
        zpwrExpandParseWords "$1"
        zpwrExpandRegexMatchOnCommandPosition
        assert $state equals 0
        assert "$ZPWR_EXPAND_PRE_EXPAND" same_as "$2"
    }
}

#==============================================================
# sudo + env (deep)
#==============================================================

@test 'cap: sudo -kE -u root env -0iv -C /tmp git' {
    _assert_tail_git 'sudo -kE -u root env -0iv -C /tmp git'
}

@test 'cap: sudo -ABbE -g wheel -h host -p pw -R /r -D /d -T 60 -U u -u admin git' {
    _assert_tail_git 'sudo -ABbE -g wheel -h host -p pw -R /r -D /d -T 60 -U u -u admin git'
}

@test 'cap: sudo -kKi -u nobody env -v -C /var CC=gcc git' {
    _assert_tail_git 'sudo -kKi -u nobody env -v -C /var CC=gcc git'
}

@test 'cap: env -a argv0 -0iv -C /tmp VAR=a git' {
    _assert_tail_git 'env -a argv0 -0iv -C /tmp VAR=a git'
}

@test 'cap: env -i sudo -E git' {
    _assert_tail_git 'env -i sudo -E git'
}

@test 'cap: sudo -E env PATH=/usr/bin git' {
    _assert_tail_git 'sudo -E env PATH=/usr/bin git'
}

@test 'cap: env -u DISPLAY -u TERM git' {
    _assert_tail_git 'env -u DISPLAY -u TERM git'
}

@test 'cap: doas -Lns -u ops env FOO=bar git' {
    _assert_tail_git 'doas -Lns -u ops env FOO=bar git'
}

#==============================================================
# sudo flag clusters
#==============================================================

@test 'cap: sudo -s -H git' {
    _assert_tail_git 'sudo -s -H git'
}

@test 'cap: sudo -l git' {
    _assert_tail_git 'sudo -l git'
}

@test 'cap: sudo -V git' {
    _assert_tail_git 'sudo -V git'
}

@test 'cap: sudo -n git' {
    _assert_tail_git 'sudo -n git'
}

#==============================================================
# unshare / nsenter / numactl
#==============================================================

@test 'cap: unshare -p --fork --mount-proc git' {
    _assert_tail_git 'unshare -p --fork --mount-proc git'
}

@test 'cap: unshare -cfmnpuUirCT -R /root -w /wd -S 1000 -G 1000 git' {
    _assert_tail_git 'unshare -cfmnpuUirCT -R /root -w /wd -S 1000 -G 1000 git'
}

@test 'cap: unshare unshare -m git' {
    _assert_tail_git 'unshare unshare -m git'
}

@test 'cap: sudo -u root unshare -m git' {
    _assert_tail_git 'sudo -u root unshare -m git'
}

@test 'cap: nsenter -t 1 -m -u -n git' {
    _assert_tail_git 'nsenter -t 1 -m -u -n git'
}

@test 'cap: sudo nsenter -t 1 -m git' {
    _assert_tail_git 'sudo nsenter -t 1 -m git'
}

@test 'cap: nsenter -aceZTwW -t 2 -S 1 -G 1 -N 4 git' {
    _assert_tail_git 'nsenter -aceZTwW -t 2 -S 1 -G 1 -N 4 git'
}

@test 'cap: numactl -absHl -C 0-3 -i all -m 0 -N 0 -p 1 -w 0 -P 1 git' {
    _assert_tail_git 'numactl -absHl -C 0-3 -i all -m 0 -N 0 -p 1 -w 0 -P 1 git'
}

#==============================================================
# prlimit / choom / cpulimit
#==============================================================

@test 'cap: prlimit git' {
    _assert_tail_git 'prlimit git'
}

@test 'cap: prlimit --nofile=1024 -o RES -p 1234 git' {
    _assert_tail_git 'prlimit --nofile=1024 -o RES -p 1234 git'
}

@test 'cap: prlimit --nproc=512 -o COL -p 5678 git' {
    _assert_tail_git 'prlimit --nproc=512 -o COL -p 5678 git'
}

@test 'cap: choom -n -500 git' {
    _assert_tail_git 'choom -n -500 git'
}

@test 'cap: choom -n 500 -- git' {
    _assert_tail_git 'choom -n 500 -- git'
}

@test 'cap: cpulimit -viz -e app -p 1 -l 50 git' {
    _assert_tail_git 'cpulimit -viz -e app -p 1 -l 50 git'
}

@test 'cap: cpulimit -viz -e doom -p 1 -l 1 git' {
    _assert_tail_git 'cpulimit -viz -e doom -p 1 -l 1 git'
}

#==============================================================
# flock / runuser
#==============================================================

@test 'cap: flock -e -c cmd /tmp/l git' {
    _assert_tail_git 'flock -e -c cmd /tmp/l git'
}

@test 'cap: flock -eFnosux -c cmd -w 10 -E 2 /tmp/lk git' {
    _assert_tail_git 'flock -eFnosux -c cmd -w 10 -E 2 /tmp/lk git'
}

@test 'cap: runuser -fmlpPT -c cmd -u deploy git' {
    _assert_tail_git 'runuser -fmlpPT -c cmd -u deploy git'
}

@test 'cap: runuser -fmpPT -c cmd -s /bin/bash -u deploy -w 1,2 git' {
    _assert_tail_git 'runuser -fmpPT -c cmd -s /bin/bash -u deploy -w 1,2 git'
}

#==============================================================
# setpriv / capsh / bwrap (overlap with misc — different combos)
#==============================================================

@test 'cap: setpriv --reuid=1000 --regid=1000 --clear-groups git' {
    _assert_tail_git 'setpriv --reuid=1000 --regid=1000 --clear-groups git'
}

@test 'cap: capsh --drop=cap_net_raw -- git' {
    _assert_tail_git 'capsh --drop=cap_net_raw -- git'
}

@test 'cap: bwrap --ro-bind / / --unshare-net git' {
    _assert_tail_git 'bwrap --ro-bind / / --unshare-net git'
}

#==============================================================
# Cross-wrapper stacks
#==============================================================

@test 'cap: nice -n 10 sudo ionice -c 2 git' {
    _assert_tail_git 'nice -n 10 sudo ionice -c 2 git'
}

@test 'cap: timeout 10 sudo strace -f git' {
    _assert_tail_git 'timeout 10 sudo strace -f git'
}

@test 'cap: sudo nice -n 5 timeout 30 env -i git' {
    _assert_tail_git 'sudo nice -n 5 timeout 30 env -i git'
}

@test 'cap: sudo -kE -u www su root stdbuf -oL git' {
    _assert_tail_git 'sudo -kE -u www su root stdbuf -oL git'
}

@test 'cap: su -l root env -i git' {
    _assert_tail_git 'su -l root env -i git'
}

@test 'cap: sg docker git' {
    _assert_tail_git 'sg docker git'
}

@test 'cap: torify sudo -u nobody git' {
    _assert_tail_git 'torify sudo -u nobody git'
}

@test 'cap: stdbuf -oL strace -f git' {
    _assert_tail_git 'stdbuf -oL strace -f git'
}

@test 'cap: unshare --user git' {
    _assert_tail_git 'unshare --user git'
}

@test 'cap: ltrace -c sudo git' {
    _assert_tail_git 'ltrace -c sudo git'
}

@test 'cap: ionice -c 1 nice -n -5 git' {
    _assert_tail_git 'ionice -c 1 nice -n -5 git'
}

@test 'cap: flock /tmp/x git' {
    _assert_tail_git 'flock /tmp/x git'
}

@test 'cap: nsenter -t 1 -U -m git' {
    _assert_tail_git 'nsenter -t 1 -U -m git'
}

@test 'cap: doas -C /etc/doas.conf -u _www git' {
    _assert_tail_git 'doas -C /etc/doas.conf -u _www git'
}

#==============================================================
# Multi-word tail + idempotency
#==============================================================

@test 'cap: sudo -u root git stash pop' {
    _assert_tail_str 'sudo -u root git stash pop' 'git stash pop'
}

@test 'cap: idempotent sudo -u root git' {
    zpwrExpandParseWords 'sudo -u root git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'sudo -u root git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
