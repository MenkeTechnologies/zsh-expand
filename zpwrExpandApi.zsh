#!/usr/bin/env zsh
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Fri Aug 14 15:12:03 EDT 2020
##### Purpose: zsh script to hold expand lib fns
##### Notes:
# Usage for external service like fzf.  Must have ZPWR_VARS set
#
# zpwrExpandParseWords
# zpwrExpandLastWordAtCommandPosAndExpand
#
# if $ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND] == true; then
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

    # arithmetic expansion $(()) is not a a command position so replace with junk value
    tmp[-1]=${tmp[-1]//[\$]\(\(/no_cmd_$RANDOM}
    # change <(, =(, $( to ; for word splitting
    tmp[-1]=${tmp[-1]//[\<\=\$]\(/;}
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

    mywordsleft=( ${(Az)tmp} )
    #zpwrLogDebug "my words left = $mywordsleft"

    # we must find the first index of the partition
    firstIndex=0

    for (( i = $#mywordsleft; i >= 1; i-- )); do
        # ;; ; | || && are statement separating chars
        # we will split the command line and get the statement of the cursor
        # regular aliases are valid in the first position of this statement
        case $mywordsleft[$i] in
            ';;' | \; | \| | '||' | '&&' | '(' | '{')
                firstIndex=$((i + 1))
                break
                ;;
            *=*)
                #remove assignment
                mywordsleft[$i]=()
                ;;
            '>'* | '<'* | '&>'*)
                #remove redirection operator from left words
                mywordsleft[$i]=()
                #remove redirected file
                mywordsleft[$i]=()
                ;;
            *)
                ;;
        esac
    done

    ZPWR_EXPAND_WORDS_LPARTITION=( $mywordsleft[$firstIndex,$#mywordsleft] )

    #zpwrLogDebug "lpartition = '$ZPWR_EXPAND_WORDS_LPARTITION'"

    lpartAry=( ${(z)${ZPWR_EXPAND_WORDS_LPARTITION}} )

    ZPWR_VARS[firstword_partition]=${lpartAry[1]}

    ZPWR_VARS[lastword_lbuffer]=${lpartAry[-1]}

    #zpwrLogDebug "first word partition = ...$ZPWR_VARS[firstword_partition]..."
    #zpwrLogDebug "last word lbuf before no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    lbufAry=( ${(z)${ZPWR_VARS[lastword_lbuffer]}} )

    ZPWR_VARS[lastword_lbuffer]=${lbufAry[-1]}
    #zpwrLogDebug "last word lbuf after no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    #zpwrLogDebug "first word partition before spelling = ...$ZPWR_VARS[firstword_partition]..."
    #zpwrLogDebug "last word lbuf before spelling = ...$ZPWR_VARS[lastword_lbuffer]..."

    lastWordAry=( ${(Az)${ZPWR_VARS[lastword_lbuffer]//[\[\]\{\}\(\)\']/}} )
    finalWord=${lastWordAry[-1]}
    ZPWR_VARS[lastword_remove_special]=$finalWord

    #zpwrLogDebug "last word no special chars...${ZPWR_VARS[lastword_remove_special]}..."

}

function zpwrExpandLastWordAtCommandPosAndExpand(){

    local cursorAction=$1
    local caller=$2
    local triggerKey=$3

    if (( $#ZPWR_EXPAND_WORDS_LPARTITION == 1 )); then
        if [[ $caller == zle ]]; then
            zpwrExpandGetAliasValue
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
            if [[ $ZPWR_VARS[WAS_EXPANDED] == true && $cursorAction == moveCursor ]]; then
                zpwrExpandGoToTabStopOrEndOfLBuffer
            fi
        fi
        ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=true
        ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]

    elif (( $#ZPWR_EXPAND_WORDS_LPARTITION >= 2 )); then
        # regular alias expansion after sudo
        if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then


            if [[ -n "$ZPWR_EXPAND_PRE_EXPAND" ]]; then
                #zpwrLogDebug "${ZPWR_EXPAND_PRE_EXPAND[@]}"
                if [[ $triggerKey == "${ZPWR_VARS[ENTER_KEY]}" && $ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION != true ]]; then
                    return
                fi

                if (( $#ZPWR_EXPAND_PRE_EXPAND == 1)); then
                    if [[ $caller == zle ]]; then
                        zpwrExpandGetAliasValue
                        zpwrExpandAlias
                        if [[ $ZPWR_VARS[WAS_EXPANDED] == true && $cursorAction == moveCursor && $triggerKey != "${ZPWR_VARS[ENTER_KEY]}" ]]; then
                            zpwrExpandGoToTabStopOrEndOfLBuffer
                        fi
                    fi
                    ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=true
                    ZPWR_VARS[ORIGINAL_LAST_COMMAND]=$ZPWR_VARS[lastword_lbuffer]
                else
                    ZPWR_VARS[NEED_TO_ADD_SPACECHAR]=true
                fi
            else
                # here if not called by supernatural space fn
                if zpwrExpandRegexMatchOnCommandPosition; then

                    if (( $#ZPWR_EXPAND_PRE_EXPAND == 1)); then
                        if [[ $caller == zle ]]; then
                            zpwrExpandGetAliasValue
                        fi
                        ZPWR_VARS[LAST_WORD_WAS_AT_COMMAND]=true
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
