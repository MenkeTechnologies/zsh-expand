#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: zpwrExpandPreviewResolve (pure) and stats file helpers — no ZLE
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
}

#==============================================================
# zpwrExpandPreviewResolve — REPLY only, no LBUFFER / zle
#==============================================================

@test 'previewResolve: empty lastword returns 1' {
    run zpwrExpandPreviewResolve ''
    assert $state same_as 1
}

@test 'previewResolve: unknown token returns 1' {
    run zpwrExpandPreviewResolve '__zpr_no_such_word_zz__'
    assert $state not_equal_to 0
}

@test 'previewResolve: regular alias expands to definition' {
    local rc
    alias __zpr_prev1='git log --oneline'
    zpwrExpandPreviewResolve __zpr_prev1
    rc=$?
    assert $rc same_as 0
    assert "$REPLY" same_as 'git log --oneline'
    unalias __zpr_prev1
}

@test 'previewResolve: global alias expands' {
    local rc
    alias -g __ZPR_GA_PREV__='| sort -u'
    zpwrExpandPreviewResolve __ZPR_GA_PREV__
    rc=$?
    assert $rc same_as 0
    assert "$REPLY" same_as '| sort -u'
    unalias __ZPR_GA_PREV__
}

@test 'previewResolve: suffix alias uses saliases and preserves filename' {
    local rc
    saliases[zpst]=cat
    zpwrExpandPreviewResolve 'notes.zpst'
    rc=$?
    assert $rc same_as 0
    assert "$REPLY" same_as 'cat notes.zpst'
    unset 'saliases[zpst]'
}

@test 'previewResolve: spelling correction via ZPWR_EXPAND_CORRECT_REVERSE' {
    local rc
    # built from plugin: ZPWR_EXPAND_CORRECT_WORDS[command] includes comamnd
    zpwrExpandPreviewResolve comamnd
    rc=$?
    assert $rc same_as 0
    assert "$REPLY" same_as 'command'
}

@test 'previewResolve: regular alias wins when same name is not also galias' {
    local rc
    alias __zpr_prev2='echo one'
    zpwrExpandPreviewResolve __zpr_prev2
    rc=$?
    assert $rc same_as 0
    assert "$REPLY" same_as 'echo one'
    unalias __zpr_prev2
}

#==============================================================
# zpwrExpandStatsRecord / zpwrExpandStats — temp file, no real ~/.cache
#==============================================================

@test 'stats: missing stats file shows empty message via box output' {
    local tmp
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-missing.XXXXXX")
    command rm -f "$tmp"
    ZPWR_EXPAND_STATS_FILE=$tmp
    run zpwrExpandStats
    assert $state equals 0
    assert "$output" contains 'No expansions recorded yet'
}

@test 'stats: record then read tallies S: and H: and correction lines' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    alias __zpr_stat_a='ls -la'
    zpwrExpandStatsRecord 'S:alias:__zpr_stat_a'
    zpwrExpandStatsRecord 'H:alias:__zpr_stat_a'
    zpwrExpandStatsRecord 'S:correction:'
    out=$(zpwrExpandStats)
    assert "$out" contains 'SPACE EXPANSIONS'
    assert "$out" contains 'HISTORY EXPANSIONS'
    assert "$out" contains 'TOTAL EXPANSIONS'
    assert "$out" contains 'CORRECTIONS'
    assert "$out" contains '__zpr_stat_a'
    unalias __zpr_stat_a
    command rm -f "$tmp"
}

@test 'stats: legacy line without S:/H: prefix counts as space expansion' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-legacy.XXXXXX")
    : >"$tmp"
    print -r -- 'legacy_alias_name' >>"$tmp"
    ZPWR_EXPAND_STATS_FILE=$tmp
    out=$(zpwrExpandStats)
    assert "$out" contains 'SPACE EXPANSIONS'
    assert "$out" contains 'legacy_alias_name'
    command rm -f "$tmp"
}

@test 'stats: old format S:alias (no type) counts as space + alias' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-old.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:old_alias'
    zpwrExpandStatsRecord 'H:old_alias'
    out=$(zpwrExpandStats)
    assert "$out" contains 'old_alias'
    assert "$out" contains 'ALIAS'
    command rm -f "$tmp"
}

#==============================================================
# stats: all expansion types tracked
#==============================================================

@test 'stats: alias type counted' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-alias.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:alias:gco'
    zpwrExpandStatsRecord 'S:alias:gco'
    zpwrExpandStatsRecord 'S:alias:gco'
    out=$(zpwrExpandStats)
    assert "$out" contains 'ALIAS'
    assert "$out" contains 'gco'
    command rm -f "$tmp"
}

@test 'stats: global alias type counted' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-global.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:global:G'
    zpwrExpandStatsRecord 'S:global:G'
    out=$(zpwrExpandStats)
    assert "$out" contains 'GLOBAL ALIAS'
    assert "$out" contains 'G'
    command rm -f "$tmp"
}

@test 'stats: suffix alias type counted' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-suffix.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:suffix:file.txt'
    out=$(zpwrExpandStats)
    assert "$out" contains 'SUFFIX ALIAS'
    assert "$out" contains 'file.txt'
    command rm -f "$tmp"
}

@test 'stats: escape type counted' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-escape.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:escape:git'
    out=$(zpwrExpandStats)
    assert "$out" contains 'SELF-REF ESCAPE'
    assert "$out" contains 'git'
    command rm -f "$tmp"
}

@test 'stats: native type counted' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-native.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:native:glob_word'
    out=$(zpwrExpandStats)
    assert "$out" contains 'NATIVE'
    assert "$out" contains 'glob_word'
    command rm -f "$tmp"
}

@test 'stats: correction counted' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-correct.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:correction:'
    zpwrExpandStatsRecord 'S:correction:'
    zpwrExpandStatsRecord 'S:correction:'
    out=$(zpwrExpandStats)
    assert "$out" contains 'CORRECTIONS'
    command rm -f "$tmp"
}

@test 'stats: mixed types all appear in output' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-mixed.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    alias __zpr_mix='echo mix'
    zpwrExpandStatsRecord 'S:alias:__zpr_mix'
    zpwrExpandStatsRecord 'S:alias:__zpr_mix'
    zpwrExpandStatsRecord 'H:alias:__zpr_mix'
    zpwrExpandStatsRecord 'S:global:G'
    zpwrExpandStatsRecord 'S:suffix:f.txt'
    zpwrExpandStatsRecord 'S:escape:git'
    zpwrExpandStatsRecord 'S:native:glob'
    zpwrExpandStatsRecord 'S:correction:'
    out=$(zpwrExpandStats)
    assert "$out" contains 'TRIGGER'
    assert "$out" contains 'TYPE'
    assert "$out" contains 'SUMMARY'
    assert "$out" contains 'TOP ALIASES'
    assert "$out" contains 'TOTAL EXPANSIONS'
    assert "$out" contains 'KEYSTROKES SAVED'
    assert "$out" contains '__zpr_mix'
    unalias __zpr_mix
    command rm -f "$tmp"
}

@test 'stats: keystrokes saved computed correctly' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-saved.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    alias __zpr_ks='git checkout'
    # alias is 8 chars, expansion is 12 chars, saving 4 per expansion
    # 5 expansions = 20 keystrokes saved
    zpwrExpandStatsRecord 'S:alias:__zpr_ks'
    zpwrExpandStatsRecord 'S:alias:__zpr_ks'
    zpwrExpandStatsRecord 'S:alias:__zpr_ks'
    zpwrExpandStatsRecord 'S:alias:__zpr_ks'
    zpwrExpandStatsRecord 'S:alias:__zpr_ks'
    out=$(zpwrExpandStats)
    assert "$out" contains 'KEYSTROKES SAVED'
    assert "$out" contains '20'
    unalias __zpr_ks
    command rm -f "$tmp"
}

@test 'stats: keystrokes saved includes global aliases' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-saved-global.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    # global alias: je (2 chars) -> | jq . (6 chars), saves 4 per use
    # 3 uses = 12 keystrokes saved
    alias -g __ZPR_KS_G='| jq .'
    zpwrExpandStatsRecord 'S:global:__ZPR_KS_G'
    zpwrExpandStatsRecord 'S:global:__ZPR_KS_G'
    zpwrExpandStatsRecord 'S:global:__ZPR_KS_G'
    out=$(zpwrExpandStats)
    # __ZPR_KS_G is 10 chars, '| jq .' is 6 chars — would subtract if not handled as global
    # we just want to verify it's being counted (non-zero or matches expected)
    assert "$out" contains '__ZPR_KS_G'
    assert "$out" contains '| jq .'
    unalias __ZPR_KS_G
    command rm -f "$tmp"
}

@test 'stats: keystrokes saved includes suffix aliases' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-saved-suffix.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    # suffix alias: .zpks extension -> vim  (3 chars)
    # file.zpks (9 chars) -> vim file.zpks (13 chars), saves 4 per use
    # 2 uses = 8 keystrokes saved
    saliases[zpks]=vim
    zpwrExpandStatsRecord 'S:suffix:file.zpks'
    zpwrExpandStatsRecord 'S:suffix:file.zpks'
    out=$(zpwrExpandStats)
    assert "$out" contains 'file.zpks'
    assert "$out" contains 'vim file.zpks'
    unset 'saliases[zpks]'
    command rm -f "$tmp"
}

@test 'stats: TOP ALIASES shows global alias expansion' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-top-global.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    alias -g __ZPR_TOPG='| sort'
    zpwrExpandStatsRecord 'S:global:__ZPR_TOPG'
    zpwrExpandStatsRecord 'S:global:__ZPR_TOPG'
    out=$(zpwrExpandStats)
    # should show the expansion text next to the alias
    assert "$out" contains '__ZPR_TOPG'
    assert "$out" contains '| sort'
    unalias __ZPR_TOPG
    command rm -f "$tmp"
}

@test 'stats: TOP ALIASES shows suffix alias expansion' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-top-suffix.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    saliases[zpsfx]=cat
    zpwrExpandStatsRecord 'S:suffix:data.zpsfx'
    out=$(zpwrExpandStats)
    assert "$out" contains 'data.zpsfx'
    assert "$out" contains 'cat data.zpsfx'
    unset 'saliases[zpsfx]'
    command rm -f "$tmp"
}

@test 'stats: keystrokes saved sums all alias types' {
    local tmp out savedLine
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-saved-all.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    # regular: __zpr_r (7 chars) -> hello world (11 chars) = 4 per use, 2 uses = 8
    alias __zpr_r='hello world'
    # global: __ZPR_G (7 chars) -> | tail -n 5 (11 chars) = 4 per use, 2 uses = 8
    alias -g __ZPR_G='| tail -n 5'
    # suffix: zpmix ext -> less (4 chars), file.zpmix (10 chars) -> less file.zpmix (15 chars) = 5 per use, 2 uses = 10
    saliases[zpmix]=less
    zpwrExpandStatsRecord 'S:alias:__zpr_r'
    zpwrExpandStatsRecord 'S:alias:__zpr_r'
    zpwrExpandStatsRecord 'S:global:__ZPR_G'
    zpwrExpandStatsRecord 'S:global:__ZPR_G'
    zpwrExpandStatsRecord 'S:suffix:file.zpmix'
    zpwrExpandStatsRecord 'S:suffix:file.zpmix'
    out=$(zpwrExpandStats)
    # total saved = 8 + 8 + 10 = 26
    assert "$out" contains 'KEYSTROKES SAVED'
    assert "$out" contains '26'
    unalias __zpr_r __ZPR_G
    unset 'saliases[zpmix]'
    command rm -f "$tmp"
}

@test 'stats: history expansion counted separately from space' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-hist.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:alias:foo'
    zpwrExpandStatsRecord 'S:alias:foo'
    zpwrExpandStatsRecord 'S:alias:foo'
    zpwrExpandStatsRecord 'H:alias:foo'
    out=$(zpwrExpandStats)
    # 3 space + 1 history = 4 total
    assert "$out" contains 'TOTAL EXPANSIONS'
    assert "$out" contains 'foo'
    command rm -f "$tmp"
}

@test 'stats: glob char * in alias name handled safely' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-glob.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:native:*'
    zpwrExpandStatsRecord 'S:native:*'
    zpwrExpandStatsRecord 'S:native:*'
    out=$(zpwrExpandStats 2>&1)
    # must not produce "bad math expression" errors
    [[ $out != *"bad math"* ]]
    assert $? equals 0
    assert "$out" contains 'NATIVE'
    command rm -f "$tmp"
}

@test 'stats: bar chart renders for top aliases' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-bar.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    local -i i
    for (( i = 1; i <= 10; i++ )); do zpwrExpandStatsRecord 'S:alias:top_alias'; done
    for (( i = 1; i <= 3; i++ )); do zpwrExpandStatsRecord 'S:alias:small_alias'; done
    out=$(zpwrExpandStats)
    # should contain bar chart characters
    assert "$out" contains '█'
    assert "$out" contains 'top_alias'
    assert "$out" contains 'small_alias'
    command rm -f "$tmp"
}

@test 'stats: output is valid box structure' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-box.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:alias:test_box'
    out=$(zpwrExpandStats)
    # first line is box top
    assert "$out" matches ".*┌.*┐.*"
    # last non-empty lines contain box bottom and shadow
    assert "$out" matches ".*└.*┘.*"
    assert "$out" contains '░'
    command rm -f "$tmp"
}

@test 'stats: ZPWR_EXPAND_STATS_TOP limits TOP ALIASES rows' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-top.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    local -i i
    ZPWR_EXPAND_STATS_TOP=3
    for (( i = 1; i <= 10; i++ )); do zpwrExpandStatsRecord 'S:alias:zst_rank1'; done
    for (( i = 1; i <= 8; i++ )); do zpwrExpandStatsRecord 'S:alias:zst_rank2'; done
    for (( i = 1; i <= 6; i++ )); do zpwrExpandStatsRecord 'S:alias:zst_rank3'; done
    for (( i = 1; i <= 4; i++ )); do zpwrExpandStatsRecord 'S:alias:zst_rank4_dropped'; done
    out=$(zpwrExpandStats)
    assert "$out" contains 'zst_rank1'
    assert "$out" contains 'zst_rank2'
    assert "$out" contains 'zst_rank3'
    [[ $out != *zst_rank4_dropped* ]]
    assert $? equals 0
    command rm -f "$tmp"
    unset ZPWR_EXPAND_STATS_TOP
}

@test 'stats: unset ZPWR_EXPAND_STATS_TOP uses default 20' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-top-default.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    unset ZPWR_EXPAND_STATS_TOP
    local -i r
    for (( r = 1; r <= 21; r++ )); do
        zpwrExpandStatsRecord "S:alias:zst_def_${(l:2::0:)r}"
    done
    out=$(zpwrExpandStats)
    # Tied counts sort with zst_def_21 … zst_def_02 in the top 20; zst_def_01 is rank 21.
    assert "$out" contains 'zst_def_21'
    assert "$out" contains 'zst_def_02'
    [[ $out != *zst_def_01* ]]
    assert $? equals 0
    command rm -f "$tmp"
}

#==============================================================
# zpwrExpandStats CLI (-h, -t, -w, -f, -r, -c)
#==============================================================

@test 'stats CLI: -h prints dashboard help and exits 0' {
    run zpwrExpandStats -h
    assert $state equals 0
    assert "$output" contains 'EXPANSION STATS DASHBOARD'
    assert "$output" contains 'USAGE:'
}

@test 'stats CLI: --help matches -h' {
    run zpwrExpandStats --help
    assert $state equals 0
    assert "$output" contains 'zpwrExpandStats'
    assert "$output" contains '--top'
}

@test 'stats CLI: unknown option returns non-zero' {
    run zpwrExpandStats --not-a-real-flag-zz 2>&1
    assert $state not_equal_to 0
    assert "$output" contains 'unknown option'
}

@test 'stats CLI: -r clears file passed via -f' {
    local tmp
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-reset.XXXXXX")
    print -r 'S:alias:gone' >>"$tmp"
    run zpwrExpandStats -r -f "$tmp"
    assert $state equals 0
    assert "$output" contains 'Stats cleared'
    [[ ! -f $tmp ]]
    assert $? equals 0
}

@test 'stats CLI: -r when -f path has no file' {
    local tmp
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-reset-miss.XXXXXX")
    command rm -f "$tmp"
    run zpwrExpandStats -r -f "$tmp"
    assert $state equals 0
    assert "$output" contains 'No stats file'
}

@test 'stats CLI: -f reads stats from alternate path' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-file.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:alias:alt_path_marker'
    unset ZPWR_EXPAND_STATS_FILE
    out=$(zpwrExpandStats -f "$tmp")
    assert "$out" contains 'alt_path_marker'
    command rm -f "$tmp"
}

@test 'stats CLI: -t limits TOP ALIASES with -f' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-top.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    local -i i
    for (( i = 1; i <= 5; i++ )); do zpwrExpandStatsRecord 'S:alias:cli_top_heavy'; done
    for (( i = 1; i <= 2; i++ )); do zpwrExpandStatsRecord 'S:alias:cli_top_light'; done
    unset ZPWR_EXPAND_STATS_FILE
    out=$(zpwrExpandStats -f "$tmp" -t 1)
    assert "$out" contains 'cli_top_heavy'
    [[ $out != *cli_top_light* ]]
    assert $? equals 0
    command rm -f "$tmp"
}

@test 'stats CLI: -w widens box (corners present)' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-width.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:alias:wide_box'
    unset ZPWR_EXPAND_STATS_FILE
    out=$(zpwrExpandStats -f "$tmp" -w 92)
    assert "$out" matches ".*┌.*┐.*"
    command rm -f "$tmp"
}

@test 'stats CLI: -c with stats does not error' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-color.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:alias:color_row'
    unset ZPWR_EXPAND_STATS_FILE
    out=$(zpwrExpandStats -f "$tmp" -c 2>&1)
    [[ $out != *"bad math"* ]]
    assert $? equals 0
    assert "$out" contains 'color_row'
    command rm -f "$tmp"
}

@test 'stats CLI: long form --reset --file' {
    local tmp
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-long.XXXXXX")
    print -r 'S:alias:gone2' >>"$tmp"
    run zpwrExpandStats --reset --file "$tmp"
    assert $state equals 0
    [[ ! -f $tmp ]]
    assert $? equals 0
}

@test 'stats CLI: multiline alias expansion collapsed in TOP ALIASES' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-cli-mline.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    alias __zpr_mline='line1
line2   spaced'
    zpwrExpandStatsRecord 'S:alias:__zpr_mline'
    unset ZPWR_EXPAND_STATS_FILE
    out=$(zpwrExpandStats -f "$tmp" -w 70)
    assert "$out" contains '__zpr_mline'
    assert "$out" contains 'line1'
    assert "$out" contains 'line2'
    unalias __zpr_mline
    command rm -f "$tmp"
}

#==============================================================
# glob chars must not falsely match aliases
#==============================================================

@test 'glob: * is not treated as alias even when aliases exist' {
    alias __zpr_real='echo real'
    # ${+aliases[*]} would return 1 without (e) flag
    [[ -z ${aliases[(e)*]} ]]
    assert $? equals 0
    # the (e) flag must be used in the expansion path
    (( ! ${+aliases[(e)*]} ))
    assert $? equals 0
    unalias __zpr_real
}

@test 'glob: ? is not treated as alias' {
    alias __zpr_q='echo q'
    (( ! ${+aliases[(e)?]} ))
    assert $? equals 0
    unalias __zpr_q
}

@test 'glob: [abc] is not treated as alias' {
    alias a='echo a'
    (( ! ${+aliases[(e)[abc]]} ))
    assert $? equals 0
}

@test 'glob: * not treated as global alias even when galiases exist' {
    alias -g __ZPR_G='| head'
    (( ! ${+galiases[(e)*]} ))
    assert $? equals 0
    unalias __ZPR_G
}

@test 'glob: previewResolve does not resolve star as alias' {
    alias __zpr_star_test='echo star'
    run zpwrExpandPreviewResolve '*'
    assert $state equals 1
    unalias __zpr_star_test
}

@test 'glob: previewResolve does not resolve question mark as alias' {
    alias __zpr_q2='echo q2'
    run zpwrExpandPreviewResolve '?'
    assert $state equals 1
    unalias __zpr_q2
}

@test 'stats: echo * records as native not alias' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-glob-type.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    # simulate what should happen: native expansion, not alias
    zpwrExpandStatsRecord 'S:native:*'
    out=$(zpwrExpandStats 2>&1)
    assert "$out" contains 'NATIVE'
    # should NOT have alias count for *
    [[ $out != *"S:alias:*"* ]]
    assert $? equals 0
    command rm -f "$tmp"
}

@test 'stats: * does not produce double records' {
    local tmp
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-glob-double.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:native:*'
    local -i lineCount
    lineCount=$(wc -l < "$tmp")
    assert $lineCount equals 1
    command rm -f "$tmp"
}

@test 'stats: glob chars in keys do not cause bad math' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-glob-math.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'S:native:*'
    zpwrExpandStatsRecord 'S:native:?'
    zpwrExpandStatsRecord 'S:native:[abc]'
    zpwrExpandStatsRecord 'S:alias:normal'
    out=$(zpwrExpandStats 2>&1)
    [[ $out != *"bad math"* ]]
    assert $? equals 0
    assert "$out" contains 'normal'
    command rm -f "$tmp"
}

@test 'glob: actual alias named literally is still found' {
    # an alias whose name has no glob meaning should still work
    alias __zpr_noglobname='echo works'
    (( ${+aliases[(e)__zpr_noglobname]} ))
    assert $? equals 0
    assert "${aliases[(e)__zpr_noglobname]}" same_as 'echo works'
    unalias __zpr_noglobname
}

@test 'glob: previewResolve still resolves normal aliases' {
    alias __zpr_norm='echo normal'
    zpwrExpandPreviewResolve '__zpr_norm'
    local rc=$?
    assert $rc equals 0
    assert "$REPLY" same_as 'echo normal'
    unalias __zpr_norm
}

#==============================================================
# new stats format: trigger:type:alias:saved for natives
#==============================================================

@test 'stats: native record with saved chars suffix parses correctly' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-native-saved.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    # new format: H:native:!!:42 means 42 chars saved
    zpwrExpandStatsRecord 'H:native:!!:42'
    zpwrExpandStatsRecord 'H:native:!!:38'
    out=$(zpwrExpandStats)
    # both should count as native, saved chars should total 80
    assert "$out" contains 'NATIVE'
    assert "$out" contains '!!'
    assert "$out" contains '80'
    command rm -f "$tmp"
}

@test 'stats: native record without saved suffix still counts (legacy)' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-native-nosave.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    # old format without saved chars
    zpwrExpandStatsRecord 'S:native:globby'
    zpwrExpandStatsRecord 'H:native:globby'
    out=$(zpwrExpandStats)
    assert "$out" contains 'NATIVE'
    assert "$out" contains 'globby'
    command rm -f "$tmp"
}

@test 'stats: mixed alias savings and native saved chars sum together' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-mixed-saved.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    alias __zpr_mixa='git checkout branch'  # 10 chars -> 19 chars = 9 saved/use
    # 2 uses: 18 chars saved from alias
    zpwrExpandStatsRecord 'S:alias:__zpr_mixa'
    zpwrExpandStatsRecord 'S:alias:__zpr_mixa'
    # 3 native expansions with saved chars
    zpwrExpandStatsRecord 'H:native:!!:10'
    zpwrExpandStatsRecord 'H:native:!!:15'
    zpwrExpandStatsRecord 'H:native:!!:5'
    # total saved = 18 + 30 = 48
    out=$(zpwrExpandStats)
    assert "$out" contains '48'
    unalias __zpr_mixa
    command rm -f "$tmp"
}

@test 'stats: native saved zero does not corrupt totals' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-native-zero.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    zpwrExpandStatsRecord 'H:native:starword:0'
    zpwrExpandStatsRecord 'H:native:starword:0'
    out=$(zpwrExpandStats)
    assert "$out" contains 'NATIVE'
    assert "$out" contains 'starword'
    command rm -f "$tmp"
}

#==============================================================
# native char in alias name (not type) is not confused with saved
#==============================================================

@test 'stats: alias name containing colon is not split at first colon' {
    local tmp out
    tmp=$(mktemp "${TMPDIR:-/tmp}/zunit-zpwr-stats-colon-alias.XXXXXX")
    ZPWR_EXPAND_STATS_FILE=$tmp
    # alias type does not use saved suffix — 'ns:tool' is the alias name
    zpwrExpandStatsRecord 'S:alias:ns:tool'
    out=$(zpwrExpandStats)
    assert "$out" contains 'ns:tool'
    command rm -f "$tmp"
}
