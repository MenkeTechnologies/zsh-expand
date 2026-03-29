#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandCorrectWord
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# no correction for valid commands (single word)
#==============================================================

@test 'correctWord: no correction for valid command ls' {
    LBUFFER="ls"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for valid command echo' {
    LBUFFER="echo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for valid command cat' {
    LBUFFER="cat"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for valid command grep' {
    LBUFFER="grep"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for valid command git' {
    LBUFFER="git"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for valid command cd' {
    LBUFFER="cd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for valid command pwd' {
    LBUFFER="pwd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# no correction when word is a global alias
#==============================================================

@test 'correctWord: skips correction when word is global alias' {
    galiases[teh]='| grep'
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
    unset 'galiases[teh]'
}

#==============================================================
# correction after various prefixes
#==============================================================

@test 'correctWord: corrects after sudo' {
    LBUFFER="sudo ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sudo echo'
}

@test 'correctWord: corrects after env' {
    LBUFFER="env ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'env echo'
}

@test 'correctWord: corrects after nice' {
    LBUFFER="nice ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'nice echo'
}

@test 'correctWord: corrects after nohup' {
    LBUFFER="nohup ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'nohup echo'
}

@test 'correctWord: corrects after time' {
    LBUFFER="time ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'time echo'
}

@test 'correctWord: corrects after sudo -u root' {
    LBUFFER="sudo -u root ehco"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'sudo -u root echo'
}

#==============================================================
# no correction for subcommand positions
#==============================================================

@test 'correctWord: no correction for git subcommand' {
    LBUFFER="sudo git teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for docker subcommand' {
    LBUFFER="sudo docker teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for npm subcommand' {
    LBUFFER="sudo npm teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for brew subcommand' {
    LBUFFER="sudo brew teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for kubectl subcommand' {
    LBUFFER="sudo kubectl teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

@test 'correctWord: no correction for yarn subcommand' {
    LBUFFER="sudo yarn teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $ZPWR_VARS[foundIncorrect] same_as 'false'
}

#==============================================================
# correction of abbreviations
#==============================================================

@test 'correctWord: corrects bg to background' {
    LBUFFER="echo bg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo background'
}

@test 'correctWord: corrects fg to foreground' {
    LBUFFER="echo fg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo foreground'
}

@test 'correctWord: corrects cmd to command' {
    LBUFFER="echo cmd"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo command'
}

@test 'correctWord: corrects db to database' {
    LBUFFER="echo db"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo database'
}

@test 'correctWord: corrects dir to directory' {
    LBUFFER="echo dir"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo directory'
}

@test 'correctWord: corrects fn to function' {
    LBUFFER="echo fn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo function'
}

@test 'correctWord: corrects func to function' {
    LBUFFER="echo func"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo function'
}

@test 'correctWord: corrects lib to library' {
    LBUFFER="echo lib"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo library'
}

@test 'correctWord: corrects msg to message' {
    LBUFFER="echo msg"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo message'
}

@test 'correctWord: corrects src to source' {
    LBUFFER="echo src"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo source'
}

@test 'correctWord: corrects var to variable' {
    LBUFFER="echo var"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo variable'
}

@test 'correctWord: corrects vars to variables' {
    LBUFFER="echo vars"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo variables'
}

@test 'correctWord: corrects args to arguments' {
    LBUFFER="echo args"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo arguments'
}

@test 'correctWord: corrects env to environment' {
    LBUFFER="echo env"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo environment'
}

@test 'correctWord: corrects repo to repository' {
    LBUFFER="echo repo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo repository'
}

@test 'correctWord: corrects deps to dependencies' {
    LBUFFER="echo deps"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo dependencies'
}

@test 'correctWord: corrects docs to documentation' {
    LBUFFER="echo docs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo documentation'
}

@test 'correctWord: corrects perms to permissions' {
    LBUFFER="echo perms"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo permissions'
}

#==============================================================
# correction of case-sensitive acronyms
#==============================================================

@test 'correctWord: corrects json to JSON' {
    LBUFFER="echo json"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JSON'
}

@test 'correctWord: corrects html to HTML' {
    LBUFFER="echo html"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo HTML'
}

@test 'correctWord: corrects css to CSS' {
    LBUFFER="echo css"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo CSS'
}

@test 'correctWord: corrects sql to SQL' {
    LBUFFER="echo sql"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo SQL'
}

@test 'correctWord: corrects ssh to SSH' {
    LBUFFER="echo ssh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo SSH'
}

@test 'correctWord: corrects ssl to SSL' {
    LBUFFER="echo ssl"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo SSL'
}

@test 'correctWord: corrects http to HTTP' {
    LBUFFER="echo http"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo HTTP'
}

@test 'correctWord: corrects https to HTTPS' {
    LBUFFER="echo https"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo HTTPS'
}

@test 'correctWord: corrects cpu to CPU' {
    LBUFFER="echo cpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo CPU'
}

@test 'correctWord: corrects gpu to GPU' {
    LBUFFER="echo gpu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo GPU'
}

@test 'correctWord: corrects dns to DNS' {
    LBUFFER="echo dns"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo DNS'
}

@test 'correctWord: corrects cli to CLI' {
    LBUFFER="echo cli"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo CLI'
}

@test 'correctWord: corrects url to URL' {
    LBUFFER="echo url"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo URL'
}

@test 'correctWord: corrects usb to USB' {
    LBUFFER="echo usb"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo USB'
}

@test 'correctWord: corrects vpn to VPN' {
    LBUFFER="echo vpn"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo VPN'
}

@test 'correctWord: corrects ascii to ASCII' {
    LBUFFER="echo ascii"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo ASCII'
}

@test 'correctWord: corrects ansi to ANSI' {
    LBUFFER="echo ansi"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo ANSI'
}

@test 'correctWord: corrects posix to POSIX' {
    LBUFFER="echo posix"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo POSIX'
}

#==============================================================
# correction of common typos
#==============================================================

@test 'correctWord: corrects teh to the' {
    LBUFFER="echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'correctWord: corrects hte to the' {
    LBUFFER="echo hte"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'correctWord: corrects eht to the' {
    LBUFFER="echo eht"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'correctWord: corrects eth to the' {
    LBUFFER="echo eth"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo the'
}

@test 'correctWord: corrects taht to that' {
    LBUFFER="echo taht"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo that'
}

@test 'correctWord: corrects tihs to this' {
    LBUFFER="echo tihs"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo this'
}

@test 'correctWord: corrects htis to this' {
    LBUFFER="echo htis"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo this'
}

@test 'correctWord: corrects si to is' {
    LBUFFER="echo si"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo is'
}

@test 'correctWord: corrects fro to for' {
    LBUFFER="echo fro"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo for'
}

@test 'correctWord: corrects rfo to for' {
    LBUFFER="echo rfo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo for'
}

@test 'correctWord: corrects ot to to' {
    LBUFFER="echo ot"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo to'
}

@test 'correctWord: corrects nto to not' {
    LBUFFER="echo nto"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo not'
}

@test 'correctWord: corrects tno to not' {
    LBUFFER="echo tno"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo not'
}

@test 'correctWord: corrects fo to of' {
    LBUFFER="echo fo"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo of'
}

@test 'correctWord: corrects ro to or' {
    LBUFFER="echo ro"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo or'
}

@test 'correctWord: corrects flase to false' {
    LBUFFER="echo flase"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo false'
}

@test 'correctWord: corrects treu to true' {
    LBUFFER="echo treu"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo true'
}

@test 'correctWord: corrects ture to true' {
    LBUFFER="echo ture"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo true'
}

#==============================================================
# correction of underscore-separated expansions
#==============================================================

@test 'correctWord: corrects btw to by the way' {
    LBUFFER="echo btw"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo by the way'
}

@test 'correctWord: corrects cant to can not' {
    LBUFFER="echo cant"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo can not'
}

@test 'correctWord: corrects dont to do not' {
    LBUFFER="echo dont"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo do not'
}

@test 'correctWord: corrects doesnt to does not' {
    LBUFFER="echo doesnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo does not'
}

@test 'correctWord: corrects isnt to is not' {
    LBUFFER="echo isnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo is not'
}

@test 'correctWord: corrects wasnt to was not' {
    LBUFFER="echo wasnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo was not'
}

@test 'correctWord: corrects wont to will not' {
    LBUFFER="echo wont"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo will not'
}

@test 'correctWord: corrects shouldnt to should not' {
    LBUFFER="echo shouldnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo should not'
}

@test 'correctWord: corrects wouldnt to would not' {
    LBUFFER="echo wouldnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo would not'
}

@test 'correctWord: corrects havent to have not' {
    LBUFFER="echo havent"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo have not'
}

@test 'correctWord: corrects hasnt to has not' {
    LBUFFER="echo hasnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo has not'
}

@test 'correctWord: corrects didnt to did not' {
    LBUFFER="echo didnt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo did not'
}

#==============================================================
# correction with various preceding contexts
#==============================================================

@test 'correctWord: corrects after pipe' {
    LBUFFER="cat file | echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'cat file | echo the'
}

@test 'correctWord: corrects after semicolon' {
    LBUFFER="ls; echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'ls; echo the'
}

@test 'correctWord: corrects after &&' {
    LBUFFER="make && echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'make && echo the'
}

@test 'correctWord: corrects after ||' {
    LBUFFER="make || echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'make || echo the'
}

@test 'correctWord: preserves full prefix on correction' {
    LBUFFER="git commit -m teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'git commit -m the'
}

@test 'correctWord: corrects with leading spaces' {
    LBUFFER="  echo teh"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as '  echo the'
}

#==============================================================
# technology-specific corrections
#==============================================================

@test 'correctWord: corrects igt to git' {
    LBUFFER="echo igt"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo git'
}

@test 'correctWord: corrects dokcer to docker' {
    LBUFFER="echo dokcer"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo docker'
}

@test 'correctWord: corrects ivm to vim' {
    LBUFFER="echo ivm"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo vim'
}

@test 'correctWord: corrects linux to Linux' {
    LBUFFER="echo linux"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo Linux'
}

@test 'correctWord: corrects macos to macOS' {
    LBUFFER="echo macos"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo macOS'
}

@test 'correctWord: corrects unix to Unix' {
    LBUFFER="echo unix"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo Unix'
}

@test 'correctWord: corrects darwin to Darwin' {
    LBUFFER="echo darwin"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo Darwin'
}

@test 'correctWord: corrects mysql to MySQL' {
    LBUFFER="echo mysql"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo MySQL'
}

@test 'correctWord: corrects js to JavaScript' {
    LBUFFER="echo js"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo JavaScript'
}

@test 'correctWord: corrects yaml to YAML' {
    LBUFFER="echo yaml"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo YAML'
}

@test 'correctWord: corrects xml to XML' {
    LBUFFER="echo xml"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo XML'
}

@test 'correctWord: corrects latex to LaTeX' {
    LBUFFER="echo latex"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo LaTeX'
}

#==============================================================
# correction of slash-separated words
#==============================================================

@test 'correctWord: corrects b/c to because' {
    LBUFFER="echo b/c"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo because'
}

@test 'correctWord: corrects w/o to without' {
    LBUFFER="echo w/o"
    ZPWR_VARS[foundIncorrect]=false
    zpwrExpandParseWords "$LBUFFER"
    zpwrExpandCorrectWord
    assert $LBUFFER same_as 'echo without'
}
