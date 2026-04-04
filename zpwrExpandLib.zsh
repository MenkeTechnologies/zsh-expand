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
    local title="" wrapW=0
    local -a rawLines=()

    # parse flags
    while [[ $1 == -* ]]; do
        case $1 in
            -t|--title) title=$2; shift 2 ;;
            -w|--width) wrapW=$2; shift 2 ;;
            --) shift; break ;;
            *)  shift ;;
        esac
    done

    # collect lines from args and/or stdin, expand tabs
    if (( $# )); then
        rawLines=("$@")
    fi
    # When stdin is not a TTY, only read if data is already available (read -t 0),
    # then drain the rest. Avoids blocking forever when fd 0 is open but never EOF
    # (e.g. some CI/sandbox runners) while still supporting real pipes.
    if [[ ! -t 0 ]]; then
        local stdinLine
        if read -r -t 0 stdinLine || [[ -n $stdinLine ]]; then
            rawLines+=("$stdinLine")
            while IFS= read -r stdinLine || [[ -n $stdinLine ]]; do
                rawLines+=("$stdinLine")
            done
        fi
    fi
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

    # find actual max content width (may be less than wrapW after wrapping)
    local -i w=0 len
    local line
    for line in "${lines[@]}"; do
        len=${#line}
        (( len > w )) && w=$len
    done
    (( titleW + 2 > w )) && w=$((titleW + 2))

    # build box
    local -i boxW=$((w + 4))
    local msg
    if [[ -n $title ]]; then
        local -i titlePad=$((boxW - titleW - 5))
        msg="╭─ $title ${(l:titlePad::─:)}╮"
    else
        msg="╭${(l:boxW-2::─:)}╮"
    fi
    for line in "${lines[@]}"; do
        len=${#line}
        msg+=$'\n'"│ $line${(l:w-len+1:: :)}│"
    done
    msg+=$'\n'"╰${(l:boxW-2::─:)}╯"
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

#{{{                    MARK:main fn
#**************************************************************
function zpwrExpandSupernaturalSpace() {

    'builtin' emulate -L zsh
    setopt rcquotes extended_glob zle

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
}
#}}}*********************************************************** 
