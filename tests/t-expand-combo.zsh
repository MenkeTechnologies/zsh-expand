#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: combination and integration tests for zsh-expand
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"

    function correct_word() {
        LBUFFER="echo $1"
        ZPWR_VARS[foundIncorrect]=false
        zpwrExpandParseWords "$LBUFFER"
        zpwrExpandCorrectWord
    }
}

#==============================================================
# Sequence: parseWords then expandAlias (40+ tests)
#==============================================================

@test 'combo-parse-alias: single alias at command position' {
    alias __zt_lsx='ls -lah'
    LBUFFER="__zt_lsx"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls -lah'
    unalias __zt_lsx
}

@test 'combo-parse-alias: alias after sudo' {
    alias __zt_apt='apt-get update'
    LBUFFER="sudo __zt_apt"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo apt-get update'
    unalias __zt_apt
}

@test 'combo-parse-alias: alias after pipe' {
    alias __zt_grp='grep -i pattern'
    LBUFFER="cat file | __zt_grp"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat file | grep -i pattern'
    unalias __zt_grp
}

@test 'combo-parse-alias: alias after semicolon' {
    alias __zt_clr='clear'
    LBUFFER="echo done; __zt_clr"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo done; clear'
    unalias __zt_clr
}

@test 'combo-parse-alias: alias after &&' {
    alias __zt_mk='make -j4'
    LBUFFER="cmake .. && __zt_mk"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cmake .. && make -j4'
    unalias __zt_mk
}

@test 'combo-parse-alias: alias after ||' {
    alias __zt_fb='echo fallback'
    LBUFFER="cmd1 || __zt_fb"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cmd1 || echo fallback'
    unalias __zt_fb
}

@test 'combo-parse-alias: self-referential alias escape' {
    alias __zt_ls='__zt_ls -la'
    LBUFFER="__zt_ls"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_ls -la'
    unalias __zt_ls
}

@test 'combo-parse-alias: alias with tabstop value' {
    alias __zt_commit="git commit -m ${ZPWR_TABSTOP}"
    LBUFFER="__zt_commit"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as "git commit -m ${ZPWR_TABSTOP}"
    unalias __zt_commit
}

@test 'combo-parse-alias: alias with multi-flag expansion' {
    alias __zt_curl='curl -fsSL --retry 3'
    LBUFFER="__zt_curl"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'curl -fsSL --retry 3'
    unalias __zt_curl
}

@test 'combo-parse-alias: alias after double pipe with spaces' {
    alias __zt_warn='echo warning'
    LBUFFER="test -f file  ||  __zt_warn"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'test -f file  ||  echo warning'
    unalias __zt_warn
}

@test 'combo-parse-alias: alias after double ampersand with spaces' {
    alias __zt_ok='echo success'
    LBUFFER="make  &&  __zt_ok"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'make  &&  echo success'
    unalias __zt_ok
}

@test 'combo-parse-alias: alias expanding to path' {
    alias __zt_goHome='cd ~/Documents'
    LBUFFER="__zt_goHome"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ~/Documents'
    unalias __zt_goHome
}

@test 'combo-parse-alias: alias expanding to command with quotes' {
    alias __zt_hi='echo hello world'
    LBUFFER="__zt_hi"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo hello world'
    unalias __zt_hi
}

@test 'combo-parse-alias: alias after multiple semicolons' {
    alias __zt_fin='echo done'
    LBUFFER="a; b; c; __zt_fin"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'a; b; c; echo done'
    unalias __zt_fin
}

@test 'combo-parse-alias: alias after mixed operators' {
    alias __zt_run='./run.sh'
    LBUFFER="a && b || c; __zt_run"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'a && b || c; ./run.sh'
    unalias __zt_run
}

@test 'combo-parse-alias: WAS_EXPANDED true after successful expansion' {
    alias __zt_ww='whoami'
    LBUFFER="__zt_ww"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unalias __zt_ww
}

@test 'combo-parse-alias: firstword_partition after pipe is alias' {
    alias __zt_srt='sort -u'
    LBUFFER="cat data | __zt_srt"
    zpwrExpandParseWords "$LBUFFER"
    assert $ZPWR_VARS[firstword_partition] same_as '__zt_srt'
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat data | sort -u'
    unalias __zt_srt
}

@test 'combo-parse-alias: alias value with equals sign' {
    alias __zt_col='ls --color=always'
    LBUFFER="__zt_col"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls --color=always'
    unalias __zt_col
}

@test 'combo-parse-alias: alias after env prefix' {
    alias __zt_py='python3 -u'
    LBUFFER="FOO=bar __zt_py"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'FOO=bar python3 -u'
    unalias __zt_py
}

@test 'combo-parse-alias: alias with long expansion' {
    alias __zt_long='find . -type f -name "*.txt" -exec grep -l pattern {} +'
    LBUFFER="__zt_long"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'find . -type f -name "*.txt" -exec grep -l pattern {} +'
    unalias __zt_long
}

@test 'combo-parse-alias: alias with numeric flags' {
    alias __zt_t10='tail -n 10'
    LBUFFER="__zt_t10"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'tail -n 10'
    unalias __zt_t10
}

@test 'combo-parse-alias: alias after pipe keeps prefix intact' {
    alias __zt_wc='wc -l'
    LBUFFER="find . -name *.txt | __zt_wc"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'find . -name *.txt | wc -l'
    unalias __zt_wc
}

@test 'combo-parse-alias: alias with hyphen in name' {
    alias __zt_g-s='git status'
    LBUFFER="__zt_g-s"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'git status'
    unalias __zt_g-s
}

@test 'combo-parse-alias: alias preserves leading whitespace' {
    alias __zt_ec='echo test'
    LBUFFER="  __zt_ec"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as '  echo test'
    unalias __zt_ec
}

@test 'combo-parse-alias: alias with dot in expansion' {
    alias __zt_ver='python3 --version'
    LBUFFER="__zt_ver"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'python3 --version'
    unalias __zt_ver
}

@test 'combo-parse-alias: alias to single char command' {
    alias __zt_q='q'
    LBUFFER="__zt_q"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'q'
    unalias __zt_q
}

@test 'combo-parse-alias: alias after paren in subshell' {
    alias __zt_sub='echo inner'
    LBUFFER="( __zt_sub"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as '( echo inner'
    unalias __zt_sub
}

@test 'combo-parse-alias: alias after brace in command group' {
    alias __zt_bg='echo grouped'
    LBUFFER="{ __zt_bg"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as '{ echo grouped'
    unalias __zt_bg
}

@test 'combo-parse-alias: alias with redirect chars in expansion' {
    alias __zt_redir='cat /dev/null'
    LBUFFER="__zt_redir"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat /dev/null'
    unalias __zt_redir
}

@test 'combo-parse-alias: alias with multiple dashes in flags' {
    alias __zt_dkr='docker run --rm --it'
    LBUFFER="__zt_dkr"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'docker run --rm --it'
    unalias __zt_dkr
}

@test 'combo-parse-alias: alias value same as alias name no recursion issue' {
    alias __zt_noop='__zt_noop'
    LBUFFER="__zt_noop"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_noop'
    unalias __zt_noop
}

@test 'combo-parse-alias: alias after double semicolons' {
    alias __zt_ds='echo dsemi'
    LBUFFER="case x in p);; __zt_ds"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'case x in p);; echo dsemi'
    unalias __zt_ds
}

@test 'combo-parse-alias: alias expanding to pipeline command' {
    alias __zt_pipe='sort | uniq -c | sort -rn'
    LBUFFER="__zt_pipe"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sort | uniq -c | sort -rn'
    unalias __zt_pipe
}

@test 'combo-parse-alias: alias with env var in expansion' {
    alias __zt_home='cd $HOME'
    LBUFFER="__zt_home"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd $HOME'
    unalias __zt_home
}

@test 'combo-parse-alias: alias with trailing flag after sudo' {
    alias __zt_stail='tail -f /var/log/syslog'
    LBUFFER="sudo __zt_stail"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo tail -f /var/log/syslog'
    unalias __zt_stail
}

@test 'combo-parse-alias: alias with numbers in name and expansion' {
    alias __zt_p8080='python3 -m http.server 8080'
    LBUFFER="__zt_p8080"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'python3 -m http.server 8080'
    unalias __zt_p8080
}

@test 'combo-parse-alias: alias with underscore heavy name' {
    alias __zt_a_b_c='echo abc'
    LBUFFER="__zt_a_b_c"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo abc'
    unalias __zt_a_b_c
}

@test 'combo-parse-alias: alias after pipe pipe with word before' {
    alias __zt_err='echo error'
    LBUFFER="false || __zt_err"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'false || echo error'
    unalias __zt_err
}

@test 'combo-parse-alias: alias in deeply nested pipe chain' {
    alias __zt_hd='head -5'
    LBUFFER="cat f | grep x | sort | __zt_hd"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat f | grep x | sort | head -5'
    unalias __zt_hd
}

@test 'combo-parse-alias: alias with tilde path expansion' {
    alias __zt_cdbin='cd ~/bin'
    LBUFFER="__zt_cdbin"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ~/bin'
    unalias __zt_cdbin
}

#==============================================================
# Sequence: parseWords then expandAliasEscape then GoToTabStop (20+ tests)
#==============================================================

@test 'combo-escape-tabstop: self-ref alias with tabstop sets NEED_TO_ADD_SPACECHAR false' {
    alias __zt_git="__zt_git commit -m ${ZPWR_TABSTOP}"
    LBUFFER="__zt_git"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
    unalias __zt_git
}

@test 'combo-escape-tabstop: self-ref alias no tabstop sets NEED_TO_ADD_SPACECHAR true' {
    alias __zt_pwd='__zt_pwd -P'
    LBUFFER="__zt_pwd"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
    unalias __zt_pwd
}

@test 'combo-escape-tabstop: WAS_EXPANDED set to true on escape' {
    alias __zt_grep='__zt_grep -rn'
    LBUFFER="__zt_grep"
    RBUFFER=""
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unalias __zt_grep
}

@test 'combo-escape-tabstop: self-ref with trailing flags preserves backslash' {
    alias __zt_ls2='__zt_ls2 -lah --color=auto'
    LBUFFER="__zt_ls2"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_ls2 -lah --color=auto'
    unalias __zt_ls2
}

@test 'combo-escape-tabstop: self-ref alias after sudo' {
    alias __zt_rm='__zt_rm -i'
    LBUFFER="sudo __zt_rm"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'sudo \__zt_rm -i'
    unalias __zt_rm
}

@test 'combo-escape-tabstop: tabstop in expansion positions cursor' {
    alias __zt_echo="__zt_echo ${ZPWR_TABSTOP} done"
    LBUFFER="__zt_echo"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
    unalias __zt_echo
}

@test 'combo-escape-tabstop: self-ref with leading spaces' {
    alias __zt_cat='__zt_cat -n'
    LBUFFER="  __zt_cat"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '  \__zt_cat -n'
    unalias __zt_cat
}

@test 'combo-escape-tabstop: self-ref with many flags' {
    alias __zt_tar='__zt_tar -xzvf'
    LBUFFER="__zt_tar"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_tar -xzvf'
    unalias __zt_tar
}

@test 'combo-escape-tabstop: self-ref preserves pipe context' {
    alias __zt_sed='__zt_sed -e s/a/b/g'
    LBUFFER="cat f | __zt_sed"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cat f | \__zt_sed -e s/a/b/g'
    unalias __zt_sed
}

@test 'combo-escape-tabstop: self-ref preserves semicolon context' {
    alias __zt_mv='__zt_mv -i'
    LBUFFER="ls; __zt_mv"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'ls; \__zt_mv -i'
    unalias __zt_mv
}

@test 'combo-escape-tabstop: self-ref alias expand with double tabstop' {
    alias __zt_cp="__zt_cp ${ZPWR_TABSTOP} ${ZPWR_TABSTOP}"
    LBUFFER="__zt_cp"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
    unalias __zt_cp
}

@test 'combo-escape-tabstop: self-ref single word alias' {
    alias __zt_x='__zt_x'
    LBUFFER="__zt_x"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_x'
    unalias __zt_x
}

@test 'combo-escape-tabstop: self-ref with path in expansion' {
    alias __zt_vim='__zt_vim /etc/hosts'
    LBUFFER="__zt_vim"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_vim /etc/hosts'
    unalias __zt_vim
}

@test 'combo-escape-tabstop: self-ref after && operator' {
    alias __zt_cp2='__zt_cp2 -r'
    LBUFFER="mkdir dir && __zt_cp2"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'mkdir dir && \__zt_cp2 -r'
    unalias __zt_cp2
}

@test 'combo-escape-tabstop: self-ref after || operator' {
    alias __zt_echo2='__zt_echo2 fail'
    LBUFFER="test -f x || __zt_echo2"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'test -f x || \__zt_echo2 fail'
    unalias __zt_echo2
}

@test 'combo-escape-tabstop: no expansion when trailing space present' {
    alias __zt_tr='__zt_tr -d'
    LBUFFER="__zt_tr "
    RBUFFER=""
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unalias __zt_tr
}

@test 'combo-escape-tabstop: self-ref with numeric suffix' {
    alias __zt_gcc9='__zt_gcc9 -O2 -Wall'
    LBUFFER="__zt_gcc9"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_gcc9 -O2 -Wall'
    unalias __zt_gcc9
}

@test 'combo-escape-tabstop: self-ref alias goto tabstop clears RBUFFER prefix' {
    alias __zt_fn="__zt_fn ${ZPWR_TABSTOP}"
    LBUFFER="__zt_fn"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
    unalias __zt_fn
}

@test 'combo-escape-tabstop: self-ref with complex flags' {
    alias __zt_rsync='__zt_rsync -avz --progress --delete'
    LBUFFER="__zt_rsync"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_rsync -avz --progress --delete'
    unalias __zt_rsync
}

@test 'combo-escape-tabstop: self-ref no tabstop goto end NEED_TO_ADD_SPACECHAR true' {
    alias __zt_date='__zt_date +%Y-%m-%d'
    LBUFFER="__zt_date"
    RBUFFER=""
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAliasEscape
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
    unalias __zt_date
}

#==============================================================
# Sequence: parseWords then correctWord (30+ tests)
#==============================================================

@test 'combo-parse-correct: correct teh after echo' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'combo-parse-correct: correct adn after printf' {
    LBUFFER="printf adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'printf and'
}

@test 'combo-parse-correct: correct hte after cat' {
    LBUFFER="cat hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat the'
}

@test 'combo-parse-correct: correct jsut after git commit -m' {
    LBUFFER="git commit -m jsut"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m just'
}

@test 'combo-parse-correct: correct btw in echo context' {
    LBUFFER="echo btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo by the way'
}

@test 'combo-parse-correct: correct b/c after echo' {
    LBUFFER="echo b/c"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo because'
}

@test 'combo-parse-correct: foundIncorrect true on misspelling' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'combo-parse-correct: foundIncorrect false on valid word' {
    LBUFFER="echo hello"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'combo-parse-correct: no change for valid word world' {
    LBUFFER="echo world"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo world'
}

@test 'combo-parse-correct: correct josn to JSON' {
    LBUFFER="echo josn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JSON'
}

@test 'combo-parse-correct: correct ehco to echo' {
    LBUFFER="echo ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo echo'
}

@test 'combo-parse-correct: correct nad to and' {
    LBUFFER="echo nad"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'
}

@test 'combo-parse-correct: correct w/o to without' {
    LBUFFER="echo w/o"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo without'
}

@test 'combo-parse-correct: correct defalut to default' {
    LBUFFER="echo defalut"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo default'
}

@test 'combo-parse-correct: correct fales to false' {
    LBUFFER="echo fales"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo false'
}

@test 'combo-parse-correct: correct treu to true' {
    LBUFFER="echo treu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo true'
}

@test 'combo-parse-correct: correct eror to error' {
    LBUFFER="echo eror"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo error'
}

@test 'combo-parse-correct: correct idr to directory' {
    LBUFFER="echo idr"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo directory'
}

@test 'combo-parse-correct: correct fiel to file' {
    LBUFFER="echo fiel"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo file'
}

@test 'combo-parse-correct: correct liek to like' {
    LBUFFER="echo liek"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo like'
}

@test 'combo-parse-correct: correct taht to that' {
    LBUFFER="echo taht"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo that'
}

@test 'combo-parse-correct: correct tihs to this' {
    LBUFFER="echo tihs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo this'
}

@test 'combo-parse-correct: correct ues to use' {
    LBUFFER="echo ues"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo use'
}

@test 'combo-parse-correct: correct oepn to open' {
    LBUFFER="echo oepn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo open'
}

@test 'combo-parse-correct: correct pirnt to print' {
    LBUFFER="echo pirnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo print'
}

@test 'combo-parse-correct: correct maek to make' {
    LBUFFER="echo maek"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo make'
}

@test 'combo-parse-correct: correct flase to false' {
    LBUFFER="echo flase"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo false'
}

@test 'combo-parse-correct: correct ture to true' {
    LBUFFER="echo ture"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo true'
}

@test 'combo-parse-correct: correct moer to more' {
    LBUFFER="echo moer"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo more'
}

@test 'combo-parse-correct: correct insaed to instead' {
    LBUFFER="echo insaed"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo instead'
}

@test 'combo-parse-correct: preserves multiword prefix during correction' {
    LBUFFER="sudo echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sudo echo the'
}

#==============================================================
# RightTrim then expandAlias (20+ tests)
#==============================================================

@test 'combo-trim-alias: basic trim then expand' {
    alias __zt_trimA='expanded_a'
    LBUFFER="__zt_trimA "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_trimA
    ZPWR_VARS[EXPANDED]='expanded_a'
    zpwrExpandAlias
    assert $LBUFFER same_as 'expanded_a'
    unalias __zt_trimA
}

@test 'combo-trim-alias: trim trailing space then expand multi-word' {
    alias __zt_trimB='git log --oneline'
    LBUFFER="__zt_trimB "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_trimB
    ZPWR_VARS[EXPANDED]='git log --oneline'
    zpwrExpandAlias
    assert $LBUFFER same_as 'git log --oneline'
    unalias __zt_trimB
}

@test 'combo-trim-alias: no trim when double space, no expand' {
    LBUFFER="__zt_xx  "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_xx
    ZPWR_VARS[EXPANDED]='expanded'
    zpwrExpandAlias || :
    assert $LBUFFER same_as '__zt_xx  '
}

@test 'combo-trim-alias: trim then expand after sudo' {
    LBUFFER="sudo __zt_yy "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_yy
    ZPWR_VARS[EXPANDED]='apt install'
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo apt install'
}

@test 'combo-trim-alias: trim then expand after pipe' {
    LBUFFER="cat file | __zt_zz "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_zz
    ZPWR_VARS[EXPANDED]='grep -i test'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat file | grep -i test'
}

@test 'combo-trim-alias: trim then expand after semicolon' {
    LBUFFER="echo hi; __zt_aa "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_aa
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo hi; ls -la'
}

@test 'combo-trim-alias: trim preserves leading space then expand' {
    LBUFFER=" __zt_bb "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_bb
    ZPWR_VARS[EXPANDED]='pwd'
    zpwrExpandAlias
    assert $LBUFFER same_as ' pwd'
}

@test 'combo-trim-alias: trim then expand with equals in value' {
    LBUFFER="__zt_cc "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_cc
    ZPWR_VARS[EXPANDED]='ls --color=always'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls --color=always'
}

@test 'combo-trim-alias: trim then expand with path in value' {
    LBUFFER="__zt_dd "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_dd
    ZPWR_VARS[EXPANDED]='cd /usr/local/bin'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd /usr/local/bin'
}

@test 'combo-trim-alias: trim then expand to single command' {
    LBUFFER="__zt_ee "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_ee
    ZPWR_VARS[EXPANDED]='whoami'
    zpwrExpandAlias
    assert $LBUFFER same_as 'whoami'
}

@test 'combo-trim-alias: trim then WAS_EXPANDED true' {
    LBUFFER="__zt_ff "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_ff
    ZPWR_VARS[EXPANDED]='hostname'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'combo-trim-alias: trim then expand after && operator' {
    LBUFFER="make && __zt_gg "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_gg
    ZPWR_VARS[EXPANDED]='echo done'
    zpwrExpandAlias
    assert $LBUFFER same_as 'make && echo done'
}

@test 'combo-trim-alias: trim then expand after || operator' {
    LBUFFER="cmd || __zt_hh "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_hh
    ZPWR_VARS[EXPANDED]='echo fail'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cmd || echo fail'
}

@test 'combo-trim-alias: no trim empty buffer stays empty' {
    LBUFFER=""
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'combo-trim-alias: trim with many words before' {
    LBUFFER="a b c d e __zt_ii "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_ii
    ZPWR_VARS[EXPANDED]='final'
    zpwrExpandAlias
    assert $LBUFFER same_as 'a b c d e final'
}

@test 'combo-trim-alias: trim then expand to long value' {
    LBUFFER="__zt_jj "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_jj
    ZPWR_VARS[EXPANDED]='find . -type f -name "*.log" -mtime +30 -delete'
    zpwrExpandAlias
    assert $LBUFFER same_as 'find . -type f -name "*.log" -mtime +30 -delete'
}

@test 'combo-trim-alias: trim then expand to tilde path' {
    LBUFFER="__zt_kk "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_kk
    ZPWR_VARS[EXPANDED]='cd ~/projects/myapp'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ~/projects/myapp'
}

@test 'combo-trim-alias: trim single space buffer becomes empty' {
    LBUFFER=" "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'combo-trim-alias: trim then expand preserves double leading space' {
    LBUFFER="  __zt_ll "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_ll
    ZPWR_VARS[EXPANDED]='date'
    zpwrExpandAlias
    assert $LBUFFER same_as '  date'
}

@test 'combo-trim-alias: trim then expand with numbers in value' {
    LBUFFER="__zt_mm "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_mm
    ZPWR_VARS[EXPANDED]='head -n 100'
    zpwrExpandAlias
    assert $LBUFFER same_as 'head -n 100'
}

#==============================================================
# Multiple expansions in sequence (20+ tests)
#==============================================================

@test 'combo-multi-expand: two sequential expansions' {
    LBUFFER="aaa"
    ZPWR_VARS[lastword_lbuffer]=aaa
    ZPWR_VARS[EXPANDED]='bbb'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $LBUFFER same_as 'bbb'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'

    LBUFFER="ccc"
    ZPWR_VARS[lastword_lbuffer]=ccc
    ZPWR_VARS[EXPANDED]='ddd'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $LBUFFER same_as 'ddd'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'combo-multi-expand: expand then escape in sequence' {
    LBUFFER="abc"
    ZPWR_VARS[lastword_lbuffer]=abc
    ZPWR_VARS[EXPANDED]='xyz'
    zpwrExpandAlias
    assert $LBUFFER same_as 'xyz'

    LBUFFER="self"
    ZPWR_VARS[lastword_lbuffer]=self
    ZPWR_VARS[EXPANDED]='self -flag'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\self -flag'
}

@test 'combo-multi-expand: three expansions reset state each time' {
    LBUFFER="a1"
    ZPWR_VARS[lastword_lbuffer]=a1
    ZPWR_VARS[EXPANDED]='b1'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $LBUFFER same_as 'b1'

    LBUFFER="a2"
    ZPWR_VARS[lastword_lbuffer]=a2
    ZPWR_VARS[EXPANDED]='b2'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $LBUFFER same_as 'b2'

    LBUFFER="a3"
    ZPWR_VARS[lastword_lbuffer]=a3
    ZPWR_VARS[EXPANDED]='b3'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $LBUFFER same_as 'b3'
}

@test 'combo-multi-expand: expand, fail, expand' {
    LBUFFER="x1"
    ZPWR_VARS[lastword_lbuffer]=x1
    ZPWR_VARS[EXPANDED]='y1'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'

    LBUFFER="x2 "
    ZPWR_VARS[lastword_lbuffer]=x2
    ZPWR_VARS[EXPANDED]='y2'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'

    LBUFFER="x3"
    ZPWR_VARS[lastword_lbuffer]=x3
    ZPWR_VARS[EXPANDED]='y3'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'combo-multi-expand: first expand sets WAS_EXPANDED, second resets it' {
    LBUFFER="cmd1"
    ZPWR_VARS[lastword_lbuffer]=cmd1
    ZPWR_VARS[EXPANDED]='out1'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'

    ZPWR_VARS[WAS_EXPANDED]=false
    LBUFFER="cmd2 "
    ZPWR_VARS[lastword_lbuffer]=cmd2
    ZPWR_VARS[EXPANDED]='out2'
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'combo-multi-expand: sequential aliases with different values' {
    alias __zt_seq1='val1'
    alias __zt_seq2='val2'
    alias __zt_seq3='val3'

    LBUFFER="__zt_seq1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'val1'

    LBUFFER="__zt_seq2"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'val2'

    LBUFFER="__zt_seq3"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'val3'

    unalias __zt_seq1 __zt_seq2 __zt_seq3
}

@test 'combo-multi-expand: expansion then correction' {
    LBUFFER="myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='expanded'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $LBUFFER same_as 'expanded'

    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'combo-multi-expand: correction then expansion' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'

    LBUFFER="myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]='expanded'
    zpwrExpandAlias
    assert $LBUFFER same_as 'expanded'
}

@test 'combo-multi-expand: trim then expand then trim then expand' {
    LBUFFER="aa "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=aa
    ZPWR_VARS[EXPANDED]='bb'
    zpwrExpandAlias
    assert $LBUFFER same_as 'bb'

    LBUFFER="cc "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=cc
    ZPWR_VARS[EXPANDED]='dd'
    zpwrExpandAlias
    assert $LBUFFER same_as 'dd'
}

@test 'combo-multi-expand: parse then expand same buffer twice' {
    alias __zt_rep='repeated'
    LBUFFER="__zt_rep"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'repeated'

    LBUFFER="__zt_rep"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'repeated'
    unalias __zt_rep
}

@test 'combo-multi-expand: expand with pipe context then semicolon context' {
    LBUFFER="cat | aa"
    ZPWR_VARS[lastword_lbuffer]=aa
    ZPWR_VARS[EXPANDED]='bb'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat | bb'

    LBUFFER="ls; cc"
    ZPWR_VARS[lastword_lbuffer]=cc
    ZPWR_VARS[EXPANDED]='dd'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls; dd'
}

@test 'combo-multi-expand: four sequential successful expansions' {
    LBUFFER="w1"
    ZPWR_VARS[lastword_lbuffer]=w1
    ZPWR_VARS[EXPANDED]='e1'
    zpwrExpandAlias
    assert $LBUFFER same_as 'e1'

    LBUFFER="w2"
    ZPWR_VARS[lastword_lbuffer]=w2
    ZPWR_VARS[EXPANDED]='e2'
    zpwrExpandAlias
    assert $LBUFFER same_as 'e2'

    LBUFFER="w3"
    ZPWR_VARS[lastword_lbuffer]=w3
    ZPWR_VARS[EXPANDED]='e3'
    zpwrExpandAlias
    assert $LBUFFER same_as 'e3'

    LBUFFER="w4"
    ZPWR_VARS[lastword_lbuffer]=w4
    ZPWR_VARS[EXPANDED]='e4'
    zpwrExpandAlias
    assert $LBUFFER same_as 'e4'
}

@test 'combo-multi-expand: escape then regular expand' {
    LBUFFER="self"
    ZPWR_VARS[lastword_lbuffer]=self
    ZPWR_VARS[EXPANDED]='self -flag'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\self -flag'

    LBUFFER="other"
    ZPWR_VARS[lastword_lbuffer]=other
    ZPWR_VARS[EXPANDED]='different'
    zpwrExpandAlias
    assert $LBUFFER same_as 'different'
}

@test 'combo-multi-expand: expand sets WAS_EXPANDED each time independently' {
    ZPWR_VARS[WAS_EXPANDED]=false
    LBUFFER="a"
    ZPWR_VARS[lastword_lbuffer]=a
    ZPWR_VARS[EXPANDED]='b'
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'

    ZPWR_VARS[WAS_EXPANDED]=false
    LBUFFER="c"
    ZPWR_VARS[lastword_lbuffer]=c
    ZPWR_VARS[EXPANDED]='d'
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'combo-multi-expand: alternating expand and escape' {
    LBUFFER="r1"
    ZPWR_VARS[lastword_lbuffer]=r1
    ZPWR_VARS[EXPANDED]='val1'
    zpwrExpandAlias
    assert $LBUFFER same_as 'val1'

    LBUFFER="s1"
    ZPWR_VARS[lastword_lbuffer]=s1
    ZPWR_VARS[EXPANDED]='s1 -x'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\s1 -x'

    LBUFFER="r2"
    ZPWR_VARS[lastword_lbuffer]=r2
    ZPWR_VARS[EXPANDED]='val2'
    zpwrExpandAlias
    assert $LBUFFER same_as 'val2'
}

@test 'combo-multi-expand: five failed expansions then one success' {
    for i in 1 2 3 4 5; do
        LBUFFER="fail$i "
        ZPWR_VARS[lastword_lbuffer]="fail$i"
        ZPWR_VARS[EXPANDED]="out$i"
        ZPWR_VARS[WAS_EXPANDED]=false
        zpwrExpandAlias || :
        assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    done
    LBUFFER="ok"
    ZPWR_VARS[lastword_lbuffer]=ok
    ZPWR_VARS[EXPANDED]='success'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    assert $LBUFFER same_as 'success'
}

@test 'combo-multi-expand: expand with sudo prefix, then expand standalone' {
    LBUFFER="sudo xx"
    ZPWR_VARS[lastword_lbuffer]=xx
    ZPWR_VARS[EXPANDED]='yy'
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo yy'

    LBUFFER="xx"
    ZPWR_VARS[lastword_lbuffer]=xx
    ZPWR_VARS[EXPANDED]='yy'
    zpwrExpandAlias
    assert $LBUFFER same_as 'yy'
}

@test 'combo-multi-expand: parseWords resets between expansions' {
    zpwrExpandParseWords "cat file | grep foo"
    assert $ZPWR_VARS[firstword_partition] same_as 'grep'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'foo'

    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

#==============================================================
# Global alias then regular alias (15+ tests)
#==============================================================

@test 'combo-global-regular: global alias does not interfere with regular' {
    galiases[__ZT_GL1]='| grep -i'
    alias __zt_rl1='ls -la'

    LBUFFER="__zt_rl1"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls -la'

    LBUFFER="cat file __ZT_GL1"
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    zpwrExpandGlobalAliases __ZT_GL1
    assert $LBUFFER same_as 'cat file | grep -i'

    unalias __zt_rl1
    unset 'galiases[__ZT_GL1]'
}

@test 'combo-global-regular: regular then global in sequence' {
    alias __zt_cmd='docker ps'
    galiases[__ZT_TAIL]='| tail -5'

    LBUFFER="__zt_cmd"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'docker ps'

    LBUFFER="docker ps __ZT_TAIL"
    zpwrExpandGlobalAliases __ZT_TAIL
    assert $LBUFFER same_as 'docker ps | tail -5'

    unalias __zt_cmd
    unset 'galiases[__ZT_TAIL]'
}

@test 'combo-global-regular: global alias WAS_EXPANDED true' {
    galiases[__ZT_HEAD]='| head -10'
    LBUFFER="ls __ZT_HEAD"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZT_HEAD
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
    unset 'galiases[__ZT_HEAD]'
}

@test 'combo-global-regular: global alias sets lastword_lbuffer' {
    galiases[__ZT_SORT]='| sort -u'
    LBUFFER="cat data __ZT_SORT"
    zpwrExpandGlobalAliases __ZT_SORT
    assert $ZPWR_VARS[lastword_lbuffer] same_as '__ZT_SORT'
    unset 'galiases[__ZT_SORT]'
}

@test 'combo-global-regular: two global aliases sequentially' {
    galiases[__ZT_G1]='| grep pattern'
    galiases[__ZT_G2]='| wc -l'

    LBUFFER="cat file __ZT_G1"
    zpwrExpandGlobalAliases __ZT_G1
    assert $LBUFFER same_as 'cat file | grep pattern'

    LBUFFER="cat file | grep pattern __ZT_G2"
    zpwrExpandGlobalAliases __ZT_G2
    assert $LBUFFER same_as 'cat file | grep pattern | wc -l'

    unset 'galiases[__ZT_G1]' 'galiases[__ZT_G2]'
}

@test 'combo-global-regular: regular alias then global alias same test' {
    alias __zt_find='find . -name'
    galiases[__ZT_LESS]='| less'

    LBUFFER="__zt_find"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'find . -name'

    LBUFFER="find . -name *.txt __ZT_LESS"
    zpwrExpandGlobalAliases __ZT_LESS
    assert $LBUFFER same_as 'find . -name *.txt | less'

    unalias __zt_find
    unset 'galiases[__ZT_LESS]'
}

@test 'combo-global-regular: global alias no match when not at end' {
    galiases[__ZT_NM]='| tee'
    LBUFFER="cat __ZT_NM file"
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandGlobalAliases __ZT_NM || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    unset 'galiases[__ZT_NM]'
}

@test 'combo-global-regular: global alias expanding to redirection' {
    galiases[__ZT_NUL]='> /dev/null 2>&1'
    LBUFFER="cmd __ZT_NUL"
    zpwrExpandGlobalAliases __ZT_NUL
    assert $LBUFFER same_as 'cmd > /dev/null 2>&1'
    unset 'galiases[__ZT_NUL]'
}

@test 'combo-global-regular: global alias with multi-pipe expansion' {
    galiases[__ZT_CHAIN]='| sort | uniq | head'
    LBUFFER="cat data __ZT_CHAIN"
    zpwrExpandGlobalAliases __ZT_CHAIN
    assert $LBUFFER same_as 'cat data | sort | uniq | head'
    unset 'galiases[__ZT_CHAIN]'
}

@test 'combo-global-regular: global alias preserves prefix text' {
    galiases[__ZT_AWK]='| awk {print}'
    LBUFFER="cat /etc/passwd __ZT_AWK"
    zpwrExpandGlobalAliases __ZT_AWK
    assert $LBUFFER same_as 'cat /etc/passwd | awk {print}'
    unset 'galiases[__ZT_AWK]'
}

@test 'combo-global-regular: global alias after complex command' {
    galiases[__ZT_CNT]='| wc -l'
    LBUFFER="find . -type f -name *.log __ZT_CNT"
    zpwrExpandGlobalAliases __ZT_CNT
    assert $LBUFFER same_as 'find . -type f -name *.log | wc -l'
    unset 'galiases[__ZT_CNT]'
}

@test 'combo-global-regular: global alias single word expansion' {
    galiases[__ZT_TEE]='| tee output.txt'
    LBUFFER="make __ZT_TEE"
    zpwrExpandGlobalAliases __ZT_TEE
    assert $LBUFFER same_as 'make | tee output.txt'
    unset 'galiases[__ZT_TEE]'
}

@test 'combo-global-regular: regular alias not affected by global alias state' {
    galiases[__ZT_PREV]='| less'
    LBUFFER="cmd __ZT_PREV"
    zpwrExpandGlobalAliases __ZT_PREV

    LBUFFER="myword"
    ZPWR_VARS[lastword_lbuffer]=myword
    ZPWR_VARS[EXPANDED]='expanded_word'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias
    assert $LBUFFER same_as 'expanded_word'
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'

    unset 'galiases[__ZT_PREV]'
}

@test 'combo-global-regular: global alias with xargs' {
    galiases[__ZT_XA]='| xargs rm'
    LBUFFER="find /tmp -name *.bak __ZT_XA"
    zpwrExpandGlobalAliases __ZT_XA
    assert $LBUFFER same_as 'find /tmp -name *.bak | xargs rm'
    unset 'galiases[__ZT_XA]'
}

@test 'combo-global-regular: global alias with grep -c' {
    galiases[__ZT_GC]='| grep -c'
    LBUFFER="cat log __ZT_GC"
    zpwrExpandGlobalAliases __ZT_GC
    assert $LBUFFER same_as 'cat log | grep -c'
    unset 'galiases[__ZT_GC]'
}

#==============================================================
# Edge case: ZPWR_EXPAND_BLACKLIST behavior (20+ tests)
#==============================================================

@test 'combo-blacklist: blacklisted alias does not expand via expandAlias' {
    alias __zt_bl1='should not expand'
    ZPWR_VARS[blacklistUser]='^(__zt_bl1)$'
    LBUFFER="__zt_bl1"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_bl1'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_bl1
}

@test 'combo-blacklist: non-blacklisted alias still expands' {
    alias __zt_ok1='yes expanded'
    ZPWR_VARS[blacklistUser]='^(__zt_blocked)$'
    LBUFFER="__zt_ok1"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'yes expanded'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_ok1
}

@test 'combo-blacklist: empty blacklist allows expansion' {
    alias __zt_eb='empty blacklist ok'
    ZPWR_VARS[blacklistUser]=""
    LBUFFER="__zt_eb"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'empty blacklist ok'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_eb
}

@test 'combo-blacklist: blacklist with multiple entries blocks first' {
    alias __zt_b2a='blocked a'
    ZPWR_VARS[blacklistUser]='^(__zt_b2a|__zt_b2b)$'
    LBUFFER="__zt_b2a"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_b2a'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_b2a
}

@test 'combo-blacklist: blacklist with multiple entries blocks second' {
    alias __zt_b2b='blocked b'
    ZPWR_VARS[blacklistUser]='^(__zt_b2a|__zt_b2b)$'
    LBUFFER="__zt_b2b"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_b2b'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_b2b
}

@test 'combo-blacklist: blacklist regex match is exact not partial' {
    alias __zt_b3x='expanded partial'
    ZPWR_VARS[blacklistUser]='^(__zt_b3)$'
    LBUFFER="__zt_b3x"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'expanded partial'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_b3x
}

@test 'combo-blacklist: blacklist one alias while other expands' {
    alias __zt_blk='blocked'
    alias __zt_ok2='allowed'
    ZPWR_VARS[blacklistUser]='^(__zt_blk)$'

    LBUFFER="__zt_blk"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_blk'

    LBUFFER="__zt_ok2"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'allowed'

    ZPWR_VARS[blacklistUser]=""
    unalias __zt_blk __zt_ok2
}

@test 'combo-blacklist: blacklist cleared allows expansion again' {
    alias __zt_b4='value4'
    ZPWR_VARS[blacklistUser]='^(__zt_b4)$'
    LBUFFER="__zt_b4"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_b4'

    ZPWR_VARS[blacklistUser]=""
    LBUFFER="__zt_b4"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'value4'
    unalias __zt_b4
}

@test 'combo-blacklist: blacklist does not affect global aliases' {
    galiases[__ZT_BLG]='| grep blocked'
    ZPWR_VARS[blacklistUser]='^(__ZT_BLG)$'
    LBUFFER="cmd __ZT_BLG"
    zpwrExpandGlobalAliases __ZT_BLG
    assert $LBUFFER same_as 'cmd | grep blocked'
    ZPWR_VARS[blacklistUser]=""
    unset 'galiases[__ZT_BLG]'
}

@test 'combo-blacklist: blacklist with underscore in pattern' {
    alias __zt_under_score='value_us'
    ZPWR_VARS[blacklistUser]='^(__zt_under_score)$'
    LBUFFER="__zt_under_score"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_under_score'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_under_score
}

@test 'combo-blacklist: blacklist with hyphen in pattern' {
    alias __zt_hy-phen='value_hp'
    ZPWR_VARS[blacklistUser]='^(__zt_hy-phen)$'
    LBUFFER="__zt_hy-phen"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_hy-phen'
    ZPWR_VARS[blacklistUser]=""
    unalias -- __zt_hy-phen
}

@test 'combo-blacklist: blacklist three aliases blocks all three' {
    alias __zt_x1='v1'
    alias __zt_x2='v2'
    alias __zt_x3='v3'
    ZPWR_VARS[blacklistUser]='^(__zt_x1|__zt_x2|__zt_x3)$'

    for name in __zt_x1 __zt_x2 __zt_x3; do
        LBUFFER="$name"
        zpwrExpandParseWords "$LBUFFER"
        if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
            zpwrExpandGetAliasValue
            zpwrExpandAlias
        fi
        assert $LBUFFER same_as "$name"
    done
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_x1 __zt_x2 __zt_x3
}

@test 'combo-blacklist: blacklist after sudo context still blocks' {
    alias __zt_bsudo='blocked sudo'
    ZPWR_VARS[blacklistUser]='^(__zt_bsudo)$'
    LBUFFER="sudo __zt_bsudo"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'sudo __zt_bsudo'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_bsudo
}

@test 'combo-blacklist: blacklist after pipe context still blocks' {
    alias __zt_bpipe='blocked pipe'
    ZPWR_VARS[blacklistUser]='^(__zt_bpipe)$'
    LBUFFER="cat | __zt_bpipe"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'cat | __zt_bpipe'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_bpipe
}

@test 'combo-blacklist: blacklist with numeric name' {
    alias __zt_123='num blocked'
    ZPWR_VARS[blacklistUser]='^(__zt_123)$'
    LBUFFER="__zt_123"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_123'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_123
}

@test 'combo-blacklist: adding then removing from blacklist' {
    alias __zt_toggle='toggled'
    ZPWR_VARS[blacklistUser]='^(__zt_toggle)$'

    LBUFFER="__zt_toggle"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_toggle'

    ZPWR_VARS[blacklistUser]=""
    LBUFFER="__zt_toggle"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'toggled'
    unalias __zt_toggle
}

@test 'combo-blacklist: blacklist case sensitive' {
    alias __zt_Case='case value'
    ZPWR_VARS[blacklistUser]='^(__zt_case)$'
    LBUFFER="__zt_Case"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as 'case value'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_Case
}

@test 'combo-blacklist: blacklist with dot in name' {
    alias __zt_dot='dot value'
    ZPWR_VARS[blacklistUser]='^(__zt_dot)$'
    LBUFFER="__zt_dot"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $LBUFFER same_as '__zt_dot'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_dot
}

@test 'combo-blacklist: blacklist WAS_EXPANDED stays false' {
    alias __zt_bwe='blocked we'
    ZPWR_VARS[blacklistUser]='^(__zt_bwe)$'
    ZPWR_VARS[WAS_EXPANDED]=false
    LBUFFER="__zt_bwe"
    zpwrExpandParseWords "$LBUFFER"
    if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
        zpwrExpandGetAliasValue
        zpwrExpandAlias
    fi
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
    ZPWR_VARS[blacklistUser]=""
    unalias __zt_bwe
}

#==============================================================
# Edge case: empty and minimal inputs (20+ tests)
#==============================================================

@test 'combo-empty: empty LBUFFER parseWords no crash' {
    zpwrExpandParseWords ""
    assert $state equals 0
}

@test 'combo-empty: empty LBUFFER expandAlias no crash' {
    LBUFFER=""
    ZPWR_VARS[lastword_lbuffer]=""
    ZPWR_VARS[EXPANDED]='something'
    zpwrExpandAlias || :
    assert $LBUFFER same_as 'something'
}

@test 'combo-empty: empty LBUFFER rightTrim no crash' {
    LBUFFER=""
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'combo-empty: empty LBUFFER terminateSpace adds space' {
    LBUFFER=""
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as ' '
}

@test 'combo-empty: empty LBUFFER goToTabStop sets NEED_TO_ADD_SPACECHAR true' {
    LBUFFER=""
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'combo-empty: single character LBUFFER parseWords' {
    zpwrExpandParseWords "a"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'a'
    assert $ZPWR_VARS[firstword_partition] same_as 'a'
}

@test 'combo-empty: single character LBUFFER expandAlias' {
    LBUFFER="x"
    ZPWR_VARS[lastword_lbuffer]=x
    ZPWR_VARS[EXPANDED]='expanded_x'
    zpwrExpandAlias
    assert $LBUFFER same_as 'expanded_x'
}

@test 'combo-empty: single space LBUFFER rightTrim trims to empty' {
    LBUFFER=" "
    zpwrExpandRightTrim
    assert $LBUFFER same_as ''
}

@test 'combo-empty: single space LBUFFER terminateSpace adds second space' {
    LBUFFER=" "
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as '  '
}

@test 'combo-empty: single space LBUFFER expandAlias no match' {
    LBUFFER=" "
    ZPWR_VARS[lastword_lbuffer]=notmatch
    ZPWR_VARS[EXPANDED]='val'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'combo-empty: two spaces LBUFFER rightTrim no trim' {
    LBUFFER="  "
    zpwrExpandRightTrim
    assert $LBUFFER same_as '  '
}

@test 'combo-empty: tab character LBUFFER parseWords' {
    zpwrExpandParseWords "	"
    assert $state equals 0
}

@test 'combo-empty: single dash as LBUFFER' {
    zpwrExpandParseWords "-"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '-'
}

@test 'combo-empty: double dash as LBUFFER' {
    zpwrExpandParseWords "--"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '--'
}

@test 'combo-empty: semicolon only LBUFFER parseWords' {
    zpwrExpandParseWords ";"
    assert $state equals 0
}

@test 'combo-empty: pipe only LBUFFER parseWords' {
    zpwrExpandParseWords "|"
    assert $state equals 0
}

@test 'combo-empty: ampersand pair LBUFFER parseWords' {
    zpwrExpandParseWords "&&"
    assert $state equals 0
}

@test 'combo-empty: single word rightTrim no trailing space' {
    LBUFFER="word"
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'word'
}

@test 'combo-empty: single word terminateSpace appends' {
    LBUFFER="word"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'word '
}

@test 'combo-empty: only spaces LBUFFER expandAliasEscape no match' {
    LBUFFER="   "
    ZPWR_VARS[lastword_lbuffer]=nomatch
    ZPWR_VARS[EXPANDED]='val'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

#==============================================================
# Edge case: special characters in LBUFFER (30+ tests)
#==============================================================

@test 'combo-special: path /usr/bin/env parseWords lastword' {
    zpwrExpandParseWords "/usr/bin/env"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/usr/bin/env'
}

@test 'combo-special: tilde path ~/Documents parseWords' {
    zpwrExpandParseWords "cd ~/Documents"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '~/Documents'
}

@test 'combo-special: dot-slash path ./script.sh parseWords' {
    zpwrExpandParseWords "./script.sh"
    assert $ZPWR_VARS[lastword_lbuffer] same_as './script.sh'
}

@test 'combo-special: env var $HOME parseWords' {
    zpwrExpandParseWords 'echo $HOME'
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'combo-special: glob *.txt as lastword parseWords' {
    zpwrExpandParseWords "ls *.txt"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'combo-special: double glob **/*.zsh parseWords' {
    zpwrExpandParseWords "find **/*.zsh"
    assert $ZPWR_VARS[firstword_partition] same_as 'find'
}

@test 'combo-special: question mark glob file?.log parseWords' {
    zpwrExpandParseWords "ls file?.log"
    assert $ZPWR_VARS[firstword_partition] same_as 'ls'
}

@test 'combo-special: arithmetic expansion parseWords does not crash' {
    zpwrExpandParseWords 'echo $((1+2))'
    assert $state equals 0
}

@test 'combo-special: backslash n in LBUFFER expandAlias' {
    LBUFFER='echo \n'
    ZPWR_VARS[lastword_lbuffer]='\n'
    ZPWR_VARS[EXPANDED]='newline'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo newline'
}

@test 'combo-special: double backslash in LBUFFER' {
    LBUFFER='echo \\\\'
    zpwrExpandParseWords "$LBUFFER"
    assert $state equals 0
}

@test 'combo-special: path with dots /usr/local/../bin parseWords' {
    zpwrExpandParseWords "/usr/local/../bin"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/usr/local/../bin'
}

@test 'combo-special: equals in word FOO=bar parseWords removes assignment' {
    zpwrExpandParseWords "FOO=bar cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'combo-special: multiple equals assignments parseWords' {
    zpwrExpandParseWords "A=1 B=2 cmd"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd'
}

@test 'combo-special: parentheses stripped in lastword_remove_special' {
    zpwrExpandParseWords "func(x)"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'funcx'
}

@test 'combo-special: brackets stripped in lastword_remove_special' {
    zpwrExpandParseWords "arr[0]"
    assert "$ZPWR_VARS[lastword_remove_special]" same_as 'arr0'
}

@test 'combo-special: braces stripped in lastword_remove_special' {
    zpwrExpandParseWords 'echo ${VAR}'
    assert $state equals 0
}

@test 'combo-special: colon in path /usr/bin:path parseWords' {
    zpwrExpandParseWords "echo /usr/bin:path"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'combo-special: hash character parseWords' {
    zpwrExpandParseWords "echo #comment"
    assert $state equals 0
}

@test 'combo-special: at sign in email parseWords' {
    zpwrExpandParseWords "echo user@host"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

@test 'combo-special: percent in format string parseWords' {
    zpwrExpandParseWords "printf %s hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'printf'
}

@test 'combo-special: ampersand at end parseWords' {
    zpwrExpandParseWords "sleep 10 &"
    assert $state equals 0
}

@test 'combo-special: exclamation mark parseWords' {
    zpwrExpandParseWords "echo !!"
    assert $state equals 0
}

@test 'combo-special: dollar sign question mark parseWords' {
    zpwrExpandParseWords 'echo $?'
    assert $state equals 0
}

@test 'combo-special: absolute path with spaces conceptual' {
    zpwrExpandParseWords "ls /tmp/my-file"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '/tmp/my-file'
}

@test 'combo-special: url-like string parseWords' {
    zpwrExpandParseWords "curl https://example.com"
    assert $ZPWR_VARS[firstword_partition] same_as 'curl'
}

@test 'combo-special: mixed operators in LBUFFER' {
    zpwrExpandParseWords "cmd1 && cmd2 || cmd3"
    assert $ZPWR_VARS[firstword_partition] same_as 'cmd3'
}

@test 'combo-special: semicolon then pipe' {
    zpwrExpandParseWords "a; b | c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'combo-special: pipe then semicolon' {
    zpwrExpandParseWords "a | b; c"
    assert $ZPWR_VARS[firstword_partition] same_as 'c'
}

@test 'combo-special: numeric word parseWords' {
    zpwrExpandParseWords "echo 12345"
    assert $ZPWR_VARS[lastword_lbuffer] same_as '12345'
}

@test 'combo-special: word with period parseWords' {
    zpwrExpandParseWords "echo file.txt"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'file.txt'
}

@test 'combo-special: comma separated values parseWords' {
    zpwrExpandParseWords "echo a,b,c"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
}

#==============================================================
# Edge case: very long inputs (10+ tests)
#==============================================================

@test 'combo-long: LBUFFER with 10 words parseWords' {
    zpwrExpandParseWords "a b c d e f g h i j"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'j'
    assert $ZPWR_VARS[firstword_partition] same_as 'a'
}

@test 'combo-long: LBUFFER with 20 words parseWords' {
    zpwrExpandParseWords "w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 w12 w13 w14 w15 w16 w17 w18 w19 w20"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'w20'
    assert $ZPWR_VARS[firstword_partition] same_as 'w1'
}

@test 'combo-long: very long single word 50 chars' {
    local longword="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWX"
    zpwrExpandParseWords "$longword"
    assert $ZPWR_VARS[lastword_lbuffer] same_as "$longword"
}

@test 'combo-long: very long single word 80 chars' {
    local longword="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    zpwrExpandParseWords "$longword"
    assert $ZPWR_VARS[lastword_lbuffer] same_as "$longword"
}

@test 'combo-long: many pipes in chain firstword of last segment' {
    zpwrExpandParseWords "a | b | c | d | e | f | g | h"
    assert $ZPWR_VARS[firstword_partition] same_as 'h'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'h'
}

@test 'combo-long: many semicolons firstword of last segment' {
    zpwrExpandParseWords "a; b; c; d; e; f; g; h"
    assert $ZPWR_VARS[firstword_partition] same_as 'h'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'h'
}

@test 'combo-long: many && operators firstword of last segment' {
    zpwrExpandParseWords "a && b && c && d && e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'combo-long: long alias expansion value' {
    local longval="find / -type f -name pattern -newer ref -not -path */node_modules/* -not -path */.git/* -exec grep -l search {} + 2>/dev/null"
    LBUFFER="myalias"
    ZPWR_VARS[lastword_lbuffer]=myalias
    ZPWR_VARS[EXPANDED]=$longval
    zpwrExpandAlias
    assert $LBUFFER same_as "$longval"
}

@test 'combo-long: LBUFFER with 15 words and alias at end' {
    alias __zt_last='final command'
    LBUFFER="a b c d e f g h i j k l m n; __zt_last"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'a b c d e f g h i j k l m n; final command'
    unalias __zt_last
}

@test 'combo-long: mixed operators with many segments' {
    zpwrExpandParseWords "a; b && c || d | e; f && g || h; final"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'final'
}

@test 'combo-long: expansion with 100+ char value' {
    local bigval="aaaaaaaaaa bbbbbbbbbb cccccccccc dddddddddd eeeeeeeeee ffffffffff gggggggggg hhhhhhhhhh iiiiiiiiii jjjjjjjjjj"
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]=$bigval
    zpwrExpandAlias
    assert $LBUFFER same_as "$bigval"
}

@test 'combo-long: pipe chain with args' {
    zpwrExpandParseWords "cat file.txt | grep -i pattern | sort -u | head -n 10 | tee output.log"
    assert $ZPWR_VARS[firstword_partition] same_as 'tee'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'output.log'
}

#==============================================================
# Cross-function state isolation (20+ tests)
#==============================================================

@test 'combo-state: rightTrim does not affect lastword_lbuffer' {
    ZPWR_VARS[lastword_lbuffer]='preserved'
    LBUFFER="test "
    zpwrExpandRightTrim
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'preserved'
}

@test 'combo-state: rightTrim does not affect EXPANDED' {
    ZPWR_VARS[EXPANDED]='my_expanded'
    LBUFFER="test "
    zpwrExpandRightTrim
    assert $ZPWR_VARS[EXPANDED] same_as 'my_expanded'
}

@test 'combo-state: rightTrim does not affect WAS_EXPANDED' {
    ZPWR_VARS[WAS_EXPANDED]=true
    LBUFFER="test "
    zpwrExpandRightTrim
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'combo-state: rightTrim does not affect firstword_partition' {
    ZPWR_VARS[firstword_partition]='first'
    LBUFFER="test "
    zpwrExpandRightTrim
    assert $ZPWR_VARS[firstword_partition] same_as 'first'
}

@test 'combo-state: terminateSpace does not affect lastword_lbuffer' {
    ZPWR_VARS[lastword_lbuffer]='preserved'
    LBUFFER="test"
    zpwrExpandTerminateSpace
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'preserved'
}

@test 'combo-state: terminateSpace does not affect EXPANDED' {
    ZPWR_VARS[EXPANDED]='my_expanded'
    LBUFFER="test"
    zpwrExpandTerminateSpace
    assert $ZPWR_VARS[EXPANDED] same_as 'my_expanded'
}

@test 'combo-state: terminateSpace does not affect WAS_EXPANDED' {
    ZPWR_VARS[WAS_EXPANDED]=false
    LBUFFER="test"
    zpwrExpandTerminateSpace
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'combo-state: terminateSpace does not affect foundIncorrect' {
    ZPWR_VARS[foundIncorrect]=true
    LBUFFER="test"
    zpwrExpandTerminateSpace
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'combo-state: parseWords properly sets lastword_lbuffer' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'status'
}

@test 'combo-state: parseWords properly sets firstword_partition' {
    zpwrExpandParseWords "git status"
    assert $ZPWR_VARS[firstword_partition] same_as 'git'
}

@test 'combo-state: parseWords resets firstword on new call' {
    zpwrExpandParseWords "first1 last1"
    assert $ZPWR_VARS[firstword_partition] same_as 'first1'
    zpwrExpandParseWords "first2 last2"
    assert $ZPWR_VARS[firstword_partition] same_as 'first2'
}

@test 'combo-state: parseWords resets lastword on new call' {
    zpwrExpandParseWords "first1 last1"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'last1'
    zpwrExpandParseWords "first2 last2"
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'last2'
}

@test 'combo-state: expandAlias does not set WAS_EXPANDED when no match' {
    LBUFFER="nomatch "
    ZPWR_VARS[lastword_lbuffer]=nomatch
    ZPWR_VARS[EXPANDED]='val'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAlias || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'combo-state: expandAliasEscape does not set WAS_EXPANDED when no match' {
    LBUFFER="nomatch "
    ZPWR_VARS[lastword_lbuffer]=nomatch
    ZPWR_VARS[EXPANDED]='nomatch -flag'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape || :
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'false'
}

@test 'combo-state: parseWords then expandAlias then parseWords fresh state' {
    zpwrExpandParseWords "git status"
    LBUFFER="git status"
    ZPWR_VARS[EXPANDED]='git status -s'
    zpwrExpandAlias

    zpwrExpandParseWords "echo hello"
    assert $ZPWR_VARS[firstword_partition] same_as 'echo'
    assert $ZPWR_VARS[lastword_lbuffer] same_as 'hello'
}

@test 'combo-state: NEED_TO_ADD_SPACECHAR preserved by expandAlias' {
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=false
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='expanded'
    zpwrExpandAlias
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'combo-state: rightTrim does not affect NEED_TO_ADD_SPACECHAR' {
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=false
    LBUFFER="cmd "
    zpwrExpandRightTrim
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

@test 'combo-state: terminateSpace does not affect NEED_TO_ADD_SPACECHAR' {
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    LBUFFER="cmd"
    zpwrExpandTerminateSpace
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'combo-state: goToTabStop sets NEED_TO_ADD_SPACECHAR true when no tabstop' {
    LBUFFER="no tabstop here"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

@test 'combo-state: goToTabStop sets NEED_TO_ADD_SPACECHAR false when tabstop present' {
    LBUFFER="cmd ${ZPWR_TABSTOP} rest"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}

#==============================================================
# Alias values with various content (30+ tests)
#==============================================================

@test 'combo-content: alias value with tab character' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]="echo	tab"
    zpwrExpandAlias
    assert $LBUFFER same_as "echo	tab"
}

@test 'combo-content: alias value with multiple consecutive spaces' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo   three   spaces'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo   three   spaces'
}

@test 'combo-content: alias value with empty string' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]=''
    zpwrExpandAlias
    assert $LBUFFER same_as ''
}

@test 'combo-content: alias value that is just a space' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]=' '
    zpwrExpandAlias
    assert $LBUFFER same_as ' '
}

@test 'combo-content: alias value with leading spaces' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='  leading'
    zpwrExpandAlias
    assert $LBUFFER same_as '  leading'
}

@test 'combo-content: alias value with trailing spaces' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='trailing  '
    zpwrExpandAlias
    assert $LBUFFER same_as 'trailing  '
}

@test 'combo-content: alias value with dot chars' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='ls ./path/../other'
    zpwrExpandAlias
    assert $LBUFFER same_as 'ls ./path/../other'
}

@test 'combo-content: alias value with asterisk' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo *'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo *'
}

@test 'combo-content: alias value with plus sign' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo a+b'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo a+b'
}

@test 'combo-content: alias value with question mark' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo file?.txt'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo file?.txt'
}

@test 'combo-content: alias value with square brackets' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo [abc]'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo [abc]'
}

@test 'combo-content: alias value with parentheses' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo (group)'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo (group)'
}

@test 'combo-content: alias value with curly braces' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo {a,b,c}'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo {a,b,c}'
}

@test 'combo-content: alias value with caret' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='grep ^pattern'
    zpwrExpandAlias
    assert $LBUFFER same_as 'grep ^pattern'
}

@test 'combo-content: alias value with dollar sign' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='grep pattern$'
    zpwrExpandAlias
    assert $LBUFFER same_as 'grep pattern$'
}

@test 'combo-content: alias value with pipe character in expansion' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='grep -E "a|b"'
    zpwrExpandAlias
    assert $LBUFFER same_as 'grep -E "a|b"'
}

@test 'combo-content: alias value with backslash' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo \\n'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo \\n'
}

@test 'combo-content: alias value with tilde' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='cd ~'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cd ~'
}

@test 'combo-content: alias value with hash' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo #comment'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo #comment'
}

@test 'combo-content: alias value with at sign' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo user@host'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo user@host'
}

@test 'combo-content: alias value with exclamation' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo hello!'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo hello!'
}

@test 'combo-content: alias value with semicolons' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo a; echo b'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo a; echo b'
}

@test 'combo-content: alias value with ampersands' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='cmd1 && cmd2'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cmd1 && cmd2'
}

@test 'combo-content: alias value with single quotes in double quoted context' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]="echo 'hello'"
    zpwrExpandAlias
    assert $LBUFFER same_as "echo 'hello'"
}

@test 'combo-content: alias value with double quotes' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo "hello world"'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo "hello world"'
}

@test 'combo-content: alias value with equals signs' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='make CFLAGS=-O2 LDFLAGS=-lm'
    zpwrExpandAlias
    assert $LBUFFER same_as 'make CFLAGS=-O2 LDFLAGS=-lm'
}

@test 'combo-content: alias value with colons' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo a:b:c'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo a:b:c'
}

@test 'combo-content: alias value with comma' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='echo a,b,c'
    zpwrExpandAlias
    assert $LBUFFER same_as 'echo a,b,c'
}

@test 'combo-content: alias value 100 chars long' {
    local val100="aaaaaaaaaa_bbbbbbbbb_ccccccccc_ddddddddd_eeeeeeeee_fffffffff_ggggggggg_hhhhhhhhh_iiiiiiiii_jjjjjjjjj"
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]=$val100
    zpwrExpandAlias
    assert $LBUFFER same_as "$val100"
}

@test 'combo-content: alias value with multiple flag styles' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='tar -xzvf --strip-components=1 -C /tmp'
    zpwrExpandAlias
    assert $LBUFFER same_as 'tar -xzvf --strip-components=1 -C /tmp'
}

@test 'combo-content: alias value with redirection operators' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='cat < input > output 2>&1'
    zpwrExpandAlias
    assert $LBUFFER same_as 'cat < input > output 2>&1'
}

#==============================================================
# Additional combination and integration tests
#==============================================================

@test 'combo-extra-parse-alias: alias expanding to sudo command' {
    alias __zt_svc='sudo systemctl restart'
    LBUFFER="__zt_svc"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'sudo systemctl restart'
    unalias __zt_svc
}

@test 'combo-extra-parse-alias: alias with double dash separator' {
    alias __zt_dd='git checkout --'
    LBUFFER="__zt_dd"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'git checkout --'
    unalias __zt_dd
}

@test 'combo-extra-parse-alias: alias expanding to command with redirect' {
    alias __zt_quiet='make 2>/dev/null'
    LBUFFER="__zt_quiet"
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandGetAliasValue
    zpwrExpandAlias
    assert $LBUFFER same_as 'make 2>/dev/null'
    unalias __zt_quiet
}

@test 'combo-extra-correct: correct updaet to update' {
    LBUFFER="echo updaet"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo update'
}

@test 'combo-extra-correct: correct dokcer to docker' {
    LBUFFER="echo dokcer"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo docker'
}

@test 'combo-extra-correct: correct igt to git' {
    LBUFFER="echo igt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo git'
}

@test 'combo-extra-correct: correct usdo to sudo' {
    LBUFFER="echo usdo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo sudo'
}

@test 'combo-extra-correct: correct cahnge to change' {
    LBUFFER="echo cahnge"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo change'
}

@test 'combo-extra-state: parseWords updates lastword_remove_special' {
    zpwrExpandParseWords "echo test"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'test'
    zpwrExpandParseWords "echo other"
    assert $ZPWR_VARS[lastword_remove_special] same_as 'other'
}

@test 'combo-extra-state: expandAlias preserves foundIncorrect' {
    ZPWR_VARS[foundIncorrect]=true
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='expanded'
    zpwrExpandAlias
    assert $ZPWR_VARS[foundIncorrect] same_as 'true'
}

@test 'combo-extra-state: expandAliasEscape preserves foundIncorrect' {
    ZPWR_VARS[foundIncorrect]=false
    LBUFFER="self"
    ZPWR_VARS[lastword_lbuffer]=self
    ZPWR_VARS[EXPANDED]='self -x'
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'combo-extra-multi: three corrections in a row' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'

    LBUFFER="echo adn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'

    LBUFFER="echo nad"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo and'
}

@test 'combo-extra-special: parseWords with process substitution syntax' {
    zpwrExpandParseWords "diff <(cmd1)"
    assert $state equals 0
}

@test 'combo-extra-special: parseWords with heredoc marker' {
    zpwrExpandParseWords "cat <<EOF"
    assert $state equals 0
}

@test 'combo-extra-special: parseWords with nested quotes' {
    zpwrExpandParseWords "echo 'hello \"world\"'"
    assert $state equals 0
}

@test 'combo-extra-special: parseWords with backtick substitution' {
    zpwrExpandParseWords 'echo `date`'
    assert $state equals 0
}

@test 'combo-extra-long: many || operators' {
    zpwrExpandParseWords "a || b || c || d || e || f"
    assert $ZPWR_VARS[firstword_partition] same_as 'f'
}

@test 'combo-extra-long: alternating && and || operators' {
    zpwrExpandParseWords "a && b || c && d || e"
    assert $ZPWR_VARS[firstword_partition] same_as 'e'
}

@test 'combo-extra-content: alias value with underscore' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='my_command_name'
    zpwrExpandAlias
    assert $LBUFFER same_as 'my_command_name'
}

@test 'combo-extra-content: alias value with dash in command name' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='my-command --flag'
    zpwrExpandAlias
    assert $LBUFFER same_as 'my-command --flag'
}

@test 'combo-extra-content: alias value with absolute path' {
    LBUFFER="cmd"
    ZPWR_VARS[lastword_lbuffer]=cmd
    ZPWR_VARS[EXPANDED]='/usr/local/bin/my-tool --config /etc/my.conf'
    zpwrExpandAlias
    assert $LBUFFER same_as '/usr/local/bin/my-tool --config /etc/my.conf'
}

@test 'combo-extra-trim: rightTrim then expandAliasEscape' {
    LBUFFER="__zt_selfref "
    zpwrExpandRightTrim
    ZPWR_VARS[lastword_lbuffer]=__zt_selfref
    ZPWR_VARS[EXPANDED]='__zt_selfref -v'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\__zt_selfref -v'
}

@test 'combo-extra-trim: rightTrim then global alias expand' {
    galiases[__ZT_TRIM_G]='| grep trimmed'
    LBUFFER="cmd __ZT_TRIM_G "
    zpwrExpandRightTrim
    zpwrExpandGlobalAliases __ZT_TRIM_G
    assert $LBUFFER same_as 'cmd | grep trimmed'
    unset 'galiases[__ZT_TRIM_G]'
}

@test 'combo-extra-blacklist: blacklist does not affect correctWord' {
    ZPWR_VARS[blacklistUser]='^(teh)$'
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
    ZPWR_VARS[blacklistUser]=""
}

@test 'combo-extra-blacklist: blacklist does not affect terminateSpace' {
    ZPWR_VARS[blacklistUser]='^(cmd)$'
    LBUFFER="cmd"
    zpwrExpandTerminateSpace
    assert $LBUFFER same_as 'cmd '
    ZPWR_VARS[blacklistUser]=""
}

@test 'combo-extra-blacklist: blacklist does not affect rightTrim' {
    ZPWR_VARS[blacklistUser]='^(cmd)$'
    LBUFFER="cmd "
    zpwrExpandRightTrim
    assert $LBUFFER same_as 'cmd'
    ZPWR_VARS[blacklistUser]=""
}

@test 'combo-extra-empty: goToTabStop with only tabstop in LBUFFER' {
    LBUFFER="${ZPWR_TABSTOP}"
    RBUFFER=""
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'false'
}
