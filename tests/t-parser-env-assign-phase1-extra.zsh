#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: env -u / assignments / phase-1 keywords — command-position tails (live parser).
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

    function _assert_tail_str() {
        zpwrExpandParseWords "$1"
        zpwrExpandRegexMatchOnCommandPosition
        assert $state equals 0
        assert "$ZPWR_EXPAND_PRE_EXPAND" same_as "$2"
    }

    function _assert_tail_git() {
        _assert_tail_str "$1" 'git'
    }
}

#==============================================================
# env -u / inline env / trace
#==============================================================

@test 'ea1: env -u LC_ALL git' {
    _assert_tail_git 'env -u LC_ALL git'
}

@test 'ea1: nice env -u VAR git' {
    _assert_tail_git 'nice env -u VAR git'
}

@test 'ea1: sudo nice -n 5 env -u A -u B git' {
    _assert_tail_git 'sudo nice -n 5 env -u A -u B git'
}

@test 'ea1: env GIT_TRACE=1 git' {
    _assert_tail_git 'env GIT_TRACE=1 git'
}

@test 'ea1: FOO=bar env git' {
    _assert_tail_git 'FOO=bar env git'
}

@test 'ea1: VAR=1 VAR2=2 env git' {
    _assert_tail_git 'VAR=1 VAR2=2 env git'
}

@test 'ea1: doas -u x env git' {
    _assert_tail_git 'doas -u x env git'
}

@test 'ea1: torify env -u http_proxy git' {
    _assert_tail_git 'torify env -u http_proxy git'
}

#==============================================================
# env -S (GNU) and paths
#==============================================================

@test 'ea1: env -S "FOO=1" git' {
    _assert_tail_git 'env -S "FOO=1" git'
}

@test 'ea1: /usr/bin/env git' {
    _assert_tail_str '/usr/bin/env git' '/usr/bin/env git'
}

#==============================================================
# env --chdir (tail until stripped)
#==============================================================

@test 'ea1: env --chdir=/repo git' {
    _assert_tail_str 'env --chdir=/repo git' '--chdir=/repo git'
}

@test 'ea1: sudo env --chdir=/x git' {
    _assert_tail_str 'sudo env --chdir=/x git' '--chdir=/x git'
}

@test 'ea1: stdbuf -oL env --chdir=/d git' {
    _assert_tail_str 'stdbuf -oL env --chdir=/d git' '--chdir=/d git'
}

#==============================================================
# phase-1: time / command / noglob / nocorrect
#==============================================================

@test 'ea1: time -p git status' {
    _assert_tail_str 'time -p git status' 'git status'
}

@test 'ea1: command -p git' {
    _assert_tail_git 'command -p git'
}

@test 'ea1: builtin command git' {
    _assert_tail_git 'builtin command git'
}

@test 'ea1: noglob git status' {
    _assert_tail_str 'noglob git status' 'git status'
}

@test 'ea1: nocorrect git pull' {
    _assert_tail_str 'nocorrect git pull' 'git pull'
}

@test 'ea1: exec git' {
    _assert_tail_git 'exec git'
}

@test 'ea1: coproc git' {
    _assert_tail_git 'coproc git'
}

#==============================================================
# command -v (not command git)
#==============================================================

@test 'ea1: command -v git' {
    _assert_tail_str 'command -v git' '-v git'
}

#==============================================================
# Pipelines — tail is rhs
#==============================================================

@test 'ea1: curl -fsSL https://x | bash' {
    _assert_tail_str 'curl -fsSL https://x | bash' 'bash'
}

@test 'ea1: wget -qO- u | sh' {
    _assert_tail_str 'wget -qO- u | sh' 'sh'
}

#==============================================================
# Deep stacks toward git
#==============================================================

@test 'ea1: timeout 9 ionice -c1 env -u X git' {
    _assert_tail_git 'timeout 9 ionice -c1 env -u X git'
}

@test 'ea1: flock /lk prlimit --rss=unlimited env git' {
    _assert_tail_git 'flock /lk prlimit --rss=unlimited env git'
}

@test 'ea1: unshare --fork env -i git' {
    _assert_tail_git 'unshare --fork env -i git'
}

@test 'ea1: setpriv --nnp env git' {
    _assert_tail_git 'setpriv --nnp env git'
}

@test 'ea1: runuser -u u -- env -u HOME git' {
    _assert_tail_git 'runuser -u u -- env -u HOME git'
}

@test 'ea1: bwrap --dev-bind /dev /dev env git' {
    _assert_tail_git 'bwrap --dev-bind /dev /dev env git'
}

@test 'ea1: systemd-run --scope env git' {
    _assert_tail_git 'systemd-run --scope env git'
}

@test 'ea1: eatmydata fakeroot env git' {
    _assert_tail_git 'eatmydata fakeroot env git'
}

#==============================================================
# Misc preserved tails
#==============================================================

@test 'ea1: ssh -T git@github.com' {
    _assert_tail_str 'ssh -T git@github.com' 'ssh -T git@github.com'
}

@test 'ea1: make -C /src git' {
    _assert_tail_str 'make -C /src git' 'make -C /src git'
}

@test 'ea1: cmake --build . --target git' {
    _assert_tail_str 'cmake --build . --target git' 'cmake --build . --target git'
}

@test 'ea1: tar xzf -C /tmp f.tgz' {
    _assert_tail_str 'tar xzf -C /tmp f.tgz' 'tar xzf -C /tmp f.tgz'
}

#==============================================================
# env -u stacks and chroot-style wrappers
#==============================================================

@test 'ea1: env -u A -u B -u C git' {
    _assert_tail_git 'env -u A -u B -u C git'
}

@test 'ea1: sudo -E env -u PATH git' {
    _assert_tail_git 'sudo -E env -u PATH git'
}

@test 'ea1: chpst -u n env git' {
    _assert_tail_git 'chpst -u n env git'
}

@test 'ea1: chroot /x env git' {
    _assert_tail_git 'chroot /x env git'
}

@test 'ea1: nsenter -t 1 -m env git' {
    _assert_tail_git 'nsenter -t 1 -m env git'
}

@test 'ea1: valgrind --quiet env git' {
    _assert_tail_git 'valgrind --quiet env git'
}

@test 'ea1: fakechroot env git' {
    _assert_tail_git 'fakechroot env git'
}

@test 'ea1: linux32 env git' {
    _assert_tail_git 'linux32 env git'
}

#==============================================================
# Build / throttle wrappers + env
#==============================================================

@test 'ea1: trickle -d 10 env git' {
    _assert_tail_git 'trickle -d 10 env git'
}

@test 'ea1: faketime 2020-01-01 env git' {
    _assert_tail_git "faketime '2020-01-01' env git"
}

@test 'ea1: proot -q qemu git' {
    _assert_tail_git 'proot -q qemu git'
}

@test 'ea1: ccache env git' {
    _assert_tail_git 'ccache env git'
}

@test 'ea1: distcc env git' {
    _assert_tail_git 'distcc env git'
}

#==============================================================
# Idempotency
#==============================================================

@test 'ea1: idempotent env -u X git' {
    zpwrExpandParseWords 'env -u X git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'env -u X git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'ea1: idempotent time -p git status' {
    zpwrExpandParseWords 'time -p git status'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
    zpwrExpandParseWords 'time -p git status'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}
