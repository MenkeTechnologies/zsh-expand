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
if ! type -- "loggDebug" &>/dev/null;then
    function loggDebug(){
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
        loggDebug "this is a tabstop"
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

    if (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]} == 1)); then
        if type -a $ZPWR_VARS[firstword_partition] &>/dev/null; then
            loggDebug "No correction from 1 word => '"'$ZPWR_VARS[firstword_partition]'"'_____ = ""'$ZPWR_VARS[firstword_partition]'"
            return
        fi
    else
        if [[ "$ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]" =~ "$ZPWR_VARS[continueFirstPositionRegex]" ]];then
            commandWords="${(z)match[-1]}"
            loggDebug "matched: $match[@]"

            if (( $#commandWords == 1)); then
                word=${commandWords[1]}
                if type -a $word &>/dev/null; then
                    loggDebug "No correction from >= 2 words => '"'$word'"'_____ = ""'$word'"
                    return
                else
                    break
                fi
            elif (( $#commandWords == 2)); then

                if [[ $ZPWR_VARS[firstword_partition] =~ $ZPWR_VARS[blackSubcommandPositionRegex] ]]; then
                    return
                fi
            fi

        else
            loggDebug "no match$ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]"
            return
        fi
    fi

    loggDebug "______'"'attempt correction'"'_____ = ""'$ZPWR_VARS[lastword_remove_special]'"

    for key in ${(k)ZPWR_EXPAND_CORRECT_WORDS[@]}; do

        badWords=("${(z)ZPWR_EXPAND_CORRECT_WORDS[$key]}")
        for misspelling in $badWords[@];do

            if [[ ${ZPWR_VARS[lastword_remove_special]} == $misspelling ]]; then

                # expand
                [[ $LBUFFER == (#b)(*[[:space:]]#)($misspelling) ]];
                res1=${match[1]}
                # expand
                LBUFFER="$res1${key:gs/_/ /}"

                # ZPWR_VARS[finished]=true
                ZPWR_VARS[foundIncorrect]=true
                CURSOR=$#LBUFFER
                break
            fi
        done
        if [[ $ZPWR_VARS[finished] == true ]];then
            zle self-insert
            return 0
        fi
    done
}

function zpwrExpandCommonParameterExpansion(){

    ZPWR_VARS[EXPANDED]="${$(alias -r $ZPWR_VARS[lastword_lbuffer])#*=}"
    # deal with ansi quotes $'
    [[ $ZPWR_VARS[EXPANDED][1] == \$ ]] && ZPWR_VARS[EXPANDED]=${ZPWR_VARS[EXPANDED]:1}
    ZPWR_VARS[EXPANDED]=${(Q)ZPWR_VARS[EXPANDED]}
}

function zpwrExpandAliasEscape(){

    local res1 result

    [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]
    res1=${match[1]}
    # expand
    LBUFFER="$res1\\$ZPWR_VARS[EXPANDED]"

}

function zpwrExpandAlias(){

    local res1 result

    [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]
    res1=${match[1]}
    # expand
    LBUFFER="$res1$ZPWR_VARS[EXPANDED]"

}

function zpwrExpandGlobalAliases() {

    local res1 result

    ZPWR_VARS[lastword_lbuffer]="$1"
    result=$galiases[$ZPWR_VARS[lastword_lbuffer]]
    [[ $LBUFFER == (#b)(*[[:space:]]#)($ZPWR_VARS[lastword_lbuffer]) ]]

    res1=${match[1]}
    # expand
    LBUFFER="$res1$result"

    zpwrExpandGoToTabStopOrEndOfLBuffer
}

#}}}***********************************************************

#{{{                    MARK:main fn
#**************************************************************
function zpwrExpandSupernaturalSpace() {

    if [[ $ZPWR_TRACE == true ]]; then
        set -x
    fi

    local tempBuffer mywords badWords word nextWord i shouldStopExpansionDueToFailedRegex words ary res1  aliasOut
    ZPWR_VARS[finished]=false

    zpwrExpandParseWords

    if [[ $ZPWR_CORRECT == true ]]; then
        zpwrExpandCorrectWord
    fi

    if [[ $ZPWR_VARS[foundIncorrect] = true && $ZPWR_CORRECT_EXPAND = true ]]; then
        loggDebug "RE-EXPAND after incorrect spelling"
        zpwrExpandParseWords
    fi

    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
    ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=false

    #dont expand =word because that is zle expand-word
    if [[ ${ZPWR_VARS[lastword_lbuffer]:0:1} != '=' ]] && (( $#ZPWR_VARS[lastword_lbuffer] > 0 ));then
        aliasOut=$(alias -r -- $ZPWR_VARS[lastword_lbuffer])
        if [[ -n $aliasOut ]] && ! [[ $aliasOut =~ $ZPWR_VARS[blacklistFirstPosRegex] ]];then

            loggDebug "regular=>'$ZPWR_VARS[lastword_lbuffer]'"

            zpwrExpandIsLastWordLastCommand moveCursor expand
        else
            loggDebug "NOT regular=>'$ZPWR_VARS[lastword_lbuffer]'"
            # remove space from menuselect spacebar
            if [[ ${LBUFFER: -1} == " " && ZPWR_VARS[NEED_TO_ADD_SPACECHAR] == true ]]; then
                loggDebug "removing space menu select"
                LBUFFER="${LBUFFER:0:-1}"
            fi
            if [[ "$ZPWR_VARS[lastword_lbuffer]" =~ '"' ]]; then
                # expand on last word of "string" for global aliases only
                    ZPWR_VARS[lastword_lbuffer]=${ZPWR_VARS[lastword_lbuffer]:gs/\"//}
                    ary=(${(z)ZPWR_VARS[lastword_lbuffer]})
                    ZPWR_VARS[lastword_lbuffer]=$ary[-1]
            fi
            if [[ $(alias -g -- $ZPWR_VARS[lastword_lbuffer]) =~ "." ]]; then
                # global alias expansion
                if [[ ${LBUFFER: -1} == " " ]]; then
                    loggDebug "removing space global alias menu select"
                    LBUFFER="${LBUFFER:0:-1}"
                fi
                loggDebug "global=>'$ZPWR_VARS[lastword_lbuffer]'"
                zpwrExpandGlobalAliases "$ZPWR_VARS[lastword_lbuffer]"
                ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
                ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
            fi
        fi
        if [[ ! -f "$ZPWR_VARS[lastword_lbuffer]" ]]; then
            zpwrExpandNonFileExpansion
        else
            :
       fi
    fi
    if [[ $ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND] != true ]]; then
        # expand file globs, history expansions, command expansion, parameter expansion and =command
        if [[ $ZPWR_EXPAND_NATIVE == true ]]; then
            zle expand-word
        fi
    fi

    loggDebug "ZPWR_VARS[NEED_TO_ADD_SPACECHAR] = $ZPWR_VARS[NEED_TO_ADD_SPACECHAR]"
    loggDebug "ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND] = $ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]"

    if [[ $ZPWR_VARS[NEED_TO_ADD_SPACECHAR] == true ]];then
        # insert the space char
        if [[ $LBUFFER[-1] != ' ' ]]; then
            if [[ $ZPWR_VARS[AP_SPACE] == true ]]; then
                zle autopair-insert
            else
                zle self-insert
            fi
        else
            if [[ $ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND] != true ]]; then
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
#}}}*********************************************************** 
