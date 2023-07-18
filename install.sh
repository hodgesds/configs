#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# $HOME/.config setup
for dir in ${SCRIPT_DIR}/.config/*
do
  if [ ! -d "${HOME}/.config/$(basename ${dir})" ]; then
    ln -s -t "${HOME}/.config/" "${dir}"
  fi
done

# $HOME dotfiles
configs=(
  .bashrc
  .ctags
  .curlrc
  .fzf.bash
  .gdbinit
  .gitconfig
  .vimrc
)
for config in "${configs[@]}"; do
  if [ ! -f "${HOME}/${config}" ]; then
    ln -s "${SCRIPT_DIR}/${config}" "${HOME}/${config}" 
  fi
done
