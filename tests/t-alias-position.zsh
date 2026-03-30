#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Mar 25 2026
##### Purpose: alias expansion position tests
##### Notes: tests zpwrExpandAlias and zpwrExpandAliasEscape in many positions
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

@test 'alias basic: ls -> ls -la' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'ls -la'
}

@test 'alias after-pipe: cmd | ls' {
    LBUFFER="cmd | ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | ls -la'
}

@test 'alias after-semi: cmd; ls' {
    LBUFFER="cmd; ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; ls -la'
}

@test 'alias after-and: cmd && ls' {
    LBUFFER="cmd && ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && ls -la'
}

@test 'alias after-or: cmd || ls' {
    LBUFFER="cmd || ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || ls -la'
}

@test 'alias 1sp:  ls' {
    LBUFFER=" ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' ls -la'
}

@test 'alias 2sp:   ls' {
    LBUFFER="  ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  ls -la'
}

@test 'alias 3sp:    ls' {
    LBUFFER="   ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   ls -la'
}

@test 'alias 4sp:     ls' {
    LBUFFER="    ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    ls -la'
}

@test 'alias no-expand trail: ls ' {
    LBUFFER="ls "
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'ls '
}

@test 'alias basic: git -> git status' {
    LBUFFER="git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'git status'
}

@test 'alias after-pipe: cmd | git' {
    LBUFFER="cmd | git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | git status'
}

@test 'alias after-semi: cmd; git' {
    LBUFFER="cmd; git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; git status'
}

@test 'alias after-and: cmd && git' {
    LBUFFER="cmd && git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && git status'
}

@test 'alias after-or: cmd || git' {
    LBUFFER="cmd || git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || git status'
}

@test 'alias 1sp:  git' {
    LBUFFER=" git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' git status'
}

@test 'alias 2sp:   git' {
    LBUFFER="  git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  git status'
}

@test 'alias 3sp:    git' {
    LBUFFER="   git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   git status'
}

@test 'alias 4sp:     git' {
    LBUFFER="    git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    git status'
}

@test 'alias no-expand trail: git ' {
    LBUFFER="git "
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'git '
}

@test 'alias basic: echo -> echo -e' {
    LBUFFER="echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'echo -e'
}

@test 'alias after-pipe: cmd | echo' {
    LBUFFER="cmd | echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | echo -e'
}

@test 'alias after-semi: cmd; echo' {
    LBUFFER="cmd; echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; echo -e'
}

@test 'alias after-and: cmd && echo' {
    LBUFFER="cmd && echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && echo -e'
}

@test 'alias after-or: cmd || echo' {
    LBUFFER="cmd || echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || echo -e'
}

@test 'alias 1sp:  echo' {
    LBUFFER=" echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' echo -e'
}

@test 'alias 2sp:   echo' {
    LBUFFER="  echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  echo -e'
}

@test 'alias 3sp:    echo' {
    LBUFFER="   echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   echo -e'
}

@test 'alias 4sp:     echo' {
    LBUFFER="    echo"
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    echo -e'
}

@test 'alias no-expand trail: echo ' {
    LBUFFER="echo "
    ZPWR_VARS[lastword_lbuffer]=echo
    ZPWR_VARS[EXPANDED]='echo -e'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'echo '
}

@test 'alias basic: cat -> cat -n' {
    LBUFFER="cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cat -n'
}

@test 'alias after-pipe: cmd | cat' {
    LBUFFER="cmd | cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | cat -n'
}

@test 'alias after-semi: cmd; cat' {
    LBUFFER="cmd; cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; cat -n'
}

@test 'alias after-and: cmd && cat' {
    LBUFFER="cmd && cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && cat -n'
}

@test 'alias after-or: cmd || cat' {
    LBUFFER="cmd || cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || cat -n'
}

@test 'alias 1sp:  cat' {
    LBUFFER=" cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' cat -n'
}

@test 'alias 2sp:   cat' {
    LBUFFER="  cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  cat -n'
}

@test 'alias 3sp:    cat' {
    LBUFFER="   cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   cat -n'
}

@test 'alias 4sp:     cat' {
    LBUFFER="    cat"
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    cat -n'
}

@test 'alias no-expand trail: cat ' {
    LBUFFER="cat "
    ZPWR_VARS[lastword_lbuffer]=cat
    ZPWR_VARS[EXPANDED]='cat -n'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'cat '
}

@test 'alias basic: grep -> grep --color' {
    LBUFFER="grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'grep --color'
}

@test 'alias after-pipe: cmd | grep' {
    LBUFFER="cmd | grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | grep --color'
}

@test 'alias after-semi: cmd; grep' {
    LBUFFER="cmd; grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; grep --color'
}

@test 'alias after-and: cmd && grep' {
    LBUFFER="cmd && grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && grep --color'
}

@test 'alias after-or: cmd || grep' {
    LBUFFER="cmd || grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || grep --color'
}

@test 'alias 1sp:  grep' {
    LBUFFER=" grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' grep --color'
}

@test 'alias 2sp:   grep' {
    LBUFFER="  grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  grep --color'
}

@test 'alias 3sp:    grep' {
    LBUFFER="   grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   grep --color'
}

@test 'alias 4sp:     grep' {
    LBUFFER="    grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    grep --color'
}

@test 'alias no-expand trail: grep ' {
    LBUFFER="grep "
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'grep '
}

@test 'alias basic: sed -> sed -E' {
    LBUFFER="sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'sed -E'
}

@test 'alias after-pipe: cmd | sed' {
    LBUFFER="cmd | sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | sed -E'
}

@test 'alias after-semi: cmd; sed' {
    LBUFFER="cmd; sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; sed -E'
}

@test 'alias after-and: cmd && sed' {
    LBUFFER="cmd && sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && sed -E'
}

@test 'alias after-or: cmd || sed' {
    LBUFFER="cmd || sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || sed -E'
}

@test 'alias 1sp:  sed' {
    LBUFFER=" sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' sed -E'
}

@test 'alias 2sp:   sed' {
    LBUFFER="  sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  sed -E'
}

@test 'alias 3sp:    sed' {
    LBUFFER="   sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   sed -E'
}

@test 'alias 4sp:     sed' {
    LBUFFER="    sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    sed -E'
}

@test 'alias no-expand trail: sed ' {
    LBUFFER="sed "
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'sed '
}

@test 'alias basic: awk -> awk -F,' {
    LBUFFER="awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'awk -F,'
}

@test 'alias after-pipe: cmd | awk' {
    LBUFFER="cmd | awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | awk -F,'
}

@test 'alias after-semi: cmd; awk' {
    LBUFFER="cmd; awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; awk -F,'
}

@test 'alias after-and: cmd && awk' {
    LBUFFER="cmd && awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && awk -F,'
}

@test 'alias after-or: cmd || awk' {
    LBUFFER="cmd || awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || awk -F,'
}

@test 'alias 1sp:  awk' {
    LBUFFER=" awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' awk -F,'
}

@test 'alias 2sp:   awk' {
    LBUFFER="  awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  awk -F,'
}

@test 'alias 3sp:    awk' {
    LBUFFER="   awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   awk -F,'
}

@test 'alias 4sp:     awk' {
    LBUFFER="    awk"
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    awk -F,'
}

@test 'alias no-expand trail: awk ' {
    LBUFFER="awk "
    ZPWR_VARS[lastword_lbuffer]=awk
    ZPWR_VARS[EXPANDED]='awk -F,'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'awk '
}

@test 'alias basic: make -> make -j4' {
    LBUFFER="make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'make -j4'
}

@test 'alias after-pipe: cmd | make' {
    LBUFFER="cmd | make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | make -j4'
}

@test 'alias after-semi: cmd; make' {
    LBUFFER="cmd; make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; make -j4'
}

@test 'alias after-and: cmd && make' {
    LBUFFER="cmd && make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && make -j4'
}

@test 'alias after-or: cmd || make' {
    LBUFFER="cmd || make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || make -j4'
}

@test 'alias 1sp:  make' {
    LBUFFER=" make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' make -j4'
}

@test 'alias 2sp:   make' {
    LBUFFER="  make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  make -j4'
}

@test 'alias 3sp:    make' {
    LBUFFER="   make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   make -j4'
}

@test 'alias 4sp:     make' {
    LBUFFER="    make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    make -j4'
}

@test 'alias no-expand trail: make ' {
    LBUFFER="make "
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'make '
}

@test 'alias basic: find -> find .' {
    LBUFFER="find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'find .'
}

@test 'alias after-pipe: cmd | find' {
    LBUFFER="cmd | find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | find .'
}

@test 'alias after-semi: cmd; find' {
    LBUFFER="cmd; find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; find .'
}

@test 'alias after-and: cmd && find' {
    LBUFFER="cmd && find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && find .'
}

@test 'alias after-or: cmd || find' {
    LBUFFER="cmd || find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || find .'
}

@test 'alias 1sp:  find' {
    LBUFFER=" find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' find .'
}

@test 'alias 2sp:   find' {
    LBUFFER="  find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  find .'
}

@test 'alias 3sp:    find' {
    LBUFFER="   find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   find .'
}

@test 'alias 4sp:     find' {
    LBUFFER="    find"
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    find .'
}

@test 'alias no-expand trail: find ' {
    LBUFFER="find "
    ZPWR_VARS[lastword_lbuffer]=find
    ZPWR_VARS[EXPANDED]='find .'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'find '
}

@test 'alias basic: sort -> sort -n' {
    LBUFFER="sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'sort -n'
}

@test 'alias after-pipe: cmd | sort' {
    LBUFFER="cmd | sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | sort -n'
}

@test 'alias after-semi: cmd; sort' {
    LBUFFER="cmd; sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; sort -n'
}

@test 'alias after-and: cmd && sort' {
    LBUFFER="cmd && sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && sort -n'
}

@test 'alias after-or: cmd || sort' {
    LBUFFER="cmd || sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || sort -n'
}

@test 'alias 1sp:  sort' {
    LBUFFER=" sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' sort -n'
}

@test 'alias 2sp:   sort' {
    LBUFFER="  sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  sort -n'
}

@test 'alias 3sp:    sort' {
    LBUFFER="   sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   sort -n'
}

@test 'alias 4sp:     sort' {
    LBUFFER="    sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    sort -n'
}

@test 'alias no-expand trail: sort ' {
    LBUFFER="sort "
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'sort '
}

@test 'alias basic: head -> head -20' {
    LBUFFER="head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'head -20'
}

@test 'alias after-pipe: cmd | head' {
    LBUFFER="cmd | head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | head -20'
}

@test 'alias after-semi: cmd; head' {
    LBUFFER="cmd; head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; head -20'
}

@test 'alias after-and: cmd && head' {
    LBUFFER="cmd && head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && head -20'
}

@test 'alias after-or: cmd || head' {
    LBUFFER="cmd || head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || head -20'
}

@test 'alias 1sp:  head' {
    LBUFFER=" head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' head -20'
}

@test 'alias 2sp:   head' {
    LBUFFER="  head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  head -20'
}

@test 'alias 3sp:    head' {
    LBUFFER="   head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   head -20'
}

@test 'alias 4sp:     head' {
    LBUFFER="    head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    head -20'
}

@test 'alias no-expand trail: head ' {
    LBUFFER="head "
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'head '
}

@test 'alias basic: tail -> tail -f' {
    LBUFFER="tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'tail -f'
}

@test 'alias after-pipe: cmd | tail' {
    LBUFFER="cmd | tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | tail -f'
}

@test 'alias after-semi: cmd; tail' {
    LBUFFER="cmd; tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; tail -f'
}

@test 'alias after-and: cmd && tail' {
    LBUFFER="cmd && tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && tail -f'
}

@test 'alias after-or: cmd || tail' {
    LBUFFER="cmd || tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || tail -f'
}

@test 'alias 1sp:  tail' {
    LBUFFER=" tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' tail -f'
}

@test 'alias 2sp:   tail' {
    LBUFFER="  tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  tail -f'
}

@test 'alias 3sp:    tail' {
    LBUFFER="   tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   tail -f'
}

@test 'alias 4sp:     tail' {
    LBUFFER="    tail"
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    tail -f'
}

@test 'alias no-expand trail: tail ' {
    LBUFFER="tail "
    ZPWR_VARS[lastword_lbuffer]=tail
    ZPWR_VARS[EXPANDED]='tail -f'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'tail '
}

@test 'alias basic: wc -> wc -l' {
    LBUFFER="wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'wc -l'
}

@test 'alias after-pipe: cmd | wc' {
    LBUFFER="cmd | wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | wc -l'
}

@test 'alias after-semi: cmd; wc' {
    LBUFFER="cmd; wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; wc -l'
}

@test 'alias after-and: cmd && wc' {
    LBUFFER="cmd && wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && wc -l'
}

@test 'alias after-or: cmd || wc' {
    LBUFFER="cmd || wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || wc -l'
}

@test 'alias 1sp:  wc' {
    LBUFFER=" wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' wc -l'
}

@test 'alias 2sp:   wc' {
    LBUFFER="  wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  wc -l'
}

@test 'alias 3sp:    wc' {
    LBUFFER="   wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   wc -l'
}

@test 'alias 4sp:     wc' {
    LBUFFER="    wc"
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    wc -l'
}

@test 'alias no-expand trail: wc ' {
    LBUFFER="wc "
    ZPWR_VARS[lastword_lbuffer]=wc
    ZPWR_VARS[EXPANDED]='wc -l'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'wc '
}

@test 'alias basic: cp -> cp -r' {
    LBUFFER="cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cp -r'
}

@test 'alias after-pipe: cmd | cp' {
    LBUFFER="cmd | cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | cp -r'
}

@test 'alias after-semi: cmd; cp' {
    LBUFFER="cmd; cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; cp -r'
}

@test 'alias after-and: cmd && cp' {
    LBUFFER="cmd && cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && cp -r'
}

@test 'alias after-or: cmd || cp' {
    LBUFFER="cmd || cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || cp -r'
}

@test 'alias 1sp:  cp' {
    LBUFFER=" cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' cp -r'
}

@test 'alias 2sp:   cp' {
    LBUFFER="  cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  cp -r'
}

@test 'alias 3sp:    cp' {
    LBUFFER="   cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   cp -r'
}

@test 'alias 4sp:     cp' {
    LBUFFER="    cp"
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    cp -r'
}

@test 'alias no-expand trail: cp ' {
    LBUFFER="cp "
    ZPWR_VARS[lastword_lbuffer]=cp
    ZPWR_VARS[EXPANDED]='cp -r'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'cp '
}

@test 'alias basic: mv -> mv -i' {
    LBUFFER="mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'mv -i'
}

@test 'alias after-pipe: cmd | mv' {
    LBUFFER="cmd | mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | mv -i'
}

@test 'alias after-semi: cmd; mv' {
    LBUFFER="cmd; mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; mv -i'
}

@test 'alias after-and: cmd && mv' {
    LBUFFER="cmd && mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && mv -i'
}

@test 'alias after-or: cmd || mv' {
    LBUFFER="cmd || mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || mv -i'
}

@test 'alias 1sp:  mv' {
    LBUFFER=" mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' mv -i'
}

@test 'alias 2sp:   mv' {
    LBUFFER="  mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  mv -i'
}

@test 'alias 3sp:    mv' {
    LBUFFER="   mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   mv -i'
}

@test 'alias 4sp:     mv' {
    LBUFFER="    mv"
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    mv -i'
}

@test 'alias no-expand trail: mv ' {
    LBUFFER="mv "
    ZPWR_VARS[lastword_lbuffer]=mv
    ZPWR_VARS[EXPANDED]='mv -i'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'mv '
}

@test 'alias basic: rm -> rm -i' {
    LBUFFER="rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'rm -i'
}

@test 'alias after-pipe: cmd | rm' {
    LBUFFER="cmd | rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | rm -i'
}

@test 'alias after-semi: cmd; rm' {
    LBUFFER="cmd; rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; rm -i'
}

@test 'alias after-and: cmd && rm' {
    LBUFFER="cmd && rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && rm -i'
}

@test 'alias after-or: cmd || rm' {
    LBUFFER="cmd || rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || rm -i'
}

@test 'alias 1sp:  rm' {
    LBUFFER=" rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' rm -i'
}

@test 'alias 2sp:   rm' {
    LBUFFER="  rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  rm -i'
}

@test 'alias 3sp:    rm' {
    LBUFFER="   rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   rm -i'
}

@test 'alias 4sp:     rm' {
    LBUFFER="    rm"
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    rm -i'
}

@test 'alias no-expand trail: rm ' {
    LBUFFER="rm "
    ZPWR_VARS[lastword_lbuffer]=rm
    ZPWR_VARS[EXPANDED]='rm -i'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'rm '
}

@test 'alias basic: mkdir -> mkdir -p' {
    LBUFFER="mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'mkdir -p'
}

@test 'alias after-pipe: cmd | mkdir' {
    LBUFFER="cmd | mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | mkdir -p'
}

@test 'alias after-semi: cmd; mkdir' {
    LBUFFER="cmd; mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; mkdir -p'
}

@test 'alias after-and: cmd && mkdir' {
    LBUFFER="cmd && mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && mkdir -p'
}

@test 'alias after-or: cmd || mkdir' {
    LBUFFER="cmd || mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || mkdir -p'
}

@test 'alias 1sp:  mkdir' {
    LBUFFER=" mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' mkdir -p'
}

@test 'alias 2sp:   mkdir' {
    LBUFFER="  mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  mkdir -p'
}

@test 'alias 3sp:    mkdir' {
    LBUFFER="   mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   mkdir -p'
}

@test 'alias 4sp:     mkdir' {
    LBUFFER="    mkdir"
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    mkdir -p'
}

@test 'alias no-expand trail: mkdir ' {
    LBUFFER="mkdir "
    ZPWR_VARS[lastword_lbuffer]=mkdir
    ZPWR_VARS[EXPANDED]='mkdir -p'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'mkdir '
}

@test 'alias basic: chmod -> chmod 755' {
    LBUFFER="chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'chmod 755'
}

@test 'alias after-pipe: cmd | chmod' {
    LBUFFER="cmd | chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | chmod 755'
}

@test 'alias after-semi: cmd; chmod' {
    LBUFFER="cmd; chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; chmod 755'
}

@test 'alias after-and: cmd && chmod' {
    LBUFFER="cmd && chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && chmod 755'
}

@test 'alias after-or: cmd || chmod' {
    LBUFFER="cmd || chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || chmod 755'
}

@test 'alias 1sp:  chmod' {
    LBUFFER=" chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' chmod 755'
}

@test 'alias 2sp:   chmod' {
    LBUFFER="  chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  chmod 755'
}

@test 'alias 3sp:    chmod' {
    LBUFFER="   chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   chmod 755'
}

@test 'alias 4sp:     chmod' {
    LBUFFER="    chmod"
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    chmod 755'
}

@test 'alias no-expand trail: chmod ' {
    LBUFFER="chmod "
    ZPWR_VARS[lastword_lbuffer]=chmod
    ZPWR_VARS[EXPANDED]='chmod 755'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'chmod '
}

@test 'alias basic: ssh -> ssh -v' {
    LBUFFER="ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'ssh -v'
}

@test 'alias after-pipe: cmd | ssh' {
    LBUFFER="cmd | ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | ssh -v'
}

@test 'alias after-semi: cmd; ssh' {
    LBUFFER="cmd; ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; ssh -v'
}

@test 'alias after-and: cmd && ssh' {
    LBUFFER="cmd && ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && ssh -v'
}

@test 'alias after-or: cmd || ssh' {
    LBUFFER="cmd || ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || ssh -v'
}

@test 'alias 1sp:  ssh' {
    LBUFFER=" ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' ssh -v'
}

@test 'alias 2sp:   ssh' {
    LBUFFER="  ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  ssh -v'
}

@test 'alias 3sp:    ssh' {
    LBUFFER="   ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   ssh -v'
}

@test 'alias 4sp:     ssh' {
    LBUFFER="    ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    ssh -v'
}

@test 'alias no-expand trail: ssh ' {
    LBUFFER="ssh "
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'ssh '
}

@test 'alias basic: curl -> curl -sS' {
    LBUFFER="curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'curl -sS'
}

@test 'alias after-pipe: cmd | curl' {
    LBUFFER="cmd | curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | curl -sS'
}

@test 'alias after-semi: cmd; curl' {
    LBUFFER="cmd; curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; curl -sS'
}

@test 'alias after-and: cmd && curl' {
    LBUFFER="cmd && curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && curl -sS'
}

@test 'alias after-or: cmd || curl' {
    LBUFFER="cmd || curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || curl -sS'
}

@test 'alias 1sp:  curl' {
    LBUFFER=" curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' curl -sS'
}

@test 'alias 2sp:   curl' {
    LBUFFER="  curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  curl -sS'
}

@test 'alias 3sp:    curl' {
    LBUFFER="   curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   curl -sS'
}

@test 'alias 4sp:     curl' {
    LBUFFER="    curl"
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    curl -sS'
}

@test 'alias no-expand trail: curl ' {
    LBUFFER="curl "
    ZPWR_VARS[lastword_lbuffer]=curl
    ZPWR_VARS[EXPANDED]='curl -sS'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'curl '
}

@test 'alias basic: wget -> wget -c' {
    LBUFFER="wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'wget -c'
}

@test 'alias after-pipe: cmd | wget' {
    LBUFFER="cmd | wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | wget -c'
}

@test 'alias after-semi: cmd; wget' {
    LBUFFER="cmd; wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; wget -c'
}

@test 'alias after-and: cmd && wget' {
    LBUFFER="cmd && wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && wget -c'
}

@test 'alias after-or: cmd || wget' {
    LBUFFER="cmd || wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || wget -c'
}

@test 'alias 1sp:  wget' {
    LBUFFER=" wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' wget -c'
}

@test 'alias 2sp:   wget' {
    LBUFFER="  wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  wget -c'
}

@test 'alias 3sp:    wget' {
    LBUFFER="   wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   wget -c'
}

@test 'alias 4sp:     wget' {
    LBUFFER="    wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    wget -c'
}

@test 'alias no-expand trail: wget ' {
    LBUFFER="wget "
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'wget '
}

@test 'alias basic: python -> python3' {
    LBUFFER="python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'python3'
}

@test 'alias after-pipe: cmd | python' {
    LBUFFER="cmd | python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | python3'
}

@test 'alias after-semi: cmd; python' {
    LBUFFER="cmd; python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; python3'
}

@test 'alias after-and: cmd && python' {
    LBUFFER="cmd && python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && python3'
}

@test 'alias after-or: cmd || python' {
    LBUFFER="cmd || python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || python3'
}

@test 'alias 1sp:  python' {
    LBUFFER=" python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' python3'
}

@test 'alias 2sp:   python' {
    LBUFFER="  python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  python3'
}

@test 'alias 3sp:    python' {
    LBUFFER="   python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   python3'
}

@test 'alias 4sp:     python' {
    LBUFFER="    python"
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    python3'
}

@test 'alias no-expand trail: python ' {
    LBUFFER="python "
    ZPWR_VARS[lastword_lbuffer]=python
    ZPWR_VARS[EXPANDED]='python3'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'python '
}

@test 'alias basic: ruby -> ruby -e' {
    LBUFFER="ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'ruby -e'
}

@test 'alias after-pipe: cmd | ruby' {
    LBUFFER="cmd | ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | ruby -e'
}

@test 'alias after-semi: cmd; ruby' {
    LBUFFER="cmd; ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; ruby -e'
}

@test 'alias after-and: cmd && ruby' {
    LBUFFER="cmd && ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && ruby -e'
}

@test 'alias after-or: cmd || ruby' {
    LBUFFER="cmd || ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || ruby -e'
}

@test 'alias 1sp:  ruby' {
    LBUFFER=" ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' ruby -e'
}

@test 'alias 2sp:   ruby' {
    LBUFFER="  ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  ruby -e'
}

@test 'alias 3sp:    ruby' {
    LBUFFER="   ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   ruby -e'
}

@test 'alias 4sp:     ruby' {
    LBUFFER="    ruby"
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    ruby -e'
}

@test 'alias no-expand trail: ruby ' {
    LBUFFER="ruby "
    ZPWR_VARS[lastword_lbuffer]=ruby
    ZPWR_VARS[EXPANDED]='ruby -e'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'ruby '
}

@test 'alias basic: node -> node --inspect' {
    LBUFFER="node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'node --inspect'
}

@test 'alias after-pipe: cmd | node' {
    LBUFFER="cmd | node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | node --inspect'
}

@test 'alias after-semi: cmd; node' {
    LBUFFER="cmd; node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; node --inspect'
}

@test 'alias after-and: cmd && node' {
    LBUFFER="cmd && node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && node --inspect'
}

@test 'alias after-or: cmd || node' {
    LBUFFER="cmd || node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || node --inspect'
}

@test 'alias 1sp:  node' {
    LBUFFER=" node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' node --inspect'
}

@test 'alias 2sp:   node' {
    LBUFFER="  node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  node --inspect'
}

@test 'alias 3sp:    node' {
    LBUFFER="   node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   node --inspect'
}

@test 'alias 4sp:     node' {
    LBUFFER="    node"
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    node --inspect'
}

@test 'alias no-expand trail: node ' {
    LBUFFER="node "
    ZPWR_VARS[lastword_lbuffer]=node
    ZPWR_VARS[EXPANDED]='node --inspect'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'node '
}

@test 'alias basic: perl -> perl -e' {
    LBUFFER="perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'perl -e'
}

@test 'alias after-pipe: cmd | perl' {
    LBUFFER="cmd | perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | perl -e'
}

@test 'alias after-semi: cmd; perl' {
    LBUFFER="cmd; perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; perl -e'
}

@test 'alias after-and: cmd && perl' {
    LBUFFER="cmd && perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && perl -e'
}

@test 'alias after-or: cmd || perl' {
    LBUFFER="cmd || perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || perl -e'
}

@test 'alias 1sp:  perl' {
    LBUFFER=" perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' perl -e'
}

@test 'alias 2sp:   perl' {
    LBUFFER="  perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  perl -e'
}

@test 'alias 3sp:    perl' {
    LBUFFER="   perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   perl -e'
}

@test 'alias 4sp:     perl' {
    LBUFFER="    perl"
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    perl -e'
}

@test 'alias no-expand trail: perl ' {
    LBUFFER="perl "
    ZPWR_VARS[lastword_lbuffer]=perl
    ZPWR_VARS[EXPANDED]='perl -e'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'perl '
}

@test 'alias basic: java -> java -jar' {
    LBUFFER="java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'java -jar'
}

@test 'alias after-pipe: cmd | java' {
    LBUFFER="cmd | java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | java -jar'
}

@test 'alias after-semi: cmd; java' {
    LBUFFER="cmd; java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; java -jar'
}

@test 'alias after-and: cmd && java' {
    LBUFFER="cmd && java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && java -jar'
}

@test 'alias after-or: cmd || java' {
    LBUFFER="cmd || java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || java -jar'
}

@test 'alias 1sp:  java' {
    LBUFFER=" java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' java -jar'
}

@test 'alias 2sp:   java' {
    LBUFFER="  java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  java -jar'
}

@test 'alias 3sp:    java' {
    LBUFFER="   java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   java -jar'
}

@test 'alias 4sp:     java' {
    LBUFFER="    java"
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    java -jar'
}

@test 'alias no-expand trail: java ' {
    LBUFFER="java "
    ZPWR_VARS[lastword_lbuffer]=java
    ZPWR_VARS[EXPANDED]='java -jar'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'java '
}

@test 'alias basic: go -> go run' {
    LBUFFER="go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'go run'
}

@test 'alias after-pipe: cmd | go' {
    LBUFFER="cmd | go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd | go run'
}

@test 'alias after-semi: cmd; go' {
    LBUFFER="cmd; go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd; go run'
}

@test 'alias after-and: cmd && go' {
    LBUFFER="cmd && go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd && go run'
}

@test 'alias after-or: cmd || go' {
    LBUFFER="cmd || go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as 'cmd || go run'
}

@test 'alias 1sp:  go' {
    LBUFFER=" go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as ' go run'
}

@test 'alias 2sp:   go' {
    LBUFFER="  go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '  go run'
}

@test 'alias 3sp:    go' {
    LBUFFER="   go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '   go run'
}

@test 'alias 4sp:     go' {
    LBUFFER="    go"
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias
    assert "$LBUFFER" same_as '    go run'
}

@test 'alias no-expand trail: go ' {
    LBUFFER="go "
    ZPWR_VARS[lastword_lbuffer]=go
    ZPWR_VARS[EXPANDED]='go run'
    zpwrExpandAlias || :
    assert "$LBUFFER" same_as 'go '
}

@test 'escape basic: ls -> \\ls -la' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\ls -la'
}

@test 'escape after-pipe: cmd | ls' {
    LBUFFER="cmd | ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\ls -la'
}

@test 'escape after-semi: cmd; ls' {
    LBUFFER="cmd; ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\ls -la'
}

@test 'escape flag: ls sets WAS_EXPANDED' {
    LBUFFER="ls"
    ZPWR_VARS[lastword_lbuffer]=ls
    ZPWR_VARS[EXPANDED]='ls -la'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: git -> \\git status' {
    LBUFFER="git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\git status'
}

@test 'escape after-pipe: cmd | git' {
    LBUFFER="cmd | git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\git status'
}

@test 'escape after-semi: cmd; git' {
    LBUFFER="cmd; git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\git status'
}

@test 'escape flag: git sets WAS_EXPANDED' {
    LBUFFER="git"
    ZPWR_VARS[lastword_lbuffer]=git
    ZPWR_VARS[EXPANDED]='git status'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: make -> \\make -j4' {
    LBUFFER="make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\make -j4'
}

@test 'escape after-pipe: cmd | make' {
    LBUFFER="cmd | make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\make -j4'
}

@test 'escape after-semi: cmd; make' {
    LBUFFER="cmd; make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\make -j4'
}

@test 'escape flag: make sets WAS_EXPANDED' {
    LBUFFER="make"
    ZPWR_VARS[lastword_lbuffer]=make
    ZPWR_VARS[EXPANDED]='make -j4'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: diff -> \\diff --color' {
    LBUFFER="diff"
    ZPWR_VARS[lastword_lbuffer]=diff
    ZPWR_VARS[EXPANDED]='diff --color'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\diff --color'
}

@test 'escape after-pipe: cmd | diff' {
    LBUFFER="cmd | diff"
    ZPWR_VARS[lastword_lbuffer]=diff
    ZPWR_VARS[EXPANDED]='diff --color'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\diff --color'
}

@test 'escape after-semi: cmd; diff' {
    LBUFFER="cmd; diff"
    ZPWR_VARS[lastword_lbuffer]=diff
    ZPWR_VARS[EXPANDED]='diff --color'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\diff --color'
}

@test 'escape flag: diff sets WAS_EXPANDED' {
    LBUFFER="diff"
    ZPWR_VARS[lastword_lbuffer]=diff
    ZPWR_VARS[EXPANDED]='diff --color'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: sed -> \\sed -E' {
    LBUFFER="sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\sed -E'
}

@test 'escape after-pipe: cmd | sed' {
    LBUFFER="cmd | sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\sed -E'
}

@test 'escape after-semi: cmd; sed' {
    LBUFFER="cmd; sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\sed -E'
}

@test 'escape flag: sed sets WAS_EXPANDED' {
    LBUFFER="sed"
    ZPWR_VARS[lastword_lbuffer]=sed
    ZPWR_VARS[EXPANDED]='sed -E'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: grep -> \\grep --color' {
    LBUFFER="grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\grep --color'
}

@test 'escape after-pipe: cmd | grep' {
    LBUFFER="cmd | grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\grep --color'
}

@test 'escape after-semi: cmd; grep' {
    LBUFFER="cmd; grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\grep --color'
}

@test 'escape flag: grep sets WAS_EXPANDED' {
    LBUFFER="grep"
    ZPWR_VARS[lastword_lbuffer]=grep
    ZPWR_VARS[EXPANDED]='grep --color'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: sort -> \\sort -n' {
    LBUFFER="sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\sort -n'
}

@test 'escape after-pipe: cmd | sort' {
    LBUFFER="cmd | sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\sort -n'
}

@test 'escape after-semi: cmd; sort' {
    LBUFFER="cmd; sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\sort -n'
}

@test 'escape flag: sort sets WAS_EXPANDED' {
    LBUFFER="sort"
    ZPWR_VARS[lastword_lbuffer]=sort
    ZPWR_VARS[EXPANDED]='sort -n'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: head -> \\head -20' {
    LBUFFER="head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\head -20'
}

@test 'escape after-pipe: cmd | head' {
    LBUFFER="cmd | head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\head -20'
}

@test 'escape after-semi: cmd; head' {
    LBUFFER="cmd; head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\head -20'
}

@test 'escape flag: head sets WAS_EXPANDED' {
    LBUFFER="head"
    ZPWR_VARS[lastword_lbuffer]=head
    ZPWR_VARS[EXPANDED]='head -20'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: wget -> \\wget -c' {
    LBUFFER="wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\wget -c'
}

@test 'escape after-pipe: cmd | wget' {
    LBUFFER="cmd | wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\wget -c'
}

@test 'escape after-semi: cmd; wget' {
    LBUFFER="cmd; wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\wget -c'
}

@test 'escape flag: wget sets WAS_EXPANDED' {
    LBUFFER="wget"
    ZPWR_VARS[lastword_lbuffer]=wget
    ZPWR_VARS[EXPANDED]='wget -c'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: ssh -> \\ssh -v' {
    LBUFFER="ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\ssh -v'
}

@test 'escape after-pipe: cmd | ssh' {
    LBUFFER="cmd | ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\ssh -v'
}

@test 'escape after-semi: cmd; ssh' {
    LBUFFER="cmd; ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\ssh -v'
}

@test 'escape flag: ssh sets WAS_EXPANDED' {
    LBUFFER="ssh"
    ZPWR_VARS[lastword_lbuffer]=ssh
    ZPWR_VARS[EXPANDED]='ssh -v'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: ping -> \\ping -c4' {
    LBUFFER="ping"
    ZPWR_VARS[lastword_lbuffer]=ping
    ZPWR_VARS[EXPANDED]='ping -c4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\ping -c4'
}

@test 'escape after-pipe: cmd | ping' {
    LBUFFER="cmd | ping"
    ZPWR_VARS[lastword_lbuffer]=ping
    ZPWR_VARS[EXPANDED]='ping -c4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\ping -c4'
}

@test 'escape after-semi: cmd; ping' {
    LBUFFER="cmd; ping"
    ZPWR_VARS[lastword_lbuffer]=ping
    ZPWR_VARS[EXPANDED]='ping -c4'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\ping -c4'
}

@test 'escape flag: ping sets WAS_EXPANDED' {
    LBUFFER="ping"
    ZPWR_VARS[lastword_lbuffer]=ping
    ZPWR_VARS[EXPANDED]='ping -c4'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: dd -> \\dd if=/dev/zero' {
    LBUFFER="dd"
    ZPWR_VARS[lastword_lbuffer]=dd
    ZPWR_VARS[EXPANDED]='dd if=/dev/zero'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\dd if=/dev/zero'
}

@test 'escape after-pipe: cmd | dd' {
    LBUFFER="cmd | dd"
    ZPWR_VARS[lastword_lbuffer]=dd
    ZPWR_VARS[EXPANDED]='dd if=/dev/zero'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\dd if=/dev/zero'
}

@test 'escape after-semi: cmd; dd' {
    LBUFFER="cmd; dd"
    ZPWR_VARS[lastword_lbuffer]=dd
    ZPWR_VARS[EXPANDED]='dd if=/dev/zero'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\dd if=/dev/zero'
}

@test 'escape flag: dd sets WAS_EXPANDED' {
    LBUFFER="dd"
    ZPWR_VARS[lastword_lbuffer]=dd
    ZPWR_VARS[EXPANDED]='dd if=/dev/zero'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: du -> \\du -sh' {
    LBUFFER="du"
    ZPWR_VARS[lastword_lbuffer]=du
    ZPWR_VARS[EXPANDED]='du -sh'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\du -sh'
}

@test 'escape after-pipe: cmd | du' {
    LBUFFER="cmd | du"
    ZPWR_VARS[lastword_lbuffer]=du
    ZPWR_VARS[EXPANDED]='du -sh'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\du -sh'
}

@test 'escape after-semi: cmd; du' {
    LBUFFER="cmd; du"
    ZPWR_VARS[lastword_lbuffer]=du
    ZPWR_VARS[EXPANDED]='du -sh'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\du -sh'
}

@test 'escape flag: du sets WAS_EXPANDED' {
    LBUFFER="du"
    ZPWR_VARS[lastword_lbuffer]=du
    ZPWR_VARS[EXPANDED]='du -sh'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: df -> \\df -h' {
    LBUFFER="df"
    ZPWR_VARS[lastword_lbuffer]=df
    ZPWR_VARS[EXPANDED]='df -h'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\df -h'
}

@test 'escape after-pipe: cmd | df' {
    LBUFFER="cmd | df"
    ZPWR_VARS[lastword_lbuffer]=df
    ZPWR_VARS[EXPANDED]='df -h'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\df -h'
}

@test 'escape after-semi: cmd; df' {
    LBUFFER="cmd; df"
    ZPWR_VARS[lastword_lbuffer]=df
    ZPWR_VARS[EXPANDED]='df -h'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\df -h'
}

@test 'escape flag: df sets WAS_EXPANDED' {
    LBUFFER="df"
    ZPWR_VARS[lastword_lbuffer]=df
    ZPWR_VARS[EXPANDED]='df -h'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: ps -> \\ps aux' {
    LBUFFER="ps"
    ZPWR_VARS[lastword_lbuffer]=ps
    ZPWR_VARS[EXPANDED]='ps aux'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\ps aux'
}

@test 'escape after-pipe: cmd | ps' {
    LBUFFER="cmd | ps"
    ZPWR_VARS[lastword_lbuffer]=ps
    ZPWR_VARS[EXPANDED]='ps aux'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\ps aux'
}

@test 'escape after-semi: cmd; ps' {
    LBUFFER="cmd; ps"
    ZPWR_VARS[lastword_lbuffer]=ps
    ZPWR_VARS[EXPANDED]='ps aux'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\ps aux'
}

@test 'escape flag: ps sets WAS_EXPANDED' {
    LBUFFER="ps"
    ZPWR_VARS[lastword_lbuffer]=ps
    ZPWR_VARS[EXPANDED]='ps aux'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'escape basic: ip -> \\ip addr' {
    LBUFFER="ip"
    ZPWR_VARS[lastword_lbuffer]=ip
    ZPWR_VARS[EXPANDED]='ip addr'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as '\\ip addr'
}

@test 'escape after-pipe: cmd | ip' {
    LBUFFER="cmd | ip"
    ZPWR_VARS[lastword_lbuffer]=ip
    ZPWR_VARS[EXPANDED]='ip addr'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd | \\ip addr'
}

@test 'escape after-semi: cmd; ip' {
    LBUFFER="cmd; ip"
    ZPWR_VARS[lastword_lbuffer]=ip
    ZPWR_VARS[EXPANDED]='ip addr'
    zpwrExpandAliasEscape
    assert "$LBUFFER" same_as 'cmd; \\ip addr'
}

@test 'escape flag: ip sets WAS_EXPANDED' {
    LBUFFER="ip"
    ZPWR_VARS[lastword_lbuffer]=ip
    ZPWR_VARS[EXPANDED]='ip addr'
    ZPWR_VARS[WAS_EXPANDED]=false
    zpwrExpandAliasEscape
    assert $ZPWR_VARS[WAS_EXPANDED] same_as 'true'
}

@test 'rightTrim: single trailing space "word "' {
    LBUFFER="word "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'word'
}

@test 'rightTrim: single trailing space "cmd "' {
    LBUFFER="cmd "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'cmd'
}

@test 'rightTrim: single trailing space "ls "' {
    LBUFFER="ls "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'ls'
}

@test 'rightTrim: single trailing space "git "' {
    LBUFFER="git "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'git'
}

@test 'rightTrim: single trailing space "echo "' {
    LBUFFER="echo "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'echo'
}

@test 'rightTrim: single trailing space "make "' {
    LBUFFER="make "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'make'
}

@test 'rightTrim no-trim: double space "cmd  "' {
    LBUFFER="cmd  "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'cmd  '
}

@test 'rightTrim no-trim: double space "ls  "' {
    LBUFFER="ls  "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'ls  '
}

@test 'rightTrim no-trim: double space "echo  "' {
    LBUFFER="echo  "
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'echo  '
}

@test 'rightTrim no-trim: no space "cmd"' {
    LBUFFER="cmd"
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'cmd'
}

@test 'rightTrim no-trim: no space "ls"' {
    LBUFFER="ls"
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'ls'
}

@test 'rightTrim no-trim: no space "echo"' {
    LBUFFER="echo"
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'echo'
}

@test 'rightTrim no-trim: no space "git"' {
    LBUFFER="git"
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'git'
}

@test 'rightTrim no-trim: no space "make"' {
    LBUFFER="make"
    zpwrExpandRightTrim
    assert "$LBUFFER" same_as 'make'
}

@test 'terminateSpace: "cmd" appends space' {
    LBUFFER="cmd"
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as 'cmd '
}

@test 'terminateSpace: "ls -la" appends space' {
    LBUFFER="ls -la"
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as 'ls -la '
}

@test 'terminateSpace: "git status" appends space' {
    LBUFFER="git status"
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as 'git status '
}

@test 'terminateSpace: "echo hello world" appends space' {
    LBUFFER="echo hello world"
    zpwrExpandTerminateSpace
    assert "$LBUFFER" same_as 'echo hello world '
}

@test 'getAliasValue: __zt_ls01=ls -la' {
    alias __zt_ls01='ls -la'
    ZPWR_VARS[lastword_lbuffer]=__zt_ls01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ls -la'
    unalias __zt_ls01
}

@test 'getAliasValue: __zt_grep01=grep --color=auto' {
    alias __zt_grep01='grep --color=auto'
    ZPWR_VARS[lastword_lbuffer]=__zt_grep01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'grep --color=auto'
    unalias __zt_grep01
}

@test 'getAliasValue: __zt_mv01=mv -i' {
    alias __zt_mv01='mv -i'
    ZPWR_VARS[lastword_lbuffer]=__zt_mv01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'mv -i'
    unalias __zt_mv01
}

@test 'getAliasValue: __zt_cp01=cp -r' {
    alias __zt_cp01='cp -r'
    ZPWR_VARS[lastword_lbuffer]=__zt_cp01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cp -r'
    unalias __zt_cp01
}

@test 'getAliasValue: __zt_rm01=rm -i' {
    alias __zt_rm01='rm -i'
    ZPWR_VARS[lastword_lbuffer]=__zt_rm01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'rm -i'
    unalias __zt_rm01
}

@test 'getAliasValue: __zt_mkdir01=mkdir -p' {
    alias __zt_mkdir01='mkdir -p'
    ZPWR_VARS[lastword_lbuffer]=__zt_mkdir01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'mkdir -p'
    unalias __zt_mkdir01
}

@test 'getAliasValue: __zt_diff01=diff --color' {
    alias __zt_diff01='diff --color'
    ZPWR_VARS[lastword_lbuffer]=__zt_diff01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'diff --color'
    unalias __zt_diff01
}

@test 'getAliasValue: __zt_sort01=sort -n' {
    alias __zt_sort01='sort -n'
    ZPWR_VARS[lastword_lbuffer]=__zt_sort01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'sort -n'
    unalias __zt_sort01
}

@test 'getAliasValue: __zt_echo01=echo -e' {
    alias __zt_echo01='echo -e'
    ZPWR_VARS[lastword_lbuffer]=__zt_echo01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'echo -e'
    unalias __zt_echo01
}

@test 'getAliasValue: __zt_cat01=cat -v' {
    alias __zt_cat01='cat -v'
    ZPWR_VARS[lastword_lbuffer]=__zt_cat01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'cat -v'
    unalias __zt_cat01
}

@test 'getAliasValue: __zt_head01=head -20' {
    alias __zt_head01='head -20'
    ZPWR_VARS[lastword_lbuffer]=__zt_head01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'head -20'
    unalias __zt_head01
}

@test 'getAliasValue: __zt_tail01=tail -f' {
    alias __zt_tail01='tail -f'
    ZPWR_VARS[lastword_lbuffer]=__zt_tail01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'tail -f'
    unalias __zt_tail01
}

@test 'getAliasValue: __zt_wc01=wc -l' {
    alias __zt_wc01='wc -l'
    ZPWR_VARS[lastword_lbuffer]=__zt_wc01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'wc -l'
    unalias __zt_wc01
}

@test 'getAliasValue: __zt_df01=df -h' {
    alias __zt_df01='df -h'
    ZPWR_VARS[lastword_lbuffer]=__zt_df01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'df -h'
    unalias __zt_df01
}

@test 'getAliasValue: __zt_du01=du -sh' {
    alias __zt_du01='du -sh'
    ZPWR_VARS[lastword_lbuffer]=__zt_du01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'du -sh'
    unalias __zt_du01
}

@test 'getAliasValue: __zt_ps01=ps aux' {
    alias __zt_ps01='ps aux'
    ZPWR_VARS[lastword_lbuffer]=__zt_ps01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ps aux'
    unalias __zt_ps01
}

@test 'getAliasValue: __zt_ip01=ip addr show' {
    alias __zt_ip01='ip addr show'
    ZPWR_VARS[lastword_lbuffer]=__zt_ip01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ip addr show'
    unalias __zt_ip01
}

@test 'getAliasValue: __zt_ping01=ping -c 4' {
    alias __zt_ping01='ping -c 4'
    ZPWR_VARS[lastword_lbuffer]=__zt_ping01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ping -c 4'
    unalias __zt_ping01
}

@test 'getAliasValue: __zt_wget01=wget -c' {
    alias __zt_wget01='wget -c'
    ZPWR_VARS[lastword_lbuffer]=__zt_wget01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'wget -c'
    unalias __zt_wget01
}

@test 'getAliasValue: __zt_ssh01=ssh -v' {
    alias __zt_ssh01='ssh -v'
    ZPWR_VARS[lastword_lbuffer]=__zt_ssh01
    zpwrExpandGetAliasValue
    assert $ZPWR_VARS[EXPANDED] same_as 'ssh -v'
    unalias __zt_ssh01
}

@test 'tabstop: no tabstop sets NEED_TO_ADD_SPACECHAR true' {
    LBUFFER="some text"
    RBUFFER=""
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=false
    zpwrExpandGoToTabStopOrEndOfLBuffer
    assert $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] same_as 'true'
}

