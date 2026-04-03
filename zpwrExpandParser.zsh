#!/usr/bin/env zsh
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Sat Sep  5 18:51:48 EDT 2020
##### Purpose: zsh script to hold command position parser
##### Notes:
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
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -n)    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;; # -n 10
                        -n=*|-n[0-9]*) (( pos++ )) ;;     # -n=10 or -n10
                        -[0-9]*) (( pos++ )) ;;            # -19
                        --)    (( pos++ )); break ;;
                        *)     break ;;
                    esac
                done
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
                # consume optional --
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -- ]] && (( pos++ ))
                fi
                ;;
            rlwrap)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[acEhiImnNoRrUvWX]*)  (( pos++ )) ;;
                        -[bCDefgHlMOpPqsSttwz])  (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[bCDefgHlMOpPqsSttwz]=*) (( pos++ )) ;;
                        --)            (( pos++ )); break ;;
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
                        --)        (( pos++ )); break ;;
                        *)         break ;;
                    esac
                done
                # consume mandatory DURATION (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            strace)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[AcCdDfFhiknNqrtTvVwxyYzZ]*) (( pos++ )) ;;
                        -[abeEIoOpPsSuUX])   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[abeEIoOpPsSuUX]=*) (( pos++ )) ;;
                        --)                  (( pos++ )); break ;;
                        *)                   break ;;
                    esac
                done
                ;;
            ltrace)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        # --indent / -n always takes an argument (NR); match before combo flags so
                        # it cannot be mistaken for a no-arg flag on any zsh build.
                        -n)                 (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        # Standalone -b syscall mask takes the next word; bundled -bc... (one token)
                        # must still match the combo branch below.
                        -b)                 (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[bcCfhiLrStTV]*)   (( pos++ )) ;;
                        -[aADeFlopsuwx])    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[aADeFlopsuwx]=*)  (( pos++ )) ;;
                        --)                 (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)      (( pos++ )); break ;;
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
                        --)        (( pos++ )); break ;;
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
                        --)      (( pos++ )); break ;;
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
                        --)             (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
                        *)             break ;;
                    esac
                done
                # consume mandatory FILE (only if not the last word)
                (( pos <= $#words )) && (( pos++ ))
                ;;
            chroot)
                (( pos++ ))
                # consume optional --
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -- ]] && (( pos++ ))
                fi
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
                        # long opts with required arg (space-separated)
                        --map-user|--map-users|--map-group|--map-groups|--owner|--propagation|--setgroups|--setuid|--setgid|--root|--wd|--monotonic|--boottime|--load-interp)
                                       (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        --*=*)         (( pos++ )) ;;
                        # boolean and optional-arg long opts (--fork, --mount-proc, --kill-child, etc.)
                        --*)           (( pos++ )) ;;
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
                        --)        (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)                    (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
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
                        --)            (( pos++ )); break ;;
                        --*)           (( pos++ )) ;;
                        *)             break ;;
                    esac
                done
                ;;
            fakeroot)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[huv]*)   (( pos++ )) ;;
                        -[bils])   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[bils]=*) (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        *)         break ;;
                    esac
                done
                ;;
            unbuffer)
                (( pos++ ))
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -p ]] && (( pos++ ))
                fi
                ;;
            chronic)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[ev]*)    (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        *)         break ;;
                    esac
                done
                ;;
            torsocks)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[dhiq6]*) (( pos++ )) ;;
                        -[apPu])   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[apPu]=*) (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            proxychains4)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[q]*)     (( pos++ )) ;;
                        -[f])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[f]=*)    (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            daemonize)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[av]*)    (( pos++ )) ;;
                        -[ceElopu])  (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[ceElopu]=*) (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        *)         break ;;
                    esac
                done
                ;;
            firejail)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[c])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[c]=*)    (( pos++ )) ;;
                        --*=*)     (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        --*)       (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            sem)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[jP])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[jP]=*)   (( pos++ )) ;;
                        --*=*)     (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        --*)       (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            systemd-run)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[dGhPqrRSTtv]*) (( pos++ )) ;;
                        -[CEHMpu])   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[CEHMpu]=*) (( pos++ )) ;;
                        --*=*)       (( pos++ )) ;;
                        --)          (( pos++ )); break ;;
                        --*)         (( pos++ )) ;;
                        *)           break ;;
                    esac
                done
                ;;
            nocache)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[n])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[n]=*)    (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        *)         break ;;
                    esac
                done
                ;;
            fakechroot)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[hsv]*)   (( pos++ )) ;;
                        -[bcdel])  (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[bcdel]=*) (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        *)         break ;;
                    esac
                done
                ;;
            ccache)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[cChpsvVxz]*) (( pos++ )) ;;
                        -[dFkMoX])   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        -[dFkMoX]=*) (( pos++ )) ;;
                        *)           break ;;
                    esac
                done
                ;;
            distcc)
                (( pos++ ))
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -j ]] && (( pos++ ))
                fi
                ;;
            pkexec)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        -[u])      (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        --user)    (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        --user=*)  (( pos++ )) ;;
                        --disable-internal-agent|--keep-cwd)
                                   (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            torify)
                (( pos++ ))
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -v ]] && (( pos++ ))
                fi
                ;;
            dbus-run-session)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        --config-file|--dbus-daemon)
                                   (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;;
                        --*=*)     (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        *)         break ;;
                    esac
                done
                ;;
            dbus-launch)
                (( pos++ ))
                while (( pos <= $#words )); do
                    _zpwr_bare "$words[$pos]"
                    case $REPLY in
                        --*=*)     (( pos++ )) ;;
                        --)        (( pos++ )); break ;;
                        --*)       (( pos++ )) ;;
                        *)         break ;;
                    esac
                done
                ;;
            eatmydata)
                (( pos++ ))
                # consume optional --
                if (( pos <= $#words )); then
                    _zpwr_bare "$words[$pos]"
                    [[ $REPLY == -- ]] && (( pos++ ))
                fi
                ;;
            tsocks|catchsegv)
                (( pos++ ))
                ;;
            *)
                break
                ;;
        esac
    done

    # Build prefix string (everything consumed) and tail string (remaining words)
    if (( pos > 1 )); then
        ZPWR_VARS[cachedParserPrefix]="${words[1,pos-1]}"
    else
        ZPWR_VARS[cachedParserPrefix]=""
    fi

    if (( pos <= $#words )); then
        ZPWR_VARS[cachedRegexMatch]="${words[pos,-1]}"
        ZPWR_VARS[cachedRegexMatched]=true
    else
        # all words consumed as prefixes — still a valid parse, just no command yet
        ZPWR_VARS[cachedRegexMatch]=""
        ZPWR_VARS[cachedRegexMatched]=true
    fi

    # update ZPWR_EXPAND_WORDS_LPARTITION to have assignments stripped
    # (downstream code expects this)
    local -a cleaned=()
    for (( i = 1; i <= $#words; i++ )); do
        if ! _zpwr_is_assignment "$words[$i]"; then
            cleaned+=("$words[$i]")
        fi
    done
    ZPWR_EXPAND_WORDS_LPARTITION=("${cleaned[@]}")

    unfunction _zpwr_bare _zpwr_is_assignment 2>/dev/null
}
