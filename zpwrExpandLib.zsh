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
        ZPWR_VARS[indexTS$num]=$lenToFirstTS

        CURSOR=$lenToFirstTS
        RBUFFER=${RBUFFER:$#ZPWR_TABSTOP}
        ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=false
    else
        ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    fi
}

function zpwrExpandCorrectWord(){

    local word nextWord badWords misspelling key res1

    if (( ${+galiases[${ZPWR_VARS[lastword_lbuffer]}]} )); then
        return
    fi

    if (( $#ZPWR_EXPAND_WORDS_PARTITION == 1)); then
        if type -a $ZPWR_VARS[firstword_partition] &>/dev/null; then
            #zpwrLogDebug "No correction from 1 word => '"'$ZPWR_VARS[firstword_partition]'"'_____ = ""'$ZPWR_VARS[firstword_partition]'"
            # git<space>
            return
        fi
    else

        if zpwrExpandRegexMatchOnCommandPosition correct; then

            #zpwrLogDebug "${match[@]}"
            #zpwrLogDebug "${ZPWR_EXPAND_PRE_CORRECT[@]}"

            word=${ZPWR_EXPAND_PRE_CORRECT[1]}
            if (( $#ZPWR_EXPAND_PRE_CORRECT == 1)); then
                if type -a $word &>/dev/null; then
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
    fi

    #zpwrLogDebug "______'"'attempt correction'"'_____ = ""'$ZPWR_VARS[lastword_remove_special]'"

    if [[ $ZPWR_TRACE == true ]]; then
        set +x
    fi
    for key in ${(k)ZPWR_EXPAND_CORRECT_WORDS[@]}; do

        badWords=( "${(z)ZPWR_EXPAND_CORRECT_WORDS[$key]}" )
        for misspelling in $badWords[@];do

            if [[ ${ZPWR_VARS[lastword_remove_special]} == $misspelling ]]; then

                # expand only when cursor is right of misspelled word
                if [[ $LBUFFER == (#b)(*[[:space:]]#)($misspelling) ]]; then
                    res1=${match[1]}
                    # expand
                    LBUFFER="$res1${key:gs/_/ /}"
                    ZPWR_VARS[foundIncorrect]=true
                    # ZPWR_VARS[finished]=true
                fi

                # expand only when cursor is right of misspelled word
                if [[ $ZPWR_EXPAND_PRE_CORRECT == (#b)(*[[:space:]]#)($misspelling) ]]; then
                    res1=${match[1]}
                    ZPWR_EXPAND_POST_CORRECT=( "${(z):-$res1${key:gs/_/ /}}" )
                    ZPWR_VARS[foundIncorrect]=true
                    # ZPWR_VARS[finished]=true
                fi

                # break to outer for loop
                break 2
            fi
        done
        if [[ $ZPWR_VARS[finished] == true ]];then
            zle self-insert
            return 0
        fi
    done
    if [[ $ZPWR_TRACE == true ]]; then
        set -x
    fi
}

function zpwrExpandGetAliasValue(){

    ZPWR_VARS[EXPANDED]="${$(alias -r $ZPWR_VARS[lastword_lbuffer])#*=}"
    # deal with ansi quotes $'
    [[ $ZPWR_VARS[EXPANDED][1] == \$ ]] && ZPWR_VARS[EXPANDED]=${ZPWR_VARS[EXPANDED]:1}
    ZPWR_VARS[EXPANDED]=${(Q)ZPWR_VARS[EXPANDED]}
}

function zpwrExpandAliasEscape(){

    local res1 result

    if [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then
        res1=${match[1]}
        # expand
        LBUFFER="$res1\\$ZPWR_VARS[EXPANDED]"
        ZPWR_VARS[WAS_EXPANDED]=true
    fi


}

function zpwrExpandWordStopHistoryExpansion(){
    #escapes all previous history !pwd etc before last word because zle expand-word always expands them

    local res1 result

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

    local res1 result

    if [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then
        res1=${match[1]}
        # expand
        LBUFFER="$res1$ZPWR_VARS[EXPANDED]"
        ZPWR_VARS[WAS_EXPANDED]=true
    fi

}

function zpwrExpandGlobalAliases() {

    local res1 result

    ZPWR_VARS[lastword_lbuffer]="$1"
    result=$galiases[$ZPWR_VARS[lastword_lbuffer]]
    if [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]; then

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

zpwrExpandTerminateSpace(){

    LBUFFER+=" "
}

function zpwrExpandNonFileExpansion(){
    :
    #DNS lookups
    #type -a "$lastWord" &> /dev/null || {
    #print -r -- $lastWord | command grep -qE \
    #'^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}\.?$'\
    #&& {
    ##DNS lookup
    #A_Record=$(host $lastWord) 2>/dev/null \
    #&& {
    #A_Record=$(print -r -- $A_Record | command grep ' address' | head -1 | awk '{print $4}')
    #} || A_Record=bad
    #[[ $A_Record != bad ]] && \
    #LBUFFER="$(print -r -- "$LBUFFER" | sed -E "s@\\b$lastWord@$A_Record@g")"
    #} || {
    #print -r -- $lastWord | command grep -qE \
    #'\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' && {
    ##reverse DNS lookup
    #PTR_Record=$(nslookup $lastWord) 2>/dev/null && {
    #PTR_Record=$(print -r -- $PTR_Record | command grep 'name = ' | tail -1 | awk '{print $4}')
    #} || PTR_Record=bad
    #[[ $PTR_Record != bad ]] && \
    #LBUFFER="$(print -r -- "$LBUFFER" | sed -E "s@\\b$lastWord\\b@${PTR_Record:0:-1}@g")"
    #}
    #}
    #}
}

function zpwrExpandRegexMatchOnCommandPosition() {

    if [[ "$ZPWR_EXPAND_WORDS_LPARTITION" =~ "$ZPWR_VARS[continueFirstPositionRegexNoZpwr]" ]];then
        if [[ $1 == "correct" ]]; then
            ZPWR_EXPAND_PRE_CORRECT=("${(z)match[-1]}")
        else
            ZPWR_EXPAND_PRE_EXPAND=("${(z)match[-1]}")
        fi
        return 0
    fi
    return 1
}

#}}}***********************************************************

#{{{                    MARK:main fn
#**************************************************************
function zpwrExpandSupernaturalSpace() {

    'builtin' emulate -L zsh
    setopt rcquotes extended_glob zle

    local tempBuffer mywords badWords word nextWord i shouldStopExpansionDueToFailedRegex words ary res1  aliasOut

    if [[ $ZPWR_TRACE == true ]]; then
        set -x
    fi

    local triggerKey="$1"
    # globals
    ZPWR_EXPAND_WORDS_LPARTITION=()
    ZPWR_EXPAND_WORDS_PARTITION=()
    ZPWR_EXPAND_PRE_CORRECT=()
    ZPWR_EXPAND_POST_CORRECT=()
    ZPWR_EXPAND_PRE_EXPAND=()
    ZPWR_VARS[foundIncorrect]=false
    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=false
    ZPWR_VARS[finished]=false
    ZPWR_VARS[WAS_EXPANDED]=false

    zpwrExpandParseWords "$LBUFFER"

    if [[ $triggerKey == "${ZPWR_VARS[SPACE_KEY]}" ]]; then
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
                fi
            fi
            if [[ ! -f "$ZPWR_VARS[lastword_lbuffer]" ]]; then
                zpwrExpandNonFileExpansion
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
            if [[ $ZPWR_VARS[WAS_EXPANDED] == false ]]; then
                # no expansion occurred
                if [[ $ZPWR_VARS[AP_SPACE] == true ]]; then
                    zle autopair-insert
                else
                    zle self-insert
                fi
            else
                # expansion occurred
                if [[ $LBUFFER[-1] != ' ' ]]; then
                    # stop duplicate space
                    if [[ $ZPWR_VARS[AP_SPACE] == true ]]; then
                        zle autopair-insert
                    else
                        zle self-insert
                    fi
                fi
            fi
        fi
    fi
    if [[ $ZPWR_TRACE == true ]]; then
        set +x
    fi
}
#}}}*********************************************************** 
