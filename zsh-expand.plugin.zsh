subForAtSign=:::::---::::---:::::---

expandGlobalAliases() { lastword_lbuffer="$1"
    #expand alias
    res=${(Q)${(qqq)galiases[$lastword_lbuffer]:gs@\\@\\\\@}:gs@$@\\$@}
    res=${res//@/$subForAtSign}
    LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@$res@")"
    LBUFFER=${LBUFFER//$subForAtSign/@}
    LBUFFER=${LBUFFER:gs|\\\\|\\|}
    lenToFirstTS=${#BUFFER%%$ZPWR_TABSTOP*}
    if (( $lenToFirstTS < ${#BUFFER} )); then
        CURSOR=$lenToFirstTS
        RBUFFER=${RBUFFER:$#ZPWR_TABSTOP}
        __EXPANDED=false
    else
        __EXPANDED=true
    fi
}

declare -A ZPWR_CORRECT_WORDS
ZPWR_CORRECT_WORDS[about]="aobut"
ZPWR_CORRECT_WORDS[alternate]="alternaet alterntae"
ZPWR_CORRECT_WORDS[also]="laso alos"
ZPWR_CORRECT_WORDS[AKA]="aka"
ZPWR_CORRECT_WORDS[and]="adn nad"
ZPWR_CORRECT_WORDS[are]="aer rea"
ZPWR_CORRECT_WORDS[array]="ary arr"
ZPWR_CORRECT_WORDS[ASCII]="ascii"
ZPWR_CORRECT_WORDS[automatically]="auto"
ZPWR_CORRECT_WORDS[AWS]="aws"
ZPWR_CORRECT_WORDS[back]="bkac bakc abck"
ZPWR_CORRECT_WORDS[bad]="bda abd"
ZPWR_CORRECT_WORDS[based]="baesd absed"
ZPWR_CORRECT_WORDS[because]="bc b/c"
ZPWR_CORRECT_WORDS[best]="bets"
ZPWR_CORRECT_WORDS[between]="bt between"
ZPWR_CORRECT_WORDS[binary]="bianry bniary"
ZPWR_CORRECT_WORDS[BIOS]="bios"
ZPWR_CORRECT_WORDS[BSD]="bsd"
ZPWR_CORRECT_WORDS[by_the_way]="btw"
ZPWR_CORRECT_WORDS[block]="blokc bolck lbock"
ZPWR_CORRECT_WORDS[capture]="catpure catprue caputre"
ZPWR_CORRECT_WORDS[can_not]="cant"
ZPWR_CORRECT_WORDS[CDN]="cdn"
ZPWR_CORRECT_WORDS[CLI]="cli"
ZPWR_CORRECT_WORDS[change]="cahnge chnage changen"
ZPWR_CORRECT_WORDS[client]="cleint"
ZPWR_CORRECT_WORDS[click]="clikc clik"
ZPWR_CORRECT_WORDS[clone]="cloen"
ZPWR_CORRECT_WORDS[command]="cmd comand aommnd commnd comamnd ocmmand"
ZPWR_CORRECT_WORDS[commands]="cmds comands aommnds commnds comamnds"
ZPWR_CORRECT_WORDS[computer_science]="cs compsci"
ZPWR_CORRECT_WORDS[count]="ocunt coont"
ZPWR_CORRECT_WORDS[CPU]="cpu"
ZPWR_CORRECT_WORDS[create]="craete"
ZPWR_CORRECT_WORDS[CSS]="css"
ZPWR_CORRECT_WORDS[custom]="custmo cusotm"
ZPWR_CORRECT_WORDS[Darwin]="darwin"
ZPWR_CORRECT_WORDS[database]="db datab"
ZPWR_CORRECT_WORDS[DDL]="ddl"
ZPWR_CORRECT_WORDS[declare]="delcare declaer"
ZPWR_CORRECT_WORDS[default]="defalut deafult"
ZPWR_CORRECT_WORDS[dependencies]="deps dependenceis"
ZPWR_CORRECT_WORDS[dependency]="dep dependenc"
ZPWR_CORRECT_WORDS[developer]="dev"
ZPWR_CORRECT_WORDS[developers]="devs"
ZPWR_CORRECT_WORDS[did_not]="didt"
ZPWR_CORRECT_WORDS[directory]="dir idr direcotry direcorty directroy"
ZPWR_CORRECT_WORDS[DMA]="dma"
ZPWR_CORRECT_WORDS[DML]="dml"
ZPWR_CORRECT_WORDS[DNS]="dns"
ZPWR_CORRECT_WORDS[DQL]="dql"
ZPWR_CORRECT_WORDS[docker]="dokcer"
ZPWR_CORRECT_WORDS[does_not]="doesnt"
ZPWR_CORRECT_WORDS[do_not]="dont"
ZPWR_CORRECT_WORDS[double]="dbl"
ZPWR_CORRECT_WORDS[drag]="darg"
ZPWR_CORRECT_WORDS[drop]="dorp dorpp dropp"
ZPWR_CORRECT_WORDS[each]="eah"
ZPWR_CORRECT_WORDS[echo]="ehco eccho eho ceho ecoh eco"
ZPWR_CORRECT_WORDS[EFI]="efi"
ZPWR_CORRECT_WORDS[environment]="environ evn env"
ZPWR_CORRECT_WORDS[exit]="eixt"
ZPWR_CORRECT_WORDS[expansion]="exp"
ZPWR_CORRECT_WORDS[IEEE]="ieee"
ZPWR_CORRECT_WORDS[file]="feil fiel ifle"
ZPWR_CORRECT_WORDS[files]="ifles"
ZPWR_CORRECT_WORDS[final]="fnial fianl finl"
ZPWR_CORRECT_WORDS[finger]="fingre finegr figner"
ZPWR_CORRECT_WORDS[for]="forr forrr fro rfo rof fr ofr"
ZPWR_CORRECT_WORDS[found]="ofund fuond foudn"
ZPWR_CORRECT_WORDS[function]="fxn func fn"
ZPWR_CORRECT_WORDS[functions]="fxns funcs fns"
ZPWR_CORRECT_WORDS[go]="og"
ZPWR_CORRECT_WORDS[GPT]="gpt"
ZPWR_CORRECT_WORDS[GPU]="gpu"
ZPWR_CORRECT_WORDS[here]="ehre"
ZPWR_CORRECT_WORDS[high]="hgih hihg ihgh hi"
ZPWR_CORRECT_WORDS[H2]="h2"
ZPWR_CORRECT_WORDS[HFS]="hfs"
ZPWR_CORRECT_WORDS[HTTP]="http"
ZPWR_CORRECT_WORDS[HTML]="html"
ZPWR_CORRECT_WORDS[images]="iamges"
ZPWR_CORRECT_WORDS[implementation]="impl"
ZPWR_CORRECT_WORDS[iOS]="ios"
ZPWR_CORRECT_WORDS[iPad]="ipad"
ZPWR_CORRECT_WORDS[iPhone]="iphone"
ZPWR_CORRECT_WORDS[is]="si ise"
ZPWR_CORRECT_WORDS[inside]="insdie isndie inisde isnide sindie"
ZPWR_CORRECT_WORDS[instead]="insaed instaed"
ZPWR_CORRECT_WORDS[iSCSI]="iscsi"
ZPWR_CORRECT_WORDS[ISO]="iso"
ZPWR_CORRECT_WORDS[JavaScript]="js"
ZPWR_CORRECT_WORDS[JSON]="json"
ZPWR_CORRECT_WORDS[just]="jsut jutsi just"
ZPWR_CORRECT_WORDS[LED]="led"
ZPWR_CORRECT_WORDS[like]="liek"
ZPWR_CORRECT_WORDS[Linux]="linux"
ZPWR_CORRECT_WORDS[location]="locaiton lcoation"
ZPWR_CORRECT_WORDS[lock]="lokc lcok"
ZPWR_CORRECT_WORDS[macOS]="macos"
ZPWR_CORRECT_WORDS[MBR]="mbr"
ZPWR_CORRECT_WORDS[motherboard]="mobo"
ZPWR_CORRECT_WORDS[more]="moer"
ZPWR_CORRECT_WORDS[move]="moev"
ZPWR_CORRECT_WORDS[mount]="mounr mounf"
ZPWR_CORRECT_WORDS[MySQL]="mysql"
ZPWR_CORRECT_WORDS[namespace]="namepsace naemspace naempsace"
ZPWR_CORRECT_WORDS[night]="nite"
ZPWR_CORRECT_WORDS[NTFS]="ntfs"
ZPWR_CORRECT_WORDS[number]="numbre numebr nr"
ZPWR_CORRECT_WORDS[not]="nto tno"
ZPWR_CORRECT_WORDS[of]="fo"
ZPWR_CORRECT_WORDS[or]="ro"
ZPWR_CORRECT_WORDS[operating_system]="os"
ZPWR_CORRECT_WORDS[outside]="otuside outsdie"
ZPWR_CORRECT_WORDS[over]="voer ovre"
ZPWR_CORRECT_WORDS[other]="othe toher"
ZPWR_CORRECT_WORDS[name]="anme naem"
ZPWR_CORRECT_WORDS[network]="newtork entwork ntework"
ZPWR_CORRECT_WORDS[parameter]="parm"
ZPWR_CORRECT_WORDS[parameters]="parms"
ZPWR_CORRECT_WORDS[PATA]="pata"
ZPWR_CORRECT_WORDS[PCI]="pci"
ZPWR_CORRECT_WORDS[perl]="prel"
ZPWR_CORRECT_WORDS[PID]="pid"
ZPWR_CORRECT_WORDS[please]="plase plz"
ZPWR_CORRECT_WORDS[point]="opint ponit"
ZPWR_CORRECT_WORDS[POSIX]="posix"
ZPWR_CORRECT_WORDS[print]="pirnt pritn rpint prnit"
ZPWR_CORRECT_WORDS[probe]="porbe rpobe"
ZPWR_CORRECT_WORDS[project]="projcet proejct proeject porject"
ZPWR_CORRECT_WORDS[radius]="radisu raduis"
ZPWR_CORRECT_WORDS[range]="rnage arnge"
ZPWR_CORRECT_WORDS[RGB]="rgb"
ZPWR_CORRECT_WORDS[remote]="remoet"
ZPWR_CORRECT_WORDS[reverse]="rvs revrse"
ZPWR_CORRECT_WORDS[route]="rotue roote"
ZPWR_CORRECT_WORDS[runnning]="runnign"
ZPWR_CORRECT_WORDS[SATA]="sata"
ZPWR_CORRECT_WORDS[SCSI]="scsi"
ZPWR_CORRECT_WORDS[scope]="scoep"
ZPWR_CORRECT_WORDS[share]="sahre shre"
ZPWR_CORRECT_WORDS[shell_script]="shel"
ZPWR_CORRECT_WORDS[show]="shwo"
ZPWR_CORRECT_WORDS[single]="signle"
ZPWR_CORRECT_WORDS[some]="soem som seom"
ZPWR_CORRECT_WORDS[sound]="osund"
ZPWR_CORRECT_WORDS[spelling]="spellign spelilng"
ZPWR_CORRECT_WORDS[SQL]="sql"
ZPWR_CORRECT_WORDS[state]="staet steta sttae"
ZPWR_CORRECT_WORDS[states]="staets stetas sttaes"
ZPWR_CORRECT_WORDS[standard]="std"
ZPWR_CORRECT_WORDS[store]="tsore sotre"
ZPWR_CORRECT_WORDS[string]="stirng stinrg"
ZPWR_CORRECT_WORDS[substitute]="sub"
ZPWR_CORRECT_WORDS[SYSV]="sysv"
ZPWR_CORRECT_WORDS[than]="tahn"
ZPWR_CORRECT_WORDS[that]="taht"
ZPWR_CORRECT_WORDS[the]="teh hte eht eth te th"
ZPWR_CORRECT_WORDS[their]="thier"
ZPWR_CORRECT_WORDS[they]="tehy ethy"
ZPWR_CORRECT_WORDS[this]="tihs htis"
ZPWR_CORRECT_WORDS[then]="tehn"
ZPWR_CORRECT_WORDS[through]="thru throug"
ZPWR_CORRECT_WORDS[time]="tiem"
ZPWR_CORRECT_WORDS[true]="treu ture"
ZPWR_CORRECT_WORDS[to]="ot"
ZPWR_CORRECT_WORDS[tomorrow]="tmr"
ZPWR_CORRECT_WORDS[transfer]="xfer"
ZPWR_CORRECT_WORDS[UEFI]="uefi"
ZPWR_CORRECT_WORDS[under]="uner udner uder"
ZPWR_CORRECT_WORDS[Unix]="unix"
ZPWR_CORRECT_WORDS[URL]="url"
ZPWR_CORRECT_WORDS[URI]="uri"
ZPWR_CORRECT_WORDS[USB]="usb"
ZPWR_CORRECT_WORDS[UTF-8]="utf-8"
ZPWR_CORRECT_WORDS[use]="ues"
ZPWR_CORRECT_WORDS[using]="suing usnig"
ZPWR_CORRECT_WORDS[usually]="usu"
ZPWR_CORRECT_WORDS[value]="vlaue valeu"
ZPWR_CORRECT_WORDS[variable]="var vra"
ZPWR_CORRECT_WORDS[variables]="vars"
ZPWR_CORRECT_WORDS[version]="verssion verion verison"
ZPWR_CORRECT_WORDS[Version]="Verssion Verion Verison"
ZPWR_CORRECT_WORDS[VPN]="vpn"
ZPWR_CORRECT_WORDS[was_not]="wasnt"
ZPWR_CORRECT_WORDS[will_not]="wont"
ZPWR_CORRECT_WORDS[with]="with wiht itwh iwth wtih"
ZPWR_CORRECT_WORDS[why]="hwy wyh"
ZPWR_CORRECT_WORDS[without]="wo w/o"
ZPWR_CORRECT_WORDS[work]="wrk werk owrk wokr"
ZPWR_CORRECT_WORDS[XML]="xml"
ZPWR_CORRECT_WORDS[YAML]="yaml"


supernatural-space() {

    if [[ $ZPWR_TRACE == true ]]; then
        set -x
    fi

    local TEMP_BUFFER mywords badWords
    #TEMP_BUFFER="$(print -r -- $LBUFFER | tr -d "()[]{}\$,%'\"" )"
    #mywords=("${(z)TEMP_BUFFER}")
    finished=false

    #loop through words to get first and last words in partition
    mywordsleft=(${(z)LBUFFER})
    mywordsright=(${(z)RBUFFER})
    mywordsall=(${(z)BUFFER})
    firstIndex=0
    lastIndex=0
    for (( i = $#mywordsleft; i >= 0; i-- )); do
        case $mywordsleft[$i] in
            \; | \| | '||' | '&&')
                firstIndex=$((i+1))
                break
                ;;
            *)
                ;;
        esac
    done
    for (( i = 0; i < $#mywordsright; i++ )); do
        case $mywordsright[$i] in
            \; | \| | '||' | '&&') lastIndex=$((i-1))
                break
                ;;
            *)
                ;;
        esac
    done

    ((lastIndex+=$#mywordsleft))
    mywords_lbuffer=($mywordsleft[$firstIndex,$#mywordsleft])
    mywords_partition=($mywordsall[$firstIndex,$lastIndex])
    if [[ $ZPWR_DEBUG == true ]]; then
        logg "partition = '$mywords_lbuffer'"
    fi
    firstword_partition=${mywords_lbuffer[1]}
    lastword_lbuffer=${mywords_lbuffer[-1]}
    lastword_lbuffer=${${(Az)${mywords_lbuffer//\"/}}[-1]}
    lastword_partition=${mywords_partition[-1]}
    if [[ $ZPWR_DEBUG == true ]]; then
        logg "first word = ...$firstword_partition..."
        logg "last word lbuf = ...$lastword_lbuffer..."
        logg "last word partition = ...$lastword_partition..."
    fi
    __ALIAS=false

    lastword_noquote=${${(Az)${lastword_lbuffer//\'/}}[-1]}
    if [[ $ZPWR_DEBUG == true ]]; then
        logg "last word no quote ...${lastword_noquote}..."
    fi
    for key in ${(k)ZPWR_CORRECT_WORDS[@]}; do
        if (( ${#mywords_partition} == 1)); then
            if type -a $firstword_partition &>/dev/null; then
                break
            fi
        fi
        badWords=("${(z)ZPWR_CORRECT_WORDS[$key]}")
        for misspelling in $badWords[@];do
            if [[ ${lastword_noquote} == $misspelling ]]; then
                LBUFFER="$(print -r -- "$LBUFFER" | perl -pE \
                    "s@\\b$misspelling\\b\$@${key:gs/_/ /}@g")"
                    finished=true
                    CURSOR=$#LBUFFER
                    break
            fi
        done
        if [[ $finished == true ]];then
            zle self-insert
            return 0
        fi
    done

    __EXPANDED=true

    #dont expand =word because that is zle expand-word
    if [[ ${lastword_lbuffer:0:1} != '=' ]] && (( $#lastword_lbuffer > 0 ));then
        if alias -r -- $lastword_lbuffer | \
            command grep -Eqv '(grc|_z|zshz|cd|hub)';then
                #logg "regular=>'$lastword_lbuffer'"
                if (( $#mywords_lbuffer == 2 )); then
                    #regular alias expansion after sudo
                    if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then
                        if echo "$firstword_partition" | command grep -qE '(sudo|zpwr)';then
                            res="$(alias -r $lastword_lbuffer | cut -d= -f2-)"
                            #deal with ansi quotes $'
                            [[ $res[1] == \$ ]] && res=${res:1}
                            res=${(Q)res}
                            res=${res:gs@\\@\\\\@}
                            res=${res:gs@\\\\n@\\n@}
                            res=${res:gs@\$@\\\$@}
                            res=${res:gs|@|$(echo $subForAtSign)}
                            LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@$res@")"
                            LBUFFER=${LBUFFER:gs|$subForAtSign|@|}
                            lenToFirstTS=${#BUFFER%%$ZPWR_TABSTOP*}
                            if (( $lenToFirstTS < ${#BUFFER} )); then
                                CURSOR=$lenToFirstTS
                                RBUFFER=${RBUFFER:$#ZPWR_TABSTOP}
                                __EXPANDED=false
                            else
                                __EXPANDED=true
                            fi
                        fi
                    fi
                elif (( $#mywords_lbuffer > 2 )); then
                    #regular alias expansion after sudo -E
                    if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then
                        if echo "$firstword_partition" | command grep -qE '(sudo|zpwr)';then
                            for (( i = 2; i < $#mywords_partition; ++i )); do
                                word=${mywords_partition[$i]}
                                already_expanded=false
                                if printf "$word" | command grep -Eqv '(env|\-)'; then
                                  already_expanded=true
                                  __EXPANDED=true
                                  break
                                fi
                            done
                            if [[ $already_expanded != true ]]; then
                                res="$(alias -r $lastword_lbuffer | cut -d= -f2-)"
                                #deal with ansi quotes $'
                                [[ $res[1] == \$ ]] && res=${res:1}
                                res=${(Q)res}
                                res=${res:gs@\\@\\\\@}
                                res=${res:gs@\\\\n@\\n@}
                                res=${res:gs@\$@\\\$@}
                                res=${res:gs|@|$(echo $subForAtSign)}
                                LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@$res@")"
                                LBUFFER=${LBUFFER:gs|$subForAtSign|@|}
                                lenToFirstTS=${#BUFFER%%$ZPWR_TABSTOP*}
                                if (( $lenToFirstTS < ${#BUFFER} )); then
                                    CURSOR=$lenToFirstTS
                                    RBUFFER=${RBUFFER:$#ZPWR_TABSTOP}
                                    __EXPANDED=false
                                else
                                    __EXPANDED=true
                                fi
                            fi
                        fi
                    fi
                elif (( $#mywords_lbuffer == 1 )); then
                    #regular alias expansion
                    #remove space from menuselect spacebar
                    if [[ ${LBUFFER: -1} == " " ]]; then
                        LBUFFER="${LBUFFER:0:-1}"
                    fi
                    res="$(alias -r $lastword_lbuffer | cut -d= -f2-)"
                    #deal with ansi quotes $'
                    [[ $res[1] == \$ ]] && res=${res:1}
                    res=${(Q)res}
                    res=${res:gs@\\@\\\\@}
                    res=${res:gs@\\\\n@\\n@}
                    res=${res:gs@\$@\\\$@}
                    res=${res:gs|@|$(echo $subForAtSign)}
                    words=(${(z)res})
                    if [[ ${words[1]} == "$lastword_lbuffer" ]];then
                        LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@\\\\$res@")"
                    else
                        LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$lastword_lbuffer\$@$res@")"
                    fi
                    LBUFFER=${LBUFFER//$subForAtSign/@}
                    lenToFirstTS=${#BUFFER%%$ZPWR_TABSTOP*}
                    if (( $lenToFirstTS < ${#BUFFER} )); then
                        CURSOR=$lenToFirstTS
                        RBUFFER=${RBUFFER:$#ZPWR_TABSTOP}
                        __EXPANDED=false
                    else
                        __EXPANDED=true
                    fi
                fi
                __ALIAS=true
            else
                #remove space from menuselect spacebar
                if [[ ${LBUFFER: -1} == " " ]]; then
                    LBUFFER="${LBUFFER:0:-1}"
                fi
                if echo "$lastword_lbuffer" | command grep -Fq '"'; then
                    #expand on last word of "string" for global aliases only
                        lastword_lbuffer=${lastword_lbuffer:gs/\"//}
                        ary=(${(z)lastword_lbuffer})
                        lastword_lbuffer=$ary[-1]
                fi
                if alias -g -- $lastword_lbuffer | command grep -q "." &>/dev/null;then
                    #global alias expansion
                    #logg "global=>'$lastword_lbuffer'"
                    expandGlobalAliases "$lastword_lbuffer"
                    __ALIAS=true
                fi
        fi
        if [[ ! -f "$lastword_lbuffer" ]]; then
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
        else
            #its a file
        fi
    fi
    if [[ $__ALIAS != true ]]; then
        #expand globs, parameters and =
        zle expand-word
    fi

    if [[ $__EXPANDED == true ]];then
        #insert the space char
        if [[ $BUFFER[-1] != ' ' ]]; then
            zle self-insert
        fi
    else
        #invoke syntax highlighting
        zle self-insert
        zle backward-delete-char
    fi
    if [[ $ZPWR_TRACE == true ]]; then
        set +x
    fi
}

terminate-space(){
    LBUFFER+=" "
}

zle -N supernatural-space
zle -N terminate-space

if [[ $ZPWR_EXPAND != false ]]; then
    bindkey -M viins " " supernatural-space
    bindkey -M viins "^@" terminate-space
fi


zle -N expandGlobalAliases

bindkey '\e^E' expandGlobalAliases
