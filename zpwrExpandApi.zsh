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

# Parser that walks ZPWR_EXPAND_WORDS_LPARTITION left-to-right to find
# command position.  Strips assignments contextually (before command and
# between prefixes, but NOT when they are flag arguments like -e trace=network).
# Sets ZPWR_VARS[cachedRegexMatch] to the tail (command + args after all prefixes)
# and ZPWR_VARS[cachedRegexMatched]=true on success.
function zpwrExpandParserFindCommandPosition() {

    local -a words
    words=("${(@)ZPWR_EXPAND_WORDS_LPARTITION}")
    local -i pos=1
    local bare lower

    # helper: strip leading/trailing quotes and backslash for comparison
    # \sudo => sudo, 'sudo' => sudo, "sudo" => sudo, $'sudo' => sudo
    _zpwr_bare() {
        local w=$1
        # strip $' prefix
        w=${w#\$\'}
        # strip leading \, ', "
        w=${w#[\\\"\']}
        # strip trailing ', "
        w=${w%[\"\']}
        REPLY=$w
    }

    # helper: check if word is a variable assignment (NAME=value)
    _zpwr_is_assignment() {
        [[ $1 == [A-Za-z_]*=* ]]
    }

    # Phase 1: consume shell keywords/builtins (case-sensitive)
    # These are processed by the shell before any exec, can appear in any order
    while (( pos <= $#words )); do
        # skip assignments before/between shell keywords
        if _zpwr_is_assignment "$words[$pos]"; then
            (( pos++ ))
            continue
        fi
        _zpwr_bare "$words[$pos]"
        bare=$REPLY
        case $bare in
            nocorrect|-|builtin|eval|noglob|coproc)
                (( pos++ ))
                ;;
            time)
                (( pos++ ))
                # consume optional -p/-l/-v flags
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -[plv]* ]] && (( pos++ ))
                fi
                ;;
            command)
                (( pos++ ))
                # consume optional -p flag
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -p ]] && (( pos++ ))
                fi
                ;;
            exec)
                (( pos++ ))
                # consume -c/-l combo flags and -a NAME
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[cl]*) (( pos++ )) ;;
                        -a)     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -a=*)   (( pos++ )) ;;
                        *)      break ;;
                    esac
                done
                ;;
            *)
                break
                ;;
        esac
    done

    # Phase 2: consume execvp wrappers (case-insensitive for sudo/doas/env/nice/time/nohup/rlwrap)
    while (( pos <= $#words )); do
        # skip assignments between wrappers (env FOO=bar, sudo VAR=val, etc)
        if _zpwr_is_assignment "$words[$pos]"; then
            (( pos++ ))
            continue
        fi
        _zpwr_bare "$words[$pos]"
        bare=$REPLY
        lower=${(L)bare}
        case $lower in
            sudo|doas)
                (( pos++ ))
                # consume flags: combo flags, flag-with-arg, --, assignments
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        # sudo combo: -ABbEHkKnPSis, doas combo: -ns
                        -[ABbEHkKnPSisns]*)  (( pos++ )) ;;
                        # sudo flag-with-arg: -CghpRrTtu, doas: -uC
                        -[CghpRrTtuC])        (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[CghpRrTtuC]=*)      (( pos++ )) ;; # -u=root form
                        --)                   (( pos++ )); break ;;
                        *)                    break ;;
                    esac
                done
                ;;
            env)
                (( pos++ ))
                while (( pos <= $#words )); do
                    if _zpwr_is_assignment "$words[$pos]"; then
                        (( pos++ )); continue  # env VAR=val
                    fi
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[0iv]*)       (( pos++ )) ;;
                        -[CPSu])       (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[CPSu]=*)     (( pos++ )) ;;
                        --)            (( pos++ )); break ;;
                        *)             break ;;
                    esac
                done
                ;;
            nice)
                (( pos++ ))
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -n)    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;; # -n 10
                        -n=*|-n[0-9]*) (( pos++ )) ;;     # -n=10 or -n10
                        -[0-9]*) (( pos++ )) ;;            # -19
                    esac
                fi
                ;;
            time)
                (( pos++ ))
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -[plv]* ]] && (( pos++ ))
                fi
                ;;
            nohup)
                (( pos++ ))
                ;;
            rlwrap)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[aciNr]*)     (( pos++ )) ;;
                        -[bfHpsS])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[bfHpsS]=*)   (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            timeout)
                (( pos++ ))
                # consume optional -k/-s flags
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[ks])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[ks]=*)   (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                # consume mandatory DURATION (only if not the last word)
                (( pos < $#words )) && (( pos++ ))
                ;;
            strace|ltrace)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[cCdDfFhikqrtTvVwxXyYzZ]*) (( pos++ )) ;;
                        -[abeEIoOpPsSuU])   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[abeEIoOpPsSuU]=*) (( pos++ )) ;;
                        *)                  break ;;
                    esac
                done
                ;;
            ionice)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[t]*)         (( pos++ )) ;;
                        -[cn])         (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[cn]=*|-[cn][0-9]*) (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            caffeinate)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[dimsu]*)     (( pos++ )) ;;
                        -[tw])         (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[tw]=*)       (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            setsid)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[cfw]*) (( pos++ )) ;;
                        *)       break ;;
                    esac
                done
                ;;
            chrt)
                (( pos++ ))
                # consume optional policy flag
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -[bfimor]* ]] && (( pos++ ))
                fi
                # consume mandatory PRIORITY (only if not the last word)
                (( pos < $#words )) && (( pos++ ))
                ;;
            taskset)
                (( pos++ ))
                # consume optional -c flag
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -c ]] && (( pos++ ))
                fi
                # consume mandatory MASK (only if not the last word)
                (( pos < $#words )) && (( pos++ ))
                ;;
            watch)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[dgtecxbpw]*)  (( pos++ )) ;;
                        -n)             (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -n=*|-n[0-9]*) (( pos++ )) ;;
                        *)              break ;;
                    esac
                done
                ;;
            runuser)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[l]*)         (( pos++ )) ;;
                        -[ugG])        (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[ugG]=*)      (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            flock)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[nsux]*)      (( pos++ )) ;;
                        -[wE])         (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[wE]=*)       (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                # consume mandatory FILE (only if not the last word)
                (( pos < $#words )) && (( pos++ ))
                ;;
            chroot)
                (( pos++ ))
                # consume mandatory PATH (only if not the last word)
                (( pos < $#words )) && (( pos++ ))
                ;;
            unshare)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[fmnpuUirC]*) (( pos++ )) ;;
                        --)            (( pos++ )); break ;;
                        *)             break ;;
                    esac
                done
                ;;
            cpulimit)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[l])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[l]=*)    (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            su)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[flmpP]*)     (( pos++ )) ;;
                        -[csgGw])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[csgGw]=*)    (( pos++ )) ;;
                        --)            (( pos++ )); break ;;
                        *)             break ;;
                    esac
                done
                # consume optional USER (only if not the last word)
                (( pos < $#words )) && (( pos++ ))
                ;;
            stdbuf)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[ioe])        (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[ioe]=*)      (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            sg)
                (( pos++ ))
                # consume mandatory GROUP (only if not the last word)
                (( pos < $#words )) && (( pos++ ))
                ;;
            choom)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -n)            (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -n=*)          (( pos++ )) ;;
                        -p)            (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -p=*)          (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            nsenter)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[muinpUCrFG]*)  (( pos++ )) ;;
                        -[tS])         (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[tS]=*)       (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            numactl)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[iH]*)        (( pos++ )) ;;
                        -[CNmp])       (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[CNmp]=*)     (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            prlimit)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[v]*)         (( pos++ )) ;;
                        -[p])          (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[p]=*)        (( pos++ )) ;;
                        --*)           (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            pkexec|fakeroot|unbuffer|chronic|torify|torsocks|tsocks|proxychains4|daemonize|firejail|sem|valgrind|systemd-run|dbus-run-session)
                (( pos++ ))
                ;;
            *)
                break
                ;;
        esac
    done

    # Build prefix string (everything consumed) and tail string (remaining words)
    local -a prefix_words=()
    for (( i = 1; i < pos && i <= $#words; i++ )); do
        prefix_words+=("$words[$i]")
    done
    ZPWR_VARS[cachedParserPrefix]="${prefix_words[*]}"

    if (( pos <= $#words )); then
        local -a tail=()
        for (( i = pos; i <= $#words; i++ )); do
            tail+=("$words[$i]")
        done
        ZPWR_VARS[cachedRegexMatch]="${tail[*]}"
        ZPWR_VARS[cachedRegexMatched]=true

        # also update ZPWR_EXPAND_WORDS_LPARTITION to have assignments stripped
        # (downstream code expects this)
        local -a cleaned=()
        for (( i = 1; i <= $#words; i++ )); do
            if ! _zpwr_is_assignment "$words[$i]"; then
                cleaned+=("$words[$i]")
            fi
        done
        ZPWR_EXPAND_WORDS_LPARTITION=("${cleaned[@]}")
    else
        # all words consumed as prefixes — still a valid parse, just no command yet
        ZPWR_VARS[cachedRegexMatch]=""
        ZPWR_VARS[cachedRegexMatched]=true

        local -a cleaned=()
        for (( i = 1; i <= $#words; i++ )); do
            if ! _zpwr_is_assignment "$words[$i]"; then
                cleaned+=("$words[$i]")
            fi
        done
        ZPWR_EXPAND_WORDS_LPARTITION=("${cleaned[@]}")
    fi

    unfunction _zpwr_bare _zpwr_is_assignment 2>/dev/null
}

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

    # use parser to find command position — strips assignments contextually,
    # consumes shell keywords and execvp wrappers with their flags
    ZPWR_VARS[cachedRegexMatch]=""
    ZPWR_VARS[cachedRegexMatched]=false
    local -i isArgPosition=0
    if (( $#ZPWR_EXPAND_WORDS_LPARTITION > 1 )); then
        zpwrExpandParserFindCommandPosition
        if [[ -n $ZPWR_VARS[cachedRegexMatch] || $ZPWR_VARS[cachedRegexMatched] == true ]]; then
            ZPWR_VARS[cachedRegexMatched]=true
            local -a tailWords=( ${(z)ZPWR_VARS[cachedRegexMatch]} )
            (( $#tailWords > 1 )) && isArgPosition=1
        else
            isArgPosition=1
        fi
    fi
    if (( isArgPosition )); then
        if [[ $ZPWR_EXPAND_QUOTE_DOUBLE == true ]]; then
            ZPWR_EXPAND_WORDS_LPARTITION[-1]=${ZPWR_EXPAND_WORDS_LPARTITION[-1]:gs/\"//}
        fi
        if [[ $ZPWR_EXPAND_QUOTE_SINGLE == true ]]; then
            ZPWR_EXPAND_WORDS_LPARTITION[-1]=${ZPWR_EXPAND_WORDS_LPARTITION[-1]:gs/\'//}
        fi
    fi

    #zpwrLogDebug "lpartition = '$ZPWR_EXPAND_WORDS_LPARTITION'"

    lpartAry=( ${(z)${ZPWR_EXPAND_WORDS_LPARTITION}} )

    ZPWR_VARS[firstword_partition]=${lpartAry[1]}

    # skip words containing = (assignments and --flag=value) for lastword
    local -a _noeq=()
    local _w
    for _w in "${lpartAry[@]}"; do
        [[ $_w != *=* ]] && _noeq+=("$_w")
    done
    if (( $#_noeq )); then
        ZPWR_VARS[lastword_lbuffer]=${_noeq[-1]}
    else
        ZPWR_VARS[lastword_lbuffer]=''
    fi

    #zpwrLogDebug "first word partition = ...$ZPWR_VARS[firstword_partition]..."
    #zpwrLogDebug "last word lbuf before no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    lbufAry=( ${(z)${ZPWR_VARS[lastword_lbuffer]}} )

    if (( $#lbufAry )); then
        ZPWR_VARS[lastword_lbuffer]=${lbufAry[-1]}
    fi
    #zpwrLogDebug "last word lbuf after no dbl quotes and [-1] = ...$ZPWR_VARS[lastword_lbuffer]..."

    #zpwrLogDebug "first word partition before spelling = ...$ZPWR_VARS[firstword_partition]..."
    #zpwrLogDebug "last word lbuf before spelling = ...$ZPWR_VARS[lastword_lbuffer]..."

    lastWordAry=( ${(Az)${ZPWR_VARS[lastword_lbuffer]//[\[\]\{\}\(\)]/}} )
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
