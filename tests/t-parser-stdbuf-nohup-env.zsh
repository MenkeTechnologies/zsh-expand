#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: stdbuf, nohup, env, nice — I/O buffering and environment stacks.
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
# stdbuf
#==============================================================

@test 'sne: stdbuf -i0 -oL -e0 git' {
    _assert_tail_git 'stdbuf -i0 -oL -e0 git'
}

@test 'sne: stdbuf -o=L git' {
    _assert_tail_git 'stdbuf -o=L git'
}

@test 'sne: stdbuf -i 0 -o 0 -e 0 git' {
    _assert_tail_git 'stdbuf -i 0 -o 0 -e 0 git'
}

@test 'sne: stdbuf -- git' {
    _assert_tail_git 'stdbuf -- git'
}

@test 'sne: nohup stdbuf -oL git' {
    _assert_tail_git 'nohup stdbuf -oL git'
}

@test 'sne: stdbuf -oL timeout 10 git' {
    _assert_tail_git 'stdbuf -oL timeout 10 git'
}

#==============================================================
# nohup / nice
#==============================================================

@test 'sne: nohup -- git' {
    _assert_tail_git 'nohup -- git'
}

@test 'sne: nice -n 19 nohup git' {
    _assert_tail_git 'nice -n 19 nohup git'
}

@test 'sne: nohup nice -n 5 git' {
    _assert_tail_git 'nohup nice -n 5 git'
}

@test 'sne: sudo nohup git' {
    _assert_tail_git 'sudo nohup git'
}

#==============================================================
# env — flags and assignments
#==============================================================

@test 'sne: env -- git' {
    _assert_tail_git 'env -- git'
}

@test 'sne: env -i git' {
    _assert_tail_git 'env -i git'
}

@test 'sne: env -u DISPLAY -u TERM git' {
    _assert_tail_git 'env -u DISPLAY -u TERM git'
}

@test 'sne: env GIT_TRACE=1 git' {
    _assert_tail_git 'env GIT_TRACE=1 git'
}

@test 'sne: env -C /wrk git' {
    _assert_tail_git 'env -C /wrk git'
}

@test 'sne: env -P /bin:/usr/bin git' {
    _assert_tail_git 'env -P /bin:/usr/bin git'
}

@test 'sne: env -v VAR=1 git' {
    _assert_tail_git 'env -v VAR=1 git'
}

@test 'sne: env -i -S git git' {
    _assert_tail_git 'env -i -S git git'
}

@test 'sne: sudo -E env -i PATH=/usr/bin HOME=/tmp git' {
    _assert_tail_git 'sudo -E env -i PATH=/usr/bin HOME=/tmp git'
}

#==============================================================
# Cross stacks
#==============================================================

@test 'sne: env -i stdbuf -oL git' {
    _assert_tail_git 'env -i stdbuf -oL git'
}

@test 'sne: nice -n 0 env -i git' {
    _assert_tail_git 'nice -n 0 env -i git'
}

@test 'sne: time -v stdbuf -oL git' {
    _assert_tail_git 'time -v stdbuf -oL git'
}

@test 'sne: nocorrect env -i git' {
    _assert_tail_git 'nocorrect env -i git'
}

@test 'sne: command -p stdbuf -oL git' {
    _assert_tail_git 'command -p stdbuf -oL git'
}

@test 'sne: builtin env -i git' {
    _assert_tail_git 'builtin env -i git'
}

#==============================================================
# Multi-word tails and idempotency
#==============================================================

@test 'sne: stdbuf -oL git log -1' {
    _assert_tail_str 'stdbuf -oL git log -1' 'git log -1'
}

@test 'sne: env -i git diff --stat' {
    _assert_tail_str 'env -i git diff --stat' 'git diff --stat'
}

@test 'sne: idempotent stdbuf -oL git' {
    zpwrExpandParseWords 'stdbuf -oL git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'stdbuf -oL git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'sne: idempotent env VAR=a git' {
    zpwrExpandParseWords 'env VAR=a git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'env VAR=a git'
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
