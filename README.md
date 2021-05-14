# quality_life_scripts

Collections of scripts used for random-small projects

## Description

This repository is used to store random scripts used for small projects, such as extracting and renaming w10 login wallpaper files.

### vim-ide-installer.sh

This vim and plugins installer works for pacman package manager only. Install the folling plugins and dependencies:
* Vim
* Vundle (plugin manager)
* vim-polyglot (Provides language packs and indentation)
* auto-pairs (Provides pair completion when typing (,{,etc.)
* NERDTree (Provides an Integrated file system explorer)
* Tagbar (Add a panel that display source file's tag) and ctags package (dependency)
* CTRLS.vim (Enables asynchronous search in the file system) and ack package (dependency)
* Fswitch (Enable switching between header and implementation files)
* Vim-protodef (Enable function prototypes pull into implementation files)
* you-complete-me (Enable a powerfull code autocompletion plug-in)

Also populate the `~/.vimrc` file with several conf for those plugins. Tweek it at your convenance. 

**Install process**

1. Go to the file path `cd ~/Downloads` (for example)
2. Exec `bash vim-ide-installer.sh`
3. Enter sudo
4. Done! 
