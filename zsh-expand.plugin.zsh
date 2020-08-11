#{{{                    MARK:Global variables
#**************************************************************
if ! (( $+ZPWR_VARS )); then
    declare -A ZPWR_VARS
fi

ZPWR_VARS[blacklistFirstPosRegex]='=.?(omz_history|grc|_z|zshz|cd|hub|_zsh_tmux_.*|_rails_.*|_rake_.*|mvn-or.*|gradle-or.*|noglob .*|rlwrap .*)'
ZPWR_VARS[commonRegex]='sudo|zpwr|env|.*=.*|command|builtin'
ZPWR_VARS[continueFirstPositionRegex]='\b('$ZPWR_VARS[commonRegex]')\b'
# skip options in second and onwards
ZPWR_VARS[continueSecondAndOnwardsPositionRegex]='^('$ZPWR_VARS[commonRegex]'|-.*|--)$'
ZPWR_VARS[continueOptionSpaceArgSecondAndOnwardsPositionRegex]='^(--?\S+\s+[^-]+)$'
ZPWR_VARS[foundIncorrect]=false

ZPWR_VARS[subForAtSign]=:::::---::::---:::::---

#globals
ZPWR_EXPAND_WORDS_LBUFFER=()
ZPWR_EXPAND_WORDS_PARTITION=()

declare -A ZPWR_CORRECT_WORDS
ZPWR_CORRECT_WORDS[about]="aobut abbout aabout"
ZPWR_CORRECT_WORDS[alternate]="alternaet alterntae"
ZPWR_CORRECT_WORDS[also]="laso alos alsoo allso"
ZPWR_CORRECT_WORDS[all]="alll al aall"
ZPWR_CORRECT_WORDS[AKA]="aka"
ZPWR_CORRECT_WORDS[and]="adn nad"
ZPWR_CORRECT_WORDS[ANSI]="ansi"
ZPWR_CORRECT_WORDS[are]="aer rea"
ZPWR_CORRECT_WORDS[argument]="arg rag agr"
ZPWR_CORRECT_WORDS[arguments]="args rags agrs"
ZPWR_CORRECT_WORDS[array]="arrayy ary arr aary aray arrray"
ZPWR_CORRECT_WORDS[ASCII]="ascii"
ZPWR_CORRECT_WORDS[automatically]="auto"
ZPWR_CORRECT_WORDS[AWS]="aws"
ZPWR_CORRECT_WORDS[back]="bkac bakc abck"
ZPWR_CORRECT_WORDS[background]="bg"
ZPWR_CORRECT_WORDS[bad]="bda abd"
ZPWR_CORRECT_WORDS[bandwidth]="bw"
ZPWR_CORRECT_WORDS[bash]="bahs bbash baash bassh bashh"
ZPWR_CORRECT_WORDS[based]="baesd absed"
ZPWR_CORRECT_WORDS[because]="bc b/c"
ZPWR_CORRECT_WORDS[before]="befor beforre befre beffooorr beforee b4"
ZPWR_CORRECT_WORDS[best]="bets"
ZPWR_CORRECT_WORDS[between]="bt btn between"
ZPWR_CORRECT_WORDS[binary]="bianry bniary"
ZPWR_CORRECT_WORDS[BIOS]="bios"
ZPWR_CORRECT_WORDS[BSD]="bsd"
ZPWR_CORRECT_WORDS[by_the_way]="btw"
ZPWR_CORRECT_WORDS[block]="blokc bolck lbock"
ZPWR_CORRECT_WORDS[capture]="catpure catprue caputre"
ZPWR_CORRECT_WORDS[can_not]="cant"
ZPWR_CORRECT_WORDS[case]="caes"
ZPWR_CORRECT_WORDS[CDN]="cdn"
ZPWR_CORRECT_WORDS[CLI]="cli"
ZPWR_CORRECT_WORDS[change]="cahnge chnage chagne chaeng changen"
ZPWR_CORRECT_WORDS[client]="cleint"
ZPWR_CORRECT_WORDS[click]="clikc clik"
ZPWR_CORRECT_WORDS[clone]="cloen"
ZPWR_CORRECT_WORDS[command]="cmd comand aommnd commnd comamnd ocmmand"
ZPWR_CORRECT_WORDS[commands]="cmds comands aommnds commnds comamnds ocmmands"
ZPWR_CORRECT_WORDS[computer_science]="cs compsci"
ZPWR_CORRECT_WORDS[count]="ocunt coont"
ZPWR_CORRECT_WORDS[CPU]="cpu"
ZPWR_CORRECT_WORDS[create]="ccreate craete"
ZPWR_CORRECT_WORDS[CSS]="css"
ZPWR_CORRECT_WORDS[custom]="custmo cusotm"
ZPWR_CORRECT_WORDS[Darwin]="darwin"
ZPWR_CORRECT_WORDS[database]="db datab"
ZPWR_CORRECT_WORDS[databases]="dbs databs"
ZPWR_CORRECT_WORDS[DDL]="ddl"
ZPWR_CORRECT_WORDS[declaration]="decl"
ZPWR_CORRECT_WORDS[declare]="delcare declaer"
ZPWR_CORRECT_WORDS[default]="defalut deafult"
ZPWR_CORRECT_WORDS[dependencies]="deps dependenceis"
ZPWR_CORRECT_WORDS[dependency]="dep dependenc"
ZPWR_CORRECT_WORDS[destination]="dest"
ZPWR_CORRECT_WORDS[developer]="dev"
ZPWR_CORRECT_WORDS[developers]="devs"
ZPWR_CORRECT_WORDS[did_not]="didt didnt"
ZPWR_CORRECT_WORDS[directory]="dir idr direcotry direcorty directroy"
ZPWR_CORRECT_WORDS[directories]="dirss idrs direcotries direcorties directroies dirz"
ZPWR_CORRECT_WORDS[distribution]="dist distro"
ZPWR_CORRECT_WORDS[DMA]="dma"
ZPWR_CORRECT_WORDS[DML]="dml"
ZPWR_CORRECT_WORDS[DNS]="dns"
ZPWR_CORRECT_WORDS[DQL]="dql"
ZPWR_CORRECT_WORDS[docker]="dokcer"
ZPWR_CORRECT_WORDS[documentation]="docu docs doc"
ZPWR_CORRECT_WORDS[does_not]="doesnt"
ZPWR_CORRECT_WORDS[do_not]="dont"
ZPWR_CORRECT_WORDS[double]="dbl doubel"
ZPWR_CORRECT_WORDS[drag]="darg"
ZPWR_CORRECT_WORDS[drop]="dorp dorpp dropp"
ZPWR_CORRECT_WORDS[each]="eah"
ZPWR_CORRECT_WORDS[echo]="ehco eccho eho ceho ecoh eco"
ZPWR_CORRECT_WORDS[EFI]="efi"
ZPWR_CORRECT_WORDS[end]="ned ennd endd nedd nned"
ZPWR_CORRECT_WORDS[environment]="environ evn env"
ZPWR_CORRECT_WORDS[environments]="environs evns envs"
ZPWR_CORRECT_WORDS[environment_variable]="envvar"
ZPWR_CORRECT_WORDS[environment_variables]="envvars"
ZPWR_CORRECT_WORDS[erro]="eror err errroor errror erroor erooor"
ZPWR_CORRECT_WORDS[exit]="eixt"
ZPWR_CORRECT_WORDS[expansion]="exp"
ZPWR_CORRECT_WORDS[IEEE]="ieee"
ZPWR_CORRECT_WORDS[false]="fales fals fale flase fllase falles"
ZPWR_CORRECT_WORDS[field]="fied"
ZPWR_CORRECT_WORDS[file]="feil fie fiel ifle fille fillee"
ZPWR_CORRECT_WORDS[files]="ifles fies fiess ffiess filles filees"
ZPWR_CORRECT_WORDS[final]="fnial fianl finl"
ZPWR_CORRECT_WORDS[finger]="fingre finegr figner"
ZPWR_CORRECT_WORDS[first]="firsst firstt firrst firsstt ffirrst"
ZPWR_CORRECT_WORDS[for]="forr forrr fro rfo rof fr ofr"
ZPWR_CORRECT_WORDS[foreground]="fg"
ZPWR_CORRECT_WORDS[found]="ofund fuond foudn"
ZPWR_CORRECT_WORDS[function]="fxn func fn"
ZPWR_CORRECT_WORDS[functional]="fxnal funcal fnal"
ZPWR_CORRECT_WORDS[functions]="fxns funcs fns"
ZPWR_CORRECT_WORDS[gateway]="gw"
ZPWR_CORRECT_WORDS[git]="igt ggit"
ZPWR_CORRECT_WORDS[go]="og"
ZPWR_CORRECT_WORDS[GPT]="gpt"
ZPWR_CORRECT_WORDS[GPU]="gpu"
ZPWR_CORRECT_WORDS[have_not]="havent"
ZPWR_CORRECT_WORDS[here]="ehre"
ZPWR_CORRECT_WORDS[high]="hgih hihg ihgh hi"
ZPWR_CORRECT_WORDS[hold]="hollld holld"
ZPWR_CORRECT_WORDS[H2]="h2"
ZPWR_CORRECT_WORDS[HFS]="hfs"
ZPWR_CORRECT_WORDS[HTTP]="http"
ZPWR_CORRECT_WORDS[HTTPS]="https"
ZPWR_CORRECT_WORDS[HTML]="html"
ZPWR_CORRECT_WORDS[images]="iamges"
ZPWR_CORRECT_WORDS[implementation]="impl"
ZPWR_CORRECT_WORDS[including]="incl"
ZPWR_CORRECT_WORDS[initialization]="init"
ZPWR_CORRECT_WORDS[interface]="interfaec"
ZPWR_CORRECT_WORDS[iOS]="ios"
ZPWR_CORRECT_WORDS[iPad]="ipad"
ZPWR_CORRECT_WORDS[iPhone]="iphone"
ZPWR_CORRECT_WORDS[is]="si ise isss iss iis"
ZPWR_CORRECT_WORDS[inside]="insdie isndie inisde isnide sindie"
ZPWR_CORRECT_WORDS[instead]="insaed instaed"
ZPWR_CORRECT_WORDS[iSCSI]="iscsi"
ZPWR_CORRECT_WORDS[ISO]="iso"
ZPWR_CORRECT_WORDS[JavaScript]="js"
ZPWR_CORRECT_WORDS[JSON]="json"
ZPWR_CORRECT_WORDS[just]="jsut jutsi just"
ZPWR_CORRECT_WORDS[last]="llasst lllast llast"
ZPWR_CORRECT_WORDS[layer]="lyaer layyer llayer"
ZPWR_CORRECT_WORDS[LED]="led"
ZPWR_CORRECT_WORDS[level]="lvl"
ZPWR_CORRECT_WORDS[levels]="lvls"
ZPWR_CORRECT_WORDS[library]="lib"
ZPWR_CORRECT_WORDS[libraries]="libs"
ZPWR_CORRECT_WORDS[like]="liek lik"
ZPWR_CORRECT_WORDS[Linux]="linux"
ZPWR_CORRECT_WORDS[list]="llist llistt listt"
ZPWR_CORRECT_WORDS[location]="locaiton lcoation"
ZPWR_CORRECT_WORDS[lock]="lokc lcok"
ZPWR_CORRECT_WORDS[macOS]="macos"
ZPWR_CORRECT_WORDS[make]="maek"
ZPWR_CORRECT_WORDS[MBR]="mbr"
ZPWR_CORRECT_WORDS[mobile]="mobille"
ZPWR_CORRECT_WORDS[motherboard]="mobo"
ZPWR_CORRECT_WORDS[more]="moer"
ZPWR_CORRECT_WORDS[move]="moev"
ZPWR_CORRECT_WORDS[mount]="mounr mounf"
ZPWR_CORRECT_WORDS[message]="msg"
ZPWR_CORRECT_WORDS[MySQL]="mysql"
ZPWR_CORRECT_WORDS[namespace]="namepsace naemspace naempsace"
ZPWR_CORRECT_WORDS[night]="nite"
ZPWR_CORRECT_WORDS[NTFS]="ntfs"
ZPWR_CORRECT_WORDS[number]="numbre numebr nr"
ZPWR_CORRECT_WORDS[not]="nto tno"
ZPWR_CORRECT_WORDS[of]="fo oof"
ZPWR_CORRECT_WORDS[open]="oepn ooopen oopen oppen opeen openn"
ZPWR_CORRECT_WORDS[or]="ro orr"
ZPWR_CORRECT_WORDS[operating_system]="os"
ZPWR_CORRECT_WORDS[outside]="otuside outsdie"
ZPWR_CORRECT_WORDS[over]="voer ovre"
ZPWR_CORRECT_WORDS[other]="othe toher"
ZPWR_CORRECT_WORDS[name]="anme naem"
ZPWR_CORRECT_WORDS[next]="nextt nexxt neext"
ZPWR_CORRECT_WORDS[network]="newtork entwork ntework"
ZPWR_CORRECT_WORDS[pack]="packk pacck ppack"
ZPWR_CORRECT_WORDS[parameter]="parm"
ZPWR_CORRECT_WORDS[parameters]="parms"
ZPWR_CORRECT_WORDS[PATA]="pata"
ZPWR_CORRECT_WORDS[PCI]="pci"
ZPWR_CORRECT_WORDS[perl]="prel"
ZPWR_CORRECT_WORDS[permission]="perm"
ZPWR_CORRECT_WORDS[permissions]="perms"
ZPWR_CORRECT_WORDS[PID]="pid"
ZPWR_CORRECT_WORDS[please]="plase plz"
ZPWR_CORRECT_WORDS[point]="opint ponit"
ZPWR_CORRECT_WORDS[port]="pooort poort porrt pport portt pportt"
ZPWR_CORRECT_WORDS[position]="pos"
ZPWR_CORRECT_WORDS[POSIX]="posix"
ZPWR_CORRECT_WORDS[print]="pirnt pritn rpint prnit"
ZPWR_CORRECT_WORDS[probe]="porbe rpobe"
ZPWR_CORRECT_WORDS[project]="projcet proejct proeject porject projeccct projecct porjecct"
ZPWR_CORRECT_WORDS[property]="prop"
ZPWR_CORRECT_WORDS[properties]="props"
ZPWR_CORRECT_WORDS[punctuation]="punct"
ZPWR_CORRECT_WORDS[radius]="radisu raduis"
ZPWR_CORRECT_WORDS[range]="rnage arnge"
ZPWR_CORRECT_WORDS[RGB]="rgb"
ZPWR_CORRECT_WORDS[redo]="rdeo reod edro erdo redoo reddo"
ZPWR_CORRECT_WORDS[remote]="remoet"
ZPWR_CORRECT_WORDS[replace]='replaec relpace'
ZPWR_CORRECT_WORDS[repository]="repo rpeo"
ZPWR_CORRECT_WORDS[repositories]="repos rpeos"
ZPWR_CORRECT_WORDS[result]="ZPWR_VARS[res] resullt resultt"
ZPWR_CORRECT_WORDS[reverse]="rvs revrse"
ZPWR_CORRECT_WORDS[route]="rotue roote"
ZPWR_CORRECT_WORDS[runnning]="runnign"
ZPWR_CORRECT_WORDS[same]="saem"
ZPWR_CORRECT_WORDS[SATA]="sata"
ZPWR_CORRECT_WORDS[SCSI]="scsi"
ZPWR_CORRECT_WORDS[scope]="scoep"
ZPWR_CORRECT_WORDS[search]="searcch searhc"
ZPWR_CORRECT_WORDS[sed]="esd"
ZPWR_CORRECT_WORDS[separated]="sep separaated"
ZPWR_CORRECT_WORDS[share]="sahre shre"
ZPWR_CORRECT_WORDS[shell_script]="shel"
ZPWR_CORRECT_WORDS[should_not]="shouldnt"
ZPWR_CORRECT_WORDS[show]="shwo"
ZPWR_CORRECT_WORDS[single]="signle singel"
ZPWR_CORRECT_WORDS[so]="sso"
ZPWR_CORRECT_WORDS[solution]="soln"
ZPWR_CORRECT_WORDS[solutions]="solns"
ZPWR_CORRECT_WORDS[some]="soem som seom"
ZPWR_CORRECT_WORDS[sound]="osund"
ZPWR_CORRECT_WORDS[source]="sourcce soure sourec sourrce src"
ZPWR_CORRECT_WORDS[spelling]="spellign spelilng"
ZPWR_CORRECT_WORDS[space]="spaec spacee spacce sppace spaace"
ZPWR_CORRECT_WORDS[SQL]="sql"
ZPWR_CORRECT_WORDS[SSH]="ssh"
ZPWR_CORRECT_WORDS[SSL]="ssl"
ZPWR_CORRECT_WORDS[state]="staet steta sttae"
ZPWR_CORRECT_WORDS[states]="staets stetas sttaes"
ZPWR_CORRECT_WORDS[standard]="std"
ZPWR_CORRECT_WORDS[store]="tsore sotre stoer"
ZPWR_CORRECT_WORDS[string]="stirng stinrg"
ZPWR_CORRECT_WORDS[substitute]="sub"
ZPWR_CORRECT_WORDS[sudo]="usdo usssdo usddo"
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
ZPWR_CORRECT_WORDS[TLS]="tls"
ZPWR_CORRECT_WORDS[true]="treu ture"
ZPWR_CORRECT_WORDS[turn]="tunr utrn uttrn uutrn turrn"
ZPWR_CORRECT_WORDS[to]="ot ttto tto"
ZPWR_CORRECT_WORDS[tomorrow]="tmr"
ZPWR_CORRECT_WORDS[transfer]="xfer"
ZPWR_CORRECT_WORDS[UEFI]="uefi"
ZPWR_CORRECT_WORDS[under]="uner udner uder"
ZPWR_CORRECT_WORDS[Unix]="unix"
ZPWR_CORRECT_WORDS[update]="updatet updaet upd8"
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
ZPWR_CORRECT_WORDS[vector]="vectoor"
ZPWR_CORRECT_WORDS[version]="verssion verion verison versioon"
ZPWR_CORRECT_WORDS[Version]="Verssion Verion Verison"
ZPWR_CORRECT_WORDS[vim]="ivm"
ZPWR_CORRECT_WORDS[VPN]="vpn"
ZPWR_CORRECT_WORDS[was_not]="wasnt"
ZPWR_CORRECT_WORDS[whitespace]="whitespaec whitespacee whitespacce whitesppace whitespaace"
ZPWR_CORRECT_WORDS[will_not]="wont"
ZPWR_CORRECT_WORDS[with]="with wiht itwh iwth wtih"
ZPWR_CORRECT_WORDS[would_not]="wouldnt"
ZPWR_CORRECT_WORDS[why]="hwy wyh"
ZPWR_CORRECT_WORDS[without]="wo w/o"
ZPWR_CORRECT_WORDS[work]="wrk werk owrk wokr"
ZPWR_CORRECT_WORDS[XML]="xml"
ZPWR_CORRECT_WORDS[YAML]="yaml"
ZPWR_CORRECT_WORDS[your]="yuor ur"
#}}}***********************************************************

#{{{                    MARK:accessory functions
#**************************************************************
#dummy function if plugin used outside of zpwr
if ! type -- "loggDebug" &>/dev/null;then
    function loggDebug(){
        :
    }
fi

function commonParamExpansion(){

    ZPWR_VARS[res]="$(alias -r $ZPWR_VARS[lastword_lbuffer] | cut -d= -f2-)"
    #deal with ansi quotes $'
    [[ $ZPWR_VARS[res][1] == \$ ]] && ZPWR_VARS[res]=${ZPWR_VARS[res]:1}
    ZPWR_VARS[res]=${(Q)ZPWR_VARS[res]}
    ZPWR_VARS[res]=${ZPWR_VARS[res]:gs@\\@\\\\@}
    ZPWR_VARS[res]=${ZPWR_VARS[res]:gs@\\\\n@\\n@}
    ZPWR_VARS[res]=${ZPWR_VARS[res]:gs@\$@\\\$@}
    ZPWR_VARS[res]=${ZPWR_VARS[res]:gs|@|$(echo $ZPWR_VARS[subForAtSign])}
}

function goToTabStopOrEndOfLBuffer(){

    local lenToFirstTS

    lenToFirstTS=${#LBUFFER%%$ZPWR_TABSTOP*}

    if (( $lenToFirstTS < ${#LBUFFER} )); then
        loggDebug "this is a tabstop"
        #check if numbered tabstop
        #if num tabstop then set flag in ZPWR_VARS with value to all indexes
        #sub out all num tabstops
        #insert key fn will send key to all indexes apply any modifications
        #keep track of num keys to have activated region
        ZPWR_VARS[indexTS$num]=$lenToFirstTS

        CURSOR=$lenToFirstTS
        RBUFFER=${RBUFFER:$#ZPWR_TABSTOP}
        ZPWR_VARS[__EXPANDED]=false
    else
        ZPWR_VARS[__EXPANDED]=true
    fi
}

function nonFileExpansion(){
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

function correctWord(){

    local word nextWord badWords misspelling key

    if (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]} == 1)); then
        if type -a $ZPWR_VARS[firstword_partition] &>/dev/null; then
            loggDebug "No correction from 1 word => '"'$ZPWR_VARS[firstword_partition]'"'_____ = ""'$ZPWR_VARS[firstword_partition]'"
            return
        fi
    else
        if printf -- "$ZPWR_VARS[firstword_partition]" | command grep -qsE $ZPWR_VARS[continueFirstPositionRegex];then
            for (( i = 2; i <= ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]}; ++i )); do
                word=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION][$i]}
                nextWord=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION][$i+1]}

                if printf -- "$word $nextWord" | command grep -qsE $ZPWR_VARS[continueOptionSpaceArgSecondAndOnwardsPositionRegex]; then
                    loggDebug "matched grep -Eqv '$ZPWR_VARS[continueOptionSpaceArgSecondAndOnwardsPositionRegex]' for word:'$word $nextWord'"
                    if (( (i + 1) < ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]} )); then
                        ((++i))
                        continue
                    fi
                fi

                if ((i == ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]} )); then
                    if type -a $word &>/dev/null; then
                        loggDebug "No correction from >= 2 words => '"'$word'"'_____ = ""'$word'"
                        return
                    else
                        break
                    fi
                elif ! printf -- "$word" | command grep -qsE $ZPWR_VARS[continueSecondAndOnwardsPositionRegex]; then
                        break
                fi
            done
        fi
    fi

    loggDebug "______'"'attempt correction'"'_____ = ""'$ZPWR_VARS[lastword_remove_special]'"

    for key in ${(k)ZPWR_CORRECT_WORDS[@]}; do
        badWords=("${(z)ZPWR_CORRECT_WORDS[$key]}")
        for misspelling in $badWords[@];do
            if [[ ${ZPWR_VARS[lastword_remove_special]} == $misspelling ]]; then
                LBUFFER="$(print -r -- "$LBUFFER" | perl -pE \
                    "s@\\b$misspelling\\b\$@${key:gs/_/ /}@g")"
                #ZPWR_VARS[finished]=true
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

function parseWords(){

    local i lastword_partition firstIndex lastIndex
    local -a mywordsleft mywordsright mywordsall

    #loop through words to get first and last words in partition
    mywordsleft=(${(z)LBUFFER})
    loggDebug "my words left = $mywordsleft"
    mywordsright=(${(z)RBUFFER})
    loggDebug "my words right = $mywordsright"
    mywordsall=(${(z)BUFFER})

    #we must find the first index of the partition
    firstIndex=0
    #we must find the last index of the partition
    lastIndex=0

    for (( i = $#mywordsleft; i >= 0; i-- )); do
        # ;; ; | || && are partition separating chars
        # we will split the commad line and get the partition of the caret
        # aliases are valid in the first position after these chars
        case $mywordsleft[$i] in
            ';;' | \; | \| | '||' | '&&')
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
            ';;' | \; | \| | '||' | '&&') lastIndex=$((i-1))
            break
            ;;
        *)
            ;;
        esac
    done
    loggDebug "last index = $lastIndex"

    (( lastIndex += $#mywordsleft ))


    ZPWR_EXPAND_WORDS_LBUFFER=($mywordsleft[$firstIndex,$#mywordsleft])
    ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER]=ZPWR_EXPAND_WORDS_LBUFFER

    ZPWR_EXPAND_WORDS_PARTITION=($mywordsall[$firstIndex,$lastIndex])
    ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]=ZPWR_EXPAND_WORDS_PARTITION

    loggDebug "partition = '${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER]}'"

    ZPWR_VARS[firstword_partition]=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER][1]}
    ZPWR_VARS[lastword_lbuffer]=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER][-1]}
    ZPWR_VARS[lastword_lbuffer]=${${(Az)${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER]//\"/}}[-1]}
    lastword_partition=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION][-1]}

    loggDebug "first word partition before spelling = ...$ZPWR_VARS[firstword_partition]..."
    loggDebug "last word lbuf before spelling = ...$ZPWR_VARS[lastword_lbuffer]..."
    loggDebug "last word partition before spelling = ...$lastword_partition..."

    lastword_partition=${${(Az)${ZPWR_VARS[lastword_lbuffer]//[\[\]\{\}\(\)\']/}}[-1]}
    ZPWR_VARS[lastword_remove_special]=$lastword_partition

    loggDebug "last word no special chars...${ZPWR_VARS[lastword_remove_special]}..."
}

function expandGlobalAliases() {
    ZPWR_VARS[lastword_lbuffer]="$1"
    #expand alias and escaping backslash and double quotes
    ZPWR_VARS[res]=${(Q)${(qqq)galiases[$ZPWR_VARS[lastword_lbuffer]]:gs@\\@\\\\@}:gs@$@\\$@}
    #substitute out @ because that is the substitution delimiter for perl
    ZPWR_VARS[res]=${ZPWR_VARS[res]//@/$ZPWR_VARS[subForAtSign]}
    #do the expansion with perl sub on the last word of left buffer
    LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@$ZPWR_VARS[res]@")"
    LBUFFER=${LBUFFER//$ZPWR_VARS[subForAtSign]/@}
    LBUFFER=${LBUFFER:gs|\\\\|\\|}
    goToTabStopOrEndOfLBuffer
}

#}}}***********************************************************

#{{{                    MARK:main fn
#**************************************************************
function supernatural-space() {

    if [[ $ZPWR_TRACE == true ]]; then
        set -x
    fi

    local tempBuffer mywords badWords word nextWord i stopExpansionFailedRegex aliasWasExpanded words ary
    #tempBuffer="$(print -r -- $LBUFFER | tr -d "()[]{}\$,%'\"" )"
    #mywords=("${(z)tempBuffer}")
    ZPWR_VARS[finished]=false

    parseWords

    correctWord

    if [[ $ZPWR_VARS[foundIncorrect] = true && $ZPWR_CORRECT_EXPAND = true ]]; then
        loggDebug "RE-EXPAND after incorrect spelling"
        parseWords
    fi

    ZPWR_VARS[__EXPANDED]=true
    aliasWasExpanded=false

    #dont expand =word because that is zle expand-word
    if [[ ${ZPWR_VARS[lastword_lbuffer]:0:1} != '=' ]] && (( $#ZPWR_VARS[lastword_lbuffer] > 0 ));then
        if alias -r -- $ZPWR_VARS[lastword_lbuffer] | \
        command grep -Eqv $ZPWR_VARS[blacklistFirstPosRegex];then
            loggDebug "regular=>'$ZPWR_VARS[lastword_lbuffer]'"
            if (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER]} == 2 )); then
                #regular alias expansion after sudo
                if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then
                    if printf -- "$ZPWR_VARS[firstword_partition]" | command grep -qE $ZPWR_VARS[continueFirstPositionRegex];then
                        loggDebug "matched $ZPWR_VARS[firstword_partition] with $ZPWR_VARS[continueFirstPositionRegex] with 2 == ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER]}"
                        commonParamExpansion
                    #do the expansion with perl sub on the last word of left buffer
                        LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@$ZPWR_VARS[res]@")"
                        LBUFFER=${LBUFFER:gs|$ZPWR_VARS[subForAtSign]|@|}
                        goToTabStopOrEndOfLBuffer
                    fi
                fi
            elif (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER]} > 2 )); then
                #regular alias expansion after sudo -E or sudo env or sudo env -e or sudo -E env -e -a -f etc
                if [[ $ZPWR_EXPAND_SECOND_POSITION == true ]]; then
                    if printf -- "$ZPWR_VARS[firstword_partition]" | command grep -qsE $ZPWR_VARS[continueFirstPositionRegex];then
                        loggDebug "matched $ZPWR_VARS[firstword_partition] with $ZPWR_VARS[continueFirstPositionRegex] with $#ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER] > 2"
                        for (( i = 2; i < ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]}; ++i )); do
                            # zsh only supports nested arrays with indirection
                            word=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION][$i]}
                            # zsh only supports nested arrays with indirection
                            nextWord=${(P)ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION][$i+1]}
                            stopExpansionFailedRegex=false

                            if (( (i + 1) < ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_PARTITION]} )); then
                                if printf -- "$word $nextWord" | command grep -qsE $ZPWR_VARS[continueOptionSpaceArgSecondAndOnwardsPositionRegex]; then
                                    loggDebug "matched grep -Eqv '$ZPWR_VARS[continueOptionSpaceArgSecondAndOnwardsPositionRegex]' for word:'$word $nextWord'"
                                    ((++i))
                                    continue
                                fi
                            fi

                            if ! printf -- "$word" | command grep -qsE $ZPWR_VARS[continueSecondAndOnwardsPositionRegex]; then
                                stopExpansionFailedRegex=true
                                ZPWR_VARS[__EXPANDED]=true
                                loggDebug "failed grep -Eqv '$ZPWR_VARS[continueSecondAndOnwardsPositionRegex]' for word:'$word'"
                                break
                            fi
                        done
                        if [[ $stopExpansionFailedRegex == false ]]; then
                            commonParamExpansion
                        #do the expansion with perl sub on the last word of left buffer
                            LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@$ZPWR_VARS[res]@")"
                            LBUFFER=${LBUFFER:gs|$ZPWR_VARS[subForAtSign]|@|}
                            goToTabStopOrEndOfLBuffer
                        else
                            loggDebug "not expanding $ZPWR_VARS[lastword_lbuffer] with 1st pos:$ZPWR_VARS[continueFirstPositionRegex] and 2nd pos:$ZPWR_VARS[continueSecondAndOnwardsPositionRegex]"
                        fi
                    fi
                fi
            elif (( ${(P)#ZPWR_VARS[ZPWR_EXPAND_WORDS_LBUFFER]} == 1 )); then
                #regular alias expansion
                #remove space from menuselect spacebar
                if [[ ${LBUFFER: -1} == " " ]]; then
                    LBUFFER="${LBUFFER:0:-1}"
                fi
                commonParamExpansion
                words=(${(z)ZPWR_VARS[res]})
                if [[ ${words[1]} == "$ZPWR_VARS[lastword_lbuffer]" ]];then
                        #do the expansion with perl sub on the last word of left buffer
                    LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@\\\\$ZPWR_VARS[res]@")"
                else
                        #do the expansion with perl sub on the last word of left buffer
                    LBUFFER="$(print -r -- "$LBUFFER" | perl -pE "s@\\b$ZPWR_VARS[lastword_lbuffer]\$@$ZPWR_VARS[res]@")"
                fi
                LBUFFER=${LBUFFER//$ZPWR_VARS[subForAtSign]/@}
                goToTabStopOrEndOfLBuffer
            fi
            aliasWasExpanded=true
        else
            loggDebug "NOT regular=>'$ZPWR_VARS[lastword_lbuffer]'"
            #remove space from menuselect spacebar
            if [[ ${LBUFFER: -1} == " " && ZPWR_VARS[__EXPANDED] == true ]]; then
                loggDebug "removing space menu select"
                LBUFFER="${LBUFFER:0:-1}"
            fi
            if echo "$ZPWR_VARS[lastword_lbuffer]" | command grep -Fq '"'; then
                #expand on last word of "string" for global aliases only
                    ZPWR_VARS[lastword_lbuffer]=${ZPWR_VARS[lastword_lbuffer]:gs/\"//}
                    ary=(${(z)ZPWR_VARS[lastword_lbuffer]})
                    ZPWR_VARS[lastword_lbuffer]=$ary[-1]
            fi
            if alias -g -- $ZPWR_VARS[lastword_lbuffer] | command grep -q "." &>/dev/null;then
                #global alias expansion
                if [[ ${LBUFFER: -1} == " " ]]; then
                    loggDebug "removing space global alias menu select"
                    LBUFFER="${LBUFFER:0:-1}"
                fi
                loggDebug "global=>'$ZPWR_VARS[lastword_lbuffer]'"
                expandGlobalAliases "$ZPWR_VARS[lastword_lbuffer]"
                aliasWasExpanded=true
            fi
        fi
        if [[ ! -f "$ZPWR_VARS[lastword_lbuffer]" ]]; then
            nonFileExpansion
        else
            :
        fi
    fi
    if [[ $aliasWasExpanded != true ]]; then
        #expand globs, parameters and =
        zle expand-word
    fi

    loggDebug "ZPWR_VARS[__EXPANDED] = $ZPWR_VARS[__EXPANDED]"
    loggDebug "aliasWasExpanded = $aliasWasExpanded"

    if [[ $ZPWR_VARS[__EXPANDED] == true ]];then
        #insert the space char
        if [[ $LBUFFER[-1] != ' ' ]]; then
            zle self-insert
        else
            if [[ $aliasWasExpanded != true ]]; then
                zle self-insert
            fi
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
#}}}***********************************************************

#{{{                    MARK:keybind
#**************************************************************
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
#}}}***********************************************************
