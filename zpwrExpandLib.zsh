#!/usr/bin/env zsh
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Sat Sep  5 18:51:48 EDT 2020
##### Purpose: zsh script to expand
##### Notes:
#}}}***********************************************************

#{{{                    MARK:accessory functions
#**************************************************************
# dummy function if plugin used outside of zpwr
if ! type -- "zpwrLogDebug" &>/dev/null;then
    function zpwrLogDebug(){
        :
    }
fi

if type -- "autopair-insert" &>/dev/null;then
    ZPWR_VARS[AP_SPACE]=true
else
    ZPWR_VARS[AP_SPACE]=false
fi

function zpwrExpandIsCommand(){
    (( ${+commands[$1]} + ${+functions[$1]} + ${+builtins[$1]} + ${+aliases[$1]} ))
}

function zpwrExpandGoToTabStopOrEndOfLBuffer(){

    local lenToFirstTS

    lenToFirstTS=${#LBUFFER%%$ZPWR_TABSTOP*}

    if (( $lenToFirstTS < ${#LBUFFER} )); then
        #zpwrLogDebug "this is a tabstop"
        # check if numbered tabstop
        # if num tabstop then set flag in ZPWR_VARS with value to all indexes
        # sub out all num tabstops
        # insert key fn will send key to all indexes apply any modifications
        # keep track of num keys to have activated region
        ZPWR_VARS[indexTS]=$lenToFirstTS

        CURSOR=$lenToFirstTS
        RBUFFER=${RBUFFER:$#ZPWR_TABSTOP}
        ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=false
    else
        ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    fi
}

function zpwrExpandCorrectWord(){

    local word key res1

    if (( ${+galiases[${ZPWR_VARS[lastword_lbuffer]}]} )); then
        return
    fi


    if zpwrExpandRegexMatchOnCommandPosition correct; then

        #zpwrLogDebug "${match[@]}"
        #zpwrLogDebug "${ZPWR_EXPAND_PRE_CORRECT[@]}"

        word=${ZPWR_EXPAND_PRE_CORRECT[1]}
        if [[ -z $word && $#ZPWR_EXPAND_PRE_CORRECT -le 1 ]]; then
            # all words consumed as prefixes (e.g. "env" alone) — nothing to correct
            return
        elif (( $#ZPWR_EXPAND_PRE_CORRECT == 1)); then
            if zpwrExpandIsCommand $word; then
                #zpwrLogDebug "No correction from >= 2 words => '"'$word'"'_____ = ""'$word'"
                # sudo/env pwd<space>
                return
            fi

        elif (( $#ZPWR_EXPAND_PRE_CORRECT == 2)); then
            if [[ $word =~ $ZPWR_VARS[blacklistSubcommandPositionRegex] ]]; then
                # sudo/env git init<space>
                return
            fi
        fi

    else
        #zpwrLogDebug "no match ZPWR_EXPAND_WORDS_LPARTITION '$ZPWR_EXPAND_WORDS_LPARTITION'"
        zpwrLogConsoleErr zpwr expand should not reach here
        return
    fi

    #zpwrLogDebug "______'"'attempt correction'"'_____ = ""'$ZPWR_VARS[lastword_remove_special]'"

    local misspelling=${ZPWR_VARS[lastword_remove_special]}
    key=${ZPWR_EXPAND_CORRECT_REVERSE[$misspelling]}

    if [[ -n $key ]]; then
        # expand only when cursor is right of misspelled word
        if [[ $LBUFFER == (#b)(*[[:space:]]#)($misspelling) ]]; then
            res1=${match[1]}
            LBUFFER="$res1${key:gs/_/ /}"
            ZPWR_VARS[foundIncorrect]=true
        fi

        # expand only when cursor is right of misspelled word
        if [[ $ZPWR_EXPAND_PRE_CORRECT == (#b)(*[[:space:]]#)($misspelling) ]]; then
            res1=${match[1]}
            ZPWR_EXPAND_POST_CORRECT=( "${(z):-$res1${key:gs/_/ /}}" )
            ZPWR_VARS[foundIncorrect]=true
        fi
    fi
}

function zpwrExpandGetAliasValue(){

    ZPWR_VARS[EXPANDED]="${aliases[$ZPWR_VARS[lastword_lbuffer]]}"
}

function zpwrExpandAliasEscape(){

    local res1

    if [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then
        res1=${match[1]}
        # expand
        LBUFFER="$res1\\$ZPWR_VARS[EXPANDED]"
        ZPWR_VARS[WAS_EXPANDED]=true
        ZPWR_VARS[EXPAND_TYPE]=escape
    fi


}

function zpwrExpandWordStopHistoryExpansion(){
    #escapes all previous history !pwd etc before last word because zle expand-word always expands them

    local res1

    if [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then
        res1=${match[1]}
        # expand
        regexp-replace res1 '(^|[ ])!([[:graph:]]+ )' '$match[1]\!$match[2]' &> /dev/null
        LBUFFER="$res1$ZPWR_VARS[lastword_lbuffer]"
        ZPWR_VARS[WAS_EXPANDED]=true
        ZPWR_VARS[EXPAND_TYPE]=native
        zle expand-word
    fi

}

function zpwrExpandAlias(){

    local res1

    if [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then
        res1=${match[1]}
        # expand
        LBUFFER="$res1$ZPWR_VARS[EXPANDED]"
        ZPWR_VARS[WAS_EXPANDED]=true
        ZPWR_VARS[EXPAND_TYPE]=alias
    fi

}

function zpwrExpandGlobalAliases() {

    local res1 result

    if [[ -n "$1" ]]; then
        ZPWR_VARS[lastword_lbuffer]="$1"
    else
        # called as ZLE widget (e.g. via keybinding) — parse words from LBUFFER
        zpwrExpandParseWords "$LBUFFER"
    fi
    result=$galiases[$ZPWR_VARS[lastword_lbuffer]]
    if [[ -n $result ]] && [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then

        res1=${match[1]}
        # expand
        LBUFFER="$res1$result"
        ZPWR_VARS[WAS_EXPANDED]=true
        ZPWR_VARS[EXPAND_TYPE]=global

        zpwrExpandGoToTabStopOrEndOfLBuffer
    fi
}

function zpwrExpandRightTrim() {
    # regular alias expansion
    # remove space from menuselect spacebar
    if [[ ${LBUFFER: -1} == " "  && ${LBUFFER: -2:-1} != " " ]]; then
        #zpwrLogDebug "removing space menu select"
        LBUFFER="${LBUFFER:0:-1}"
    fi

}

function zpwrExpandSuffixAlias(){

    local word=$ZPWR_VARS[lastword_lbuffer]
    local ext=${word:e}
    local res1

    # only expand at command position: single word or single word after prefixes
    if (( $#ZPWR_EXPAND_WORDS_LPARTITION > 1 )) && (( $#ZPWR_EXPAND_PRE_EXPAND != 1 )); then
        return
    fi

    if [[ -n $ext ]] && (( ${+saliases[$ext]} )); then
        if [[ $LBUFFER == (#b)(*[[:space:]]#)($word) ]]; then
            res1=${match[1]}
            LBUFFER="$res1$saliases[$ext] $word"
            ZPWR_VARS[WAS_EXPANDED]=true
            ZPWR_VARS[EXPAND_TYPE]=suffix
            zpwrExpandGoToTabStopOrEndOfLBuffer
        fi
    fi
}

zpwrExpandTerminateSpace(){

    LBUFFER+=" "
}


function zpwrExpandRegexMatchOnCommandPosition() {

    # run parser if cache not populated (e.g. caller set ZPWR_EXPAND_WORDS_LPARTITION directly)
    if [[ $ZPWR_VARS[cachedRegexMatched] != true ]]; then
        zpwrExpandParserFindCommandPosition
    fi

    if [[ $ZPWR_VARS[cachedRegexMatched] == true ]]; then
        if [[ $1 == "correct" ]]; then
            ZPWR_EXPAND_PRE_CORRECT=("${(z)ZPWR_VARS[cachedRegexMatch]}")
        else
            ZPWR_EXPAND_PRE_EXPAND=("${(z)ZPWR_VARS[cachedRegexMatch]}")
        fi
        return 0
    fi
    return 1
}

#}}}***********************************************************

#{{{                    MARK:box and debug
#**************************************************************
function zpwrExpandBox() {
    local title="" wrapW=0 forceColor=false
    local -a rawLines=()

    # parse flags
    while [[ $1 == -* ]]; do
        case $1 in
            -t|--title) title=$2; shift 2 ;;
            -w|--width) wrapW=$2; shift 2 ;;
            -c|--color) forceColor=true; shift ;;
            --) shift; break ;;
            *)  shift ;;
        esac
    done

    # collect lines from args and/or stdin, expand tabs
    # when positional lines are given, do not read stdin — a non-tty stdin may
    # never close (e.g. test runners), which would block forever after filling rawLines
    if (( $# )); then
        rawLines=("$@")
    elif [[ ! -t 0 ]]; then
        local stdinLine
        while IFS= read -r stdinLine || [[ -n $stdinLine ]]; do
            rawLines+=("$stdinLine")
        done
    fi
    # strip backspace overprint sequences (bold: X\bX -> X, underline: _\bX -> X)
    local -i ri
    for (( ri = 1; ri <= $#rawLines; ri++ )); do
        while [[ $rawLines[$ri] == *$'\b'* ]]; do
            rawLines[$ri]=${rawLines[$ri]//?$'\b'/}
        done
    done
    # expand tabs to spaces so char count matches rendered width
    rawLines=("${(@)rawLines//$'\t'/        }")

    # default wrap width to terminal width minus box overhead (4 chars: "│ " + " │")
    if (( wrapW == 0 )); then
        wrapW=$((COLUMNS > 0 ? COLUMNS - 4 : 76))
    fi

    # never allow zero wrap width (would infinite-loop in word-wrap)
    (( wrapW < 1 )) && wrapW=1

    # ensure title fits
    local -i titleW=${#title}
    (( titleW + 2 > wrapW )) && wrapW=$((titleW + 2))

    # word-wrap lines that exceed wrapW
    local -a lines=()
    local raw remaining chunk trimmed
    local -i breakAt
    for raw in "${rawLines[@]}"; do
        if (( ${#raw} <= wrapW )); then
            lines+=("$raw")
        else
            remaining=$raw
            while (( ${#remaining} > wrapW )); do
                chunk=${remaining:0:$wrapW}
                breakAt=${#chunk}
                if [[ $chunk == *" "* ]]; then
                    trimmed=${chunk% *}
                    breakAt=${#trimmed}
                    (( breakAt == 0 )) && breakAt=$wrapW
                fi
                lines+=("${remaining:0:$breakAt}")
                remaining=${remaining:$breakAt}
                remaining=${remaining# }
            done
            [[ -n $remaining ]] && lines+=("$remaining")
        fi
    done

    # find actual max content width, capped to wrapW so box never exceeds terminal
    local -i w=0 len
    local line
    for line in "${lines[@]}"; do
        len=${#line}
        (( len > w )) && w=$len
    done
    (( titleW + 2 > w )) && w=$((titleW + 2))
    (( w > wrapW )) && w=$wrapW

    # build box
    local -i boxW=$((w + 4))
    local msg hbar pad
    hbar=${(l:boxW-2::─:)}

    # color support: ANSI 256-color when outputting to terminal, plain for zle -M / pipes
    local useColor=false
    [[ -t 1 || $forceColor == true ]] && useColor=true

    local RST="" cBorder="" cTitle="" cContent="" cShadow=""
    if [[ $useColor == true ]]; then
        RST=$'\e[0m'
        cBorder=$'\e[38;5;51m'       # cyan neon
        cTitle=$'\e[1m\e[38;5;207m'  # bold magenta neon
        cContent=$'\e[38;5;48m'      # green neon
        cShadow=$'\e[38;5;236m'      # dark gray
    fi

    if [[ -n $title ]]; then
        local -i titlePad=$((boxW - titleW - 6))
        msg="${cBorder}┌── ${cTitle}$title${cBorder} ${(l:titlePad::─:)}┐${RST}"
    else
        msg="${cBorder}┌${hbar}┐${RST}"
    fi
    for line in "${lines[@]}"; do
        # truncate if still wider than w (e.g. single word longer than wrapW)
        (( ${#line} > w )) && line=${line:0:$w}
        len=${#line}
        pad=${(l:w-len+1:: :)}
        msg+=$'\n'"${cBorder}│${RST} ${cContent}$line${RST}${pad}${cBorder}│${RST}"
    done
    msg+=$'\n'"${cBorder}└${hbar}┘${RST}"
    msg+=$'\n'"${cShadow}${(l:boxW::░:)}${RST}"
    print -r -- "$msg"
}

function zpwrExpandDebugWidget() {

    'builtin' emulate -L zsh
    setopt rcquotes extended_glob zle

    if [[ -z $LBUFFER ]]; then
        zle -M "zsh-expand: empty line"
        return
    fi

    local -a savedPartition
    local savedMatch savedMatched savedPrefix

    # save state
    savedPartition=("${ZPWR_EXPAND_WORDS_LPARTITION[@]}")
    savedMatch=$ZPWR_VARS[cachedRegexMatch]
    savedMatched=$ZPWR_VARS[cachedRegexMatched]
    savedPrefix=$ZPWR_VARS[cachedParserPrefix]

    zpwrExpandParseWords "$LBUFFER"

    local lastword=$ZPWR_VARS[lastword_lbuffer]
    local prefix=$ZPWR_VARS[cachedParserPrefix]
    local tail=$ZPWR_VARS[cachedRegexMatch]
    local matched=$ZPWR_VARS[cachedRegexMatched]
    local -a tailWords=( ${(z)tail} )
    local cmdWord=${tailWords[1]}
    local msg=""
    local expandsTo="" expandType=""

    # determine what would happen
    if [[ -n $lastword ]]; then
        if (( ${+aliases[$lastword]} )); then
            expandsTo=${aliases[$lastword]}
            expandType="alias"
        elif (( ${+galiases[$lastword]} )); then
            expandsTo=${galiases[$lastword]}
            expandType="global alias"
        elif [[ -n ${lastword:e} ]] && (( ${+saliases[${lastword:e}]} )); then
            expandsTo="$saliases[${lastword:e}] $lastword"
            expandType="suffix alias"
        elif [[ -n ${ZPWR_EXPAND_CORRECT_REVERSE[$ZPWR_VARS[lastword_remove_special]]} ]]; then
            expandsTo=${ZPWR_EXPAND_CORRECT_REVERSE[$ZPWR_VARS[lastword_remove_special]]}
            expandType="correction"
        fi
    fi

    # build lines
    local -a lines=()
    lines+=("input:    $LBUFFER")
    lines+=("words:    ${#ZPWR_EXPAND_WORDS_LPARTITION} [${ZPWR_EXPAND_WORDS_LPARTITION[*]}]")
    if [[ -n $prefix ]]; then
        lines+=("prefix:   $prefix")
    fi
    if [[ $matched == true && -n $tail ]]; then
        lines+=("command:  $cmdWord")
        if (( $#tailWords > 1 )); then
            lines+=("args:     ${tailWords[2,-1]}")
        fi
    elif [[ $matched == true ]]; then
        lines+=("command:  (all words consumed as prefix)")
    fi
    lines+=("lastword: $lastword")
    if [[ -n $expandType ]]; then
        lines+=("action:   $expandType -> $expandsTo")
    else
        lines+=("action:   (no expansion)")
    fi
    if zpwrExpandIsCommand "$cmdWord" 2>/dev/null; then
        lines+=("valid:    yes ($cmdWord exists)")
    elif [[ -n $cmdWord ]]; then
        lines+=("valid:    no ($cmdWord not found)")
    fi
    msg=$(zpwrExpandBox -t "zsh-expand debug" "${lines[@]}")

    # restore state
    ZPWR_EXPAND_WORDS_LPARTITION=("${savedPartition[@]}")
    ZPWR_VARS[cachedRegexMatch]=$savedMatch
    ZPWR_VARS[cachedRegexMatched]=$savedMatched
    ZPWR_VARS[cachedParserPrefix]=$savedPrefix

    zle -M "$msg"
}
#}}}***********************************************************

function zpwrExpandPreviewResolve() {
    # resolve what the last word would expand to, return via REPLY
    # does not modify LBUFFER or any global state
    REPLY=""
    local lastword=$1
    [[ -z $lastword ]] && return 1

    if (( ${+aliases[$lastword]} )); then
        REPLY=${aliases[$lastword]}
    elif (( ${+galiases[$lastword]} )); then
        REPLY=${galiases[$lastword]}
    elif [[ -n ${lastword:e} ]] && (( ${+saliases[${lastword:e}]} )); then
        REPLY="$saliases[${lastword:e}] $lastword"
    elif [[ -n ${ZPWR_EXPAND_CORRECT_REVERSE[$lastword]} ]]; then
        REPLY=${ZPWR_EXPAND_CORRECT_REVERSE[$lastword]}
    fi

    [[ -n $REPLY ]] && return 0
    return 1
}

function zpwrExpandPreview() {
    # called on zle-line-pre-redraw — show expansion preview below prompt via zle -M

    # bail if preview disabled or expand disabled
    [[ $ZPWR_EXPAND_PREVIEW != true || $ZPWR_EXPAND == false ]] && return

    # bail if empty or ends with space (already expanded)
    if [[ -z $LBUFFER || $LBUFFER[-1] == " " ]]; then
        if [[ -n $ZPWR_VARS[previewShowing] ]]; then
            zle -M ""
            ZPWR_VARS[previewShowing]=""
            ZPWR_VARS[previewLastWord]=""
        fi
        return
    fi

    # get the last word cheaply — no full parse, just grab trailing non-space
    local lastword=${LBUFFER##*[[:space:]]}

    # check blacklist
    if [[ -n $ZPWR_VARS[blacklistUser] ]] && [[ $lastword =~ $ZPWR_VARS[blacklistUser] ]]; then
        if [[ -n $ZPWR_VARS[previewShowing] ]]; then
            zle -M ""
            ZPWR_VARS[previewShowing]=""
        fi
        return
    fi

    # skip if same as last check
    if [[ $lastword == $ZPWR_VARS[previewLastWord] ]]; then
        return
    fi
    ZPWR_VARS[previewLastWord]=$lastword

    local expanded
    if zpwrExpandPreviewResolve "$lastword"; then
        expanded=$REPLY
        if [[ $expanded == "$lastword" ]]; then
            if [[ -n $ZPWR_VARS[previewShowing] ]]; then
                zle -M ""
                ZPWR_VARS[previewShowing]=""
            fi
            return
        fi
        zle -M "  → $expanded"
        ZPWR_VARS[previewShowing]=true
    else
        if [[ -n $ZPWR_VARS[previewShowing] ]]; then
            zle -M ""
            ZPWR_VARS[previewShowing]=""
        fi
    fi
}
#}}}***********************************************************

#{{{                    MARK:main fn
#**************************************************************
function zpwrExpandSupernaturalSpace() {

    'builtin' emulate -L zsh
    setopt rcquotes extended_glob zle

    # clear expansion preview
    if [[ -n $ZPWR_VARS[previewShowing] ]]; then
        zle -M ""
        ZPWR_VARS[previewShowing]=""
        ZPWR_VARS[previewLastWord]=""
    fi

    if [[ $ZPWR_TRACE == true ]]; then
        set -x
    fi

    local triggerKey="$1"
    # globals
    ZPWR_EXPAND_WORDS_LPARTITION=()
    ZPWR_EXPAND_PRE_CORRECT=()
    ZPWR_EXPAND_POST_CORRECT=()
    ZPWR_EXPAND_PRE_EXPAND=()
    ZPWR_VARS[foundIncorrect]=false
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    ZPWR_VARS[EXPAND_TYPE]=""
    ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=false
    ZPWR_VARS[WAS_EXPANDED]=false

    zpwrExpandParseWords "$LBUFFER"

    if [[ $triggerKey == "${ZPWR_VARS[SPACEBAR_KEY]}" ]]; then
        if [[ $ZPWR_EXPAND == false ]]; then
            zle self-insert
            return
        fi
        if [[ $ZPWR_CORRECT == true ]]; then
            zpwrExpandCorrectWord
            if [[ $ZPWR_VARS[foundIncorrect] = true && $ZPWR_CORRECT_EXPAND = true ]]; then
                #zpwrLogDebug "RE-EXPAND after incorrect spelling"
                ZPWR_EXPAND_PRE_EXPAND=( "${ZPWR_EXPAND_POST_CORRECT[@]}" )
                zpwrExpandParseWords "$LBUFFER"
            else
                ZPWR_EXPAND_PRE_EXPAND=( "${ZPWR_EXPAND_PRE_CORRECT[@]}" )
            fi
        else
            zpwrExpandRegexMatchOnCommandPosition
        fi

    else
        if [[ $ZPWR_EXPAND == false ]]; then
            return
        fi
        zpwrExpandRegexMatchOnCommandPosition
    fi

    #dont expand =word because that is zle expand-word
    if [[ ${ZPWR_VARS[lastword_lbuffer]:0:1} != '=' ]] && (( $#ZPWR_VARS[lastword_lbuffer] > 0 ));then
        if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $ZPWR_VARS[lastword_lbuffer] =~ $ZPWR_VARS[blacklistUser] ]]; then
            if (( ${+aliases[${ZPWR_VARS[lastword_lbuffer]}]} )) && ! [[ ${aliases[${ZPWR_VARS[lastword_lbuffer]}]} =~ $ZPWR_VARS[blacklistFirstPosRegex] ]];then

                #zpwrLogDebug "regular=>'$ZPWR_VARS[lastword_lbuffer]'"
                zpwrExpandRightTrim
                zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "$triggerKey"
            else
                #zpwrLogDebug "NOT regular=>'$ZPWR_VARS[lastword_lbuffer]'"
                if (( ${+galiases[${ZPWR_VARS[lastword_lbuffer]}]} )); then

                    zpwrExpandRightTrim
                    # global alias expansion
                    #zpwrLogDebug "global=>'$ZPWR_VARS[lastword_lbuffer]'"
                    zpwrExpandGlobalAliases "$ZPWR_VARS[lastword_lbuffer]"
                    ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=true
                    ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
                elif [[ $ZPWR_EXPAND_SUFFIX == true ]]; then
                    zpwrExpandRightTrim
                    zpwrExpandSuffixAlias
                fi
            fi
        fi
    fi

    if [[ $ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND] != true ]]; then
        # expand file globs, history expansions, command expansion, parameter expansion and =command
        if [[ $ZPWR_EXPAND_NATIVE == true ]]; then
            if [[ $LBUFFER[-1] != ' ' ]]; then
                if [[ $triggerKey == "${ZPWR_VARS[ENTER_KEY]}" ]]; then
                    if [[ $ZPWR_EXPAND_PRE_EXEC_NATIVE == true ]]; then
                        zpwrExpandWordStopHistoryExpansion
                    fi
                else
                    zpwrExpandWordStopHistoryExpansion
                fi
                #zle expand-word
            fi
        fi
    fi

    #zpwrLogDebug "ZPWR_VARS[NEED_TO_ADD_SPACECHAR] = $ZPWR_VARS[NEED_TO_ADD_SPACECHAR]"
    #zpwrLogDebug "ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND] = $ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]"

    if [[ $triggerKey != "${ZPWR_VARS[ENTER_KEY]}" ]]; then
        if [[ $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] == true ]];then
            if [[ $ZPWR_VARS[WAS_EXPANDED] == false || $LBUFFER[-1] != ' ' ]]; then
                if [[ $ZPWR_VARS[AP_SPACE] == true ]]; then
                    zle autopair-insert
                else
                    zle self-insert
                fi
            fi
        fi
    fi
    if [[ $ZPWR_TRACE == true ]]; then
        set +x
    fi

    # track expansion stats — format: trigger:type:alias
    # trigger: S=space, H=history/enter
    # type: alias, global, suffix, escape, native
    if [[ $ZPWR_VARS[WAS_EXPANDED] == true && -n $ZPWR_VARS[ORIGINAL_LAST_COMMAND] ]]; then
        local _trigger=S
        [[ $triggerKey == "${ZPWR_VARS[ENTER_KEY]}" || -z $triggerKey ]] && _trigger=H
        local _type=${ZPWR_VARS[EXPAND_TYPE]:-alias}
        zpwrExpandStatsRecord "${_trigger}:${_type}:$ZPWR_VARS[ORIGINAL_LAST_COMMAND]"
    fi
    if [[ $ZPWR_VARS[foundIncorrect] == true ]]; then
        zpwrExpandStatsRecord "S:correction:"
    fi
}
#}}}***********************************************************

#{{{                    MARK:stats
#**************************************************************
function zpwrExpandStatsRecord() {
    local alias=$1
    local statsFile=${ZPWR_EXPAND_STATS_FILE:-${ZPWR_LOCAL:-${XDG_CACHE_HOME:-$HOME/.cache}}/zpwr-expand-stats.dat}

    # append alias name to stats file (one per expansion)
    print -r -- "$alias" >> "$statsFile"
}

function zpwrExpandStats() {
    'builtin' emulate -L zsh
    setopt extendedglob

    local statsFile=${ZPWR_EXPAND_STATS_FILE:-${ZPWR_LOCAL:-${XDG_CACHE_HOME:-$HOME/.cache}}/zpwr-expand-stats.dat}
    local -i topN=${ZPWR_EXPAND_STATS_TOP:-15}
    local -i boxWidth=70
    local doReset=false doColor=false

    # parse flags
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                cat <<'HELP'
 ███████╗██╗  ██╗██████╗  █████╗ ███╗   ██╗██████╗
 ██╔════╝╚██╗██╔╝██╔══██╗██╔══██╗████╗  ██║██╔══██╗
 █████╗   ╚███╔╝ ██████╔╝███████║██╔██╗ ██║██║  ██║
 ██╔══╝   ██╔██╗ ██╔═══╝ ██╔══██║██║╚██╗██║██║  ██║
 ███████╗██╔╝ ██╗██║     ██║  ██║██║ ╚████║██████╔╝
 ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝
 ┌──────────────────────────────────────────────────────┐
 │ STATUS: TRACKING  // SIGNAL: ████████░░ // STATS  │
 └──────────────────────────────────────────────────────┘
  >> EXPANSION STATS DASHBOARD // FULL SPECTRUM <<

  USAGE: zpwrExpandStats [OPTIONS]

  ── OPTIONS ────────────────────────────────────────────
  -h, --help                                     // Show this help
  -t, --top <N>                                  // Top N aliases (default: 15)
  -w, --width <N>                                // Box width (default: 70)
  -c, --color                                    // Force ANSI colors
  -r, --reset                                    // Clear all stats
  -f, --file <PATH>                              // Override stats file path

  ── CONFIG ─────────────────────────────────────────────
  ZPWR_EXPAND_STATS_FILE                         // Stats file location
  ZPWR_EXPAND_STATS_TOP                          // Default top N

  ── SYSTEM ─────────────────────────────────────────
  (c) MenkeTechnologies
  Your keystrokes are currency. Spend them wisely.
  >>> JACK IN. TRACK YOUR EXPANSIONS. OWN YOUR ALIASES. <<<
 ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
HELP
                return 0
                ;;
            -t|--top)   topN=$2; shift 2 ;;
            -w|--width) boxWidth=$2; shift 2 ;;
            -c|--color) doColor=true; shift ;;
            -r|--reset)
                doReset=true; shift ;;
            -f|--file)  statsFile=$2; shift 2 ;;
            --)         shift; break ;;
            *)          print "zpwrExpandStats: unknown option: $1" >&2; return 1 ;;
        esac
    done

    if [[ $doReset == true ]]; then
        if [[ -f $statsFile ]]; then
            command rm -f "$statsFile"
            print "Stats cleared: $statsFile"
        else
            print "No stats file to clear."
        fi
        return 0
    fi

    if [[ ! -f $statsFile ]]; then
        zpwrExpandBox -t "EXPANSION STATS" "No expansions recorded yet."
        return
    fi

    local -A counts
    local -i total=0 spaceTotal=0 histTotal=0 corrections=0 savedChars=0
    local -i aliasTotal=0 globalTotal=0 suffixTotal=0 escapeTotal=0 nativeTotal=0 _cnt=0
    local line alias expanded trigger etype

    # tally counts — format: "trigger:type:alias" or legacy "S:alias" / "__correction__"
    while IFS= read -r line; do
        if [[ $line == __correction__ || $line == S:correction: ]]; then
            (( corrections++ ))
        elif [[ $line == [SH]:*:* ]]; then
            # new format: trigger:type:alias
            trigger=${line%%:*}
            line=${line#?:}
            etype=${line%%:*}
            alias=${line#*:}
            _cnt=${counts[(e)$alias]:-0}
            counts[$alias]=$(( _cnt + 1 ))
            (( total++ ))
            if [[ $trigger == S ]]; then (( spaceTotal++ )); else (( histTotal++ )); fi
            case $etype in
                alias)   (( aliasTotal++ )) ;;
                global)  (( globalTotal++ )) ;;
                suffix)  (( suffixTotal++ )) ;;
                escape)  (( escapeTotal++ )) ;;
                native)  (( nativeTotal++ )) ;;
            esac
        elif [[ $line == [SH]:* ]]; then
            # old format: trigger:alias
            trigger=${line%%:*}
            alias=${line#?:}
            _cnt=${counts[(e)$alias]:-0}
            counts[$alias]=$(( _cnt + 1 ))
            (( total++ ))
            (( aliasTotal++ ))
            if [[ $trigger == S ]]; then (( spaceTotal++ )); else (( histTotal++ )); fi
        else
            # legacy format (no prefix)
            _cnt=${counts[(e)$line]:-0}
            counts[$line]=$(( _cnt + 1 ))
            (( total++ ))
            (( spaceTotal++ ))
            (( aliasTotal++ ))
        fi
    done < "$statsFile"

    # compute chars saved per alias
    local -i _cnt _alen _elen
    local _key
    for _key in "${(k)counts[@]}"; do
        expanded=${aliases[$_key]}
        _cnt=${counts[(e)$_key]}
        _alen=${#_key}
        if [[ -n $expanded ]]; then
            _elen=${#expanded}
            (( savedChars += (_elen - _alen) * _cnt ))
        fi
    done

    # sort by frequency, top 15
    local -a sorted=()
    local k
    for k in "${(k)counts[@]}"; do
        _cnt=${counts[(e)$k]}
        sorted+=("$_cnt $k")
    done
    sorted=(${(On)sorted})

    # build output lines
    local -a lines=()
    lines+=("── TRIGGER ──────────────────────")
    lines+=("  SPACE EXPANSIONS:   $spaceTotal")
    lines+=("  HISTORY EXPANSIONS: $histTotal")
    lines+=("")
    lines+=("── TYPE ─────────────────────────")
    lines+=("  ALIAS:              $aliasTotal")
    lines+=("  GLOBAL ALIAS:       $globalTotal")
    lines+=("  SUFFIX ALIAS:       $suffixTotal")
    lines+=("  SELF-REF ESCAPE:    $escapeTotal")
    lines+=("  NATIVE (glob/hist): $nativeTotal")
    lines+=("  CORRECTIONS:        $corrections")
    lines+=("")
    lines+=("── SUMMARY ──────────────────────")
    lines+=("  TOTAL EXPANSIONS:   $total")
    lines+=("  KEYSTROKES SAVED:   $savedChars")
    lines+=("")
    lines+=("── TOP ALIASES ──────────────────")

    local -i rank=0 maxExpand=0
    local entry cnt name bar barLen maxBar rankStr
    maxBar=20
    local -i topCount=0
    if (( $#sorted )); then
        topCount=${sorted[1]%% *}
    fi
    (( topCount == 0 )) && topCount=1

    for entry in "${sorted[@]}"; do
        (( rank++ ))
        (( rank > topN )) && break
        cnt=${entry%% *}
        name=${entry#* }

        # bar chart
        barLen=$(( cnt * maxBar / topCount ))
        (( barLen < 1 )) && barLen=1
        bar=${(l:barLen::█:)}${(l:maxBar-barLen::░:)}

        expanded=${aliases[$name]}
        printf -v rankStr '  %2d. %-12s %s %3d' $rank "$name" "$bar" $cnt
        if [[ -n $expanded ]]; then
            # collapse newlines/tabs/multi-spaces
            expanded=${expanded//$'\n'/ }
            expanded=${expanded//$'\t'/ }
            expanded=${expanded//  ##/ }
            # truncate to fit within box width (prefix + "  // " + expansion)
            maxExpand=$((boxWidth - ${#rankStr} - 6))
            (( maxExpand < 10 )) && maxExpand=10
            (( ${#expanded} > maxExpand )) && expanded="${expanded:0:$((maxExpand - 3))}..."
            lines+=("$rankStr  // $expanded")
        else
            lines+=("$rankStr")
        fi
    done

    lines+=("")
    lines+=(">>> YOUR ALIASES ARE WORKING FOR YOU <<<")

    local -a boxArgs=(-t "EXPANSION STATS" -w $boxWidth)
    [[ $doColor == true ]] && boxArgs+=(--color)
    zpwrExpandBox "${boxArgs[@]}" "${lines[@]}"
}
#}}}*********************************************************** 
