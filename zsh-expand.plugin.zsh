#!/usr/bin/env zsh
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Date: Tue Aug 11 13:59:02 EDT 2020
##### Purpose: zsh script to parse words and expand words
##### Notes:
#}}}***********************************************************

#{{{                    MARK:Global variables
#**************************************************************
#
# According to the standard:
# http://zdharma.org/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if ! (( $+ZPWR_VARS )) || [[ ${parameters[ZPWR_VARS]} != association ]]; then
    # global map to containerize global variables
    typeset -gA ZPWR_VARS
fi

ZPWR_VARS[ENTER_KEY]='ENTER'
ZPWR_VARS[SPACEBAR_KEY]='SPACE'

if ! (( $+ZPWR_TABSTOP )) || [[ ${parameters[ZPWR_TABSTOP]} != scalar-export ]]; ; then
    export ZPWR_TABSTOP=__________
fi

autoload regexp-replace
setopt extendedglob
setopt rcquotes

ZPWR_VARS[EXPAND_API]=${0:A:h}/zpwrExpandApi.zsh
ZPWR_VARS[EXPAND_LIB]=${0:A:h}/zpwrExpandLib.zsh

if ! source $ZPWR_VARS[EXPAND_API];then
    echo "failed source ZPWR_VARS[EXPAND_API] $ZPWR_VARS[EXPAND_API]" >&2
    return 1
fi

if ! source $ZPWR_VARS[EXPAND_LIB];then
    echo "failed source ZPWR_VARS[EXPAND_LIB] $ZPWR_VARS[EXPAND_LIB]" >&2
    return 1
fi


#{{{                    MARK:regex
#**************************************************************
ZPWR_VARS[builtinSkips]='(builtin|command|exec|eval|noglob|-)'

ZPWR_VARS[blacklistUser]=""
if (( $#ZPWR_EXPAND_BLACKLIST )); then
    ZPWR_VARS[blacklistUser]="^(${(j:|:)ZPWR_EXPAND_BLACKLIST})$"
fi

(){
    local ws='[:space:]'
    local l='[:graph:]'
    ZPWR_VARS[startQuoteRegex]='(\$''|[\\"''])*'
    ZPWR_VARS[endQuoteRegex]='["'']*'
    local sq=${ZPWR_VARS[startQuoteRegex]}
    local eq=${ZPWR_VARS[endQuoteRegex]}

    ZPWR_VARS[blacklistFirstPosRegex]='^(omz_history|grc|_z|zshz|cd|hub|_zsh_tmux_|_rails_|_rake_|mvn-or|gradle-or|noglob |rlwrap ).*$'

    ZPWR_VARS[blacklistSubcommandPositionRegex]='^(cargo|jenv|svn|git|ng|pod|docker|kubectl|rndc|yarn|npm|pip[0-9\.]*|bundle|rails|gem|nmcli|brew|apt|dnf|yum|zypper|pacman|service|proxychains[0-9\.]*|zpwr|zm|zd|zg|zinit)$'
    # the main regex to match x=1 \builtin* 'command'* '"sudo"' -* y=2 \env* -* z=3 cmd arg1 arg2 etc

    ZPWR_VARS[continueFirstPositionRegexNoZpwr]="^([$ws]*)((${sq}(-|nocorrect|time)${eq}[$ws]+)*(${sq}builtin${eq}[$ws]+)*(${sq}${ZPWR_VARS[builtinSkips]}${eq}[$ws]+)*)?(${sq}[sS][uU][dD][oO]${eq}([$ws]+)(${sq}(-[ABbEHnPSis]+${eq}[$ws]*|-[CghpTu][$ws=]+[$l]*${eq}[$ws]+|--${eq})*)*|${sq}[eE][nN][vV]${eq}[$ws]+(${sq}-[iv]+${eq}[$ws]*|-[PSu][$ws=]+[$l]*${eq}[$ws]+|--${eq})*|${sq}([nN][iI][cC][eE]|[tT][iI][mM][eE]|[nN][oO][hH][uU][pP]|[rR][lL][wW][rR][aA][pP])${eq}[$ws]+)*([$ws]*)(.*)$"
}



#}}}***********************************************************

typeset -Ag ZPWR_EXPAND_CORRECT_WORDS
ZPWR_EXPAND_CORRECT_WORDS[about]="aobut abbout aabout"
ZPWR_EXPAND_CORRECT_WORDS[alternate]="alternaet alterntae"
ZPWR_EXPAND_CORRECT_WORDS[also]="laso alos alsoo allso"
ZPWR_EXPAND_CORRECT_WORDS[all]="alll al aall"
ZPWR_EXPAND_CORRECT_WORDS[AKA]="aka"
ZPWR_EXPAND_CORRECT_WORDS[and]="adn nad"
ZPWR_EXPAND_CORRECT_WORDS[ANSI]="ansi"
ZPWR_EXPAND_CORRECT_WORDS[are]="aer rea"
ZPWR_EXPAND_CORRECT_WORDS[argument]="arg rag agr"
ZPWR_EXPAND_CORRECT_WORDS[arguments]="args rags agrs"
ZPWR_EXPAND_CORRECT_WORDS[array]="arrayy ary arr aary aray arrray"
ZPWR_EXPAND_CORRECT_WORDS[ASCII]="ascii"
ZPWR_EXPAND_CORRECT_WORDS[automatically]="auto"
ZPWR_EXPAND_CORRECT_WORDS[AWS]="aws"
ZPWR_EXPAND_CORRECT_WORDS[back]="bkac bakc abck"
ZPWR_EXPAND_CORRECT_WORDS[background]="bg"
ZPWR_EXPAND_CORRECT_WORDS[bad]="bda abd"
ZPWR_EXPAND_CORRECT_WORDS[bandwidth]="bw"
ZPWR_EXPAND_CORRECT_WORDS[bash]="bahs bbash baash bassh bashh"
ZPWR_EXPAND_CORRECT_WORDS[based]="baesd absed"
ZPWR_EXPAND_CORRECT_WORDS[because]="bc b/c"
ZPWR_EXPAND_CORRECT_WORDS[before]="befor beforre befre beffooorr beforee b4"
ZPWR_EXPAND_CORRECT_WORDS[best]="bets"
ZPWR_EXPAND_CORRECT_WORDS[between]="bt btn between"
ZPWR_EXPAND_CORRECT_WORDS[binary]="bianry bniary"
ZPWR_EXPAND_CORRECT_WORDS[BIOS]="bios"
ZPWR_EXPAND_CORRECT_WORDS[BSD]="bsd"
ZPWR_EXPAND_CORRECT_WORDS[by_the_way]="btw"
ZPWR_EXPAND_CORRECT_WORDS[block]="blokc bolck lbock"
ZPWR_EXPAND_CORRECT_WORDS[brew]="berw brerw berww brrerw breww bbrrew brrew"
ZPWR_EXPAND_CORRECT_WORDS[capture]="catpure catprue caputre"
ZPWR_EXPAND_CORRECT_WORDS[can_not]="cant"
ZPWR_EXPAND_CORRECT_WORDS[case]="caes"
ZPWR_EXPAND_CORRECT_WORDS[CDN]="cdn"
ZPWR_EXPAND_CORRECT_WORDS[CLI]="cli"
ZPWR_EXPAND_CORRECT_WORDS[change]="cahnge chnage chagne chaeng changen"
ZPWR_EXPAND_CORRECT_WORDS[client]="cleint"
ZPWR_EXPAND_CORRECT_WORDS[click]="clikc clik"
ZPWR_EXPAND_CORRECT_WORDS[clone]="cloen"
ZPWR_EXPAND_CORRECT_WORDS[close]="cloes"
ZPWR_EXPAND_CORRECT_WORDS[command]="cmd comand aommnd commnd comamnd ocmmand"
ZPWR_EXPAND_CORRECT_WORDS[commands]="cmds comands aommnds commnds comamnds ocmmands"
ZPWR_EXPAND_CORRECT_WORDS[computer_science]="cs compsci"
ZPWR_EXPAND_CORRECT_WORDS[count]="ocunt coont"
ZPWR_EXPAND_CORRECT_WORDS[CPU]="cpu"
ZPWR_EXPAND_CORRECT_WORDS[create]="ccreate craete"
ZPWR_EXPAND_CORRECT_WORDS[CSS]="css"
ZPWR_EXPAND_CORRECT_WORDS[custom]="custmo cusotm"
ZPWR_EXPAND_CORRECT_WORDS[Darwin]="darwin"
ZPWR_EXPAND_CORRECT_WORDS[database]="db datab"
ZPWR_EXPAND_CORRECT_WORDS[databases]="dbs databs"
ZPWR_EXPAND_CORRECT_WORDS[DDL]="ddl"
ZPWR_EXPAND_CORRECT_WORDS[declaration]="decl"
ZPWR_EXPAND_CORRECT_WORDS[declare]="delcare declaer"
ZPWR_EXPAND_CORRECT_WORDS[default]="defalut deafult"
ZPWR_EXPAND_CORRECT_WORDS[dependencies]="deps dependenceis"
ZPWR_EXPAND_CORRECT_WORDS[dependency]="dep dependenc"
ZPWR_EXPAND_CORRECT_WORDS[delay]="dly"
ZPWR_EXPAND_CORRECT_WORDS[destination]="dest"
ZPWR_EXPAND_CORRECT_WORDS[developer]="deve"
ZPWR_EXPAND_CORRECT_WORDS[developers]="devs"
ZPWR_EXPAND_CORRECT_WORDS[did_not]="didt didnt"
ZPWR_EXPAND_CORRECT_WORDS[directory]="dir ddir idr direcotry direcorty directroy"
ZPWR_EXPAND_CORRECT_WORDS[directories]="dirss ddirs dirs idrs direcotries direcorties directroies dirz"
ZPWR_EXPAND_CORRECT_WORDS[distribution]="dist distro"
ZPWR_EXPAND_CORRECT_WORDS[DMA]="dma"
ZPWR_EXPAND_CORRECT_WORDS[DML]="dml"
ZPWR_EXPAND_CORRECT_WORDS[DNS]="dns"
ZPWR_EXPAND_CORRECT_WORDS[DQL]="dql"
ZPWR_EXPAND_CORRECT_WORDS[docker]="dokcer"
ZPWR_EXPAND_CORRECT_WORDS[documentation]="docu docs doc"
ZPWR_EXPAND_CORRECT_WORDS[does_not]="doesnt"
ZPWR_EXPAND_CORRECT_WORDS[do_not]="dont"
ZPWR_EXPAND_CORRECT_WORDS[double]="dbl doubel"
ZPWR_EXPAND_CORRECT_WORDS[drag]="darg"
ZPWR_EXPAND_CORRECT_WORDS[drop]="dorp dorpp dropp"
ZPWR_EXPAND_CORRECT_WORDS[during]="durring durriing durrring durinng duringg durinng duurig durign durrgn"
ZPWR_EXPAND_CORRECT_WORDS[each]="eah"
ZPWR_EXPAND_CORRECT_WORDS[echo]="ehco eo eccho eho ceho ecoh eco"
ZPWR_EXPAND_CORRECT_WORDS[EFI]="efi"
ZPWR_EXPAND_CORRECT_WORDS[end]="ned ennd endd nedd nned"
ZPWR_EXPAND_CORRECT_WORDS[environment]="environ evn env"
ZPWR_EXPAND_CORRECT_WORDS[environments]="environs evns envs"
ZPWR_EXPAND_CORRECT_WORDS[environment_variable]="envvar ev"
ZPWR_EXPAND_CORRECT_WORDS[environment_variables]="envvars evs"
ZPWR_EXPAND_CORRECT_WORDS[error]="eror err errroor errror erroor erooor"
ZPWR_EXPAND_CORRECT_WORDS[exit]="eixt"
ZPWR_EXPAND_CORRECT_WORDS[expansion]="exp"
ZPWR_EXPAND_CORRECT_WORDS[IEEE]="ieee"
ZPWR_EXPAND_CORRECT_WORDS[false]="fales fals fale flase fllase falles"
ZPWR_EXPAND_CORRECT_WORDS[field]="fied"
ZPWR_EXPAND_CORRECT_WORDS[file]="feil fie fiel ifle fille fillee"
ZPWR_EXPAND_CORRECT_WORDS[files]="ifles fies fiess ffiess filles filees"
ZPWR_EXPAND_CORRECT_WORDS[final]="fnial fianl finl"
ZPWR_EXPAND_CORRECT_WORDS[finger]="fingre finegr figner"
ZPWR_EXPAND_CORRECT_WORDS[first]="firsst firstt firrst firsstt ffirrst"
ZPWR_EXPAND_CORRECT_WORDS[for]="forr forrr fro rfo rof fr ofr"
ZPWR_EXPAND_CORRECT_WORDS[foreground]="fg"
ZPWR_EXPAND_CORRECT_WORDS[found]="ofund fuond foudn"
ZPWR_EXPAND_CORRECT_WORDS[function]="fxn func fn"
ZPWR_EXPAND_CORRECT_WORDS[functional]="fxnal funcal fnal"
ZPWR_EXPAND_CORRECT_WORDS[functions]="fxns funcs fns"
ZPWR_EXPAND_CORRECT_WORDS[gateway]="gw"
ZPWR_EXPAND_CORRECT_WORDS[git]="igt ggit"
ZPWR_EXPAND_CORRECT_WORDS[go]="og"
ZPWR_EXPAND_CORRECT_WORDS[GPT]="gpt"
ZPWR_EXPAND_CORRECT_WORDS[GPU]="gpu"
ZPWR_EXPAND_CORRECT_WORDS[group]="gorup groop gourp grp"
ZPWR_EXPAND_CORRECT_WORDS[has_not]="hasnt"
ZPWR_EXPAND_CORRECT_WORDS[have_not]="havent"
ZPWR_EXPAND_CORRECT_WORDS[here]="ehre"
ZPWR_EXPAND_CORRECT_WORDS[high]="hgih hihg ihgh hi"
ZPWR_EXPAND_CORRECT_WORDS[hold]="hollld holld"
ZPWR_EXPAND_CORRECT_WORDS[H2]="h2"
ZPWR_EXPAND_CORRECT_WORDS[HFS]="hfs"
ZPWR_EXPAND_CORRECT_WORDS[HTTP]="http"
ZPWR_EXPAND_CORRECT_WORDS[HTTPS]="https"
ZPWR_EXPAND_CORRECT_WORDS[HTML]="html"
ZPWR_EXPAND_CORRECT_WORDS[images]="iamges"
ZPWR_EXPAND_CORRECT_WORDS[implementation]="impl"
ZPWR_EXPAND_CORRECT_WORDS[including]="incl"
ZPWR_EXPAND_CORRECT_WORDS[initialization]="init"
ZPWR_EXPAND_CORRECT_WORDS[interface]="interfaec"
ZPWR_EXPAND_CORRECT_WORDS[iOS]="ios"
ZPWR_EXPAND_CORRECT_WORDS[iPad]="ipad"
ZPWR_EXPAND_CORRECT_WORDS[iPhone]="iphone"
ZPWR_EXPAND_CORRECT_WORDS[is]="si ise isss iss iis"
ZPWR_EXPAND_CORRECT_WORDS[is_not]="isnt sint"
ZPWR_EXPAND_CORRECT_WORDS[inside]="insdie isndie inisde isnide sindie"
ZPWR_EXPAND_CORRECT_WORDS[instead]="insaed instaed"
ZPWR_EXPAND_CORRECT_WORDS[iSCSI]="iscsi"
ZPWR_EXPAND_CORRECT_WORDS[ISO]="iso"
ZPWR_EXPAND_CORRECT_WORDS[JavaScript]="js"
ZPWR_EXPAND_CORRECT_WORDS[JSON]="josn json"
ZPWR_EXPAND_CORRECT_WORDS[just]="jsut jutsi just"
ZPWR_EXPAND_CORRECT_WORDS[last]="llasst lllast llast"
ZPWR_EXPAND_CORRECT_WORDS[LaTeX]="latex"
ZPWR_EXPAND_CORRECT_WORDS[layer]="lyaer layyer llayer"
ZPWR_EXPAND_CORRECT_WORDS[LED]="led"
ZPWR_EXPAND_CORRECT_WORDS[level]="lvl"
ZPWR_EXPAND_CORRECT_WORDS[levels]="lvls"
ZPWR_EXPAND_CORRECT_WORDS[library]="lib"
ZPWR_EXPAND_CORRECT_WORDS[libraries]="libs"
ZPWR_EXPAND_CORRECT_WORDS[like]="liek lik"
ZPWR_EXPAND_CORRECT_WORDS[link]="llink linnk linkk"
ZPWR_EXPAND_CORRECT_WORDS[Linux]="linux"
ZPWR_EXPAND_CORRECT_WORDS[list]="llist llistt listt"
ZPWR_EXPAND_CORRECT_WORDS[location]="locaiton lcoation"
ZPWR_EXPAND_CORRECT_WORDS[lock]="lokc lcok"
ZPWR_EXPAND_CORRECT_WORDS[macOS]="macos"
ZPWR_EXPAND_CORRECT_WORDS[make]="maek"
ZPWR_EXPAND_CORRECT_WORDS[MBR]="mbr"
ZPWR_EXPAND_CORRECT_WORDS[mobile]="mobille"
ZPWR_EXPAND_CORRECT_WORDS[motherboard]="mobo"
ZPWR_EXPAND_CORRECT_WORDS[more]="moer"
ZPWR_EXPAND_CORRECT_WORDS[move]="moev"
ZPWR_EXPAND_CORRECT_WORDS[mount]="mounr mounf"
ZPWR_EXPAND_CORRECT_WORDS[message]="msg"
ZPWR_EXPAND_CORRECT_WORDS[messages]="msgs"
ZPWR_EXPAND_CORRECT_WORDS[MIDI]="midi"
ZPWR_EXPAND_CORRECT_WORDS[MySQL]="mysql"
ZPWR_EXPAND_CORRECT_WORDS[namespace]="namepsace naemspace naempsace"
ZPWR_EXPAND_CORRECT_WORDS[night]="nite"
ZPWR_EXPAND_CORRECT_WORDS[NTFS]="ntfs"
ZPWR_EXPAND_CORRECT_WORDS[number]="numbre numebr nr"
ZPWR_EXPAND_CORRECT_WORDS[not]="nto tno"
ZPWR_EXPAND_CORRECT_WORDS[of]="fo oof"
ZPWR_EXPAND_CORRECT_WORDS[open]="oepn ooopen oopen oppen opeen openn"
ZPWR_EXPAND_CORRECT_WORDS[or]="ro orr"
ZPWR_EXPAND_CORRECT_WORDS[operating_system]="os"
ZPWR_EXPAND_CORRECT_WORDS[outside]="otuside outsdie"
ZPWR_EXPAND_CORRECT_WORDS[over]="voer ovre"
ZPWR_EXPAND_CORRECT_WORDS[other]="othe toher"
ZPWR_EXPAND_CORRECT_WORDS[name]="anme naem"
ZPWR_EXPAND_CORRECT_WORDS[next]="nextt nexxt neext"
ZPWR_EXPAND_CORRECT_WORDS[network]="newtork entwork ntework"
ZPWR_EXPAND_CORRECT_WORDS[pack]="packk pacck ppack"
ZPWR_EXPAND_CORRECT_WORDS[parameter]="parm"
ZPWR_EXPAND_CORRECT_WORDS[parameters]="parms"
ZPWR_EXPAND_CORRECT_WORDS[PATA]="pata"
ZPWR_EXPAND_CORRECT_WORDS[PCI]="pci"
ZPWR_EXPAND_CORRECT_WORDS[perl]="prel"
ZPWR_EXPAND_CORRECT_WORDS[permission]="perm"
ZPWR_EXPAND_CORRECT_WORDS[permissions]="perms"
ZPWR_EXPAND_CORRECT_WORDS[phase]="phaes phae phasee pahes phasse"
ZPWR_EXPAND_CORRECT_WORDS[PID]="pid"
ZPWR_EXPAND_CORRECT_WORDS[please]="plase plz"
ZPWR_EXPAND_CORRECT_WORDS[point]="opint ponit"
ZPWR_EXPAND_CORRECT_WORDS[port]="pooort poort porrt pport portt pportt"
ZPWR_EXPAND_CORRECT_WORDS[position]="pos"
ZPWR_EXPAND_CORRECT_WORDS[POSIX]="posix"
ZPWR_EXPAND_CORRECT_WORDS[print]="pirnt pritn rpint prnit"
ZPWR_EXPAND_CORRECT_WORDS[probe]="porbe rpobe"
ZPWR_EXPAND_CORRECT_WORDS[project]="projcet proejct proeject porject projeccct projecct porjecct"
ZPWR_EXPAND_CORRECT_WORDS[property]="prop"
ZPWR_EXPAND_CORRECT_WORDS[properties]="props"
ZPWR_EXPAND_CORRECT_WORDS[proxy]="rpoxy poxy proxyy proxxy rrpoxy"
ZPWR_EXPAND_CORRECT_WORDS[punctuation]="punct"
ZPWR_EXPAND_CORRECT_WORDS[radius]="radisu raduis"
ZPWR_EXPAND_CORRECT_WORDS[range]="rnage arnge"
ZPWR_EXPAND_CORRECT_WORDS[RGB]="rgb"
ZPWR_EXPAND_CORRECT_WORDS[README]="eradme readme"
ZPWR_EXPAND_CORRECT_WORDS[redo]="rdeo reod edro erdo redoo reddo"
ZPWR_EXPAND_CORRECT_WORDS[remote]="remoet"
ZPWR_EXPAND_CORRECT_WORDS[replace]='replaec relpace'
ZPWR_EXPAND_CORRECT_WORDS[repository]="repo rpeo"
ZPWR_EXPAND_CORRECT_WORDS[repositories]="repos rpeos"
ZPWR_EXPAND_CORRECT_WORDS[result]="res resullt resultt"
ZPWR_EXPAND_CORRECT_WORDS[reverse]="rvs revrse"
ZPWR_EXPAND_CORRECT_WORDS[reverb]="rvb"
ZPWR_EXPAND_CORRECT_WORDS[route]="rotue roote"
ZPWR_EXPAND_CORRECT_WORDS[runnning]="runnign"
ZPWR_EXPAND_CORRECT_WORDS[same]="saem"
ZPWR_EXPAND_CORRECT_WORDS[SATA]="sata"
ZPWR_EXPAND_CORRECT_WORDS[SCSI]="scsi"
ZPWR_EXPAND_CORRECT_WORDS[scope]="scoep"
ZPWR_EXPAND_CORRECT_WORDS[search]="searcch searhc"
ZPWR_EXPAND_CORRECT_WORDS[sed]="esd"
ZPWR_EXPAND_CORRECT_WORDS[set]="est esst ste"
ZPWR_EXPAND_CORRECT_WORDS[separated]="sep separaated"
ZPWR_EXPAND_CORRECT_WORDS[share]="sahre shre"
ZPWR_EXPAND_CORRECT_WORDS[shell_script]="shel"
ZPWR_EXPAND_CORRECT_WORDS[should_not]="shouldnt"
ZPWR_EXPAND_CORRECT_WORDS[show]="shwo"
ZPWR_EXPAND_CORRECT_WORDS[single]="signle singel"
ZPWR_EXPAND_CORRECT_WORDS[so]="sso"
ZPWR_EXPAND_CORRECT_WORDS[solution]="soln"
ZPWR_EXPAND_CORRECT_WORDS[solutions]="solns"
ZPWR_EXPAND_CORRECT_WORDS[some]="soem som seom"
ZPWR_EXPAND_CORRECT_WORDS[sound]="osund"
ZPWR_EXPAND_CORRECT_WORDS[source]="sourcce soure sourec sourrce src"
ZPWR_EXPAND_CORRECT_WORDS[spelling]="spellign spelilng"
ZPWR_EXPAND_CORRECT_WORDS[space]="spaec spacee spacce sppace spaace"
ZPWR_EXPAND_CORRECT_WORDS[SQL]="sql"
ZPWR_EXPAND_CORRECT_WORDS[SSH]="ssh"
ZPWR_EXPAND_CORRECT_WORDS[SSL]="ssl"
ZPWR_EXPAND_CORRECT_WORDS[straight]="st8 strraight tsriaght tsrraight sstrraight straightt"
ZPWR_EXPAND_CORRECT_WORDS[state]="staet steta sttae"
ZPWR_EXPAND_CORRECT_WORDS[states]="staets stetas sttaes"
ZPWR_EXPAND_CORRECT_WORDS[standard]="std"
ZPWR_EXPAND_CORRECT_WORDS[store]="tsore sotre stoer"
ZPWR_EXPAND_CORRECT_WORDS[string]="stirng stinrg"
ZPWR_EXPAND_CORRECT_WORDS[substitute]="sub"
ZPWR_EXPAND_CORRECT_WORDS[sudo]="usdo usssdo usddo"
ZPWR_EXPAND_CORRECT_WORDS[SYSV]="sysv"
ZPWR_EXPAND_CORRECT_WORDS[than]="tahn"
ZPWR_EXPAND_CORRECT_WORDS[that]="taht"
ZPWR_EXPAND_CORRECT_WORDS[the]="teh hte eht eth te th"
ZPWR_EXPAND_CORRECT_WORDS[their]="thier"
ZPWR_EXPAND_CORRECT_WORDS[they]="tehy ethy"
ZPWR_EXPAND_CORRECT_WORDS[this]="tihs htis"
ZPWR_EXPAND_CORRECT_WORDS[then]="tehn"
ZPWR_EXPAND_CORRECT_WORDS[through]="thru throug"
ZPWR_EXPAND_CORRECT_WORDS[time]="tiem"
ZPWR_EXPAND_CORRECT_WORDS[TLS]="tls"
ZPWR_EXPAND_CORRECT_WORDS[true]="treu ture"
ZPWR_EXPAND_CORRECT_WORDS[turn]="tunr utrn uttrn uutrn turrn"
ZPWR_EXPAND_CORRECT_WORDS[to]="ot ttto tto"
ZPWR_EXPAND_CORRECT_WORDS[tomorrow]="tmr"
ZPWR_EXPAND_CORRECT_WORDS[transfer]="xfer"
ZPWR_EXPAND_CORRECT_WORDS[UEFI]="uefi"
ZPWR_EXPAND_CORRECT_WORDS[under]="uner udner uder"
ZPWR_EXPAND_CORRECT_WORDS[Unix]="unix"
ZPWR_EXPAND_CORRECT_WORDS[update]="updatet updaet upd8"
ZPWR_EXPAND_CORRECT_WORDS[URL]="url"
ZPWR_EXPAND_CORRECT_WORDS[URI]="uri"
ZPWR_EXPAND_CORRECT_WORDS[USB]="usb"
ZPWR_EXPAND_CORRECT_WORDS[UTF-8]="utf-8"
ZPWR_EXPAND_CORRECT_WORDS[use]="ues"
ZPWR_EXPAND_CORRECT_WORDS[using]="suing usnig"
ZPWR_EXPAND_CORRECT_WORDS[usually]="usu"
ZPWR_EXPAND_CORRECT_WORDS[value]="vlaue valeu"
ZPWR_EXPAND_CORRECT_WORDS[variable]="var vra"
ZPWR_EXPAND_CORRECT_WORDS[variables]="vars"
ZPWR_EXPAND_CORRECT_WORDS[vector]="vectoor"
ZPWR_EXPAND_CORRECT_WORDS[verb]="vverb erbb vverbb verbb veerb"
ZPWR_EXPAND_CORRECT_WORDS[version]="verssion verion verison versioon"
ZPWR_EXPAND_CORRECT_WORDS[Version]="Verssion Verion Verison"
ZPWR_EXPAND_CORRECT_WORDS[vim]="ivm"
ZPWR_EXPAND_CORRECT_WORDS[VPN]="vpn"
ZPWR_EXPAND_CORRECT_WORDS[was_not]="wasnt"
ZPWR_EXPAND_CORRECT_WORDS[whitespace]="whitespaec whitespacee whitespacce whitesppace whitespaace"
ZPWR_EXPAND_CORRECT_WORDS[will_not]="wont"
ZPWR_EXPAND_CORRECT_WORDS[with]="with wiht itwh witth iwth wtih"
ZPWR_EXPAND_CORRECT_WORDS[would_not]="wouldnt"
ZPWR_EXPAND_CORRECT_WORDS[why]="hwy wyh"
ZPWR_EXPAND_CORRECT_WORDS[without]="wo w/o"
ZPWR_EXPAND_CORRECT_WORDS[work]="wrk werk owrk wokr"
ZPWR_EXPAND_CORRECT_WORDS[write]="wirte wrrite writte wiirrrte"
ZPWR_EXPAND_CORRECT_WORDS[XML]="xml"
ZPWR_EXPAND_CORRECT_WORDS[YAML]="yaml"
ZPWR_EXPAND_CORRECT_WORDS[your]="yuor ur"
ZPWR_EXPAND_CORRECT_WORDS[zsh]="zhs zshh zzsh zssh"
#}}}***********************************************************

#{{{                    MARK:keybind
#**************************************************************

zle -N zpwrExpandSupernaturalSpace
zle -N zpwrExpandTerminateSpace

if [[ $ZPWR_EXPAND != false ]]; then
    bindkey -M viins " " zpwrExpandSupernaturalSpace
    bindkey -M viins "^@" zpwrExpandTerminateSpace

    bindkey -M emacs " " zpwrExpandSupernaturalSpace
    bindkey -M emacs "^@" zpwrExpandTerminateSpace
fi

if [[ $ZPWR_EXPAND_TO_HISTORY == true ]]; then
    function zpwrExpandHistory() {

        local LBUFFER="${*%$'\n'}"
        zpwrExpandSupernaturalSpace 2>/dev/null

        print -sr -- "$LBUFFER"
        return 1
    }
    zshaddhistory_functions+=(zpwrExpandHistory)
fi


zle -N zpwrExpandGlobalAliases

bindkey '\e^E' zpwrExpandGlobalAliases
#}}}***********************************************************
