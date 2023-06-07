#!/bin/bash

# git aliases
git config --global alias.co checkout
git config --global alias.ca 'commit --amend'
git config --global alias.can 'commit --ammend --no-edit'
git config --global alias.cm 'commit -m'
git config --global alias.lg 'log --graph --all --oneline --abbrev-commit'

cp .bash_aliases ~/