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
# dummy functions if plugin used outside of zpwr
if ! type -- "zpwrLogDebug" &>/dev/null;then
    function zpwrLogDebug(){
        :
    }
fi

if ! type -- "zpwrLogConsoleErr" &>/dev/null;then
    function zpwrLogConsoleErr(){
        print -r -- "$*" >&2
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

    local word key res1 misspelling

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

    misspelling=${ZPWR_VARS[lastword_remove_special]}
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

    local res1 _pre_expand

    if [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then
        res1=${match[1]}
        # expand
        regexp-replace res1 '(^|[ ])!([[:graph:]]+ )' '$match[1]\!$match[2]' &> /dev/null
        LBUFFER="$res1$ZPWR_VARS[lastword_lbuffer]"
        _pre_expand=$LBUFFER
        zle expand-word
        ZPWR_VARS[WAS_EXPANDED]=true
        if [[ $LBUFFER != $_pre_expand ]]; then
            # space-path: zle expand-word changed the buffer
            ZPWR_VARS[EXPAND_TYPE]=native
            ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
            ZPWR_VARS[NATIVE_SAVED]=$((${#LBUFFER} - ${#_pre_expand}))
        elif [[ $ZPWR_VARS[lastword_lbuffer] == *[\!\*\$\~]* ]]; then
            # history-path: zle expand-word is a no-op outside ZLE, but the lastword
            # contains history/glob/param chars that zsh will expand at execution
            ZPWR_VARS[EXPAND_TYPE]=native
            ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
            ZPWR_VARS[NATIVE_SAVED]=0
            ZPWR_VARS[WAS_EXPANDED]=true
        fi
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
    result=$galiases[(e)$ZPWR_VARS[lastword_lbuffer]]
    if [[ -n $result ]] && [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then

        res1=${match[1]}
        # expand
        LBUFFER="$res1$result"
        ZPWR_VARS[WAS_EXPANDED]=true
        ZPWR_VARS[EXPAND_TYPE]=global

        # stats: record if called directly as ZLE widget (not via supernatural space)
        if [[ -z "$1" ]]; then
            zpwrExpandStatsRecord S global "$ZPWR_VARS[lastword_lbuffer]"
        fi

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
    local stdinLine
    local -i titlePad=0

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
        titlePad=$((boxW - titleW - 6))
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
    local lastword prefix tail matched cmdWord msg expandsTo expandType
    local -a tailWords lines

    # save state
    savedPartition=("${ZPWR_EXPAND_WORDS_LPARTITION[@]}")
    savedMatch=$ZPWR_VARS[cachedRegexMatch]
    savedMatched=$ZPWR_VARS[cachedRegexMatched]
    savedPrefix=$ZPWR_VARS[cachedParserPrefix]

    zpwrExpandParseWords "$LBUFFER"

    lastword=$ZPWR_VARS[lastword_lbuffer]
    prefix=$ZPWR_VARS[cachedParserPrefix]
    tail=$ZPWR_VARS[cachedRegexMatch]
    matched=$ZPWR_VARS[cachedRegexMatched]
    tailWords=( ${(z)tail} )
    cmdWord=${tailWords[1]}
    msg=""
    expandsTo="" expandType=""

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
    lines=()
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

    if (( ${+aliases[(e)$lastword]} )); then
        REPLY=${aliases[(e)$lastword]}
    elif (( ${+galiases[(e)$lastword]} )); then
        REPLY=${galiases[(e)$lastword]}
    elif [[ -n ${lastword:e} ]] && (( ${+saliases[(e)${lastword:e}]} )); then
        REPLY="$saliases[(e)${lastword:e}] $lastword"
    elif [[ -n ${ZPWR_EXPAND_CORRECT_REVERSE[(e)$lastword]} ]]; then
        REPLY=${ZPWR_EXPAND_CORRECT_REVERSE[(e)$lastword]}
    fi

    [[ -n $REPLY ]] && return 0
    return 1
}

function zpwrExpandPreview() {
    # called on zle-line-pre-redraw — show expansion preview below prompt via zle -M
    local lastword expanded

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
    lastword=${LBUFFER##*[[:space:]]}

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
    local _saved _lw _lwbuf _expansion _trigger _type
    local -a _histWords=()
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
    ZPWR_VARS[ORIGINAL_LAST_COMMAND]=""
    ZPWR_VARS[NATIVE_SAVED]=""

    zpwrExpandParseWords "$LBUFFER"

    if [[ $KEYS == " " || $triggerKey == "${ZPWR_VARS[SPACEBAR_KEY]}" ]]; then
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

    _lwbuf=$ZPWR_VARS[lastword_lbuffer]

    #dont expand =word because that is zle expand-word
    if [[ ${_lwbuf:0:1} != '=' ]] && (( $#_lwbuf > 0 ));then
        if [[ -z $ZPWR_VARS[blacklistUser] ]] || ! [[ $_lwbuf =~ $ZPWR_VARS[blacklistUser] ]]; then
            if (( ${+aliases[(e)$_lwbuf]} )) && ! [[ ${aliases[(e)$_lwbuf]} =~ $ZPWR_VARS[blacklistFirstPosRegex] ]];then

                #zpwrLogDebug "regular=>'$_lwbuf'"
                zpwrExpandRightTrim
                zpwrExpandLastWordAtCommandPosAndExpand moveCursor zle "$triggerKey"
            else
                #zpwrLogDebug "NOT regular=>'$_lwbuf'"
                if (( ${+galiases[(e)$_lwbuf]} )); then

                    zpwrExpandRightTrim
                    # global alias expansion
                    #zpwrLogDebug "global=>'$_lwbuf'"
                    zpwrExpandGlobalAliases "$_lwbuf"
                    ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=true
                    ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$_lwbuf
                elif [[ $ZPWR_EXPAND_SUFFIX == true ]]; then
                    zpwrExpandRightTrim
                    zpwrExpandSuffixAlias
                    if [[ $ZPWR_VARS[WAS_EXPANDED] == true ]]; then
                        ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=true
                        ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$_lwbuf
                    fi
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
            fi
        fi
        # stats-only: track native expansions on ENTER even when expansion is gated off.
        # zsh itself will expand !history, globs, $params, ~user at execution time.
        if [[ $triggerKey == "${ZPWR_VARS[ENTER_KEY]}" && $ZPWR_VARS[WAS_EXPANDED] != true ]]; then
            if [[ $_lwbuf == *[\!\*\$\~]* ]]; then
                ZPWR_VARS[EXPAND_TYPE]=native
                ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$_lwbuf
                ZPWR_VARS[WAS_EXPANDED]=true
                # estimate saved chars for history refs using the history entry
                _saved=0
                _lw=$_lwbuf
                _expansion=""
                _histWords=()
                case $_lw in
                    # !! — full previous command
                    !!) _expansion=${history[1]} ;;
                    # !$ — last word of previous command
                    \!\$)
                        _histWords=( ${(z)history[1]} )
                        _expansion=${_histWords[-1]}
                        ;;
                    # !^ — first argument (word 2) of previous command
                    \!\^)
                        _histWords=( ${(z)history[1]} )
                        _expansion=${_histWords[2]}
                        ;;
                    # !* — all arguments of previous command
                    \!\*)
                        _histWords=( ${(z)history[1]} )
                        _expansion="${_histWords[2,-1]}"
                        ;;
                    # !:n — nth word of previous command (0-indexed)
                    \!:<->)
                        _histWords=( ${(z)history[1]} )
                        _expansion=${_histWords[$(( ${_lw#\!:} + 1 ))]}
                        ;;
                    # !n — history entry n (1-based)
                    \!<->)
                        _expansion=${history[${_lw#\!}]}
                        ;;
                    # !-n — n commands back
                    \!-<->)
                        _expansion=${history[${_lw#\!-}]}
                        ;;
                    # !string — most recent command starting with string
                    \!?*)
                        # approximate: use previous command
                        _expansion=${history[1]}
                        ;;
                    # ^old^new^ — quick substitution (approximate)
                    \^*\^*)
                        _expansion=${history[1]}
                        ;;
                    *) _expansion="" ;;
                esac
                if [[ -n $_expansion ]]; then
                    _saved=$(( ${#_expansion} - ${#_lw} ))
                    (( _saved < 0 )) && _saved=0
                fi
                ZPWR_VARS[NATIVE_SAVED]=$_saved
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

    # track expansion stats — format: NUL-delimited fields trigger\0type\0byteLen\0payload[\0saved] (see zpwrExpandStatsRecord)
    # trigger: S=space, H=history/enter
    # type: alias, global, suffix, escape, native
    if [[ $ZPWR_VARS[WAS_EXPANDED] == true && -n $ZPWR_VARS[ORIGINAL_LAST_COMMAND] ]]; then
        _trigger=S
        # explicit triggerKey from caller takes precedence (history hook passes ENTER)
        # otherwise use $KEYS from ZLE widget context (may be stale outside ZLE)
        if [[ $triggerKey == "${ZPWR_VARS[ENTER_KEY]}" ]]; then
            _trigger=H
        elif [[ $triggerKey == "${ZPWR_VARS[SPACEBAR_KEY]}" ]]; then
            _trigger=S
        elif [[ -n $triggerKey ]]; then
            _trigger=H
        elif [[ $KEYS == " " ]]; then
            _trigger=S
        else
            _trigger=H
        fi
        _type=${ZPWR_VARS[EXPAND_TYPE]:-alias}
        # native types append saved-char count (can't look up expansion later)
        if [[ $_type == native ]]; then
            zpwrExpandStatsRecord "$_trigger" "$_type" "$ZPWR_VARS[ORIGINAL_LAST_COMMAND]" "${ZPWR_VARS[NATIVE_SAVED]:-0}"
        else
            zpwrExpandStatsRecord "$_trigger" "$_type" "$ZPWR_VARS[ORIGINAL_LAST_COMMAND]"
        fi
    fi
    if [[ $ZPWR_VARS[foundIncorrect] == true ]]; then
        zpwrExpandStatsRecord S correction ''
    fi
}
#}}}***********************************************************

# CI and minimal HOME trees often lack ~/.cache; ensure stats dir exists once at source time.
(){
    local _d=${ZPWR_EXPAND_STATS_FILE:-${ZPWR_LOCAL:-${XDG_CACHE_HOME:-$HOME/.cache}}/zpwr-expand-stats.dat}
    [[ -d ${_d:h} ]] || command mkdir -p "${_d:h}"
}

#{{{                    MARK:stats
#**************************************************************
function zpwrExpandStatsRecord() {
    # One arg: raw line (legacy tests / colon layout).
    # Three args: trigger type payload — writes NUL-delimited trigger\0type\0len\0payload (len is ${#payload}; payload may contain ':').
    # Four args: trigger type payload saved — native only; appends \0saved after payload.
    local statsFile=${ZPWR_EXPAND_STATS_FILE:-${ZPWR_LOCAL:-${XDG_CACHE_HOME:-$HOME/.cache}}/zpwr-expand-stats.dat}
    local len

    if (( $# == 3 )); then
        len=${#3}
        print -r -- "$1"$'\0'"$2"$'\0'"$len"$'\0'"$3" >> "$statsFile"
    elif (( $# == 4 )); then
        len=${#3}
        print -r -- "$1"$'\0'"$2"$'\0'"$len"$'\0'"$3"$'\0'"$4" >> "$statsFile"
    elif (( $# == 1 )); then
        print -r -- "$1" >> "$statsFile"
    else
        print 'zpwrExpandStatsRecord: expected 1, 3, or 4 arguments' >&2
        return 1
    fi
}

function zpwrExpandStats() {
    'builtin' emulate -L zsh
    setopt extendedglob

    local statsFile=${ZPWR_EXPAND_STATS_FILE:-${ZPWR_LOCAL:-${XDG_CACHE_HOME:-$HOME/.cache}}/zpwr-expand-stats.dat}
    local -i topN=${ZPWR_EXPAND_STATS_TOP:-20}
    local -i boxWidth=70
    local doReset=false doColor=false
    local _r _c _m _g _y _d _w

    # parse flags
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                _r=$'\e[0m'
                _c=$'\e[38;5;51m'    # cyan neon
                _m=$'\e[1m\e[38;5;207m' # bold magenta
                _g=$'\e[38;5;48m'    # green neon
                _y=$'\e[38;5;226m'   # yellow
                _d=$'\e[38;5;236m'   # dark gray
                _w=$'\e[1m\e[38;5;255m' # bold white
                print -r -- "${_c} ███████╗███████╗██╗  ██╗      ███████╗██╗  ██╗██████╗  █████╗ ███╗   ██╗██████╗${_r}
${_c} ╚══███╔╝██╔════╝██║  ██║      ██╔════╝╚██╗██╔╝██╔══██╗██╔══██╗████╗  ██║██╔══██╗${_r}
${_c}   ███╔╝ ███████╗███████║█████╗█████╗   ╚███╔╝ ██████╔╝███████║██╔██╗ ██║██║  ██║${_r}
${_c}  ███╔╝  ╚════██║██╔══██║╚════╝██╔══╝   ██╔██╗ ██╔═══╝ ██╔══██║██║╚██╗██║██║  ██║${_r}
${_c} ███████╗███████║██║  ██║      ███████╗██╔╝ ██╗██║     ██║  ██║██║ ╚████║██████╔╝${_r}
${_c} ╚══════╝╚══════╝╚═╝  ╚═╝      ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝${_r}
${_g} ┌───────────────────────────────────────────────────────────────────────────────┐${_r}
${_g} │${_r} ${_w}STATUS:${_r} ${_g}TRACKING${_r}  ${_d}//${_r} ${_w}SIGNAL:${_r} ${_g}████████${_d}░░${_r}  ${_d}//${_r} ${_m}EXPANSION STATS DASHBOARD${_r}         ${_g}│${_r}
${_g} └───────────────────────────────────────────────────────────────────────────────┘${_r}
  ${_m}>>${_r} ${_w}YOUR ALIASES ARE WORKING FOR YOU${_r} ${_d}//${_r} ${_y}FULL SPECTRUM${_r} ${_m}<<${_r}

  ${_w}USAGE:${_r} ${_g}zpwrExpandStats${_r} ${_d}[OPTIONS]${_r}

  ${_c}── OPTIONS ────────────────────────────────────────────${_r}
  ${_g}-h${_r}, ${_g}--help${_r}                                     ${_d}//${_r} Show this help
  ${_g}-t${_r}, ${_g}--top${_r} ${_y}<N>${_r}                                  ${_d}//${_r} Top N aliases (default: 20)
  ${_g}-w${_r}, ${_g}--width${_r} ${_y}<N>${_r}                                ${_d}//${_r} Box width (default: 70)
  ${_g}-c${_r}, ${_g}--color${_r}                                    ${_d}//${_r} Force ANSI colors
  ${_g}-r${_r}, ${_g}--reset${_r}                                    ${_d}//${_r} Clear all stats
  ${_g}-f${_r}, ${_g}--file${_r} ${_y}<PATH>${_r}                              ${_d}//${_r} Override stats file path

  ${_c}── CONFIG ─────────────────────────────────────────────${_r}
  ${_g}ZPWR_EXPAND_STATS_FILE${_r}                         ${_d}//${_r} Stats file location
  ${_g}ZPWR_EXPAND_STATS_TOP${_r}                          ${_d}//${_r} Default top N

  ${_c}── SYSTEM ─────────────────────────────────────────${_r}
  ${_d}(c) MenkeTechnologies${_r}
  ${_w}Your keystrokes are currency. Spend them wisely.${_r}
  ${_m}>>>${_r} ${_y}JACK IN. TRACK YOUR EXPANSIONS. OWN YOUR ALIASES.${_r} ${_m}<<<${_r}
${_d} ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░${_r}"
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

    local -A counts nativeSaved
    local -i total=0 spaceTotal=0 histTotal=0 corrections=0 savedChars=0
    local -i aliasTotal=0 globalTotal=0 suffixTotal=0 escapeTotal=0 nativeTotal=0 _cnt=0
    local line alias expanded trigger etype rest savedField plen tail lp_ok
    local -a fields
    local nf

    # bump one stats row (trigger, expansion type, alias key for counts)
    _zpwrExpandStatsBumpRow() {
        local trig=$1 etyp=$2 al=$3
        _cnt=${counts[(e)$al]:-0}
        counts[$al]=$(( _cnt + 1 ))
        (( total++ ))
        if [[ $trig == S ]]; then (( spaceTotal++ )); else (( histTotal++ )); fi
        case $etyp in
            alias)   (( aliasTotal++ )) ;;
            global)  (( globalTotal++ )) ;;
            suffix)  (( suffixTotal++ )) ;;
            escape)  (( escapeTotal++ )) ;;
            native)  (( nativeTotal++ )) ;;
        esac
    }

    # tally counts — NUL-delimited: trigger\0type\0byteLen\0payload[\0saved]; legacy colon length-prefixed;
    # legacy: trigger:type:rest (colon-delimited, ambiguous for native); "S:alias" two-part; bare alias
    while IFS= read -r line; do
        if [[ $line == *$'\0'* ]]; then
            fields=(${(0)line})
            nf=$#fields
            if (( nf >= 2 )) && [[ $fields[2] == correction ]]; then
                (( corrections++ ))
                continue
            fi
            trigger=$fields[1]
            etype=$fields[2]
            if (( nf == 5 )); then
                plen=$fields[3]
                alias=$fields[4]
                savedField=$fields[5]
                if [[ $plen =~ '^[0-9]+$' ]] && (( ${#alias} == plen )); then
                    if [[ $etype == native && $savedField =~ '^[0-9]+$' ]]; then
                        nativeSaved[$alias]=$(( ${nativeSaved[(e)$alias]:-0} + savedField ))
                    fi
                    _zpwrExpandStatsBumpRow "$trigger" "$etype" "$alias"
                fi
                continue
            fi
            if (( nf == 4 )); then
                plen=$fields[3]
                alias=$fields[4]
                if [[ ! $plen =~ '^[0-9]+$' ]] || (( ${#alias} != plen )); then
                    continue
                fi
                _zpwrExpandStatsBumpRow "$trigger" "$etype" "$alias"
                continue
            fi
            if (( nf == 3 )); then
                plen=$fields[3]
                if [[ ! $plen =~ '^[0-9]+$' ]] || (( plen != 0 )); then
                    continue
                fi
                alias=""
                _zpwrExpandStatsBumpRow "$trigger" "$etype" "$alias"
                continue
            fi
            continue
        fi
        if [[ $line == __correction__ || $line == S:correction: ]]; then
            (( corrections++ ))
        elif [[ $line =~ '^([SH]):([^:]+):([0-9]+):(.*)$' ]]; then
            trigger=$match[1]
            etype=$match[2]
            plen=$match[3]
            rest=$match[4]
            lp_ok=false
            if (( ${#rest} >= plen )); then
                alias=${rest:0:$plen}
                tail=${rest:$plen}
                if [[ $etype == native ]]; then
                    if [[ $tail =~ '^:[0-9]+$' ]]; then
                        savedField=${tail#:}
                        nativeSaved[$alias]=$(( ${nativeSaved[(e)$alias]:-0} + savedField ))
                        lp_ok=true
                    fi
                elif [[ -z $tail ]] && (( ${#rest} == plen )); then
                    lp_ok=true
                fi
            fi
            if [[ $lp_ok == true ]]; then
                _zpwrExpandStatsBumpRow "$trigger" "$etype" "$alias"
            elif [[ $line == [SH]:*:* ]]; then
                trigger=${line%%:*}
                rest=${line#?:}
                etype=${rest%%:*}
                rest=${rest#*:}
                if [[ $etype == native && $rest == *:* ]]; then
                    alias=${rest%:*}
                    savedField=${rest##*:}
                    nativeSaved[$alias]=$(( ${nativeSaved[(e)$alias]:-0} + savedField ))
                else
                    alias=$rest
                fi
                _zpwrExpandStatsBumpRow "$trigger" "$etype" "$alias"
            fi
        elif [[ $line == [SH]:*:* ]]; then
            trigger=${line%%:*}
            rest=${line#?:}
            etype=${rest%%:*}
            rest=${rest#*:}
            if [[ $etype == native && $rest == *:* ]]; then
                alias=${rest%:*}
                savedField=${rest##*:}
                nativeSaved[$alias]=$(( ${nativeSaved[(e)$alias]:-0} + savedField ))
            else
                alias=$rest
            fi
            _zpwrExpandStatsBumpRow "$trigger" "$etype" "$alias"
        elif [[ $line == [SH]:* ]]; then
            trigger=${line%%:*}
            alias=${line#?:}
            _cnt=${counts[(e)$alias]:-0}
            counts[$alias]=$(( _cnt + 1 ))
            (( total++ ))
            (( aliasTotal++ ))
            if [[ $trigger == S ]]; then (( spaceTotal++ )); else (( histTotal++ )); fi
        else
            _cnt=${counts[(e)$line]:-0}
            counts[$line]=$(( _cnt + 1 ))
            (( total++ ))
            (( spaceTotal++ ))
            (( aliasTotal++ ))
        fi
    done < "$statsFile"

    # compute chars saved per alias (regular, global, and suffix)
    local -i _alen _elen _nsaved
    local _key
    for _key in "${(k)counts[@]}"; do
        expanded=${aliases[(e)$_key]}
        [[ -z $expanded ]] && expanded=${galiases[(e)$_key]}
        # suffix alias: key is a filename like foo.txt, look up by extension
        if [[ -z $expanded && -n ${_key:e} ]]; then
            expanded=${saliases[(e)${_key:e}]}
            [[ -n $expanded ]] && expanded="$expanded $_key"
        fi
        _cnt=${counts[(e)$_key]}
        _alen=${#_key}
        if [[ -n $expanded ]]; then
            _elen=${#expanded}
            (( savedChars += (_elen - _alen) * _cnt ))
        fi
        # add native saved chars (stored at record time for !! and globs)
        _nsaved=${nativeSaved[(e)$_key]:-0}
        (( savedChars += _nsaved ))
    done

    # sort by frequency, top 15
    local -a sorted=()
    local k
    for k in "${(k)counts[@]}"; do
        _cnt=${counts[(e)$k]}
        sorted+=("$_cnt $k")
    done
    sorted=(${(On)sorted})

    # color codes (same names as help banner)
    _r=$'\e[0m'
    _c=$'\e[38;5;51m'       # cyan neon
    _m=$'\e[1m\e[38;5;207m' # bold magenta
    _g=$'\e[38;5;48m'       # green neon
    _y=$'\e[38;5;226m'      # yellow
    _d=$'\e[38;5;236m'      # dark gray
    _w=$'\e[1m\e[38;5;255m' # bold white

    # banner
    print -r -- "${_c} ███████╗███████╗██╗  ██╗      ███████╗██╗  ██╗██████╗  █████╗ ███╗   ██╗██████╗${_r}
${_c} ╚══███╔╝██╔════╝██║  ██║      ██╔════╝╚██╗██╔╝██╔══██╗██╔══██╗████╗  ██║██╔══██╗${_r}
${_c}   ███╔╝ ███████╗███████║█████╗█████╗   ╚███╔╝ ██████╔╝███████║██╔██╗ ██║██║  ██║${_r}
${_c}  ███╔╝  ╚════██║██╔══██║╚════╝██╔══╝   ██╔██╗ ██╔═══╝ ██╔══██║██║╚██╗██║██║  ██║${_r}
${_c} ███████╗███████║██║  ██║      ███████╗██╔╝ ██╗██║     ██║  ██║██║ ╚████║██████╔╝${_r}
${_c} ╚══════╝╚══════╝╚═╝  ╚═╝      ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝${_r}"

    # build plain lines (for width calc) and colored lines (for display)
    local -a plain=() color=()

    plain+=("── TRIGGER ──────────────────────────────────────────────")
    color+=("${_c}── TRIGGER ──────────────────────────────────────────────${_r}")
    plain+=("  SPACE EXPANSIONS:   $spaceTotal")
    color+=("  ${_w}SPACE EXPANSIONS:${_r}   ${_g}$spaceTotal${_r}")
    plain+=("  HISTORY EXPANSIONS: $histTotal")
    color+=("  ${_w}HISTORY EXPANSIONS:${_r} ${_g}$histTotal${_r}")
    plain+=("")
    color+=("")
    plain+=("── TYPE ─────────────────────────────────────────────────")
    color+=("${_c}── TYPE ─────────────────────────────────────────────────${_r}")
    plain+=("  ALIAS:              $aliasTotal")
    color+=("  ${_w}ALIAS:${_r}              ${_g}$aliasTotal${_r}")
    plain+=("  GLOBAL ALIAS:       $globalTotal")
    color+=("  ${_w}GLOBAL ALIAS:${_r}       ${_g}$globalTotal${_r}")
    plain+=("  SUFFIX ALIAS:       $suffixTotal")
    color+=("  ${_w}SUFFIX ALIAS:${_r}       ${_g}$suffixTotal${_r}")
    plain+=("  SELF-REF ESCAPE:    $escapeTotal")
    color+=("  ${_w}SELF-REF ESCAPE:${_r}    ${_g}$escapeTotal${_r}")
    plain+=("  NATIVE (glob/hist): $nativeTotal")
    color+=("  ${_w}NATIVE (glob/hist):${_r} ${_g}$nativeTotal${_r}")
    plain+=("  CORRECTIONS:        $corrections")
    color+=("  ${_w}CORRECTIONS:${_r}        ${_g}$corrections${_r}")
    plain+=("")
    color+=("")
    plain+=("── SUMMARY ──────────────────────────────────────────────")
    color+=("${_c}── SUMMARY ──────────────────────────────────────────────${_r}")
    plain+=("  TOTAL EXPANSIONS:   $total")
    color+=("  ${_w}TOTAL EXPANSIONS:${_r}   ${_y}$total${_r}")
    plain+=("  KEYSTROKES SAVED:   $savedChars")
    color+=("  ${_w}KEYSTROKES SAVED:${_r}   ${_y}$savedChars${_r}")
    plain+=("")
    color+=("")
    plain+=("── TOP ALIASES ──────────────────────────────────────────")
    color+=("${_c}── TOP ALIASES ──────────────────────────────────────────${_r}")

    local -i rank=0 maxExpand=0
    local entry cnt name bar barLen maxBar rankStr plainLine
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

        expanded=${aliases[(e)$name]}
        [[ -z $expanded ]] && expanded=${galiases[(e)$name]}
        if [[ -z $expanded && -n ${name:e} ]]; then
            expanded=${saliases[(e)${name:e}]}
            [[ -n $expanded ]] && expanded="$expanded $name"
        fi
        printf -v rankStr '  %2d. %-12s %s %3d' $rank "$name" "$bar" $cnt
        if [[ -n $expanded ]]; then
            expanded=${expanded//$'\n'/ }
            expanded=${expanded//$'\t'/ }
            expanded=${expanded//  ##/ }
            maxExpand=$((boxWidth - ${#rankStr} - 6))
            (( maxExpand < 10 )) && maxExpand=10
            (( ${#expanded} > maxExpand )) && expanded="${expanded:0:$((maxExpand - 3))}..."
            plain+=("$rankStr  // $expanded")
            color+=("  ${_g}$(printf '%2d' $rank).${_r} ${_g}$name${_r}$(printf '%*s' $((12 - ${#name})) '') ${_g}$bar${_r} $(printf '%3d' $cnt)  ${_d}//${_r} ${_w}$expanded${_r}")
        else
            plain+=("$rankStr")
            color+=("  ${_g}$(printf '%2d' $rank).${_r} ${_g}$name${_r}$(printf '%*s' $((12 - ${#name})) '') ${_g}$bar${_r} $(printf '%3d' $cnt)")
        fi
    done

    plain+=("")
    color+=("")
    plain+=(">>> YOUR ALIASES ARE WORKING FOR YOU <<<")
    color+=("${_m}>>>${_r} ${_y}YOUR ALIASES ARE WORKING FOR YOU${_r} ${_m}<<<${_r}")

    # compute box width from plain lines
    local -i bW=0 len pad
    for line in "${plain[@]}"; do
        len=${#line}
        (( len > bW )) && bW=$len
    done
    (( boxWidth > bW )) && bW=$boxWidth
    local -i fullW=$((bW + 4))

    # build box
    local hbar=${(l:fullW-2::─:)}
    local -i titleW=15  # "EXPANSION STATS"
    local -i titlePad=$((fullW - titleW - 6))
    local msg="${_c}┌── ${_m}EXPANSION STATS${_c} ${(l:titlePad::─:)}┐${_r}"
    local -i i
    for (( i = 1; i <= $#color; i++ )); do
        len=${#plain[$i]}
        pad=$((bW - len))
        msg+=$'\n'"${_c}│${_r} ${color[$i]}${(l:pad+1:: :)}${_c}│${_r}"
    done
    msg+=$'\n'"${_c}└${hbar}┘${_r}"
    msg+=$'\n'"${_d}${(l:fullW::░:)}${_r}"
    print -r -- "$msg"
    unfunction _zpwrExpandStatsBumpRow 2>/dev/null
}
#}}}*********************************************************** 
