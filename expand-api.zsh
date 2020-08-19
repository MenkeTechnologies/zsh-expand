#!/usr/bin/env zsh
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Fri Aug 14 15:12:03 EDT 2020
##### Purpose: zsh script to hold expand lib fns
##### Notes: 
# Usage for external service like fzf.  Must have BUFFER, LBUFFER, BUFFER set like ZLE does.
#
# parseWords
# isLastWordLastCommand
#
# if $ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND] == true; then
#   echo $ZPWR_VARS[ORIGINAL_LAST_COMMAND]
# fi
#
#
#}}}***********************************************************

function parseWords(){

    local i lastword_partition firstIndex lastIndex finalWord
    local -a mywordsleft mywordsright mywordsall lbufAry lpartAry lastWordAry partitionAry

    # loop through words to get first and last words in partition
    mywordsleft=(${(z)LBUFFER})
    loggDebug "my words left = $mywordsleft"
    mywordsright=(${(z)RBUFFER})
    loggDebug "my words right = $mywordsright"
    mywordsall=(${(z)BUFFER})

    # we must find the first index of the partition
    firstIndex=0
    # we must find the last index of the partition
    lastIndex=0

    for (( i = $#mywordsleft; i >= 0; i-- )); do
        # ;; ; | || && are partition separating chars
        # we will split the commad line and get the partition of the caret
        # aliases are valid in the first position after these chars
        case $mywordsleft[$i] in
            ';;' | \; | \| | '||' | '&&' | '<(' | '(' | '{')
                firstIndex=$((i+1))
                break
                ;;
            *)
                ;;
        esac
    done

    loggDebug "first index = $firstIndex"

    for (( i = 0; i < $#mywordsright; i++ )); do
        case $mywordsright[$i] in
            # ;; ; | || && are partition separating chars
            # we will split the commad line and get the partition of the caret
            # aliases are valid in the first position after these chars
            ';;' | \; | \| | '||' | '&&' | ')' | '}') lastIndex=$((i-1))
            break
            ;;
        *)
            ;;
        esac
    done
    loggDebug "last index = $lastIndex"

    (( lastIndex += $#mywordsleft ))


    ZPWR_EXPAND_WORDS_LPARTITION=($mywordsleft[$firstIndex,$#mywordsleft])
    ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]=ZPWR_EXPAND_WORDS_LPARTITION

    ZPWR_EXPAND_WORDS_PARTITION=($mywordsall[$firstIndex,$lastIndex])
    ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]=ZPWR_EXPAND_WORDS_PARTITION

    loggDebug "partition = '${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}'"

    lpartAry=(${(z)${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}})

    ZPWR_VARS[firstword_partition]=${lpartAry[1]}

    ZPWR_VARS[lastword_lbuffer]=${lpartAry[-1]}

    # to get rid of double quotes
    loggDebug "first word partition = ...$ZPWR_VARS[firstword_partition]..."
    loggDebug "last word lbuf before no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    lbufAry=(${(z)${ZPWR_VARS[lastword_lbuffer]//\"/}})

    ZPWR_VARS[lastword_lbuffer]=${lbufAry[-1]}
    loggDebug "last word lbuf after no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    partitionAry=(${(z)${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]}})
    lastword_partition=${partitionAry[-1]}

    loggDebug "first word partition before spelling = ...$ZPWR_VARS[firstword_partition]..."
    loggDebug "last word lbuf before spelling = ...$ZPWR_VARS[lastword_lbuffer]..."
    loggDebug "last word partition before spelling = ...$lastword_partition..."

    lastWordAry=(${(Az)${ZPWR_VARS[lastword_lbuffer]//[\[\]\{\}\(\)\']/}})
    finalWord=${lastWordAry[-1]}
    ZPWR_VARS[lastword_remove_special]=$finalWord

    loggDebug "last word no special chars...${ZPWR_VARS[lastword_remove_special]}..."
}

function isLastWordLastCommand(){

    local moveCursor=$1
    local expand=$2


    if (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]} == 1 )); then
        # regular alias expansion
        # remove space from menuselect spacebar
        if [[ ${LBUFFER: -1} == " " ]]; then
            LBUFFER="${LBUFFER:0:-1}"
        fi
        if [[ $expand == expand ]]; then
            commonParameterExpansion
            words=(${(z)ZPWR_VARS[EXPANDED]})
            if [[ ${words[1]} == "$ZPWR_VARS[lastword_lbuffer]" ]];then
                # do the expansion with perl sub on the last word of left buffer
                LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@\\\\$ZPWR_VARS[EXPANDED]@")"
            else
                # do the expansion with perl sub on the last word of left buffer
                LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@$ZPWR_VARS[EXPANDED]@")"
            fi
            LBUFFER=${LBUFFER//$ZPWR_VARS[subForAtSign]/@}
            if [[ $moveCursor == moveCursor ]]; then
                goToTabStopOrEndOfLBuffer
            fi
        fi
        ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
        ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]

    elif (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]} == 2 )); then
        # regular alias expansion after sudo
        if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then
            if printf -- "$ZPWR_VARS[firstword_partition]" | command grep -qE $ZPWR_VARS[continueFirstPositionRegex];then
                loggDebug "matched $ZPWR_VARS[firstword_partition] with $ZPWR_VARS[continueFirstPositionRegex] with 2 == ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]}"
                if [[ $expand == expand ]]; then
                    commonParameterExpansion
                    # do the expansion with perl sub on the last word of left buffer
                    LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@$ZPWR_VARS[EXPANDED]@")"
                    LBUFFER=${LBUFFER:gs|$ZPWR_VARS[subForAtSign]|@|}
                    if [[ $moveCursor == moveCursor ]]; then
                        goToTabStopOrEndOfLBuffer
                    fi
                fi
                ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
                ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
            fi
        fi

    elif (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION]} > 2 )); then
        # regular alias expansion after sudo -E or sudo env or sudo env -e or sudo -E env -e -a -f etc
        if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then
            if printf -- "$ZPWR_VARS[firstword_partition]" | command grep -qsE $ZPWR_VARS[continueFirstPositionRegex];then
                loggDebug "matched $ZPWR_VARS[firstword_partition] with $ZPWR_VARS[continueFirstPositionRegex] with $#ZPWR_VARS[ZPWR_EXPAND_WORDS_LPARTITION] > 2"
                for (( i = 2; i < ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]}; ++i )); do
                    # zsh only supports nested arrays with indirection
                    word=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION][$i]}
                    # zsh only supports nested arrays with indirection
                    nextWord=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION][$i+1]}
                    shouldStopExpansionDueToFailedRegex=false

                    if (( (i + 1) < ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]} )); then
                        if printf -- "$word $nextWord" | command grep -qsE $ZPWR_VARS[continueOptionSpaceArgSecondAndOnwardsPositionRegex]; then
                            loggDebug "matched grep -Eqv '$ZPWR_VARS[continueOptionSpaceArgSecondAndOnwardsPositionRegex]' for word:'$word $nextWord'"
                            ((++i))
                            continue
                        fi
                    fi

                    if ! printf -- "$word" | command grep -qsE $ZPWR_VARS[continueSecondAndOnwardsPositionRegex]; then
                        shouldStopExpansionDueToFailedRegex=true
                        ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
                        loggDebug "failed grep -Eqv '$ZPWR_VARS[continueSecondAndOnwardsPositionRegex]' for word:'$word'"
                        break
                    fi
                done
                if [[ $shouldStopExpansionDueToFailedRegex == false ]]; then
                    if [[ $expand == expand ]]; then
                        commonParameterExpansion
                        # do the expansion with perl sub on the last word of left buffer
                        LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@$ZPWR_VARS[EXPANDED]@")"
                        LBUFFER=${LBUFFER:gs|$ZPWR_VARS[subForAtSign]|@|}
                        if [[ $moveCursor == moveCursor ]]; then
                            goToTabStopOrEndOfLBuffer
                        fi
                    fi
                    ZPWR_VARS[LAST_WORD_WAS_LAST_COMMAND]=true
                    ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
                else
                    loggDebug "not expanding $ZPWR_VARS[lastword_lbuffer] with 1st pos:$ZPWR_VARS[continueFirstPositionRegex] and 2nd pos:$ZPWR_VARS[continueSecondAndOnwardsPositionRegex]"
                fi
            fi
        fi
    fi
}
