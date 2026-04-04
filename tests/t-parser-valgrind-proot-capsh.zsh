#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: valgrind, capsh, proot, fakechroot, xvfb-run — flags and deep stacks with strace/ltrace/watch.
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
# valgrind
#==============================================================

@test 'vpc: valgrind -q --tool=memcheck --leak-check=full git' {
    _assert_tail_git 'valgrind -q --tool=memcheck --leak-check=full git'
}

@test 'vpc: valgrind --track-origins=yes -- git' {
    _assert_tail_git 'valgrind --track-origins=yes -- git'
}

@test 'vpc: sudo valgrind --quiet git' {
    _assert_tail_git 'sudo valgrind --quiet git'
}

@test 'vpc: eatmydata valgrind --quiet git' {
    _assert_tail_git 'eatmydata valgrind --quiet git'
}

@test 'vpc: nocorrect valgrind git' {
    _assert_tail_git 'nocorrect valgrind git'
}

@test 'vpc: flock /l valgrind git' {
    _assert_tail_git 'flock /l valgrind git'
}

@test 'vpc: cpulimit -l 10 valgrind git' {
    _assert_tail_git 'cpulimit -l 10 valgrind git'
}

@test 'vpc: runuser -u u valgrind git' {
    _assert_tail_git 'runuser -u u valgrind git'
}

@test 'vpc: watch -n 1 valgrind git' {
    _assert_tail_git 'watch -n 1 valgrind git'
}

#==============================================================
# capsh
#==============================================================

@test 'vpc: capsh --print git' {
    _assert_tail_git 'capsh --print git'
}

@test 'vpc: capsh --print -- git' {
    _assert_tail_git 'capsh --print -- git'
}

@test 'vpc: capsh --caps="" -- -c git (tail is -c + cmd)' {
    _assert_tail_str 'capsh --caps="" -- -c git' '-c git'
}

@test 'vpc: bwrap --dev-bind / / capsh --print git' {
    _assert_tail_git 'bwrap --dev-bind / / capsh --print git'
}

@test 'vpc: nsenter -t 1 -m capsh --print git' {
    _assert_tail_git 'nsenter -t 1 -m capsh --print git'
}

@test 'vpc: pkexec --user u capsh --print git' {
    _assert_tail_git 'pkexec --user u capsh --print git'
}

#==============================================================
# proot
#==============================================================

@test 'vpc: proot -R /jail git' {
    _assert_tail_git 'proot -R /jail git'
}

@test 'vpc: proot -b /h:/g git' {
    _assert_tail_git 'proot -b /h:/g git'
}

@test 'vpc: timeout 10 proot -0 git' {
    _assert_tail_git 'timeout 10 proot -0 git'
}

@test 'vpc: setpriv --nnp proot -R /x git' {
    _assert_tail_git 'setpriv --nnp proot -R /x git'
}

@test 'vpc: torify proot git' {
    _assert_tail_git 'torify proot git'
}

@test 'vpc: doas proot -R /r git' {
    _assert_tail_git 'doas proot -R /r git'
}

@test 'vpc: chroot /j proot -R /r git' {
    _assert_tail_git 'chroot /j proot -R /r git'
}

@test 'vpc: unshare -r proot -0 git' {
    _assert_tail_git 'unshare -r proot -0 git'
}

#==============================================================
# fakechroot / xvfb-run
#==============================================================

@test 'vpc: fakechroot -b /usr git' {
    _assert_tail_git 'fakechroot -b /usr git'
}

@test 'vpc: fakechroot -l /lib git' {
    _assert_tail_git 'fakechroot -l /lib git'
}

@test 'vpc: env FOO=bar fakechroot git' {
    _assert_tail_git 'env FOO=bar fakechroot git'
}

@test 'vpc: sem -j 1 fakechroot git' {
    _assert_tail_git 'sem -j 1 fakechroot git'
}

@test 'vpc: xvfb-run -a -s "-screen 0 1024x768x24" git' {
    _assert_tail_git 'xvfb-run -a -s "-screen 0 1024x768x24" git'
}

@test 'vpc: xvfb-run -e /tmp/x.log git' {
    _assert_tail_git 'xvfb-run -e /tmp/x.log git'
}

@test 'vpc: xvfb-run -f 99 git' {
    _assert_tail_git 'xvfb-run -f 99 git'
}

@test 'vpc: nice -n 0 xvfb-run git' {
    _assert_tail_git 'nice -n 0 xvfb-run git'
}

#==============================================================
# strace / ltrace
#==============================================================

@test 'vpc: stdbuf -oL strace -c git' {
    _assert_tail_git 'stdbuf -oL strace -c git'
}

@test 'vpc: strace -f -e trace=network git' {
    _assert_tail_git 'strace -f -e trace=network git'
}

@test 'vpc: strace -o /tmp/s.log -s 2000 git' {
    _assert_tail_git 'strace -o /tmp/s.log -s 2000 git'
}

@test 'vpc: ltrace -e malloc git' {
    _assert_tail_git 'ltrace -e malloc git'
}

@test 'vpc: ltrace -L -l libc git' {
    _assert_tail_git 'ltrace -L -l libc git'
}

@test 'vpc: command -p ltrace git' {
    _assert_tail_git 'command -p ltrace git'
}

#==============================================================
# Multi-word tails, idempotency
#==============================================================

@test 'vpc: valgrind git diff' {
    _assert_tail_str 'valgrind git diff' 'git diff'
}

@test 'vpc: proot git log -1' {
    _assert_tail_str 'proot git log -1' 'git log -1'
}

@test 'vpc: fakechroot git show --stat' {
    _assert_tail_str 'fakechroot git show --stat' 'git show --stat'
}

@test 'vpc: idempotent valgrind --quiet git' {
    zpwrExpandParseWords 'valgrind --quiet git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'valgrind --quiet git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'vpc: idempotent proot -R /x git' {
    zpwrExpandParseWords 'proot -R /x git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'proot -R /x git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
