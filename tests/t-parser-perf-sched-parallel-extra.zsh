#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: perf, schedtool, GNU parallel, xargs, renice — stacks and tails (live parser).
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
# perf — subcommands stay in tail until bare command
#==============================================================

@test 'psp: sudo perf stat git' {
    _assert_tail_str 'sudo perf stat git' 'perf stat git'
}

@test 'psp: env perf record -g git' {
    _assert_tail_str 'env perf record -g git' 'perf record -g git'
}

@test 'psp: timeout 10 perf stat -r 5 git' {
    _assert_tail_str 'timeout 10 perf stat -r 5 git' 'perf stat -r 5 git'
}

@test 'psp: stdbuf -oL perf bench syscall read' {
    _assert_tail_str 'stdbuf -oL perf bench syscall read' 'perf bench syscall read'
}

@test 'psp: chronic perf stat git' {
    _assert_tail_str 'chronic perf stat git' 'perf stat git'
}

@test 'psp: nice -n 5 perf top' {
    _assert_tail_str 'nice -n 5 perf top' 'perf top'
}

@test 'psp: perf report --stdio' {
    _assert_tail_str 'perf report --stdio' 'perf report --stdio'
}

@test 'psp: taskset -c 0-1 perf stat git' {
    _assert_tail_str 'taskset -c 0-1 perf stat git' 'perf stat git'
}

@test 'psp: bwrap --ro-bind / / perf stat git' {
    _assert_tail_str 'bwrap --ro-bind / / perf stat git' 'perf stat git'
}

@test 'psp: systemd-run perf stat git' {
    _assert_tail_str 'systemd-run perf stat git' 'perf stat git'
}

@test 'psp: eatmydata perf stat git' {
    _assert_tail_str 'eatmydata perf stat git' 'perf stat git'
}

@test 'psp: proxychains4 perf stat git' {
    _assert_tail_str 'proxychains4 perf stat git' 'perf stat git'
}

@test 'psp: fakeroot nice -n 0 perf record git' {
    _assert_tail_str 'fakeroot nice -n 0 perf record git' 'perf record git'
}

@test 'psp: unbuffer perf stat git' {
    _assert_tail_str 'unbuffer perf stat git' 'perf stat git'
}

@test 'psp: daemonize perf stat git' {
    _assert_tail_str 'daemonize perf stat git' 'perf stat git'
}

@test 'psp: catchsegv perf stat git' {
    _assert_tail_str 'catchsegv perf stat git' 'perf stat git'
}

@test 'psp: pkexec perf stat git' {
    _assert_tail_str 'pkexec perf stat git' 'perf stat git'
}

#==============================================================
# schedtool
#==============================================================

@test 'psp: fakeroot schedtool -a 0 git' {
    _assert_tail_str 'fakeroot schedtool -a 0 git' 'schedtool -a 0 git'
}

@test 'psp: sudo schedtool -B -e git' {
    _assert_tail_str 'sudo schedtool -B -e git' 'schedtool -B -e git'
}

@test 'psp: ionice -c1 schedtool -N 0 git' {
    _assert_tail_str 'ionice -c1 schedtool -N 0 git' 'schedtool -N 0 git'
}

#==============================================================
# GNU parallel
#==============================================================

@test 'psp: parallel -j4 ::: git' {
    _assert_tail_str 'parallel -j4 ::: git' 'parallel -j4 ::: git'
}

@test 'psp: parallel git ::: a b' {
    _assert_tail_str 'parallel git ::: a b' 'parallel git ::: a b'
}

@test 'psp: parallel -k git ::: x' {
    _assert_tail_str 'parallel -k git ::: x' 'parallel -k git ::: x'
}

@test 'psp: env -i parallel -j1 git ::: y' {
    _assert_tail_str 'env -i parallel -j1 git ::: y' 'parallel -j1 git ::: y'
}

@test 'psp: sudo parallel -a /dev/null git' {
    _assert_tail_str 'sudo parallel -a /dev/null git' 'parallel -a /dev/null git'
}

@test 'psp: env parallel git' {
    _assert_tail_str 'env parallel git' 'parallel git'
}

#==============================================================
# xargs
#==============================================================

@test 'psp: xargs -r git' {
    _assert_tail_str 'xargs -r git' 'xargs -r git'
}

@test 'psp: xargs -0 git' {
    _assert_tail_str 'xargs -0 git' 'xargs -0 git'
}

@test 'psp: xargs -P4 git' {
    _assert_tail_str 'xargs -P4 git' 'xargs -P4 git'
}

@test 'psp: find . -print0 | xargs -0 git' {
    _assert_tail_str 'find . -print0 | xargs -0 git' 'xargs -0 git'
}

@test 'psp: grep -l foo | xargs git' {
    _assert_tail_str 'grep -l foo | xargs git' 'xargs git'
}

#==============================================================
# renice — tail is renice + args (not stripped to git)
#==============================================================

@test 'psp: env renice -n 5 git' {
    _assert_tail_str 'env renice -n 5 git' 'renice -n 5 git'
}

@test 'psp: nice -n 0 renice -n 5 git' {
    _assert_tail_str 'nice -n 0 renice -n 5 git' 'renice -n 5 git'
}

@test 'psp: sudo renice -n 10 -p 1 -g 2 -u user git' {
    _assert_tail_str 'sudo renice -n 10 -p 1 -g 2 -u user git' 'renice -n 10 -p 1 -g 2 -u user git'
}

#==============================================================
# Mixed tails (git vs multi-word)
#==============================================================

@test 'psp: sudo env git' {
    _assert_tail_git 'sudo env git'
}

@test 'psp: torify git clone' {
    _assert_tail_str 'torify git clone' 'git clone'
}

@test 'psp: timeout 1 git status' {
    _assert_tail_str 'timeout 1 git status' 'git status'
}

@test 'psp: git perf wrapper fake' {
    _assert_tail_str 'git perf wrapper fake' 'git perf wrapper fake'
}

#==============================================================
# Idempotency
#==============================================================

@test 'psp: idempotent perf stat git' {
    zpwrExpandParseWords 'perf stat git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'perf stat git'
    zpwrExpandParseWords 'perf stat git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'perf stat git'
}

@test 'psp: idempotent schedtool -B git' {
    zpwrExpandParseWords 'schedtool -B git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'schedtool -B git'
    zpwrExpandParseWords 'schedtool -B git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'schedtool -B git'
}
