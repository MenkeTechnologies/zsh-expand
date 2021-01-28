# zsh-expand
This plugin expands regular aliases, global aliases, incorrect spellings and phrases, globs, command/process substitution, =command expansion, history expansion and $parameters with the spacebar key 

Expansion of regular aliases is done in the command/first position of a statement and after certain commands (sudo, env, zpwr) when in other positions in a statement 

Expansion of global aliases, incorrect spellings and phrases, globs, history expansion and $parameters is global to command line.  Exception to this is when in command position and word in command position is a command, function etc., then no expansion will be performed.

Expansion on aliases and global aliases occurs when cursor is on position right of expansion candidate or there is one space between cursor and expansion candidate (for expansion from menuselect).  Two spaces after expansion candidate will prevent expansion on spacebar.

Expansion on history, globs, parameters and mispellings occurs when cursor is on position right of expansion candidate.  A space after expansion candidate will prevent expansion on spacebar.

## Comparison to other expanding abbrevation libraries 
### [zsh-abbr](https://github.com/olets/zsh-abbr)
#### Features that zsh-abbr has but zsh-expand does not
- separate abbr command
#### Features that zsh-expand has but zsh-abbr does not
- zsh-expand uses aliases with no need of separate abbr command
- zsh-expand expands global aliases
- zsh-expand expands aliases after builtin/command/sudo/env and linear combinations of these with and without options
    - `sudo gco<space> => sudo git checkout`
    - `\builtin \command \sudo -u root -E \env gco<space> => \builtin \command \sudo -u root -E \env git checkout`
- zsh-expand expands incorrect spellings and phrases, globs, command/process substitution, =command expansion, history expansion and $parameters

### [zsh-abbrev-alias](https://github.com/momo-lab/zsh-abbrev-alias)
#### Features that zsh-abbrev-alias has but zsh-expand does not
- separate abbrev-alias command
#### Features that zsh-expand has but zsh-abbr does not
- zsh-expand uses aliases and global aliases with no need of separate abbrev-alias command
- zsh-expand expands aliases after builtin/command/sudo/env and linear combinations of these with and without options 
    - `sudo gco<space> => sudo git checkout`
    - `\builtin \command \sudo -u root -E \env gco<space> => \builtin \command \sudo -u root -E \env git checkout`
- zsh-expand expands incorrect spellings and phrases, globs, command/process substitution, =command expansion, history expansion and $parameters

## Bypassing expansion
Expansion can be temporarily bypassed with control-space.

You can override the following environment variables to control expansion.
```sh
# aliases expand in first position
export ZPWR_EXPAND=true
# aliases expand in second position after sudo
export ZPWR_EXPAND_SECOND_POSITION=true
# expand globs, history etc with zle expand-word
export ZPWR_EXPAND_NATIVE=true
# spelling correction in zsh-expand plugin
export ZPWR_CORRECT=true
# aliases expand after spelling correction
export ZPWR_CORRECT_EXPAND=true
# expand inside "
export ZPWR_EXPAND_QUOTE_DOUBLE=true
# expand inside '
export ZPWR_EXPAND_QUOTE_SINGLE=false
```

## Install for Zinit
> `~/.zshrc`
```sh
source "$HOME/.zinit/bin/zinit.zsh"
zinit ice lucid nocompile
zinit load MenkeTechnologies/zsh-expand
```

## Install for Oh My Zsh

```sh
cd "$HOME/.oh-my-zsh/custom/plugins" && git clone https://github.com/MenkeTechnologies/zsh-expand.git
```

Add `zsh-expand` to plugins array in `~/.zshrc`
> `~/.zshrc`
```sh
plugins+=(zsh-expand)
```

## General Install

```sh
git clone https://github.com/MenkeTechnologies/zsh-expand.git
```

source zsh-expand.plugin.zsh in `~/.zshrc`

