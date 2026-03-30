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

    # Phase 2: consume command wrappers (case-insensitive for sudo/doas/env/nice/time/nohup/rlwrap)
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
                        # sudo combo: -ABbEeHiKklLNnPSsVv, doas combo: -Lns
                        -[ABbEeHiKklLNnPSsVv]*)  (( pos++ )) ;;
                        # sudo flag-with-arg: -CDghpRTUu, doas: -uC
                        -[CDghpRTUu])         (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[CDghpRTUu]=*)       (( pos++ )) ;; # -u=root form
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
                        -[aCPSu])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[aCPSu]=*)    (( pos++ )) ;;
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
                        -[acEhiImnNoRrUvWX]*)  (( pos++ )) ;;
                        -[bCDefgHlMOpPqsSttwz])  (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[bCDefgHlMOpPqsSttwz]=*) (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            timeout)
                (( pos++ ))
                # consume optional flags
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[fpv]*)   (( pos++ )) ;;
                        -[ks])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[ks]=*)   (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                # consume mandatory DURATION (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            strace|ltrace)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[cCdDfhikLNnqrtTvVyYzZ]*) (( pos++ )) ;;
                        -[aAbBeEFIlnoOpPsSuUwX])   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[aAbBeEFIlnoOpPsSuUwX]=*) (( pos++ )) ;;
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
                # consume flags
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[abdefimoprRv]*)  (( pos++ )) ;;
                        -[DPT])    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[DPT]=*)  (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                # consume mandatory PRIORITY (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            taskset)
                (( pos++ ))
                # consume flags
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[acp]*) (( pos++ )) ;;
                        *)       break ;;
                    esac
                done
                # consume mandatory MASK (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            watch)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[bdCcefgprtwx]*)  (( pos++ )) ;;
                        -[nqs])         (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[nqs]=*|-[nqs][0-9]*) (( pos++ )) ;;
                        *)              break ;;
                    esac
                done
                ;;
            runuser)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[flmpPT]*)    (( pos++ )) ;;
                        -[cgsGuw])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[cgsGuw]=*)   (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            flock)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[eFnosux]*)   (( pos++ )) ;;
                        -[cwE])        (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[cwE]=*)      (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                # consume mandatory FILE (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            chroot)
                (( pos++ ))
                # consume mandatory PATH (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            unshare)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[cfmnpuUirCT]*) (( pos++ )) ;;
                        -[RwSGl])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[RwSGl]=*)    (( pos++ )) ;;
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
                        -[viz]*)   (( pos++ )) ;;
                        -[elp])    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[elp]=*)  (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            su)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[flmpPT]*)    (( pos++ )) ;;
                        -[csgGw])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[csgGw]=*)    (( pos++ )) ;;
                        --)            (( pos++ )); break ;;
                        *)             break ;;
                    esac
                done
                # consume optional USER (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            stdbuf)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[ioe])        (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[ioe]=*|-[ioe]?*) (( pos++ )) ;; # -o=L or -oL combined
                        *)             break ;;
                    esac
                done
                ;;
            sg)
                (( pos++ ))
                # consume mandatory GROUP (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
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
                        -[aceFimnpruUCTwWZ]*)  (( pos++ )) ;;
                        -[tSGN])       (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[tSGN]=*)     (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            numactl)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[absHl]*)     (( pos++ )) ;;
                        -[iCNmpwP])    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[iCNmpwP]=*)  (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            prlimit)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[op])         (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[op]=*)       (( pos++ )) ;;
                        --*)           (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            setpriv)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[dhV]*)       (( pos++ )) ;;
                        --clear-groups|--keep-groups|--init-groups|--no-new-privs|--reset-env|--nnp)
                                       (( pos++ )) ;;
                        --reuid|--regid|--groups|--inh-caps|--ambient-caps|--bounding-set|--securebits|--selinux-label|--apparmor-profile|--pdeathsig)
                                       (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        --*=*)         (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            setarch)
                (( pos++ ))
                # consume positional ARCH (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                # consume flags
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[vhV3BFILRSTXZ]*) (( pos++ )) ;;
                        -[p])              (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[p]=*)            (( pos++ )) ;;
                        --*)               (( pos++ )) ;;
                        *)                 break ;;
                    esac
                done
                ;;
            linux32|linux64)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[vhV3BFILRSTXZ]*) (( pos++ )) ;;
                        -[p])              (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[p]=*)            (( pos++ )) ;;
                        --*)               (( pos++ )) ;;
                        *)                 break ;;
                    esac
                done
                ;;
            runcon)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[c]*)         (( pos++ )) ;;
                        -[urtl])       (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[urtl]=*)     (( pos++ )) ;;
                        --)            (( pos++ )); break ;;
                        *)             break ;;
                    esac
                done
                ;;
            xvfb-run)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[alh]*)       (( pos++ )) ;;
                        -[efnpsw])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[efnpsw]=*)   (( pos++ )) ;;
                        --)            (( pos++ )); break ;;
                        *)             break ;;
                    esac
                done
                ;;
            chpst)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[vVP012]*)            (( pos++ )) ;;
                        -[uUbenlLmdopfct/])  (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[uUbenlLmdopfct/]=*) (( pos++ )) ;;
                        *)                     break ;;
                    esac
                done
                ;;
            cgexec)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[h]*)         (( pos++ )) ;;
                        -g)            (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -g=*)          (( pos++ )) ;;
                        --sticky)      (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            trickle)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[hvVs]*)      (( pos++ )) ;;
                        -[duwtnlP])    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[duwtnlP]=*)  (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            faketime)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[fm]*)        (( pos++ )) ;;
                        -[p])          (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[p]=*)        (( pos++ )) ;;
                        --*)           (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                # consume mandatory TIMESTAMP (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            proot)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[Vh0]*)           (( pos++ )) ;;
                        -[rbmqwvkiRS])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[rbmqwvkiRS]=*)   (( pos++ )) ;;
                        *)                 break ;;
                    esac
                done
                ;;
            bwrap)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        # 2-arg flags: --bind SRC DEST, --setenv VAR VAL, etc.
                        --bind|--dev-bind|--ro-bind|--bind-try|--dev-bind-try|--ro-bind-try|--symlink|--file|--bind-data|--ro-bind-data|--setenv|--chmod)
                            (( pos++ )); (( pos <= $#words )) && (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        # 3-arg: --overlay RWDIR WORKDIR DEST
                        --overlay)
                            (( pos++ )); (( pos <= $#words )) && (( pos++ )); (( pos <= $#words )) && (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        # boolean flags (0 args)
                        --unshare-*|--share-net|--clearenv|--new-session|--die-with-parent|--as-pid-1|--assert-userns-disabled|--disable-userns)
                            (( pos++ )) ;;
                        # 1-arg catch-all for remaining --flags
                        --*)
                            (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        *)
                            break ;;
                    esac
                done
                ;;
            capsh)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        --)            (( pos++ )); break ;;
                        --*=*)         (( pos++ )) ;;
                        --print|--current|--mode|--modes|--strict|--noamb|--noenv|--quiet|--has-ambient|--has-p|--has-no-new-privs)
                                       (( pos++ )) ;;
                        --*)           (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            valgrind)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[dhqsv]*)     (( pos++ )) ;;
                        --*=*)         (( pos++ )) ;;
                        --*)           (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            pkexec|fakeroot|unbuffer|chronic|torify|torsocks|tsocks|proxychains4|daemonize|firejail|sem|systemd-run|dbus-run-session|eatmydata|catchsegv|nocache|fakechroot|ccache|distcc|dbus-launch)
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
    # consumes shell keywords and command wrappers with their flags
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

                if (( $#ZPWR_EXPAND_PRE_EXPAND == 1)) && [[ -n $ZPWR_EXPAND_PRE_EXPAND[1] ]]; then
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

                    if (( $#ZPWR_EXPAND_PRE_EXPAND == 1)) && [[ -n $ZPWR_EXPAND_PRE_EXPAND[1] ]]; then
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
