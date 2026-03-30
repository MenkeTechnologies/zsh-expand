#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Author: MenkeTechnologies
##### GitHub: https://github.com/MenkeTechnologies
##### Purpose: edge case tests for zpwrExpandRegexMatchOnCommandPosition
#}}}***********************************************************

@setup {
    typeset -gA ZPWR_VARS
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
    load "$pluginDir/zsh-expand.plugin.zsh"
    # reset config to defaults so local env vars do not leak into tests
    ZPWR_EXPAND_QUOTE_DOUBLE=false
    ZPWR_EXPAND_QUOTE_SINGLE=false
    ZPWR_EXPAND_SECOND_POSITION=false
    ZPWR_EXPAND_NATIVE=false
    ZPWR_EXPAND_PRE_EXEC_NATIVE=false
    ZPWR_EXPAND_PRE_EXEC_SECOND_POSITION=false
    ZPWR_EXPAND_TO_HISTORY=false
    ZPWR_CORRECT=false
    ZPWR_CORRECT_EXPAND=false
    ZPWR_EXPAND_SUFFIX=false
    ZPWR_TRACE=false

    function printLBUFFER() {
        print -r "LBUFFER=_____'${(q)LBUFFER}'_____"
    }
}

#==============================================================
# sudo with various flag combinations
#==============================================================

@test 'regex: sudo with no flags matches' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -i flag matches' {
    zpwrExpandParseWords "sudo -i git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -s flag matches' {
    zpwrExpandParseWords "sudo -s git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -E flag matches' {
    zpwrExpandParseWords "sudo -E git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -H flag matches' {
    zpwrExpandParseWords "sudo -H git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -n flag matches' {
    zpwrExpandParseWords "sudo -n git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -u user matches' {
    zpwrExpandParseWords "sudo -u root git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -u user PRE_EXPAND has git' {
    zpwrExpandParseWords "sudo -u root git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -g group matches' {
    zpwrExpandParseWords "sudo -g wheel git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -Eins combined flags matches' {
    zpwrExpandParseWords "sudo -Eins git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -- matches' {
    zpwrExpandParseWords "sudo -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: sudo -u root -- matches' {
    zpwrExpandParseWords "sudo -u root -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# env with various flags
#==============================================================

@test 'regex: env with no flags matches' {
    zpwrExpandParseWords "env git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -i flag matches' {
    zpwrExpandParseWords "env -i git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env -- matches' {
    zpwrExpandParseWords "env -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: env PRE_EXPAND has correct value' {
    zpwrExpandParseWords "env git status"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}

#==============================================================
# nice, time, nohup, rlwrap
#==============================================================

@test 'regex: nice matches' {
    zpwrExpandParseWords "nice git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time matches' {
    zpwrExpandParseWords "time git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nohup matches' {
    zpwrExpandParseWords "nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: rlwrap matches' {
    zpwrExpandParseWords "rlwrap git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice PRE_EXPAND has git' {
    zpwrExpandParseWords "nice git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: time PRE_EXPAND has git status' {
    zpwrExpandParseWords "time git status"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}

#==============================================================
# builtin prefixes
#==============================================================

@test 'regex: command prefix matches' {
    zpwrExpandParseWords "command git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin prefix matches' {
    zpwrExpandParseWords "builtin git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob prefix matches' {
    zpwrExpandParseWords "noglob git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: exec prefix matches' {
    zpwrExpandParseWords "exec git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: eval prefix matches' {
    zpwrExpandParseWords "eval git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nocorrect prefix matches' {
    zpwrExpandParseWords "nocorrect git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# stacked prefixes
#==============================================================

@test 'regex: sudo env matches' {
    zpwrExpandParseWords "sudo env git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: time sudo matches' {
    zpwrExpandParseWords "time sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: command sudo matches' {
    zpwrExpandParseWords "command sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: noglob sudo matches' {
    zpwrExpandParseWords "noglob sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: nice time sudo matches' {
    zpwrExpandParseWords "nice time sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: builtin command sudo matches' {
    zpwrExpandParseWords "builtin command sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# case insensitive sudo/env/nice/time/nohup/rlwrap
#==============================================================

@test 'regex: SUDO uppercase matches' {
    zpwrExpandParseWords "SUDO git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: Sudo mixed case matches' {
    zpwrExpandParseWords "Sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: ENV uppercase matches' {
    zpwrExpandParseWords "ENV git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: NICE uppercase matches' {
    zpwrExpandParseWords "NICE git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: TIME uppercase matches' {
    zpwrExpandParseWords "TIME git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: NOHUP uppercase matches' {
    zpwrExpandParseWords "NOHUP git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: RLWRAP uppercase matches' {
    zpwrExpandParseWords "RLWRAP git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# correct mode vs expand mode
#==============================================================

@test 'regex: correct mode sets ZPWR_EXPAND_PRE_CORRECT' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT" same_as 'git'
}

@test 'regex: expand mode sets ZPWR_EXPAND_PRE_EXPAND' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: correct mode with two words after sudo' {
    zpwrExpandParseWords "sudo git status"
    zpwrExpandRegexMatchOnCommandPosition correct
    assert "$ZPWR_EXPAND_PRE_CORRECT" same_as 'git status'
}

@test 'regex: expand mode with two words after sudo' {
    zpwrExpandParseWords "sudo git status"
    zpwrExpandRegexMatchOnCommandPosition
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git status'
}

#==============================================================
# return value
#==============================================================

@test 'regex: returns 0 on match' {
    zpwrExpandParseWords "sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: returns 0 on simple two word match' {
    zpwrExpandParseWords "echo hello"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# leading whitespace
#==============================================================

@test 'regex: leading space before sudo matches' {
    zpwrExpandParseWords " sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: leading spaces before sudo matches' {
    zpwrExpandParseWords "   sudo git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

@test 'regex: leading space before env matches' {
    zpwrExpandParseWords " env git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
}

#==============================================================
# exhaustive flag handling
#==============================================================

@test 'regex: sudo -k combo flag' {
    zpwrExpandParseWords "sudo -k git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -kE combo flags' {
    zpwrExpandParseWords "sudo -kE git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -K combo flag' {
    zpwrExpandParseWords "sudo -K git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -D dir flag-with-arg' {
    zpwrExpandParseWords "sudo -D /tmp git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -U user flag-with-arg' {
    zpwrExpandParseWords "sudo -U deploy git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -R chroot flag-with-arg' {
    zpwrExpandParseWords "sudo -R /newroot git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo all flags combined' {
    zpwrExpandParseWords "sudo -ABbEHkKnPSis -C 3 -D /tmp -g wheel -h host -p pass -R /root -T 30 -U deploy -u root git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: env -0 combo flag' {
    zpwrExpandParseWords "env -0 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: env -0iv combo flags' {
    zpwrExpandParseWords "env -0iv git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: env -C dir flag-with-arg' {
    zpwrExpandParseWords "env -C /tmp git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: env all flags combined' {
    zpwrExpandParseWords "env -0iv -C /tmp -P /bin -S cat -u TERM -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: nice -n priority' {
    zpwrExpandParseWords "nice -n 10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: nice -n=priority' {
    zpwrExpandParseWords "nice -n=10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: nice -n10 no space' {
    zpwrExpandParseWords "nice -n10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: nice -n negative priority' {
    zpwrExpandParseWords "nice -n -10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: nice -19 short form' {
    zpwrExpandParseWords "nice -19 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: time -l BSD long format' {
    zpwrExpandParseWords "time -l git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: time -v GNU verbose' {
    zpwrExpandParseWords "time -v git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: time -plv all time flags' {
    zpwrExpandParseWords "time -plv git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: command -p default PATH' {
    zpwrExpandParseWords "command -p git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: exec -c clear env' {
    zpwrExpandParseWords "exec -c git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: exec -l login shell' {
    zpwrExpandParseWords "exec -l git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: exec -cl -a name all exec flags' {
    zpwrExpandParseWords "exec -cl -a myname git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: rlwrap -a always-readline' {
    zpwrExpandParseWords "rlwrap -a git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: rlwrap -acN combo flags' {
    zpwrExpandParseWords "rlwrap -acN git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: rlwrap -f file flag-with-arg' {
    zpwrExpandParseWords "rlwrap -f completions git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: rlwrap -s histsize flag-with-arg' {
    zpwrExpandParseWords "rlwrap -s 1000 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: rlwrap all flags combined' {
    zpwrExpandParseWords "rlwrap -acN -b x -f y -H z -p r -s 5 -S p git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# every shell keyword -> every wrapper
#==============================================================

@test 'regex: nocorrect sudo -E' {
    zpwrExpandParseWords "nocorrect sudo -E git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: time -p sudo -kE' {
    zpwrExpandParseWords "time -p sudo -kE git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: command -p sudo -E' {
    zpwrExpandParseWords "command -p sudo -E git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: exec -cl sudo -E' {
    zpwrExpandParseWords "exec -cl sudo -E git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: noglob sudo -E env -i' {
    zpwrExpandParseWords "noglob sudo -E env -i git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# wrapper pairs with flags
#==============================================================

@test 'regex: sudo -E env -i' {
    zpwrExpandParseWords "sudo -E env -i git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -E nice -n 10' {
    zpwrExpandParseWords "sudo -E nice -n 10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -E rlwrap -a' {
    zpwrExpandParseWords "sudo -E rlwrap -a git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: env -i nice -n 10 nohup' {
    zpwrExpandParseWords "env -i nice -n 10 nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: nice -n 10 rlwrap -acN -f comp time -v' {
    zpwrExpandParseWords "nice -n 10 rlwrap -acN -f comp time -v git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# ultimate monster: every prefix with every flag
#==============================================================

@test 'regex: every prefix every flag monster chain' {
    zpwrExpandParseWords "nocorrect time -plv - builtin builtin command -p command eval exec -cl -a name noglob sudo -ABbEHkKnPSis -C 3 -D /tmp -g wheel -h host -p pass -R /root -T 30 -U deploy -u root env -0iv -C /tmp -P /bin -S cat -u TERM nice -n 10 rlwrap -acN -b x -f y -H z -p r -s 5 -S p nohup time -v git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# new command wrappers: simple no-flag
#==============================================================

@test 'regex: pkexec' {
    zpwrExpandParseWords "pkexec git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: fakeroot' {
    zpwrExpandParseWords "fakeroot git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: unbuffer' {
    zpwrExpandParseWords "unbuffer git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: chronic' {
    zpwrExpandParseWords "chronic git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: torify' {
    zpwrExpandParseWords "torify git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: torsocks' {
    zpwrExpandParseWords "torsocks git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: tsocks' {
    zpwrExpandParseWords "tsocks git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: proxychains4' {
    zpwrExpandParseWords "proxychains4 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: daemonize' {
    zpwrExpandParseWords "daemonize git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: firejail' {
    zpwrExpandParseWords "firejail git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sem' {
    zpwrExpandParseWords "sem git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: valgrind' {
    zpwrExpandParseWords "valgrind git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: ltrace' {
    zpwrExpandParseWords "ltrace git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: systemd-run' {
    zpwrExpandParseWords "systemd-run git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# new command wrappers: with flags
#==============================================================

@test 'regex: watch -n 1' {
    zpwrExpandParseWords "watch -n 1 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: watch -dtec -n 2' {
    zpwrExpandParseWords "watch -dtec -n 2 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: runuser -u user' {
    zpwrExpandParseWords "runuser -u user git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: runuser -l -u deploy' {
    zpwrExpandParseWords "runuser -l -u deploy git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: flock /tmp/lock' {
    zpwrExpandParseWords "flock /tmp/lock git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: flock -ns -w 10 /tmp/lock' {
    zpwrExpandParseWords "flock -ns -w 10 /tmp/lock git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: chroot /path' {
    zpwrExpandParseWords "chroot /path git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: unshare -mnpuUir' {
    zpwrExpandParseWords "unshare -mnpuUir git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: unshare -mn --' {
    zpwrExpandParseWords "unshare -mn -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: cpulimit -l 50' {
    zpwrExpandParseWords "cpulimit -l 50 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# new wrappers combined with existing wrappers
#==============================================================

@test 'regex: sudo -E fakeroot' {
    zpwrExpandParseWords "sudo -E fakeroot git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -E chroot /path' {
    zpwrExpandParseWords "sudo -E chroot /path git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: torify sudo -E' {
    zpwrExpandParseWords "torify sudo -E git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: proxychains4 sudo -E env -i' {
    zpwrExpandParseWords "proxychains4 sudo -E env -i git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: strace -f valgrind' {
    zpwrExpandParseWords "strace -f valgrind git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: ionice -c 2 cpulimit -l 50 nice -n 10' {
    zpwrExpandParseWords "ionice -c 2 cpulimit -l 50 nice -n 10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: flock -w 5 /tmp/lock timeout 30' {
    zpwrExpandParseWords "flock -w 5 /tmp/lock timeout 30 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: watch -n 1 sudo -E' {
    zpwrExpandParseWords "watch -n 1 sudo -E git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# new wrappers with shell keywords
#==============================================================

@test 'regex: command -p fakeroot' {
    zpwrExpandParseWords "command -p fakeroot git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: nocorrect time -p command -p fakeroot' {
    zpwrExpandParseWords "nocorrect time -p command -p fakeroot git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: coproc unbuffer' {
    zpwrExpandParseWords "coproc unbuffer git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# mega chain: all new + existing wrappers
#==============================================================

@test 'regex: mega chain all wrappers with flags' {
    zpwrExpandParseWords "nocorrect time -p command -p doas -n -u root sudo -kE -u root env -0iv -C /tmp strace -f ionice -c 2 chrt -f 10 taskset -c 0 nice -n 10 caffeinate -i setsid -f flock /tmp/lock watch -n 1 unbuffer rlwrap -acN cpulimit -l 50 nohup time -v git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: mega chain all no-flag wrappers' {
    zpwrExpandParseWords "fakeroot valgrind ltrace chronic torify proxychains4 pkexec firejail sem systemd-run nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# strace -e trace=X (parser = fix)
#==============================================================

@test 'regex: strace -e trace=network' {
    zpwrExpandParseWords "strace -e trace=network git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: strace -e trace=open -o /tmp/out' {
    zpwrExpandParseWords "strace -e trace=open -o /tmp/out git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: strace -cf -e trace=write -s 256 -o /tmp/log' {
    zpwrExpandParseWords "strace -cf -e trace=write -s 256 -o /tmp/log git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -E strace -f -e trace=network' {
    zpwrExpandParseWords "sudo -E strace -f -e trace=network git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# extreme stacked: every category represented
#==============================================================

@test 'regex: proxy auth env debug sched wrapper process' {
    zpwrExpandParseWords "torify sudo -kE -u root env -0iv -C /tmp strace -f -e trace=network ionice -c 2 chrt -f 10 taskset -c 0 nice -n 10 caffeinate -i setsid -f rlwrap -acN cpulimit -l 50 nohup time -v git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: full keyword chain then all wrappers with assignments' {
    zpwrExpandParseWords "A=1 B=2 nocorrect time -p command -p doas -n -u root env -0iv FOO=bar -C /tmp ionice -c2 -n0 chrt -f 10 taskset -c 0 nice -n 10 caffeinate -i setsid -cfw rlwrap -acN -f comp -s 500 nohup time -v git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: proxy chain into sandbox into auth into env' {
    zpwrExpandParseWords "torify proxychains4 fakeroot strace -f -e trace=file ionice -c 2 chrt -f 10 taskset -c 0 nice -n 10 caffeinate -i setsid -f flock /tmp/lock timeout 30 unbuffer rlwrap -acN cpulimit -l 50 nohup time -v git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: all no-flag wrappers stacked' {
    zpwrExpandParseWords "fakeroot valgrind ltrace chronic torify torsocks tsocks proxychains4 pkexec firejail sem systemd-run daemonize unbuffer nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: every shell keyword then every auth wrapper' {
    zpwrExpandParseWords "nocorrect time -plv - builtin command -p eval noglob coproc sudo -kE -u root doas -ns -u deploy pkexec git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: assignments interspersed with env vars and flag=args' {
    zpwrExpandParseWords "PATH=/usr/bin LD_PRELOAD=x.so DISPLAY=:0 LANG=C nocorrect time -p command -p sudo -kE -u root env -0iv FOO=bar BAR=baz -C /tmp -u TERM strace -f -e trace=open nice -n 10 nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: escaped chain with flags' {
    zpwrExpandParseWords "\\nocorrect \\time -p \\builtin \\command -p \\sudo -kE -u root \\env -0iv \\nice -n 10 \\nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: single-quoted chain with flags' {
    zpwrExpandParseWords "'nocorrect' 'time' -p 'builtin' 'command' -p 'sudo' -kE -u root 'env' -0iv 'nice' -n 10 'nohup' git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: double-quoted chain with flags' {
    zpwrExpandParseWords "\"nocorrect\" \"time\" -p \"builtin\" \"command\" -p \"sudo\" -kE -u root \"env\" -0iv \"nice\" -n 10 \"nohup\" git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: mixed quoting with all flag styles' {
    zpwrExpandParseWords "\\nocorrect 'time' -p \"builtin\" \\command -p 'sudo' -kE -u root \"env\" -0iv \\nice -n 10 'rlwrap' -acN \"nohup\" git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# new sudo flags: -e -l -N -V -v -D -U (added), removed -r -t
#==============================================================

@test 'regex: sudo -elNVv' {
    zpwrExpandParseWords "sudo -elNVv git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -D /chdir -U other' {
    zpwrExpandParseWords "sudo -D /chdir -U other git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: sudo -D=/chdir -U=other' {
    zpwrExpandParseWords "sudo -D=/chdir -U=other git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# doas -L flag
#==============================================================

@test 'regex: doas -Lns -u tom -C dg' {
    zpwrExpandParseWords "doas -Lns -u tom -C dg git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# env -a flag
#==============================================================

@test 'regex: env -a argv0' {
    zpwrExpandParseWords "env -a argv0 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# rlwrap: new flags
#==============================================================

@test 'regex: rlwrap -EhInoRUvWX' {
    zpwrExpandParseWords "rlwrap -EhInoRUvWX git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: rlwrap -C name -D 2 -e x -g pat -l log -M ext -O re -P inp -q ch -t term -w 50 -z filt' {
    zpwrExpandParseWords "rlwrap -C name -D 2 -e x -g pat -l log -M ext -O re -P inp -q ch -t term -w 50 -z filt git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# timeout: new boolean flags -f -p -v
#==============================================================

@test 'regex: timeout -fpv -k 5 30' {
    zpwrExpandParseWords "timeout -fpv -k 5 30 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# strace/ltrace: new flags -L -N -n -A -F -l -w -X -B
#==============================================================

@test 'regex: strace -LNn' {
    zpwrExpandParseWords "strace -LNn git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: strace -A out -X raw -w 5 -F pathlist' {
    zpwrExpandParseWords "strace -A out -X raw -w 5 -F pathlist git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: ltrace -L -l libfoo -A 10 -n 2 -w 3' {
    zpwrExpandParseWords "ltrace -L -l libfoo -A 10 -n 2 -w 3 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: strace -b execve -l libbar' {
    zpwrExpandParseWords "strace -b execve -l libbar git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# watch: new flags -C -f -r -w -q -s
#==============================================================

@test 'regex: watch -Cfrw -n 1' {
    zpwrExpandParseWords "watch -Cfrw -n 1 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: watch -q 5 -s /shots' {
    zpwrExpandParseWords "watch -q 5 -s /shots git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# chrt: new flags -a -d -e -p -R -v -D -P -T
#==============================================================

@test 'regex: chrt -adepRv -f 10' {
    zpwrExpandParseWords "chrt -adepRv -f 10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: chrt -d -D 1000 -P 2000 -T 500 10' {
    zpwrExpandParseWords "chrt -d -D 1000 -P 2000 -T 500 10 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# taskset: new flags -a -p
#==============================================================

@test 'regex: taskset -acp 0xff' {
    zpwrExpandParseWords "taskset -acp 0xff git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# runuser: new flags -f -m -p -P -T -c -s -w
#==============================================================

@test 'regex: runuser -fmpPT -c cmd -s /bin/bash -w 1,2 -u deploy' {
    zpwrExpandParseWords "runuser -fmpPT -c cmd -s /bin/bash -w 1,2 -u deploy git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# flock: new flags -e -F -o -c
#==============================================================

@test 'regex: flock -eFo -c cmd /tmp/lock' {
    zpwrExpandParseWords "flock -eFo -c cmd /tmp/lock git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# su: new flag -T
#==============================================================

@test 'regex: su -flmpPT -c cmd root' {
    zpwrExpandParseWords "su -flmpPT -c cmd root git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# unshare: new flags -c -T -R -w -S -G -l
#==============================================================

@test 'regex: unshare -cfmnpuUirCT' {
    zpwrExpandParseWords "unshare -cfmnpuUirCT git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: unshare -R /newroot -w /workdir -S 1000 -G 1000 -l /tmp/ns' {
    zpwrExpandParseWords "unshare -R /newroot -w /workdir -S 1000 -G 1000 -l /tmp/ns git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# cpulimit: new flags -v -i -z -e -p
#==============================================================

@test 'regex: cpulimit -viz -e myapp -p 1234 -l 50' {
    zpwrExpandParseWords "cpulimit -viz -e myapp -p 1234 -l 50 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# nsenter: new flags -a -c -e -T -w -W -Z -G -N
#==============================================================

@test 'regex: nsenter -aceZTwW -t 1 -S 0 -G 0 -N 3' {
    zpwrExpandParseWords "nsenter -aceZTwW -t 1 -S 0 -G 0 -N 3 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# numactl: new flags -a -b -s -H -w -P
#==============================================================

@test 'regex: numactl -absH -w 0,1 -P 2,3' {
    zpwrExpandParseWords "numactl -absH -w 0,1 -P 2,3 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# prlimit: removed -v combo, added -o with-arg
#==============================================================

@test 'regex: prlimit -o RESOURCE -p 1234' {
    zpwrExpandParseWords "prlimit -o RESOURCE -p 1234 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# setarch/linux32/linux64: new flag -p
#==============================================================

@test 'regex: setarch i386 -R -p 1234' {
    zpwrExpandParseWords "setarch i386 -R -p 1234 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: linux32 -p 1234' {
    zpwrExpandParseWords "linux32 -p 1234 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# faketime: new flag -p
#==============================================================

@test 'regex: faketime -fm -p 42 2020-01-01' {
    zpwrExpandParseWords "faketime -fm -p 42 2020-01-01 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# proot: removed -n -p, added -m
#==============================================================

@test 'regex: proot -0 -m /src:/dst -r /jail' {
    zpwrExpandParseWords "proot -0 -m /src:/dst -r /jail git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# valgrind: with flags
#==============================================================

@test 'regex: valgrind -dhqsv --tool=memcheck --log-file=/tmp/vg' {
    zpwrExpandParseWords "valgrind -dhqsv --tool=memcheck --log-file=/tmp/vg git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# fakeroot: with flags
#==============================================================

@test 'regex: fakeroot -huv -b 10 -i /tmp/save -l /usr/lib/libfakeroot.so -s /tmp/save' {
    zpwrExpandParseWords "fakeroot -huv -b 10 -i /tmp/save -l /usr/lib/libfakeroot.so -s /tmp/save git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

@test 'regex: fakeroot -- git' {
    zpwrExpandParseWords "fakeroot -- git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# unbuffer: -p flag
#==============================================================

@test 'regex: unbuffer -p git' {
    zpwrExpandParseWords "unbuffer -p git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# chronic: -e -v flags
#==============================================================

@test 'regex: chronic -ev git' {
    zpwrExpandParseWords "chronic -ev git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# torsocks: with flags
#==============================================================

@test 'regex: torsocks -diq6 -a 127.0.0.1 -P 9050 -u user -p pass' {
    zpwrExpandParseWords "torsocks -diq6 -a 127.0.0.1 -P 9050 -u user -p pass git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# proxychains4: with flags
#==============================================================

@test 'regex: proxychains4 -q -f /etc/proxychains.conf' {
    zpwrExpandParseWords "proxychains4 -q -f /etc/proxychains.conf git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# daemonize: with flags
#==============================================================

@test 'regex: daemonize -av -c /tmp -e /var/log/err -E FOO=bar -l /tmp/lock -o /var/log/out -p /var/run/pid -u www' {
    zpwrExpandParseWords "daemonize -av -c /tmp -e /var/log/err -E FOO=bar -l /tmp/lock -o /var/log/out -p /var/run/pid -u www git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# firejail: with flags
#==============================================================

@test 'regex: firejail -c cmd --private --net=none' {
    zpwrExpandParseWords "firejail -c cmd --private --net=none git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# sem: with flags
#==============================================================

@test 'regex: sem -j 4 -P 8' {
    zpwrExpandParseWords "sem -j 4 -P 8 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# systemd-run: with flags
#==============================================================

@test 'regex: systemd-run -dGPqrRSTtv -C cap -E VAR=val -H host -M mach -p prop -u unit' {
    zpwrExpandParseWords "systemd-run -dGPqrRSTtv -C cap -E VAR=val -H host -M mach -p prop -u unit git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# nocache: with flags
#==============================================================

@test 'regex: nocache -n 2' {
    zpwrExpandParseWords "nocache -n 2 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# fakechroot: with flags
#==============================================================

@test 'regex: fakechroot -hsv -b /base -c /cfg -d /ld -e env -l /lib' {
    zpwrExpandParseWords "fakechroot -hsv -b /base -c /cfg -d /ld -e env -l /lib git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# ccache: with flags
#==============================================================

@test 'regex: ccache -cChpsvVxz -d /cache -F 1000 -k key -M 5G -o opt=val -X 80' {
    zpwrExpandParseWords "ccache -cChpsvVxz -d /cache -F 1000 -k key -M 5G -o opt=val -X 80 git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# distcc: -j flag
#==============================================================

@test 'regex: distcc -j' {
    zpwrExpandParseWords "distcc -j git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}

#==============================================================
# mega chain: all wrappers with new flags
#==============================================================

@test 'regex: mega chain all new flags' {
    zpwrExpandParseWords "proxychains4 -q -f /etc/pc.conf torsocks -diq6 -a 127.0.0.1 -P 9050 sudo -elNVv -D /chdir -U other doas -Lns -u root env -a argv0 -0iv fakeroot -u -s /tmp/save chronic -ev systemd-run -dGqt -u unit -p prop daemonize -av -c /tmp -u www firejail --private ccache nocache -n 2 fakechroot -s -l /lib sem -j 4 unbuffer -p valgrind -qv --tool=memcheck strace -LNn -A out -X raw rlwrap -EhIoRUvWX -C name -D 2 -z filt timeout -fpv -k 5 30 chrt -adepRv -D 1000 -T 500 -f 10 taskset -acp 0xff watch -Cfrw -q 5 -s /dir -n 1 flock -eFo -c cmd -w 5 /tmp/lock runuser -fmpPT -c cmd -s /bin/bash -u deploy unshare -cfmnpuUirCT -R /root -S 1000 -G 1000 cpulimit -viz -e app -p 1234 -l 50 nsenter -aceZTwW -t 1 -S 0 -G 0 -N 3 numactl -absH -w 0,1 -P 2,3 prlimit -o RES -p 1234 su -flmpPT -c cmd root nice -n 10 nohup git"
    zpwrExpandRegexMatchOnCommandPosition
    assert $state equals 0
    assert "$ZPWR_EXPAND_PRE_EXPAND" same_as 'git'
}
