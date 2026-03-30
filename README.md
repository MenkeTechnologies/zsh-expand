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

### // THE MONSTER CHAIN

No other expansion plugin can do this. 12 shell builtin permutations up front, then every one of the 62 command wrapper commands duplicated with different flag combos. `strace` and `ltrace` with all 40 flags maxed out. Variable assignments scattered everywhere. Shell builtins come first (they only exist inside zsh), then command wrappers chain freely. The parser consumes the entire prefix and `gco` expands to `git checkout`:

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
  torify sudo -kE -u root su -l deploy                        \
    env -0iv -C /tmp VAR1=a VAR2=b                            \
  doas -n -u ops env FOO=bar BAZ=qux LANG=C                  \
  sudo -ABbHnPS -g wheel -h h1 -p pw -R /ch -D /d1 -T 60    \
    -U deploy -u admin                                        \
  su -flm root env -i HOME=/r1 PATH=/b1 TERM=x1              \
  doas -s -C /etc/d1 env -u DISPLAY TERM=xterm-256           \
  sudo -kKi -u nobody env -v -C /var CC=gcc CFLAGS=-O2       \
  sudo -kE -u daemon env -0i -C /opt RUST_LOG=debug          \
  doas -n -u _www env -i SHELL=/bin/zsh EDITOR=vim            \
  torsocks sudo -kE -u test env -i GOPATH=/go                 \
  proxychains4                                                \
  su -s /bin/zsh -g staff root stdbuf -i 0 -o L -e 0         \
  nice -n 10 nohup nice -n 5 nohup nice -n 1 nohup           \
  nice -n 19 nohup nice -n 15 nohup nice -n 12 nohup         \
  rlwrap -acirN -f /d1 -s 500 -b x -H /h1 -p red -S p1      \
  timeout -k 5 -s TERM 30                                     \
  strace -cCdDfFhikqrtTvVwxXyYzZ -a 80 -b 32                 \
    -e trace=network -E LD -I 1 -o /t1 -O 50 -p 1 -P /proc  \
    -s 256 -S time -u 40 -U 80                                \
  ltrace -cCdDfFhikqrtTvVwxXyYzZ -a 60 -b 16 -e malloc       \
    -E MALLOC -I 2 -o /t2 -O 25 -p 2 -P /lib -s 128         \
    -S calls -u 20 -U 40                                      \
  ionice -t -c 2 -n 7 caffeinate -dimsu -t 60 -w 1234        \
  setsid -cf chrt -f 10 taskset -c 0-3                        \
  watch -dgtecxbp -n 2                                        \
  nsenter -t 1 -m -u -i -n -p                                 \
  numactl -C 0-3 -m 0 choom -n -500                           \
  sg staff                                                    \
  flock -nsux -w 10 -E 2 /tmp/lk1 chroot /nr1                \
  runuser -l -u deploy -g staff -G docker                     \
  unshare -fmnpuUirC --                                       \
  prlimit --nofile=4096 cpulimit -l 50                        \
  pkexec fakeroot unbuffer chronic valgrind                   \
  torify torsocks tsocks proxychains4                         \
  daemonize firejail sem systemd-run dbus-run-session         \
  sudo -kE -u www su root stdbuf -oL                          \
    env -0i -C /v2 PATH=/b2 GOPATH=/go                        \
  doas -n -u _httpd                                           \
  nice -n 8 nohup nice -n 3 nohup                             \
  rlwrap -acN -f /d2 -s 1000 -b y -H /h2 -p blue -S p2      \
  timeout -k 10 -s KILL 60                                    \
  strace -cfkqrTvV -e trace=file -s 512 -o /t3               \
  ltrace -cfhikrtTvV -e open -s 64 -a 40 -o /t4              \
  ionice -c 1 -n 3 caffeinate -im -t 120                      \
  setsid -f chrt -r 20 taskset -c 0-7                         \
  watch -dx -n 5                                              \
  nsenter -t 2 -m numactl -i all choom -n -1000               \
  flock -nx -w 3 -E 3 /tmp/lk2 chroot /nr2                   \
  runuser -u op -g sys unshare -mn --                         \
  prlimit --nproc=512 cpulimit -l 75                          \
  pkexec fakeroot unbuffer chronic valgrind                   \
  torify torsocks proxychains4                                \
  daemonize firejail sem systemd-run dbus-run-session         \
  sudo -kE -u test su -l svc stdbuf -e 0                      \
    env -i RUST_LOG=trace NODE_ENV=prod                        \
  doas -n -u _test                                            \
  nice -n 7 nohup nice -n 2 nohup                             \
  rlwrap -air -f /d3 -s 200 -b z -H /h3 -p green -S p3      \
  timeout -k 2 -s HUP 15                                      \
  strace -cf -e trace=open -s 64 -o /t5                       \
  ltrace -cf -e free -s 32 -a 20 -o /t6                       \
  ionice -t -c 3 -n 0 caffeinate -d -t 30                     \
  setsid -cfw chrt -i 0 taskset -c 0                          \
  watch -dt -n 1                                              \
  nsenter -t 3 -n sg wheel                                    \
  flock -su -w 1 -E 1 /tmp/lk3 chroot /nr3                   \
  runuser -l -u svc -g svc unshare -fpU --                    \
  prlimit --stack=8192 cpulimit -l 25                         \
  pkexec fakeroot unbuffer chronic valgrind                   \
  torify torsocks tsocks proxychains4                         \
  daemonize firejail sem systemd-run dbus-run-session         \
  sudo -kKnP -u op -T 120 -D /tmp -U mgr                     \
    su -P root env -0iv -C /run DB=pg REDIS=6379              \
  doas -s -C /etc/d2                                          \
  nice -n 14 nohup nice -n 9 nohup nice -n 4 nohup           \
  rlwrap -aciN -f /d4 -s 750 -b w -H /h4 -p cyan -S p4      \
  timeout -k 8 -s USR1 45                                     \
  strace -dDfFhikwxXyYzZ -a 100 -b 64 -e trace=desc          \
    -E PATH -I 3 -o /t7 -O 75 -p 3 -P /dev -s 384           \
    -S calls -u 60 -U 100                                     \
  ltrace -dDfFhikwxXyYzZ -a 80 -b 48 -e write -E HOME        \
    -I 4 -o /t8 -O 50 -p 4 -P /sys -s 192 -S time           \
    -u 30 -U 60                                               \
  ionice -t -c 2 -n 5 caffeinate -dimsu -t 90 -w 5678        \
  setsid -cf chrt -b 5 taskset -c 0-15                        \
  watch -dgtecxbp -n 3                                        \
  nsenter -t 4 -m -u numactl -N 0 -m 0 choom -n 100          \
  flock -nsux -w 15 -E 4 /tmp/lk4 chroot /nr4                \
  runuser -l -u admin -g adm -G wheel                         \
  unshare -fmnpuUirC --                                       \
  prlimit --memlock=unlimited cpulimit -l 90                  \
  pkexec fakeroot unbuffer chronic valgrind                   \
  torify torsocks tsocks proxychains4                         \
  daemonize firejail sem systemd-run dbus-run-session         \
  sudo -kE -u root su root stdbuf -o 0                        \
    env -0iv -C /final VAR=last FINAL=yes                      \
  doas -n -u root                                             \
  nice -n 0 nohup time -v gco<space>
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
  doas -s -C /etc/doas.d/monster -u _chaos                   \
  torsocks                                                    \
  sudo -kE -u daemon su root env -i                           \
    MALLOC_CHECK_=3 LD_PRELOAD=/lib/libevil.so                \
    ASAN_OPTIONS=detect_leaks=1                               \
    UBSAN_OPTIONS=print_stacktrace=1                          \
  proxychains4                                                \
  stdbuf -i 0 -o L -e 0                                      \
  nice -n -20 nohup                                           \
  nice -n 19 nohup                                            \
  nice -n 0 nohup                                             \
  strace -cCdDfFhikqrtTvVwxXyYzZ                              \
    -a 132 -b 65536 -e trace=all                              \
    -E LD_LIBRARY_PATH -I 1                                   \
    -o /tmp/strace.nightmare.log -O 999                       \
    -p 1 -P /proc/self/exe                                    \
    -s 1048576 -S calls                                       \
    -u 80 -U 132                                              \
  ltrace -cCdDfFhikqrtTvVwxXyYzZ                              \
    -a 132 -b 65536 -e '*'                                    \
    -E HOME -I 1                                              \
    -o /tmp/ltrace.abyss.log -O 999                           \
    -p 1 -P /lib/x86_64-linux-gnu                             \
    -s 1048576 -S time                                        \
    -u 80 -U 132                                              \
  ionice -c 1 -n 0                                            \
  caffeinate -dimsu -t 86400 -w 1                             \
  setsid -cfw                                                 \
  chrt -f 99                                                  \
  taskset -c 0-63                                             \
  nsenter -t 1 -m -u -i -n -p                                 \
  numactl -C 0-63 -m all                                      \
  choom -n -1000                                              \
  sg nogroup                                                  \
  watch -dgtecxbp -n 1                                        \
  flock -nsux -w 3600 -E 42 /tmp/lock.of.ages                \
  chroot /newroot/of/all/evil                                 \
  runuser -l -u nobody -g nogroup -G wheel                    \
  unshare -fmnpuUirC --                                       \
  prlimit --nofile=1048576 --nproc=unlimited                  \
  cpulimit -l 1                                               \
  rlwrap -acirN                                               \
    -f /usr/share/dict/words                                  \
    -s 999999                                                 \
    -b '(){}[]<>'                                             \
    -H /tmp/history.of.madness                                \
    -p magenta                                                \
    -S 'MONSTER> '                                            \
  timeout -k 1 -s KILL 86400                                  \
  pkexec fakeroot unbuffer chronic                            \
  valgrind                                                    \
  daemonize firejail sem systemd-run dbus-run-session         \
  tsocks                                                      \
  sudo -kE -u www-data su -l app stdbuf -oL                   \
    env -0iv -C /srv                                           \
    DATABASE_URL=postgres://doom:fire@localhost/inferno        \
    REDIS_URL=redis://localhost:6379/0                         \
    SECRET_KEY=hunter2 API_KEY=sk-AAAA                        \
  doas -n -u _deploy                                          \
  nice -n -10 nohup                                           \
  strace -cfkqrTvV -e trace=network -s 4096 -o /tmp/net.log  \
  ltrace -cfhikrtTvV -e 'ssl_*' -s 4096 -o /tmp/ssl.log     \
  ionice -t -c 2 -n 7                                        \
  caffeinate -im -t 3600                                      \
  setsid -f                                                   \
  chrt -r 50                                                  \
  taskset -c 0                                                \
  nsenter -t 2 -m -n numactl -i all choom -n 500             \
  flock -x -w 60 -E 1 /tmp/final.lock                        \
  chroot /srv/jail                                            \
  runuser -u app -g app                                       \
  unshare -mn --                                              \
  prlimit --memlock=unlimited cpulimit -l 100                 \
  pkexec fakeroot unbuffer chronic valgrind                   \
  torify torsocks tsocks proxychains4                         \
  daemonize firejail sem systemd-run dbus-run-session         \
  sudo -kE -u root su root stdbuf -o 0                        \
    env -i PATH=/usr/bin LAST_WORDS=goodbye                    \
  doas -n -u root                                             \
  nice -n 0 nohup time -v gco<space>
  =>  ...git checkout
```

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
| **Correct-Then-Expand** | Typo correction chains into alias expansion in a single keypress |
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
| `strace` `ltrace` | `-c -C -d -D -f -h -i -k -L -N -n -q -r -t -T -v -V -y -Y -z -Z` | `-a COL` `-A N` `-b SZ` `-e EXPR` `-E VAR` `-F LIST` `-I N` `-l LIB` `-n N` `-o FILE` `-O N` `-p PID` `-P PATH` `-s SZ` `-S BY` `-u USER` `-U COL` `-w N` `-X FMT` | `strace -cf -s 256 gco` |
| `ionice` | `-t` | `-c CLASS` `-n LEVEL` | `ionice -c 2 -n 7 gco` |
| `caffeinate` | `-d -i -m -s -u` | `-t SEC` `-w PID` | `caffeinate -i gco` |
| `setsid` | `-c -f -w` | — | `setsid -f gco` |
| `chrt` | `-a -b -d -e -f -i -m -o -p -r -R -v` | `-D NS` `-P NS` `-T NS` | `chrt -f 10 gco` |
| `taskset` | `-a -c -p` | — | `taskset -c 0-3 gco` |
| `watch` | `-b -C -c -d -e -f -g -p -r -t -w -x` | `-n INTERVAL` `-q CYCLES` `-s DIR` | `watch -d -n 1 gco` |
| `flock` | `-e -F -n -o -s -u -x` | `-c CMD` `-w SEC` `-E N` | `flock -w 5 /tmp/lock gco` |
| `chroot` | — | — | `chroot /path gco` |
| `runuser` | `-f -l -m -p -P -T` | `-c CMD` `-g GRP` `-s SHELL` `-G GRP` `-u USER` `-w LIST` | `runuser -u deploy gco` |
| `unshare` | `-c -C -f -i -m -n -p -r -T -u -U` | `-R DIR` `-w DIR` `-S UID` `-G GID` `-l FILE` `--` | `unshare -mn gco` |
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
| `file.txt` (suffix alias) | ~175 µs |
| `sudo file.txt` (prefix + suffix) | ~190 µs |
| `gco` (regular alias) | ~284 µs |

Human perception threshold is ~100ms -- these are 350-570x below that.

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
