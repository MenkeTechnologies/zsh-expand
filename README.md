# zsh-expand
This plugin expands regular aliases, global aliases, incorrect spellings and phrases, globs, history expansion and $parameters with the spacebar key.

Expansion of regular aliases is done in the command/first position of a statement and after certain commands (sudo, env, zpwr) when in other positions in a statement.

Expansion of global aliases, incorrect spellings and phrases, globs, history expansion and $parameters is global to command line.

## Bypassing expansion
Expansion can be temporarily bypassed with control-space.

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

Add `zsh-expand` to plugins array in ~/.zshrc

## General Install

```sh
git clone https://github.com/MenkeTechnologies/zsh-expand.git
```

source zsh-expand.plugin.zsh from .zshrc

