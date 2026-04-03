#!/usr/bin/env zunit
#{{{                    MARK:Header
##### Purpose: rlwrap, timeout, strace, and ltrace prefix parsing (flags + stacks).
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
# rlwrap
#==============================================================

@test 'rts: rlwrap -a git' {
    _assert_tail_git 'rlwrap -a git'
}

@test 'rts: rlwrap -acEhiImnNoRrUvWX git' {
    _assert_tail_git 'rlwrap -acEhiImnNoRrUvWX git'
}

@test 'rts: rlwrap -f /usr/share/dict/words -s 999 git' {
    _assert_tail_git 'rlwrap -f /usr/share/dict/words -s 999 git'
}

@test 'rts: rlwrap -b x -C name -D 2 -e ch git' {
    _assert_tail_git 'rlwrap -b x -C name -D 2 -e ch git'
}

@test 'rts: rlwrap -g pat -H hist -l log -M ext -O re git' {
    _assert_tail_git 'rlwrap -g pat -H hist -l log -M ext -O re git'
}

@test 'rts: rlwrap -P inp -p red -q ch -S prompt -t term -w 50 -z filt git' {
    _assert_tail_git 'rlwrap -P inp -p red -q ch -S prompt -t term -w 50 -z filt git'
}

@test 'rts: rlwrap -- git' {
    _assert_tail_git 'rlwrap -- git'
}

@test 'rts: rlwrap -a sudo git' {
    _assert_tail_git 'rlwrap -a sudo git'
}

@test 'rts: rlwrap -a env -i git' {
    _assert_tail_git 'rlwrap -a env -i git'
}

@test 'rts: sudo rlwrap -a git' {
    _assert_tail_git 'sudo rlwrap -a git'
}

#==============================================================
# timeout
#==============================================================

@test 'rts: timeout 30 git' {
    _assert_tail_git 'timeout 30 git'
}

@test 'rts: timeout -fpv 30 git' {
    _assert_tail_git 'timeout -fpv 30 git'
}

@test 'rts: timeout -k 5 30 git' {
    _assert_tail_git 'timeout -k 5 30 git'
}

@test 'rts: timeout -k 10 -s KILL 120 git' {
    _assert_tail_git 'timeout -k 10 -s KILL 120 git'
}

@test 'rts: timeout -- 99 git' {
    _assert_tail_git 'timeout -- 99 git'
}

@test 'rts: nice -n 1 timeout 10 git' {
    _assert_tail_git 'nice -n 1 timeout 10 git'
}

@test 'rts: env -i timeout 5 git' {
    _assert_tail_git 'env -i timeout 5 git'
}

#==============================================================
# strace
#==============================================================

@test 'rts: strace git' {
    _assert_tail_git 'strace git'
}

@test 'rts: strace -f git' {
    _assert_tail_git 'strace -f git'
}

@test 'rts: strace -c -f -F -h -i -k -n -q -r -t -T -v -V -w -x -y -Y -z -Z git' {
    _assert_tail_git 'strace -c -f -F -h -i -k -n -q -r -t -T -v -V -w -x -y -Y -z -Z git'
}

@test 'rts: strace -e trace=file -e trace=network git' {
    _assert_tail_git 'strace -e trace=file -e trace=network git'
}

@test 'rts: strace -e trace=network -s 256 -o /tmp/s -X raw git' {
    _assert_tail_git 'strace -e trace=network -s 256 -o /tmp/s -X raw git'
}

@test 'rts: strace -b execve -I 1 -O 50 -P /proc git' {
    _assert_tail_git 'strace -b execve -I 1 -O 50 -P /proc git'
}

@test 'rts: strace -a 80 -U 40 -S calls -u strace git' {
    _assert_tail_git 'strace -a 80 -U 40 -S calls -u strace git'
}

@test 'rts: strace -- git' {
    _assert_tail_git 'strace -- git'
}

@test 'rts: sudo strace -f git' {
    _assert_tail_git 'sudo strace -f git'
}

#==============================================================
# ltrace
#==============================================================

@test 'rts: ltrace git' {
    _assert_tail_git 'ltrace git'
}

@test 'rts: ltrace -e malloc -e free -F /etc/ltrace.conf git' {
    _assert_tail_git 'ltrace -e malloc -e free -F /etc/ltrace.conf git'
}

@test 'rts: ltrace -D 0xff -x dlopen -s 128 git' {
    _assert_tail_git 'ltrace -D 0xff -x dlopen -s 128 git'
}

@test 'rts: ltrace -- git' {
    _assert_tail_git 'ltrace -- git'
}

#==============================================================
# Nested stacks
#==============================================================

@test 'rts: timeout 5 strace -f git' {
    _assert_tail_git 'timeout 5 strace -f git'
}

@test 'rts: timeout 10 ltrace -c git' {
    _assert_tail_git 'timeout 10 ltrace -c git'
}

@test 'rts: strace -f timeout 3 git' {
    _assert_tail_git 'strace -f timeout 3 git'
}

@test 'rts: rlwrap -a timeout 30 git' {
    _assert_tail_git 'rlwrap -a timeout 30 git'
}

@test 'rts: nice -n 0 rlwrap -a strace -f git' {
    _assert_tail_git 'nice -n 0 rlwrap -a strace -f git'
}

@test 'rts: sudo -u root timeout 60 strace -e open git' {
    _assert_tail_git 'sudo -u root timeout 60 strace -e open git'
}

#==============================================================
# Multi-word tail
#==============================================================

@test 'rts: timeout 5 git diff' {
    _assert_tail_str 'timeout 5 git diff' 'git diff'
}

@test 'rts: strace -f git status' {
    _assert_tail_str 'strace -f git status' 'git status'
}

#==============================================================
# Idempotency
#==============================================================

@test 'rts: idempotent timeout 10 git' {
    zpwrExpandParseWords 'timeout 10 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'timeout 10 git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'rts: idempotent strace -f git' {
    zpwrExpandParseWords 'strace -f git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
    zpwrExpandParseWords 'strace -f git'
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'rts: strace -ANnw git' {
    _assert_tail_git 'strace -ANnw git'
}

@test 'rts: strace -s 1048576 -p 1 git' {
    _assert_tail_git 'strace -s 1048576 -p 1 git'
}

@test 'rts: ltrace -bcCfhiLrStTV git' {
    _assert_tail_git 'ltrace -bcCfhiLrStTV git'
}

@test 'rts: ltrace -a 40 -A 5 -n 1 -w 2 git' {
    _assert_tail_git 'ltrace -a 40 -A 5 -n 1 -w 2 git'
}

@test 'rts: nocorrect strace -f git' {
    _assert_tail_git 'nocorrect strace -f git'
}

@test 'rts: builtin strace -f git' {
    _assert_tail_git 'builtin strace -f git'
}

@test 'rts: command -p strace git' {
    _assert_tail_git 'command -p strace git'
}

@test 'rts: time -v strace -c git' {
    _assert_tail_git 'time -v strace -c git'
}

@test 'rts: rlwrap -a ltrace -c git' {
    _assert_tail_git 'rlwrap -a ltrace -c git'
}

@test 'rts: strace -f ltrace -c git' {
    _assert_tail_git 'strace -f ltrace -c git'
}

@test 'rts: timeout 1 strace -e execve git' {
    _assert_tail_git 'timeout 1 strace -e execve git'
}
