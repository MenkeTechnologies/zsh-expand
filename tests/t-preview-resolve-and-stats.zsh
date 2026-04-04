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
    unalias __zpr_ks
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
