#!/usr/bin/env zsh
# Print @test counts for the zunit suite (source of truth: tests/*.zsh).
emulate -L zsh
builtin setopt extended_glob null_glob
local -a files=(tests/*.zsh)
local f n t
n=0
for f in "${files[@]}"; do
  t=$(command grep -c '^@test' "$f" 2>/dev/null) || t=0
  (( n += t ))
done
print -r "test_files=${#files}"
print -r "test_blocks=$n"
