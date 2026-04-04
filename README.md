# zsh-expand

```
@@@@@@@@   @@@@@@   @@@  @@@             @@@@@@@@  @@@  @@@  @@@@@@@
@@@@@@@@  @@@@@@@   @@@  @@@             @@@@@@@@  @@@  @@@  @@@@@@@@
     @@!  !@@       @@!  @@@             @@!       @@!  !@@  @@!  @@@
    !@!   !@!       !@!  @!@             !@!       !@!  @!!  !@!  @!@
   @!!    !!@@!!    @!@!@!@!  @!@!@!@!@  @!!!:!     !@@!@!   @!@@!@!
  !!!      !!@!!!   !!!@!!!!  !!!@!@!!!  !!!!!:      @!!!    !!@!!!
 !!:           !:!  !!:  !!!             !!:        !: :!!   !!:
:!:           !:!   :!:  !:!             :!:       :!:  !:!  :!:
 :: ::::  :::: ::   ::   :::              :: ::::   ::  :::   ::
: :: : :  :: : :     :   : :             : :: ::    :   ::    :

 @@@@@@   @@@  @@@  @@@@@@@
@@@@@@@@  @@@@ @@@  @@@@@@@@
@@!  @@@  @@!@!@@@  @@!  @@@
!@!  @!@  !@!!@!@!  !@!  @!@
@!@!@!@!  @!@ !!@!  @!@  !@!
!!!@!!!!  !@!  !!!  !@!  !!!
!!:  !!!  !!:  !!!  !!:  !!!
:!:  !:!  :!:  !:!  :!:  !:!
::   :::   ::   ::   :::: ::
 :   : :  ::    :   :: :  :
```

> *Jack into your shell. Let the machine think faster than you can type.*

---

[![CI](https://github.com/MenkeTechnologies/zsh-expand/actions/workflows/ci.yml/badge.svg)](https://github.com/MenkeTechnologies/zsh-expand/actions/workflows/ci.yml)

### // TABLE OF CONTENTS

- [What Is This](#-what-is-this)
- [Demo](#-demo)
- [Neural Expansion Core](#-neural-expansion-core)
- [Expansion Rules](#-expansion-rules)
- [Supported Prefixes and Flags](#-supported-prefixes-and-flags)
- [Bypass Protocols](#-bypass-protocols)
- [Configuration Matrix](#-configuration-matrix)
- [Key Bindings](#-key-bindings)
- [Custom Corrections](#-custom-corrections)
- [Versus the Competition](#-versus-the-competition)
- [Tabstop Snippets](#-tabstop-snippets)
- [Self-Referential Alias Escape](#-self-referential-alias-escape)
- [Correct-Then-Expand](#-correct-then-expand)
- [Expand Inside Quotes](#-expand-inside-quotes)
- [Suffix Alias Expansion](#-suffix-alias-expansion)
- [Autopair Integration](#-autopair-integration)
- [History Injection](#-history-injection)
- [Debug Widget](#-debug-widget)
- [Command-Position Parser](#-command-position-parser)
- [Performance](#-performance)
- [Test Coverage](#-test-coverage)
- [Install](#-install)
- [The Monster Chain](#-the-monster-chain)

---

### // WHAT IS THIS

**The world's most powerful zsh expansion plugin.** Intercepts your spacebar and expands everything in its path -- regular aliases, global aliases, suffix aliases, misspellings, globs, history, parameters, and more. No pipes. No external commands. Pure zsh. Sub-millisecond. 10,000+ tests.

```
gco<space>  =>  git checkout
sudo gco<space>  =>  sudo git checkout
teh<space>  =>  the

# su, stdbuf, and friends — all parsed:
su -l root gco<space>  =>  su -l root git checkout
stdbuf -oL gco<space>  =>  stdbuf -oL git checkout
su root nice -n 10 nohup gco<space>  =>  ...git checkout

# deep prefix chain — all flags parsed, alias still expanded:
nocorrect time -p command sudo -kE -u root env -0iv -C /tmp \
  nice -n 10 rlwrap -acN -f comp nohup gco<space>
  =>  ...git checkout

# extreme stack — proxy, auth, env, debug, scheduling, sandbox,
# process control, namespace, NUMA, OOM, buffering, all with flags:
torify sudo -kE -u root su -l deploy                         \
  env -0iv -C /tmp                                            \
  strace -f -e trace=network stdbuf -oL                       \
  nsenter -t 1 -m -n numactl -C 0-3                           \
  ionice -c 2 chrt -f 10 choom -n -500                        \
  taskset -c 0 nice -n 10 caffeinate -i setsid -f            \
  flock /tmp/lock timeout 30 unbuffer rlwrap -acN             \
  prlimit --nofile=4096 cpulimit -l 50                        \
  nohup time -v gco<space>
  =>  ...git checkout

```

### // DEMO

[![asciicast](https://asciinema.org/a/FbFsuMCSLtooqkB5ZZbBZeiEg.svg)](https://asciinema.org/a/FbFsuMCSLtooqkB5ZZbBZeiEg)

---

### // NEURAL EXPANSION CORE

| Layer | What It Does |
|---|---|
| **Alias Expansion** | Expands regular aliases in command position and after `sudo`, `env`, `builtin`, `command`, `exec`, `eval`, `noglob`, `nocorrect`, `nice`, `nohup`, `rlwrap`, `time` and arbitrary combos of these with full flag support |
| **Global Alias Expansion** | Expands global aliases anywhere on the command line |
| **Spelling Correction** | 290+ built-in misspelling/abbreviation corrections -- `teh` -> `the`, `cmd` -> `command`, `bg` -> `background` -- user-extensible via associative array |
| **Native Expansion** | Globs, `$parameters`, `$(command substitution)`, `=(process substitution)`, `!history` expansion via zle `expand-word` |
| **Tabstop Snippets** | Aliases with `$ZPWR_TABSTOP` placeholders act as templates -- cursor jumps to the placeholder on expansion |
| **Self-Referential Alias Escape** | `alias git="hub"` expands to `\hub` -- backslash-escapes the first word to prevent infinite recursion |
| **Correct-Then-Expand** | Typo correction chains into alias expansion in a single keypress |
| **Quote-Aware Expansion** | Optionally expands aliases inside `"double"` or `'single'` quoted strings in argument position (not command position) |
| **Suffix Alias Expansion** | `file.txt<space>` -> `vim file.txt` -- expands suffix aliases (`alias -s`) at command position |
| **Autopair Integration** | Detects [autopair](https://github.com/hlissner/zsh-autopair) and delegates space insertion to preserve bracket/quote auto-pairing |
| **History Injection** | Optionally writes the fully-expanded form of your command into history |
| **Debug Widget** | `Esc Ctrl+D` shows parser state -- prefix chain, command position, expansion action -- without modifying the line |

---

### // EXPANSION RULES

```
COMMAND POSITION
  alias in first word position         => expanded
  alias after sudo/env/builtin/etc     => expanded (case-insensitive: SUDO, Sudo, sUdO — works on macOS/Windows)
  word is a real command/function       => NOT corrected (valid commands are left alone)

GLOBAL
  global alias anywhere on line         => expanded
  misspelling anywhere on line          => corrected
  globs, $params, history               => expanded

CURSOR RULES
  cursor directly after word            => expand
  one space after word (menuselect)     => expand
  two spaces after word                 => bypass
```

---

### // SUPPORTED PREFIXES AND FLAGS

Shell builtins/keywords (must precede external wrappers):

| Prefix | Flags | Example |
|---|---|---|
| `nocorrect` | — | `nocorrect gco` |
| `time` | `-p` `-l` `-v` | `time -plv gco` |
| `-` | — | `- gco` |
| `builtin` | — | `builtin gco` |
| `command` | `-p` | `command -p gco` |
| `exec` | `-c` `-l` `-a NAME` | `exec -cl -a name gco` |
| `eval` | — | `eval gco` |
| `noglob` | — | `noglob gco` |
| `coproc` | — | `coproc gco` |

External prefix commands:

| Prefix | Combo flags | Flag-with-arg | Example |
|---|---|---|---|
| `sudo` | `-A -B -b -E -e -H -i -K -k -l -L -N -n -P -S -s -V -v` | `-C N` `-D DIR` `-g GRP` `-h HOST` `-p PROMPT` `-R DIR` `-T SEC` `-U USER` `-u USER` `--` | `sudo -kE -u root gco` |
| `doas` | `-L -n -s` | `-u USER` `-C CFG` `--` | `doas -n -u root gco` |
| `env` | `-0 -i -v` | `-a ARG` `-C DIR` `-P PATH` `-S STR` `-u VAR` `--` | `env -0iv -C /tmp -u HOME gco` |
| `nice` | — | `-n ADJ` `-ADJ` | `nice -n 10 gco` |
| `time` | `-p -l -v` | — | `time -v gco` |
| `nohup` | — | — | `nohup gco` |
| `rlwrap` | `-a -c -E -h -i -I -m -n -N -o -R -r -U -v -W -X` | `-b CHARS` `-C NAME` `-D N` `-e CHAR` `-f FILE` `-g REGEX` `-H FILE` `-l FILE` `-M EXT` `-O REGEX` `-p COLOR` `-P INPUT` `-q CHARS` `-s N` `-S PROMPT` `-t NAME` `-w MS` `-z FILTER` | `rlwrap -acN -f comp -s 500 gco` |
| `timeout` | `-f -p -v` | `-k DUR` `-s SIG` | `timeout -k 10 30 gco` |
| `strace` | `-A -c -C -d -D -f -F -h -i -k -n -N -q -r -t -T -v -V -w -x -y -Y -z -Z` | `-a COL` `-b SYS` `-e EXPR` `-E VAR` `-I N` `-o FILE` `-O N` `-p PID` `-P PATH` `-s SZ` `-S BY` `-u USER` `-U COL` `-X FMT` | `strace -cf -s 256 gco` |
| `ltrace` | `-b -c -C -f -h -i -L -r -S -t -T -V` | `-a COL` `-A N` `-D MASK` `-e FILTER` `-F PATH` `-l LIB` `-n NR` `-o FILE` `-p PID` `-s SZ` `-u USER` `-w NR` `-x FILTER` | `ltrace -f -l libfoo gco` |
| `ionice` | `-t` | `-c CLASS` `-n LEVEL` | `ionice -c 2 -n 7 gco` |
| `caffeinate` | `-d -i -m -s -u` | `-t SEC` `-w PID` | `caffeinate -i gco` |
| `setsid` | `-c -f -w` | — | `setsid -f gco` |
| `chrt` | `-a -b -d -e -f -i -m -o -p -r -R -v` | `-D NS` `-P NS` `-T NS` | `chrt -f 10 gco` |
| `taskset` | `-a -c -p` | — | `taskset -c 0-3 gco` |
| `watch` | `-b -C -c -d -e -f -g -p -r -t -w -x` | `-n INTERVAL` `-q CYCLES` `-s DIR` | `watch -d -n 1 gco` |
| `flock` | `-e -F -n -o -s -u -x` | `-c CMD` `-w SEC` `-E N` | `flock -w 5 /tmp/lock gco` |
| `chroot` | — | — | `chroot /path gco` |
| `runuser` | `-f -l -m -p -P -T` | `-c CMD` `-g GRP` `-s SHELL` `-G GRP` `-u USER` `-w LIST` | `runuser -u deploy gco` |
| `unshare` | `-c -C -f -i -m -n -p -r -T -u -U` `--fork` `--map-root-user` `--map-current-user` `--map-auto` `--map-subids` `--keep-caps` `--mount-proc[=MP]` `--mount-binfmt[=MP]` `--kill-child[=SIG]` `--mount[=F]` `--uts[=F]` `--ipc[=F]` `--net[=F]` `--pid[=F]` `--user[=F]` `--cgroup[=F]` `--time[=F]` | `-R DIR` `-w DIR` `-S UID` `-G GID` `-l FILE` `--propagation MODE` `--setgroups ALLOW\|DENY` `--map-user UID` `--map-users MAP` `--map-group GID` `--map-groups MAP` `--owner UID:GID` `--monotonic OFF` `--boottime OFF` `--` | `unshare -p --fork --mount-proc gco` |
| `cpulimit` | `-v -i -z` | `-e EXE` `-l LIMIT` `-p PID` | `cpulimit -l 50 gco` |
| `su` | `-f -l -m -p -P -T` | `-c CMD` `-s SHELL` `-g GRP` `-G GRP` `-w LIST` `--` | `su -l root gco` |
| `stdbuf` | — | `-i MODE` `-o MODE` `-e MODE` | `stdbuf -oL gco` |
| `sg` | — | — | `sg staff gco` |
| `choom` | — | `-n ADJ` `-p PID` | `choom -n -1000 gco` |
| `nsenter` | `-a -c -C -e -F -i -m -n -p -r -T -u -U -w -W -Z` | `-t PID` `-S UID` `-G GID` `-N FD` | `nsenter -t 1 -m gco` |
| `numactl` | `-a -b -l -s -H` | `-i NODES` `-C CPUS` `-N NODES` `-m NODES` `-p PID` `-w NODES` `-P NODES` | `numactl -C 0,1 gco` |
| `prlimit` | — | `-o COLS` `-p PID` `--RESOURCE=LIMIT` | `prlimit --nofile=1024 gco` |
| `setpriv` | `-d` | `--reuid UID` `--regid GID` `--groups LIST` `--inh-caps CAPS` `--ambient-caps CAPS` `--bounding-set CAPS` `--securebits BITS` `--selinux-label LBL` `--apparmor-profile PRF` `--pdeathsig SIG` `--no-new-privs` `--clear-groups` `--keep-groups` `--init-groups` `--reset-env` | `setpriv --reuid=1000 --inh-caps=-all gco` |
| `setarch` | `-v -3 -B -F -I -L -R -S -T -X -Z` | `-p PID` | `setarch i386 -R gco` |
| `linux32` `linux64` | `-v -3 -B -F -I -L -R -S -T -X -Z` | `-p PID` | `linux32 -R gco` |
| `runcon` | `-c` | `-u USER` `-r ROLE` `-t TYPE` `-l RANGE` `--` | `runcon -t httpd_t gco` |
| `xvfb-run` | `-a -l` | `-e FILE` `-f FILE` `-n NUM` `-p PROTO` `-s ARGS` `-w SEC` `--` | `xvfb-run -a gco` |
| `chpst` | `-v -V -P -0 -1 -2` | `-u USER` `-U USER` `-b ARGV0` `-e DIR` `-/ ROOT` `-n INC` `-l LOCK` `-L LOCK` `-m BYTES` `-d BYTES` `-o N` `-p N` `-f BYTES` `-c BYTES` `-t SEC` | `chpst -u www -m 200000 gco` |
| `cgexec` | — | `-g CTRL:PATH` `--sticky` | `cgexec -g cpu:mygroup gco` |
| `trickle` | `-s -v` | `-d RATE` `-u RATE` `-w LEN` `-t SEC` `-l LEN` `-n PATH` `-P PATH` | `trickle -d 100 -u 50 gco` |
| `faketime` | `-f -m` | `-p PID` | `faketime '2020-01-01' gco` |
| `proot` | `-0` | `-r PATH` `-b SRC:DST` `-m SRC:DST` `-q CMD` `-w DIR` `-v LVL` `-k REL` `-i UID:GID` `-R PATH` `-S PATH` | `proot -0 -r /jail gco` |
| `bwrap` | `--unshare-* --clearenv --new-session --die-with-parent --as-pid-1` | `--bind SRC DST` `--ro-bind SRC DST` `--dev-bind SRC DST` `--setenv VAR VAL` `--tmpfs DST` `--proc DST` `--dev DST` `--uid UID` `--gid GID` | `bwrap --ro-bind / / --unshare-net gco` |
| `capsh` | `--print --noamb --noenv --quiet` | `--caps=TXT` `--drop=LIST` `--uid=UID` `--gid=GID` `--user=NAME` `--chroot=PATH` `--shell=PATH` `--` | `capsh --drop=cap_net_raw -- gco` |
| `valgrind` | `-d -h -q -s -v` | `--tool=NAME` `--log-file=FILE` `--*=VAL` | `valgrind --tool=memcheck gco` |
| `fakeroot` | `-h -u -v` | `-b FD` `-i FILE` `-l LIB` `-s FILE` `--` | `fakeroot gco` |
| `unbuffer` | `-p` | — | `unbuffer -p gco` |
| `chronic` | `-e -v` | — | `chronic -v gco` |
| `torsocks` | `-6 -d -h -i -q` | `-a ADDR` `-p PASS` `-P PORT` `-u USER` | `torsocks gco` |
| `proxychains4` | `-q` | `-f FILE` | `proxychains4 -q gco` |
| `daemonize` | `-a -v` | `-c DIR` `-e FILE` `-E VAR` `-l FILE` `-o FILE` `-p FILE` `-u USER` | `daemonize -u www gco` |
| `firejail` | — | `-c CMD` `--*=VAL` `--*` | `firejail --private gco` |
| `sem` | — | `-j N` `-P N` `--*=VAL` `--*` | `sem -j 4 gco` |
| `systemd-run` | `-d -G -h -P -q -r -R -S -t -T -v` | `-C CAP` `-E VAR` `-H HOST` `-M MACH` `-p PROP` `-u UNIT` `--*=VAL` `--*` | `systemd-run -t gco` |
| `nocache` | — | `-n N` | `nocache gco` |
| `fakechroot` | `-h -s -v` | `-b DIR` `-c DIR` `-d LINKER` `-e ENV` `-l LIB` | `fakechroot gco` |
| `ccache` | `-c -C -h -p -s -v -V -x -z` | `-d PATH` `-F NUM` `-k KEY` `-M SIZE` `-o KEY=VAL` `-X LVL` | `ccache gco` |
| `distcc` | `-j` | — | `distcc gco` |
| `pkexec` | — | `-u USER` `--user USER` `--disable-internal-agent` `--keep-cwd` | `pkexec -u admin gco` |
| `torify` | `-v` | — | `torify gco` |
| `dbus-run-session` | — | `--config-file FILE` `--dbus-daemon BIN` `--*=VAL` `--` | `dbus-run-session gco` |
| `dbus-launch` | `--sh-syntax` `--csh-syntax` `--auto-syntax` `--binary-syntax` `--close-stderr` `--exit-with-session` `--exit-with-x11` | `--autolaunch=ID` `--config-file=FILE` | `dbus-launch gco` |
| `eatmydata` | — | `--` | `eatmydata -- gco` |
| `tsocks` `catchsegv` | — | — | `tsocks gco` |

All prefixes support `\escaped`, `'single-quoted'`, and `"double-quoted"` forms. `sudo`/`doas`/`env`/`nice`/`time`/`nohup`/`rlwrap` are case-insensitive. Variable assignments (`X=1`, `PATH=/usr/bin`) are stripped automatically at any position:

```
X=1 sudo gco                    =>  X=1 sudo git checkout
sudo X=1 env Y=2 gco            =>  sudo X=1 env Y=2 git checkout
env FOO=bar BAZ=qux gco         =>  env FOO=bar BAZ=qux git checkout
PATH=/usr/bin LANG=C sudo gco   =>  PATH=/usr/bin LANG=C sudo git checkout
```

---

### // BYPASS PROTOCOLS

**Ctrl+Space** -- insert a literal space, no expansion.

**Blacklist** -- permanently exclude aliases from expansion:

```sh
export ZPWR_EXPAND_BLACKLIST=(g gco)
```

---

### // CONFIGURATION MATRIX

```sh
# -- CORE --
export ZPWR_EXPAND=true                   # alias expansion in first position
export ZPWR_EXPAND_SECOND_POSITION=true   # alias expansion after sudo/env
export ZPWR_EXPAND_NATIVE=true            # expand globs, history, $params

# -- CORRECTION --
export ZPWR_CORRECT=true                  # spelling correction
export ZPWR_CORRECT_EXPAND=true           # expand aliases after correction

# -- QUOTES --
export ZPWR_EXPAND_QUOTE_DOUBLE=true      # expand inside "double quotes"
export ZPWR_EXPAND_QUOTE_SINGLE=false     # expand inside 'single quotes'

# -- HISTORY --
export ZPWR_EXPAND_TO_HISTORY=false       # inject expanded form into history
export ZPWR_EXPAND_PRE_EXEC_NATIVE=true   # expand globs on accept-line

# -- SUFFIX --
export ZPWR_EXPAND_SUFFIX=true            # expand suffix aliases (alias -s)

# -- BLACKLIST --
export ZPWR_EXPAND_BLACKLIST=(g gco)      # aliases to never expand
```

---

### // KEY BINDINGS

| Key | Action |
|---|---|
| `Space` | Supernatural expand + insert space |
| `Ctrl+Space` | Insert literal space (bypass) |
| `Esc Ctrl+E` | Expand global alias at cursor |
| `^\` | Debug widget -- show parser state without expanding |

---

### // CUSTOM CORRECTIONS

The correction dictionary is a plain associative array. Add your own entries after the plugin loads, then rebuild the O(1) reverse lookup:

```sh
# map misspellings to the correct word
ZPWR_EXPAND_CORRECT_WORDS[kubernetes]="k8ss kuberntes kuberneets"
ZPWR_EXPAND_CORRECT_WORDS[terraform]="terrafrom terrafomr"

# append to an existing built-in entry
ZPWR_EXPAND_CORRECT_WORDS[echo]+=" oech"

# remove a built-in correction
unset 'ZPWR_EXPAND_CORRECT_WORDS[background]'

# rebuild the reverse lookup table after any changes
zpwrExpandRebuildCorrectReverse
```

The key is the correct word, the value is a space-separated list of misspellings. Use underscores in keys to expand to spaces (e.g. `hello_world` expands to `hello world`).

---

### // VERSUS THE COMPETITION

| Feature | zsh-expand | [zsh-abbr](https://github.com/olets/zsh-abbr) | [zsh-abbrev-alias](https://github.com/momo-lab/zsh-abbrev-alias) | [globalias](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/globalias) |
|---|---|---|---|---|
| Uses native `alias` / `global alias` | **yes** | no (own `abbr` cmd) | no (own `abbrev-alias` cmd) | yes |
| Expands after 62 prefix commands with flags | **yes** | no | no | no |
| Full parser for prefix/flag/arg stripping | **yes** | no | no | no |
| Context-aware `VAR=val` vs flag-arg handling | **yes** | no | no | no |
| Positional arg depth limits (`su gco` != command) | **yes** | no | no | no |
| Spelling correction (290+ built-in) | **yes** | no | no | no |
| User-extensible corrections | **yes** | no | no | no |
| No correction of valid commands | **yes** | n/a | no | no |
| Glob / history / param expansion | **yes** | no | no | yes |
| Suffix alias expansion | **yes** | no | no | no |
| Tabstop snippets (cursor placement) | **yes** | no | no | no |
| Self-referential alias escape | **yes** | no | no | no |
| Correct-then-expand chaining | **yes** | no | no | no |
| History injection | **yes** | no | no | no |
| Expand inside quotes | **yes** | no | no | no |
| Autopair integration | **yes** | no | no | no |
| Case-insensitive prefix matching | **yes** | no | no | no |
| Blacklist / filter | **yes** | n/a | no | yes |
| Test suite | **10,000+** | yes | no | no |
| Pure zsh (no external deps) | **yes** | yes | yes | ohmyzsh |
| Active (2026) | **yes** | yes | slow (2024) | stale (2020) |

---

### // TABSTOP SNIPPETS

Define aliases with `$ZPWR_TABSTOP` placeholders to turn them into IDE-style snippets. On expansion, the cursor jumps to the placeholder instead of the end of the line:

```sh
alias gc="git commit -m ${ZPWR_TABSTOP}"
alias gca="git commit --amend -m ${ZPWR_TABSTOP}"
```

```
gc<space>  =>  git commit -m |    (cursor here)
```

No other zsh expansion plugin supports cursor placement on expansion.

---

### // SELF-REFERENTIAL ALIAS ESCAPE

If an alias expands to something whose first word is the alias name itself, zsh-expand backslash-escapes it to prevent infinite recursion:

```sh
alias git="hub"
```

```
git<space>  =>  \hub    (escaped, won't re-expand)
```

Other plugins either infinite-loop or silently break on this.

---

### // CORRECT-THEN-EXPAND

When `ZPWR_CORRECT_EXPAND=true`, typo correction chains into alias expansion in a single keypress:

The spelling corrector fires first, then the corrected word is re-checked for alias expansion -- all before the space character is inserted.

---

### // EXPAND INSIDE QUOTES

Optionally expand aliases inside quoted strings in argument position. Quoted words at command position are never expanded.

```sh
export ZPWR_EXPAND_QUOTE_DOUBLE=true   # expand inside "double quotes"
export ZPWR_EXPAND_QUOTE_SINGLE=true   # expand inside 'single quotes'
```

```
echo "gco<space>"  =>  echo "git checkout "   (argument — expanded)
"gco"<space>       =>  "gco"                  (command position — not expanded)
```

---

### // SUFFIX ALIAS EXPANSION

When `ZPWR_EXPAND_SUFFIX=true`, suffix aliases (`alias -s`) are expanded at command position:

```sh
alias -s txt=vim
alias -s py=python
alias -s json=jq
```

```
file.txt<space>       =>  vim file.txt
script.py<space>      =>  python script.py
./data.json<space>    =>  jq ./data.json
```

Works with history injection -- the expanded form is saved to history on accept-line.

---

### // AUTOPAIR INTEGRATION

If [zsh-autopair](https://github.com/hlissner/zsh-autopair) is loaded, zsh-expand delegates space insertion to `autopair-insert` so bracket and quote auto-pairing is preserved during expansion.

---

### // HISTORY INJECTION

When `ZPWR_EXPAND_TO_HISTORY=true`:

After running a command with unexpanded aliases, the **expanded** form is saved into history (up 2 lines), while the unexpanded form appears up 1 line and is never written to `$HISTFILE`. Same expansion rules as spacebar -- `sudo gco` becomes `sudo git checkout` in history.

Enable native expansion on accept-line:

```sh
export ZPWR_EXPAND_PRE_EXEC_NATIVE=true
```

---

### // DEBUG WIDGET

Press `Esc Ctrl+D` to inspect the parser's view of the current line without expanding anything:

```
┌── zsh-expand debug ────────────────┐
│ input:    sudo -kE -u root gco     │
│ words:    3 [sudo -kE -u root gco] │
│ prefix:   sudo -kE -u root         │
│ command:  gco                      │
│ lastword: gco                      │
│ action:   alias -> git checkout    │
│ valid:    no (gco not found)       │
└────────────────────────────────────┘
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
```

Shows the parsed prefix chain, identified command position, what expansion would fire, and whether the command word exists. Useful for debugging why something isn't expanding or verifying the parser is consuming flags correctly.

---

### // COMMAND-POSITION PARSER

Previous versions used a single POSIX extended regex to match prefix commands and their flags. This worked for simple cases but couldn't scale -- every new command and flag combination made the regex longer and harder to debug. Flag arguments containing `=` (like `strace -e trace=network`) were incorrectly stripped as variable assignments.

The current architecture uses a **left-to-right parser** (`zpwrExpandParserFindCommandPosition`) that walks the word array and understands shell grammar:

```
Phase 1: consume shell keywords (nocorrect, time -p, builtin, command -p, exec -cl, eval, noglob, coproc, -)
Phase 2: consume privilege-escalation prefixes (sudo, doas, su, ...) and command wrappers (env, nice, strace, timeout, ionice, caffeinate, ...)
Result:  everything remaining is the command + arguments
```

Each command has its own `case` branch that knows exactly which flags take arguments and which positional args are mandatory. This means:

- `strace -e trace=network gco` -- the parser knows `-e` takes an argument, so `trace=network` is consumed as a flag value, not stripped as a variable assignment. `gco` expands correctly.
- `env -i FOO=bar gco` -- the parser knows `FOO=bar` after `env` is an environment variable, not a shell assignment. `gco` expands correctly.
- `sudo -kE -u root gco` -- the parser knows `-u` takes an argument (`root`), so it consumes both. `gco` expands correctly.
- `su gco` -- the parser knows `gco` is the USER argument, not a command. `gco` does **not** expand. But `su root gco` expands correctly because `root` fills the USER slot and `gco` is at command position.
- Same for `timeout gco` (DURATION), `chroot gco` (PATH), `taskset gco` (MASK), `chrt gco` (PRIORITY), `sg gco` (GROUP), `flock gco` (FILE) -- mandatory positional args are never mistaken for commands.

Adding a new prefix command is a single `case` branch:

```zsh
mynewcmd)
    (( pos++ ))
    while (( pos <= $#words )); do
        _zpwr_bare "$words[$pos]"
        case $REPLY in
            -[vq]*)    (( pos++ )) ;;           # combo flags
            -[of])     (( pos++ )); (( pos <= $#words )) && (( pos++ )) ;; # flag with arg
            *)         break ;;
        esac
    done
    ;;
```

The parser exposes two results for downstream consumers:

| Variable | Contents | Example |
|---|---|---|
| `ZPWR_VARS[cachedRegexMatch]` | tail: command + args after all prefixes | `gco arg1 arg2` |
| `ZPWR_VARS[cachedParserPrefix]` | everything consumed as prefix | `sudo -kE -u root env -i` |

---

### // PERFORMANCE

Source files can be compiled to `.zwc` bytecode for instant loading (`zcompile` or via your plugin manager). The plugin uses zero external commands -- no `sed`, `awk`, `grep`, or subshells. Every expansion runs in pure zsh builtins and parameter expansion, keeping latency invisible on every keypress.

Benchmarks (Apple Silicon, 10,000 iterations):

| Scenario | Per call |
|---|---|
| `file.txt` (suffix alias) | ~31 µs |
| `sudo file.txt` (prefix + suffix) | ~130 µs |
| `gco` (regular alias) | ~36 µs |

Human perception threshold is ~100ms -- these are 770-3200x below that.

Stress test scaling (Apple Silicon, full prefix chain per loop):

| Input size | Tokens | Expand | Time |
|---|---|---|---|
| 7 KB | 1.4K | YES | 22 ms |
| 69 KB | 14K | YES | 536 ms |
| 343 KB | 70K | YES | 10 sec |
| 687 KB | 140K | YES | 39 sec |
| 1.3 MB | 280K | YES | 2.5 min |
| 3.4 MB | 700K | YES | 15.5 min |

The parser never fails -- it just gets slower on inputs no human would ever type. The bottleneck is zsh's `(z)` word splitter, not the parser itself. Normal command lines are under 1KB and expand in under 1ms.

How deep can you actually chain? The parser handles all of it instantly -- the OS is the limit:

| Command | Max depth | Limiting factor |
|---|---|---|
| `sudo sudo sudo ... gco` | ~512 | PTY allocation (`sudo` needs a pseudo-terminal for auth) |
| `env env env ... gco` | ~50,000-100,000 | `ARG_MAX` (1MB kernel limit on `execve()` argument list) |
| Parser (LBUFFER) | unlimited | Heap memory only -- no kernel limit on zsh's line editor |

---

### // TEST COVERAGE

A large [zunit](https://github.com/zunit-zsh/zunit) suite (10,000+ discrete `@test` blocks). Exact totals change frequently — print them from the repo root with:

```sh
zsh scripts/count-tests.zsh
```

Coverage includes alias expansion, global aliases, suffix aliases, spelling correction, command-position parsing, word parsing, native expansion, config flags, tab stops, prefix chains, command existence checks, integration flows, and edge cases (including parser regressions such as `ltrace -n` / `-b` flag arguments). Dedicated files exercise assignment stripping, `--` end-of-options, phase-1 shell keywords (`nocorrect`, `time`, `command`, `exec`, …), sandbox/build helpers (`xvfb-run`, `systemd-run`, `bwrap`, `ccache`, …), namespace and capability stacks (`unshare`, `nsenter`, `prlimit`, deep `sudo`/`env`), trace/wrap helpers (`rlwrap`, `timeout`, `strace`, `ltrace`), scheduling (`watch`, `ionice`, `chrt`, `taskset`, `caffeinate`, `setsid`), mixed-case wrapper spellings (`SUDO`, `DoAs`, `ENV`, … — `tests/t-parser-case-insensitive-prefix.zsh`), dbus session helpers and network proxies (`dbus-run-session`, `dbus-launch`, `torify`, `eatmydata`, `torsocks`, `pkexec`, `distcc`, … — `tests/t-parser-dbus-torify-proxy.zsh`), the debug widget’s Unicode box renderer (`zpwrExpandBox` — `tests/t-box-fuzz.zsh`), `su` / `runuser` / `sg` login stacks (`tests/t-parser-su-logins.zsh`), backslash- and quote-stripped wrapper words (`tests/t-parser-backslash-escape.zsh`), deeper `bwrap` / `fakeroot` / `systemd-run` / `capsh` / `valgrind` stacks (`tests/t-parser-sandbox-service.zsh`), and long prefix chains (`tests/t-parser-assignments-and-wrappers.zsh`, `tests/t-parser-phase1-keywords.zsh`, `tests/t-parser-wrapper-misc.zsh`, `tests/t-parser-capability-namespace.zsh`, `tests/t-parser-rlwrap-timeout-strace.zsh`, `tests/t-parser-watch-sched.zsh`, `tests/t-ltrace-parser-regression.zsh`).

```sh
zunit
```

---

### // INSTALL

#### Zinit
```sh
source "$HOME/.zinit/bin/zinit.zsh"
zinit ice lucid nocompile
zinit load MenkeTechnologies/zsh-expand
```

#### Oh My Zsh
```sh
cd "$HOME/.oh-my-zsh/custom/plugins" && git clone https://github.com/MenkeTechnologies/zsh-expand.git
```
```sh
# ~/.zshrc
plugins+=(zsh-expand)
```

#### Manual
```sh
git clone https://github.com/MenkeTechnologies/zsh-expand.git
```
Source `zsh-expand.plugin.zsh` in `~/.zshrc`.

---

### // THE MONSTER CHAIN

No other expansion plugin can do this. 12 shell builtin permutations up front, then every one of the 62 command wrapper commands duplicated with different flag combos. `strace` with all 38 flags and `ltrace` with all 25 flags. Variable assignments scattered everywhere. Shell builtins come first (they only exist inside zsh), then command wrappers chain freely. The parser consumes the entire prefix and `gco` expands to `git checkout`:

```
nocorrect time -p command -p builtin eval noglob coproc       \
  exec -cl -a p1                                              \
  nocorrect builtin eval noglob coproc time -l command -p     \
  nocorrect noglob builtin eval coproc time -v command        \
  builtin nocorrect eval noglob coproc                        \
  eval nocorrect noglob builtin coproc                        \
  noglob nocorrect builtin eval coproc time -p command -p     \
  exec -c -a p2 builtin eval nocorrect noglob coproc          \
  coproc nocorrect noglob builtin eval time -l command -p     \
  builtin eval nocorrect noglob coproc time -v command -p     \
  eval noglob nocorrect builtin coproc                        \
  noglob coproc nocorrect builtin eval time -p command        \
  nocorrect eval noglob builtin coproc                        \
  torify -v sudo -elNVvkE -D /chdir -U other -u root          \
    su -flmpPT -c cmd deploy                                  \
    env -a argv0 -0iv -C /tmp VAR1=a VAR2=b                   \
  doas -Lns -u ops env FOO=bar BAZ=qux LANG=C                \
  sudo -ABbEHiKkNnPS -g wheel -h h1 -p pw -R /ch -D /d1     \
    -T 60 -U deploy -u admin                                  \
  su -flmT root env -i HOME=/r1 PATH=/b1 TERM=x1             \
  doas -s -C /etc/d1 env -u DISPLAY TERM=xterm-256           \
  sudo -kKi -u nobody env -v -C /var CC=gcc CFLAGS=-O2       \
  sudo -kE -u daemon env -0i -C /opt RUST_LOG=debug          \
  doas -Ln -u _www env -i SHELL=/bin/zsh EDITOR=vim           \
  torsocks -diq6 -a 127.0.0.1 -P 9050 -u tor -p pass         \
    sudo -kE -u test env -i GOPATH=/go                        \
  proxychains4 -q -f /etc/pc.conf                             \
  su -s /bin/zsh -g staff root stdbuf -i 0 -o L -e 0         \
  nice -n 10 -- nohup -- nice -n 5 nohup nice -n 1 nohup     \
  nice -n 19 nohup nice -n 15 nohup nice -n 12 nohup         \
  rlwrap -acEhiImnNoRrUvWX -b x -C name -D 2 -e ch           \
    -f /d1 -g pat -H /h1 -l log -M ext -O re -P inp          \
    -p red -q ch -s 500 -S p1 -t term -w 50 -z filt --       \
  timeout -fpv -k 5 -s TERM 30                                \
  strace -AcCdDfFhiknNqrtTvVwxyYzZ -a 80 -b execve           \
    -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc  \
    -s 256 -S time -u strace -U 80 -X raw --                  \
  ltrace -bcCfhiLrStTV -a 60 -A 10 -D 0xff -e malloc          \
    -F /etc/ltrace.conf -l libfoo -n 2 -o /t2 -p 2           \
    -s 128 -u ltrace -w 3 -x dlopen --                        \
  ionice -t -c 2 -n 7 -- caffeinate -dimsu -t 60 -w 1234     \
  setsid -cfw -- chrt -adepRv -D 1000 -P 2000 -T 500 -f 10  \
  taskset -acp 0-3 --                                         \
  watch -bdCcefgprtwx -n 2 -q 5 -s /shots --                  \
  nsenter -aceiFmnpruUCTwWZ -t 1 -S 0 -G 0 -N 3 --           \
  numactl -absHl -C 0-3 -i all -m 0 -N 0 -p 1 -w 0 -P 1     \
  choom -n -500 -- sg staff                                   \
  flock -eFnosux -c cmd -w 10 -E 2 /tmp/lk1 chroot -- /nr1   \
  runuser -fmlpPT -c cmd -g staff -s /bin/bash -G docker      \
    -u deploy -w 1,2 --                                       \
  unshare -cfmnpuUirCT -R /root -w /wd -S 1000 -G 1000       \
    -l /tmp/ns --                                             \
  prlimit --nofile=4096 -o RES -p 1234                        \
  cpulimit -viz -e myapp -p 1234 -l 50 --                     \
  setpriv --reuid=1000 --regid=1000 --clear-groups --         \
  setarch i386 -vhV3BFILRSTXZ -p 1234 --                      \
  pkexec -u admin --keep-cwd --disable-internal-agent         \
  fakeroot -huv -b 10 -i /tmp/save -l /usr/lib/fk.so          \
    -s /tmp/save --                                           \
  unbuffer -p chronic -ev --                                   \
  valgrind -dhqsv --tool=memcheck --log-file=/tmp/vg --       \
  daemonize -av -c /tmp -e /var/log/err -E FOO=bar            \
    -l /tmp/lock -o /var/log/out -p /var/run/pid -u www --    \
  firejail -c cmd --private --net=none --                      \
  sem -j 4 -P 8 --                                            \
  systemd-run -dGhPqrRSTtv -C cap -E VAR=val -H host          \
    -M mach -p prop -u unit --                                \
  nocache -n 2 --                                              \
  fakechroot -hsv -b /base -c /cfg -d /ld -e env -l /lib --  \
  ccache -cChpsvVxz -d /cache -F 1000 -k key -M 5G            \
    -o opt=val -X 80                                          \
  distcc -j                                                   \
  dbus-launch --exit-with-session --config-file=foo.conf --   \
  dbus-run-session --config-file /etc/dbus.conf --             \
  torify tsocks catchsegv eatmydata --                         \
  sudo -kE -u www su root stdbuf -oL --                        \
    env -a arg -0i -C /v2 PATH=/b2 GOPATH=/go                 \
  doas -Lns -u _httpd                                         \
  nice -n 8 -- nohup -- nice -n 3 nohup                       \
  rlwrap -acEiINoRrUvWX -f /d2 -s 1000 -b y -H /h2           \
    -p blue -S p2 -C n2 -D 1 -z f2 --                        \
  timeout -fpv -k 10 -s KILL 60                                \
  strace -ANnw -e trace=file -s 512 -o /t3 -X raw            \
  ltrace -L -l libbar -A 5 -n 1 -w 2 -e open -s 64           \
    -a 40 -o /t4                                              \
  ionice -t -c 1 -n 3 -- caffeinate -im -t 120                \
  setsid -f -- chrt -adepRv -r 20 taskset -acp 0-7 --        \
  watch -bdCcefgprtwx -n 5 -q 3 -s /d2 --                     \
  nsenter -aceZTwW -t 2 -S 1 -G 1 -N 4 --                     \
  numactl -absH -i all -w 1 -P 2 choom -n -1000 --            \
  flock -eFnox -c cmd2 -w 3 -E 3 /tmp/lk2 chroot -- /nr2     \
  runuser -fmpPT -u op -c cmd2 -g sys -s /bin/zsh -w 3 --    \
  unshare -cfmnpuUirCT -R /nr -S 500 -G 500 -l /ns --        \
  prlimit --nproc=512 -o COL -p 5678                          \
  cpulimit -viz -e app2 -p 5678 -l 75 --                      \
  pkexec -u op --keep-cwd                                      \
  fakeroot -u -s /tmp/s2 --                                    \
  unbuffer -p chronic -v --                                    \
  valgrind -qv --tool=callgrind --                             \
  daemonize -v -c /srv -u op --                                \
  firejail --private --                                        \
  sem -j 2 -- systemd-run -dGqt -u u2 -p p2 --                \
  nocache -n 1 -- fakechroot -s -l /lib2 --                    \
  ccache distcc dbus-launch --exit-with-x11 --                 \
  dbus-run-session -- torify tsocks catchsegv eatmydata --     \
  sudo -kE -u root su root stdbuf -o 0 --                      \
    env -a a2 -0iv -C /final VAR=last FINAL=yes                \
  doas -Ln -u root                                             \
  nice -n 0 -- nohup -- time -v gco<space>
  =>  ...git checkout
```

Scales to 96,000+ tokens (468KB) and beyond. `ARG_MAX` only matters at `execve()` time -- zsh's line editor is just a string in memory with no kernel limit. Try that with a regex.

And if you want one that looks like it was written by someone who should be institutionalized -- triple-proxied through tor, user-switched twice, namespace-entered, NUMA-pinned, OOM-adjusted, stream-buffered, resource-limited, traced at the syscall AND library level with every flag maxed, CPU limited to 1%, real-time priority 99, pinned to 64 cores, locked, chrooted, jailed, namespaced, sandboxed, daemonized, caffeinated for 24 hours:

```
nocorrect noglob builtin eval coproc time -p command -p       \
  exec -cl -a BEAST                                           \
  nocorrect builtin eval noglob coproc time -v command        \
  eval nocorrect noglob builtin coproc                        \
  torify                                                      \
  sudo -kKEHnPS -g wheel -h fortress -p "password is gco"    \
    -R /dungeon -r overlord -T 9999 -t unconfined_t -u root  \
  su -l deploy                                                \
  env -0iv -C /dev/null                                       \
    DOOM=eternal FEAR=none PATH=/usr/games LANG=chaos         \
    CC=gcc CXX=g++ CFLAGS=-O666 LDFLAGS=-lmadness            \
    RUST_LOG=trace GOPATH=/void NODE_ENV=destruction           \
    EDITOR=ed VISUAL=ed PAGER=cat SHELL=/bin/zsh              \
  doas -Ls -C /etc/doas.d/monster -u _chaos                   \
  torsocks -diq6 -a 127.0.0.1 -P 9050 -u tor -p chaos        \
  sudo -kE -u daemon su -T root env -i                        \
    MALLOC_CHECK_=3 LD_PRELOAD=/lib/libevil.so                \
    ASAN_OPTIONS=detect_leaks=1                               \
    UBSAN_OPTIONS=print_stacktrace=1                          \
  proxychains4 -q -f /etc/proxychains.conf                    \
  stdbuf -i 0 -o L -e 0 --                                    \
  nice -n -20 -- nohup -- nice -n 19 nohup                    \
  nice -n 0 nohup                                             \
  strace -AcCdDfFhiknNqrtTvVwxyYzZ                            \
    -a 132 -b execve -e trace=all                             \
    -E LD_LIBRARY_PATH -I 1                                   \
    -o /tmp/strace.nightmare.log -O 999                       \
    -p 1 -P /proc/self/exe                                    \
    -s 1048576 -S calls                                       \
    -u strace -U 132 -X raw --                                \
  ltrace -bcCfhiLrStTV                                        \
    -a 132 -A 999 -D 0xff -e '*'                              \
    -F /etc/ltrace.conf -l libc                               \
    -n 4 -o /tmp/ltrace.abyss.log                             \
    -p 1 -s 1048576 -u ltrace -w 8 -x dlopen --               \
  ionice -c 1 -n 0 --                                         \
  caffeinate -dimsu -t 86400 -w 1                             \
  setsid -cfw --                                              \
  chrt -adepRv -D 1000 -P 2000 -T 500 -f 99                  \
  taskset -acp 0-63 --                                        \
  nsenter -aceiFmnpruUCTwWZ -t 1 -S 0 -G 0 -N 3 --           \
  numactl -absHl -C 0-63 -i all -m all -N 0 -p 1 -w 0 -P 1  \
  choom -n -1000 --                                           \
  sg nogroup                                                  \
  watch -bdCcefgprtwx -n 1 -q 10 -s /dir --                   \
  flock -eFnosux -c cmd -w 3600 -E 42 /tmp/lock.of.ages --   \
  chroot -- /newroot/of/all/evil                              \
  runuser -fmlpPT -c cmd -g nogroup -s /bin/sh -G wheel       \
    -u nobody -w 1,2 --                                       \
  unshare -cfmnpuUirCT -R /root -w /wd -S 0 -G 0 -l /ns --  \
  prlimit --nofile=1048576 --nproc=unlimited -o RES -p 1      \
  cpulimit -viz -e doom -p 1 -l 1 --                          \
  setpriv --reuid=0 --regid=0 --clear-groups --               \
  setarch x86_64 -vhV3BFILRSTXZ -p 1 --                       \
  rlwrap -acEhiImnNoRrUvWX                                    \
    -b '(){}[]<>' -C BEAST -D 2 -e ch                         \
    -f /usr/share/dict/words -g pat                           \
    -H /tmp/history.of.madness -l /tmp/rl.log                 \
    -M ext -O re -P inp -p magenta -q ch                      \
    -s 999999 -S 'MONSTER> ' -t term -w 50 -z filt --         \
  timeout -fpv -k 1 -s KILL 86400                             \
  pkexec -u admin --keep-cwd --disable-internal-agent         \
  fakeroot -huv -b 10 -i /tmp/save -l /usr/lib/fk.so          \
    -s /tmp/save --                                           \
  unbuffer -p chronic -ev --                                   \
  valgrind -dhqsv --tool=memcheck --log-file=/tmp/vg --       \
  daemonize -av -c /tmp -e /var/log/err -E FOO=bar            \
    -l /tmp/lock -o /var/log/out -p /var/run/pid -u www --    \
  firejail -c cmd --private --net=none --                      \
  sem -j 4 -P 8 --                                            \
  systemd-run -dGhPqrRSTtv -C cap -E VAR=val -H host          \
    -M mach -p prop -u unit --                                \
  nocache -n 2 --                                              \
  fakechroot -hsv -b /base -c /cfg -d /ld -e env -l /lib --  \
  ccache -cChpsvVxz -d /cache -F 1000 -k key -M 5G            \
    -o opt=val -X 80                                          \
  distcc -j                                                   \
  dbus-launch --exit-with-session --config-file=db.conf --    \
  dbus-run-session --config-file /etc/dbus.conf --             \
  torify tsocks catchsegv eatmydata --                         \
  sudo -kE -u www-data su -lT app stdbuf -oL --               \
    env -a arg -0iv -C /srv                                    \
    DATABASE_URL=postgres://doom:fire@localhost/inferno        \
    REDIS_URL=redis://localhost:6379/0                         \
    SECRET_KEY=hunter2 API_KEY=sk-AAAA                        \
  doas -Ln -u _deploy                                         \
  nice -n -10 -- nohup --                                      \
  strace -ANnwcfkqrTvV -e trace=network -s 4096               \
    -o /tmp/net.log -X raw                                    \
  ltrace -bcCfhiLrStTV -l libssl -A 5 -n 1 -w 2               \
    -e 'ssl_*' -s 4096 -o /tmp/ssl.log                        \
  ionice -t -c 2 -n 7 --                                      \
  caffeinate -im -t 3600                                      \
  setsid -f --                                                \
  chrt -adepRv -r 50                                          \
  taskset -acp 0 --                                            \
  nsenter -aceZTwW -t 2 -S 1 -G 1 -N 4 --                     \
  numactl -absH -i all -w 1 -P 2 choom -n 500 --              \
  flock -eFx -c cmd -w 60 -E 1 /tmp/final.lock --             \
  chroot -- /srv/jail                                         \
  runuser -fmpPT -u app -c cmd -g app -s /bin/zsh -w 1 --    \
  unshare -cfmnpuUirCT -R /jail -S 500 -G 500 -l /ns --      \
  prlimit --memlock=unlimited -o COL -p 2                     \
  cpulimit -viz -e app -p 2 -l 100 --                          \
  pkexec -u root --keep-cwd                                    \
  fakeroot -u -s /tmp/s2 --                                    \
  unbuffer -p chronic -v --                                    \
  valgrind -qv --tool=callgrind --                             \
  daemonize -v -c /srv -u root --                              \
  firejail --private --                                        \
  sem -j 2 -- systemd-run -dGqt -u u2 -p p2 --                \
  nocache -n 1 -- fakechroot -s -l /lib2 --                    \
  ccache distcc dbus-launch --exit-with-x11 --                 \
  dbus-run-session -- torify tsocks eatmydata --               \
  sudo -kE -u root su root stdbuf -o 0 --                      \
    env -a a2 -i PATH=/usr/bin LAST_WORDS=goodbye              \
  doas -Ln -u root                                             \
  nice -n 0 -- nohup -- time -v gco<space>
  =>  ...git checkout
```

---
<p align="center"><sub>// end of line</sub></p>
