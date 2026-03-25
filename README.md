# zsh-expand

```
 _______ _____  _____        _______ _     _ _____  _______ __   _ ______
    /   |_____] |_____|    |______ _\__/_ |_____] |_____| | \  | |     \
   /    |_____] |     |    |______ /\ /\  |       |     | |  \_| |_____/
```

> *Jack into your shell. Let the machine think faster than you can type.*

---

### // WHAT IS THIS

A high-voltage **zsh plugin** that intercepts your spacebar and **expands** everything in its path -- regular aliases, global aliases, misspellings, globs, history, parameters, and more. No pipes. No external commands. Pure zsh. Maximum speed.

```
gco<space>  =>  git checkout
sudo gco<space>  =>  sudo git checkout
teh<space>  =>  the
```

### // DEMO

[![asciicast](https://asciinema.org/a/FbFsuMCSLtooqkB5ZZbBZeiEg.svg)](https://asciinema.org/a/FbFsuMCSLtooqkB5ZZbBZeiEg)

---

### // NEURAL EXPANSION CORE

| Layer | What It Does |
|---|---|
| **Alias Expansion** | Expands regular aliases in command position and after `sudo`, `env`, `builtin`, `command`, `noglob`, `nice`, `nohup`, `rlwrap`, `time` and linear combos of these with options |
| **Global Alias Expansion** | Expands global aliases anywhere on the command line |
| **Spelling Correction** | 300+ hardcoded misspelling/abbreviation corrections -- `teh` -> `the`, `cmd` -> `command`, `bg` -> `background` |
| **Native Expansion** | Globs, `$parameters`, `$(command substitution)`, `=(process substitution)`, `!history` expansion via zle `expand-word` |
| **History Injection** | Optionally writes the fully-expanded form of your command into history |

---

### // EXPANSION RULES

```
COMMAND POSITION
  alias in first word position         => expanded
  alias after sudo/env/builtin/etc     => expanded
  word is a real command/function       => NOT expanded (no clobbering)

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

# -- BLACKLIST --
export ZPWR_EXPAND_BLACKLIST=(g gco)      # aliases to never expand
```

---

### // KEY BINDINGS

| Key | Action |
|---|---|
| `Space` | Supernatural expand + insert space |
| `Ctrl+Space` | Insert literal space (bypass) |
| `Esc Ctrl+E` | Expand all global aliases on line |

---

### // VERSUS THE COMPETITION

#### [zsh-abbrev-alias](https://github.com/momo-lab/zsh-abbrev-alias)

| | zsh-expand | zsh-abbrev-alias |
|---|---|---|
| Uses native `alias` / `global alias` | yes | no (separate `abbrev-alias` cmd) |
| Expands after `sudo`/`env`/`builtin` combos | yes | no |
| Spelling correction | yes | no |
| Glob / history / param expansion | yes | no |

---

### // HISTORY INJECTION

When `ZPWR_EXPAND_TO_HISTORY=true`:

After running a command with unexpanded aliases, the **expanded** form is saved into history (up 2 lines), while the unexpanded form appears up 1 line and is never written to `$HISTFILE`. Same expansion rules as spacebar -- `sudo gco` becomes `sudo git checkout` in history.

Enable native expansion on accept-line:

```sh
export ZPWR_EXPAND_PRE_EXEC_NATIVE=true
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
