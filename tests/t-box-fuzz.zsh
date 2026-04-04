#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: fuzz tests for zpwrExpandBox
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    export COLUMNS=80

    # helper: verify box structural integrity
    # every line must start with box char and end with box char
    # first line: ╭...╮  middle lines: │...│  last line: ╰...╯
    # all lines must be the same width
    _assert_box() {
        local output=$1
        local -a boxLines=("${(@f)output}")
        local -i numLines=${#boxLines}
        local -i expectedW=${#boxLines[1]}
        local -i i lineLen

        # must have at least 3 lines (top, content, bottom)
        [[ $numLines -ge 3 ]]
        assert $? equals 0

        # top border
        assert "$boxLines[1]" matches "^╭.*╮$"

        # bottom border
        assert "$boxLines[$numLines]" matches "^╰.*╯$"

        # middle lines
        for (( i = 2; i < numLines; i++ )); do
            assert "$boxLines[$i]" matches "^│.*│$"
        done

        # all lines same width
        for (( i = 1; i <= numLines; i++ )); do
            lineLen=${#boxLines[$i]}
            assert $lineLen equals $expectedW
        done
    }
}

#==============================================================
# basic structural integrity
#==============================================================

@test 'box: single short line' {
    local out=$(zpwrExpandBox "hello")
    _assert_box "$out"
}

@test 'box: single line with title' {
    local out=$(zpwrExpandBox -t "title" "hello")
    _assert_box "$out"
}

@test 'box: multiple lines' {
    local out=$(zpwrExpandBox "line one" "line two" "line three")
    _assert_box "$out"
}

@test 'box: empty string line' {
    local out=$(zpwrExpandBox "")
    _assert_box "$out"
}

@test 'box: single character' {
    local out=$(zpwrExpandBox "x")
    _assert_box "$out"
}

@test 'box: single space' {
    local out=$(zpwrExpandBox " ")
    _assert_box "$out"
}

#==============================================================
# wrapping
#==============================================================

@test 'box: wraps long line at width' {
    local out=$(zpwrExpandBox -w 20 "this is a long line that must wrap around")
    _assert_box "$out"
}

@test 'box: wraps multiple long lines' {
    local out=$(zpwrExpandBox -w 15 "aaaa bbbb cccc dddd" "eeee ffff gggg hhhh")
    _assert_box "$out"
}

@test 'box: word longer than wrap width hard-breaks' {
    local out=$(zpwrExpandBox -w 10 "abcdefghijklmnopqrstuvwxyz")
    _assert_box "$out"
}

@test 'box: wrap width 1' {
    local out=$(zpwrExpandBox -w 1 "ab cd")
    _assert_box "$out"
}

@test 'box: wrap with very long single word no spaces' {
    local longword=$(printf '%0.sx' {1..200})
    local out=$(zpwrExpandBox -w 30 "$longword")
    _assert_box "$out"
}

#==============================================================
# title edge cases
#==============================================================

@test 'box: title longer than content' {
    local out=$(zpwrExpandBox -t "a very long title here" "x")
    _assert_box "$out"
}

@test 'box: title same length as content' {
    local out=$(zpwrExpandBox -t "hello" "hello")
    _assert_box "$out"
}

@test 'box: empty title' {
    local out=$(zpwrExpandBox -t "" "hello")
    _assert_box "$out"
}

@test 'box: title with spaces' {
    local out=$(zpwrExpandBox -t "my great title" "content")
    _assert_box "$out"
}

@test 'box: --title long flag' {
    local out=$(zpwrExpandBox --title "long flag" "content")
    _assert_box "$out"
}

@test 'box: --width long flag' {
    local out=$(zpwrExpandBox --width 40 "short")
    _assert_box "$out"
}

#==============================================================
# special characters
#==============================================================

@test 'box: tabs expanded to spaces' {
    local tab=$'\t'
    local out=$(zpwrExpandBox "before${tab}after")
    _assert_box "$out"
}

@test 'box: multiple tabs' {
    local tab=$'\t'
    local out=$(zpwrExpandBox "${tab}${tab}${tab}")
    _assert_box "$out"
}

@test 'box: backslashes' {
    local out=$(zpwrExpandBox 'path\to\file' 'c:\windows\system32')
    _assert_box "$out"
}

@test 'box: single quotes in content' {
    local out=$(zpwrExpandBox "it's a test" "don't break")
    _assert_box "$out"
}

@test 'box: double quotes in content' {
    local out=$(zpwrExpandBox 'say "hello"' 'key="value"')
    _assert_box "$out"
}

@test 'box: dollar signs' {
    local out=$(zpwrExpandBox '$HOME' '${PATH}' '$(cmd)')
    _assert_box "$out"
}

@test 'box: glob characters' {
    local out=$(zpwrExpandBox '*.txt' 'file?' '[abc]' '{a,b}')
    _assert_box "$out"
}

@test 'box: parentheses and brackets' {
    local out=$(zpwrExpandBox '(group)' '[array]' '{block}' '<angle>')
    _assert_box "$out"
}

@test 'box: pipe and ampersand' {
    local out=$(zpwrExpandBox 'cmd | grep' 'a && b' 'c || d' 'bg &')
    _assert_box "$out"
}

@test 'box: semicolons' {
    local out=$(zpwrExpandBox 'cmd1; cmd2' 'a ;; b')
    _assert_box "$out"
}

@test 'box: hash and exclamation' {
    local out=$(zpwrExpandBox '# comment' '!history')
    _assert_box "$out"
}

@test 'box: equals signs' {
    local out=$(zpwrExpandBox 'VAR=val' 'a=b=c' '===')
    _assert_box "$out"
}

@test 'box: tilde and caret' {
    local out=$(zpwrExpandBox '~user' 'HEAD^' 'a~1')
    _assert_box "$out"
}

@test 'box: percent' {
    local out=$(zpwrExpandBox '%50' '100%')
    _assert_box "$out"
}

#==============================================================
# unicode
#==============================================================

@test 'box: unicode emoji' {
    local out=$(zpwrExpandBox "hello 🌍" "test 🚀 done")
    _assert_box "$out"
}

@test 'box: unicode CJK' {
    local out=$(zpwrExpandBox "漢字テスト" "中文测试")
    _assert_box "$out"
}

@test 'box: unicode accented chars' {
    local out=$(zpwrExpandBox "café résumé naïve" "über straße")
    _assert_box "$out"
}

@test 'box: unicode box-drawing chars in content' {
    local out=$(zpwrExpandBox "╭──╮" "│hi│" "╰──╯")
    _assert_box "$out"
}

@test 'box: unicode arrows and symbols' {
    local out=$(zpwrExpandBox "→ ← ↑ ↓" "★ ☆ ● ○" "✓ ✗ ⚡ ⚠")
    _assert_box "$out"
}

#==============================================================
# stdin
#==============================================================

@test 'box: stdin single line' {
    local out=$(print "from stdin" | zpwrExpandBox)
    _assert_box "$out"
}

@test 'box: stdin multiple lines' {
    local out=$(printf "line1\nline2\nline3\n" | zpwrExpandBox)
    _assert_box "$out"
}

@test 'box: stdin with title' {
    local out=$(printf "data\n" | zpwrExpandBox -t "piped")
    _assert_box "$out"
}

@test 'box: stdin mixed with args' {
    local out=$(printf "stdin line\n" | zpwrExpandBox -t "mix" "arg line")
    _assert_box "$out"
}

@test 'box: stdin with tabs' {
    local out=$(printf "col1\tcol2\tcol3\n" | zpwrExpandBox)
    _assert_box "$out"
}

@test 'box: stdin long lines wrap' {
    local out=$(printf '%0.sa' {1..200} | zpwrExpandBox -w 30)
    _assert_box "$out"
}

#==============================================================
# width edge cases
#==============================================================

@test 'box: width larger than content' {
    local out=$(zpwrExpandBox -w 60 "tiny")
    _assert_box "$out"
}

@test 'box: width 2 minimum viable' {
    local out=$(zpwrExpandBox -w 2 "ab")
    _assert_box "$out"
}

@test 'box: width matches content exactly' {
    local out=$(zpwrExpandBox -w 5 "hello")
    _assert_box "$out"
}

@test 'box: COLUMNS controls default width' {
    COLUMNS=40
    local out=$(zpwrExpandBox "a short line")
    _assert_box "$out"
    local -a boxLines=("${(@f)out}")
    local -i lineW=${#boxLines[1]}
    # box should not exceed COLUMNS
    [[ $lineW -ge 1 && $lineW -le 40 ]]
    assert $? equals 0
    COLUMNS=80
}

#==============================================================
# many lines
#==============================================================

@test 'box: 100 lines' {
    local -a args=()
    local -i i
    for (( i = 1; i <= 100; i++ )); do
        args+=("line number $i of one hundred")
    done
    local out=$(zpwrExpandBox "${args[@]}")
    _assert_box "$out"
}

@test 'box: 100 lines with wrap' {
    local -a args=()
    local -i i
    for (( i = 1; i <= 100; i++ )); do
        args+=("this is line number $i and it is intentionally longer than thirty characters wide")
    done
    local out=$(zpwrExpandBox -w 30 "${args[@]}")
    _assert_box "$out"
}

#==============================================================
# mixed content widths
#==============================================================

@test 'box: drastically different line lengths' {
    local out=$(zpwrExpandBox "x" "a medium length line here" "y" "an even longer line that has many more characters than the others")
    _assert_box "$out"
}

@test 'box: all empty lines' {
    local out=$(zpwrExpandBox "" "" "")
    _assert_box "$out"
}

@test 'box: mix of empty and non-empty' {
    local out=$(zpwrExpandBox "" "content" "" "more" "")
    _assert_box "$out"
}

#==============================================================
# -- end of options
#==============================================================

@test 'box: -- stops flag parsing' {
    local out=$(zpwrExpandBox -- "-t" "-w" "--title")
    _assert_box "$out"
    # content should contain the flag strings
    [[ $out == *"-t"* ]]
    assert $? equals 0
}

@test 'box: content starting with dash after --' {
    local out=$(zpwrExpandBox -- "-v --verbose -h --help")
    _assert_box "$out"
}

#==============================================================
# stress / randomized fuzz
#==============================================================

@test 'fuzz: 50 random-length lines random chars' {
    local -a args=()
    local -i i j lineLen
    local line char
    local charset='abcdefghijklmnopqrstuvwxyz 0123456789!@#$%^&*()_+-=[]{}|;:,.<>?/~`'
    for (( i = 1; i <= 50; i++ )); do
        lineLen=$(( RANDOM % 120 + 1 ))
        line=""
        for (( j = 1; j <= lineLen; j++ )); do
            char=${charset[$(( RANDOM % ${#charset} + 1 ))]}
            line+=$char
        done
        args+=("$line")
    done
    local out=$(zpwrExpandBox -t "fuzz" "${args[@]}")
    _assert_box "$out"
}

@test 'fuzz: 50 random lines with random wrap width' {
    local -a args=()
    local -i i j lineLen ww
    local line char
    local charset='abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789'
    for (( i = 1; i <= 50; i++ )); do
        lineLen=$(( RANDOM % 200 + 1 ))
        line=""
        for (( j = 1; j <= lineLen; j++ )); do
            char=${charset[$(( RANDOM % ${#charset} + 1 ))]}
            line+=$char
        done
        args+=("$line")
    done
    ww=$(( RANDOM % 60 + 10 ))
    local out=$(zpwrExpandBox -w $ww "${args[@]}")
    _assert_box "$out"
}

@test 'fuzz: 50 random lines at width 5' {
    local -a args=()
    local -i i j lineLen
    local line char
    local charset='abcdefghij '
    for (( i = 1; i <= 50; i++ )); do
        lineLen=$(( RANDOM % 80 + 1 ))
        line=""
        for (( j = 1; j <= lineLen; j++ )); do
            char=${charset[$(( RANDOM % ${#charset} + 1 ))]}
            line+=$char
        done
        args+=("$line")
    done
    local out=$(zpwrExpandBox -w 5 "${args[@]}")
    _assert_box "$out"
}

@test 'fuzz: 20 random lines all spaces' {
    local -a args=()
    local -i i lineLen
    local line
    for (( i = 1; i <= 20; i++ )); do
        lineLen=$(( RANDOM % 50 + 1 ))
        line=${(l:lineLen:: :)}
        args+=("$line")
    done
    local out=$(zpwrExpandBox "${args[@]}")
    _assert_box "$out"
}

@test 'fuzz: random title lengths' {
    local -i i titleLen
    local title char out
    local charset='abcdefghijklmnopqrstuvwxyz '
    for (( i = 1; i <= 20; i++ )); do
        titleLen=$(( RANDOM % 60 + 1 ))
        title=""
        for (( j = 1; j <= titleLen; j++ )); do
            char=${charset[$(( RANDOM % ${#charset} + 1 ))]}
            title+=$char
        done
        out=$(zpwrExpandBox -t "$title" "content line")
        _assert_box "$out"
    done
}

@test 'fuzz: 10 iterations random COLUMNS' {
    local -i i origCols=$COLUMNS
    local out
    for (( i = 1; i <= 10; i++ )); do
        COLUMNS=$(( RANDOM % 120 + 20 ))
        out=$(zpwrExpandBox "a line that is moderately long and may or may not need wrapping depending on terminal width")
        _assert_box "$out"
        local -a boxLines=("${(@f)out}")
        local -i lineW=${#boxLines[1]}
        [[ $lineW -ge 1 && $lineW -le $COLUMNS ]]
        assert $? equals 0
    done
    COLUMNS=$origCols
}
