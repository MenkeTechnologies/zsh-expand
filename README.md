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

### // WHAT IS THIS

**The world's most powerful zsh expansion plugin.** Intercepts your spacebar and expands everything in its path -- regular aliases, global aliases, suffix aliases, misspellings, globs, history, parameters, and more. No pipes. No external commands. Pure zsh. Sub-millisecond. 10,000+ tests.

```
gco<space>  =>  git checkout
sudo gco<space>  =>  sudo git checkout
teh<space>  =>  the

# deep prefix chain — all flags parsed, alias still expanded:
nocorrect time -p command sudo -kE -u root env -0iv -C /tmp \
  nice -n 10 rlwrap -acN -f comp nohup gco<space>
  =>  ...git checkout

# extreme stack — proxy, auth, env, debug, scheduling, sandbox,
# process control, wrapper, all with flags:
torify sudo -kE -u root env -0iv -C /tmp                     \
  strace -f -e trace=network ionice -c 2 chrt -f 10          \
  taskset -c 0 nice -n 10 caffeinate -i setsid -f            \
  flock /tmp/lock timeout 30 unbuffer rlwrap -acN             \
  cpulimit -l 50 nohup time -v gco<space>
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
| **Spelling Correction** | 300+ built-in misspelling/abbreviation corrections -- `teh` -> `the`, `cmd` -> `command`, `bg` -> `background` -- user-extensible via associative array |
| **Native Expansion** | Globs, `$parameters`, `$(command substitution)`, `=(process substitution)`, `!history` expansion via zle `expand-word` |
| **Tabstop Snippets** | Aliases with `$ZPWR_TABSTOP` placeholders act as templates -- cursor jumps to the placeholder on expansion |
| **Self-Referential Alias Escape** | `alias git="hub"` expands to `\hub` -- backslash-escapes the first word to prevent infinite recursion |
| **Correct-Then-Expand** | Typo correction chains into alias expansion in a single keypress -- `goc` -> `gco` -> `git checkout` |
| **Quote-Aware Expansion** | Optionally expands aliases inside `"double"` or `'single'` quoted strings in argument position (not command position) |
| **Suffix Alias Expansion** | `file.txt<space>` -> `vim file.txt` -- expands suffix aliases (`alias -s`) at command position |
| **Autopair Integration** | Detects [autopair](https://github.com/hlissner/zsh-autopair) and delegates space insertion to preserve bracket/quote auto-pairing |
| **History Injection** | Optionally writes the fully-expanded form of your command into history |

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

External wrappers (execvp commands):

| Prefix | Combo flags | Flag-with-arg | Example |
|---|---|---|---|
| `sudo` | `-A -B -b -E -H -k -K -n -P -S -i -s` | `-C N` `-g GRP` `-h HOST` `-p PROMPT` `-R DIR` `-r ROLE` `-T SEC` `-t TYPE` `-u USER` `--` | `sudo -kE -u root gco` |
| `doas` | `-n -s` | `-u USER` `-C CFG` `--` | `doas -n -u root gco` |
| `env` | `-0 -i -v` | `-C DIR` `-P PATH` `-S STR` `-u VAR` `--` | `env -0iv -C /tmp -u HOME gco` |
| `nice` | — | `-n ADJ` `-ADJ` | `nice -n 10 gco` |
| `time` | `-p -l -v` | — | `time -v gco` |
| `nohup` | — | — | `nohup gco` |
| `rlwrap` | `-a -c -i -N -r` | `-b CHARS` `-f FILE` `-H FILE` `-p COLOR` `-s N` `-S PROMPT` | `rlwrap -acN -f comp -s 500 gco` |
| `timeout` | — | `-k DUR` `-s SIG` | `timeout -k 10 30 gco` |
| `strace` `ltrace` | `-c -C -d -D -f -F -h -i -k -q -r -t -T -v -V -w -x -X -y -Y -z -Z` | `-a COL` `-b SZ` `-e EXPR` `-E VAR` `-I N` `-o FILE` `-O N` `-p PID` `-P PATH` `-s SZ` `-S BY` `-u COL` `-U COL` | `strace -cf -s 256 gco` |
| `ionice` | `-t` | `-c CLASS` `-n LEVEL` | `ionice -c 2 -n 7 gco` |
| `caffeinate` | `-d -i -m -s -u` | `-t SEC` `-w PID` | `caffeinate -i gco` |
| `setsid` | `-c -f -w` | — | `setsid -f gco` |
| `chrt` | `-b -f -i -m -o -r` | — | `chrt -f 10 gco` |
| `taskset` | `-c` | — | `taskset -c 0-3 gco` |
| `watch` | `-d -g -t -e -c -x -b -p -w` | `-n INTERVAL` | `watch -d -n 1 gco` |
| `flock` | `-n -s -u -x` | `-w SEC` `-E N` | `flock -w 5 /tmp/lock gco` |
| `chroot` | — | — | `chroot /path gco` |
| `runuser` | `-l` | `-u USER` `-g GRP` `-G GRP` | `runuser -u deploy gco` |
| `unshare` | `-f -m -n -p -u -U -i -r -C` | `--` | `unshare -mn gco` |
| `cpulimit` | — | `-l LIMIT` | `cpulimit -l 50 gco` |
| `pkexec` `fakeroot` `unbuffer` `chronic` `valgrind` | — | — | `valgrind gco` |
| `torify` `torsocks` `tsocks` `proxychains4` | — | — | `torify gco` |
| `firejail` `daemonize` `sem` `systemd-run` | — | — | `firejail gco` |

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
| Expands after 30+ prefix commands with flags | **yes** | no | no | no |
| Full parser for prefix/flag/arg stripping | **yes** | no | no | no |
| Context-aware `VAR=val` vs flag-arg handling | **yes** | no | no | no |
| Spelling correction (300+ built-in) | **yes** | no | no | no |
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

```
goc<space>  =>  gco  =>  git checkout    (corrected, then expanded)
```

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

### // COMMAND-POSITION PARSER

Previous versions used a single POSIX extended regex to match prefix commands and their flags. This worked for simple cases but couldn't scale -- every new command and flag combination made the regex longer and harder to debug. Flag arguments containing `=` (like `strace -e trace=network`) were incorrectly stripped as variable assignments.

The current architecture uses a **left-to-right parser** (`zpwrExpandParserFindCommandPosition`) that walks the word array and understands shell grammar:

```
Phase 1: consume shell keywords (nocorrect, time -p, builtin, command -p, exec -cl, eval, noglob, coproc, -)
Phase 2: consume execvp wrappers (sudo, doas, env, nice, strace, timeout, ionice, caffeinate, ...)
Result:  everything remaining is the command + arguments
```

Each command has its own `case` branch that knows exactly which flags take arguments. This means:

- `strace -e trace=network gco` -- the parser knows `-e` takes an argument, so `trace=network` is consumed as a flag value, not stripped as a variable assignment. `gco` expands correctly.
- `env -i FOO=bar gco` -- the parser knows `FOO=bar` after `env` is an environment variable, not a shell assignment. `gco` expands correctly.
- `sudo -kE -u root gco` -- the parser knows `-u` takes an argument (`root`), so it consumes both. `gco` expands correctly.

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
| `file.txt` (suffix alias) | ~175 µs |
| `sudo file.txt` (prefix + suffix) | ~190 µs |
| `gco` (regular alias) | ~284 µs |

Human perception threshold is ~100ms -- these are 350-570x below that.

---

### // TEST COVERAGE

10,000+ tests across 31 test files using [zunit](https://github.com/zunit-zsh/zunit). Covers alias expansion, global aliases, suffix aliases, spelling correction, command-position regex matching, word parsing, native expansion, config flags, tab stops, prefix chains, command existence checks, integration flows, and edge cases.

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

<p align="center"><sub>// end of line</sub></p>
