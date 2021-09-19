#!/usr/bin/env zsh
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Fri Aug 14 15:12:03 EDT 2020
##### Purpose: zsh script to hold expand lib fns
##### Notes: 
# Usage for external service like fzf.  Must have BUFFER, LBUFFER, RBUFFER set like ZLE does.
#
# zpwrExpandParseWords
# zpwrExpandIsLastWordLastCommand
#
# if $ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND] == true; then
#   echo $ZPWR_VARS[ORIGINAL_LAST_COMMAND]
# fi
#
#
#}}}***********************************************************

function zpwrExpandParseWords(){

    local i lastword_partition firstIndex lastIndex finalWord tmp
    local -a mywordsleft mywordsright mywordsall lbufAry lpartAry lastWordAry partitionAry

    # loop through words to get first and last words in partition
    tmp=${1}
    tmp=( ${(z)tmp} )

    # change <( to ; for word splitting
    tmp[-1]=${tmp[-1]:gs/\<\(/;/}
    # change $( to ; for word splitting
    tmp[-1]=${tmp[-1]:gs/\$\(/;/}
    # change ` to ; for word splitting
    tmp[-1]=${tmp[-1]:gs/\`/;/}
    # allow expansion in ""
    if [[ $ZPWR_EXPAND_QUOTE_DOUBLE == true ]]; then
        tmp[-1]=${tmp[-1]:gs/\"//}
    fi

    # allow expansion in ''
    if [[ $ZPWR_EXPAND_QUOTE_SINGLE == true ]]; then
        tmp[-1]=${tmp[-1]:gs/\'//}
    fi

    mywordsleft=(${(Az)tmp})
    #zpwrLogDebug "my words left = $mywordsleft"

    # we must find the first index of the partition
    firstIndex=0

    for (( i = $#mywordsleft; i >= 0; i-- )); do
        # ;; ; | || && are partition separating chars
        # we will split the commad line and get the partition of the caret
        # aliases are valid in the first position after these chars
        case $mywordsleft[$i] in
            ';;' | \; | \| | '||' | '&&' | '(' | '{')
                firstIndex=$((i+1))
                break
                ;;
            *)
                ;;
        esac
    done

    ZPWR_EXPAND_WORDS_LPARTITION=($mywordsleft[$firstIndex,$#mywordsleft])

    ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]=ZPWR_EXPAND_WORDS_LPARTITION

    #zpwrLogDebug "lpartition = '${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}'"

    lpartAry=(${(z)${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}})

    ZPWR_VARS[firstword_partition]=${lpartAry[1]}

    ZPWR_VARS[lastword_lbuffer]=${lpartAry[-1]}

    #zpwrLogDebug "first word partition = ...$ZPWR_VARS[firstword_partition]..."
    #zpwrLogDebug "last word lbuf before no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    lbufAry=(${(z)${ZPWR_VARS[lastword_lbuffer]}})

    ZPWR_VARS[lastword_lbuffer]=${lbufAry[-1]}
    #zpwrLogDebug "last word lbuf after no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    #zpwrLogDebug "first word partition before spelling = ...$ZPWR_VARS[firstword_partition]..."
    #zpwrLogDebug "last word lbuf before spelling = ...$ZPWR_VARS[lastword_lbuffer]..."

    lastWordAry=(${(Az)${ZPWR_VARS[lastword_lbuffer]//[\[\]\{\}\(\)\']/}})
    finalWord=${lastWordAry[-1]}
    ZPWR_VARS[lastword_remove_special]=$finalWord

    #zpwrLogDebug "last word no special chars...${ZPWR_VARS[lastword_remove_special]}..."

}

function zpwrExpandIsLastWordLastCommand(){

    local moveCursor=$1
    local expand=$2

    if (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]} == 1 )); then
        if [[ $expand == expand ]]; then
            zpwrExpandCommonParameterExpansion
            words=(${(z)ZPWR_VARS[EXPANDED]})
            if [[ ${words[1]} == "$ZPWR_VARS[lastword_lbuffer]" ]];then
                # escape the expanded form because its first word is an alias itself
                zpwrExpandAliasEscape
            else
    if [[ $ZPWR_TRACE == true ]]; then
        set -x
    fi
                zpwrExpandAlias
            fi
            if [[ $ZPWR_VARS[WAS_EXPANDED] == true && $moveCursor == moveCursor ]]; then
                zpwrExpandGoToTabStopOrEndOfLBuffer
            fi
        fi
        ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
        ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]

    elif (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]} >= 2 )); then
        # regular alias expansion after sudo
        if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then


            if [[ -n "$ZPWR_EXPAND_PRE_EXPAND" ]]; then
                #zpwrLogDebug "${ZPWR_EXPAND_PRE_EXPAND[@]}"

                if (( $#ZPWR_EXPAND_PRE_EXPAND == 1)); then
                    if [[ $expand == expand ]]; then
                        zpwrExpandCommonParameterExpansion
                        zpwrExpandAlias
                        if [[ $ZPWR_VARS[WAS_EXPANDED] == true && $moveCursor == moveCursor ]]; then
                            zpwrExpandGoToTabStopOrEndOfLBuffer
                        fi
                    fi
                    ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
                    ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
                else
                    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
                fi
            else
                if [[ "${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}" =~ "$ZPWR_VARS[continueFirstPositionRegex]" ]];then
                    ZPWR_EXPAND_PRE_EXPAND=("${(z)match[-1]}")

                    if (( $#ZPWR_EXPAND_PRE_EXPAND == 1)); then
                        if [[ $expand == expand ]]; then
                            zpwrExpandCommonParameterExpansion
                            zpwrExpandAlias
                            if [[ $ZPWR_VARS[WAS_EXPANDED] == true && $moveCursor == moveCursor ]]; then
                                zpwrExpandGoToTabStopOrEndOfLBuffer
                            fi
                        fi
                        ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
                        ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
                    else
                        ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
                    fi
                else
                    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
                    #zpwrLogDebug "no match ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION] '$ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]'"
                    return
                fi

            fi
        fi

    fi
}
