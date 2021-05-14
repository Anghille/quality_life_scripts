#!/bin/bash

# Prepare variables
BOLD=$(tput bold)
FAINT="\e[2m"
GREEN="\e[32m"
ENDFORMAT=$(tput sgr0)
USER=$(whoami)
OUTPUt=""

# Plugin selection
## Welcome message
echo -e "$BOLD Vim IDE Install Script.$ENDFORMAT
$FAINT This script is used to install Vim and Plugins.$ENDFORMAT"

# VIM_POLYGLOT "Provides language packs and indentation"
# AUTO_PAIRS "Provides pair completion when typing \{\(...]"
# NERDtree "Provides an Integrated file system explorer"
# TAGBAR "Add a panel that display source file's tag"
# CTRLS.VIM "Enables asynchronous search in the file system"
# FSWITCH "Enable switching between header and implementation files"
# VIM_PROTODEF "Enable function prototypes pull into implementation files"
# YOU_COMPLETE_ME "Enable a powerfull code autocompletion plug-in" 


# ---Installing VIM and create ~/.vimrc with basic conf---
cat "" > /home/$USER/.vimrc
echo -e "[$GREEN*$ENDFORMAT] $GREEN Installing VIM$ENDFORMAT"
sudo pacman -S --noconfirm vim
cat <<TMP >> /home/$USER/.vimrc

" --VIM CONF--
set nu " Enable line numbers  
syntax on " Enable syntax highlighting 
set incsearch " Enable incremental search
set hlsearch " Enable highlight search  

" Configure the buil-in terminal used with :term
set termwinsize=12x0   " Set terminal size
set splitbelow         " Always split below
set mouse=a            " Enable mouse drag on window splits

" Vim tab behavior
set tabstop=4 " How many columns of whitespace a \t is worth
set shiftwidth=4 " How many columns of whitespace a \"level of indentation\" is worth
set expandtab " Use spaces when tabbing

" VIM colorscheme
set background=dark   " dark or light
TMP



# ---Installing Vundle Plugin manager---
echo -e "[*] Installing VUNDLE - plug-in manager for vim"
###
if [ -d "/home/$USER/.vim" ];
then
	rm -rf /home/$USER/.vim
fi
mkdir /home/$USER/.vim
###
if [ -d "/home/$USER/.vim/bundle" ];
then
	rm -rf /home/$USER/.vim/bundle
fi
mkdir /home/$USER/.vim/bundle

## To avoid git error about "folder already existing", remove folder if existing
if [ -d "/home/$USER/.vim/bundle/Vundle.vim" ];
then
	rm -rf /home/$USER/.vim/bundle/Vundle.vim
fi

## Clone Vundle and prepare conf
git clone https://github.com/VundleVim/Vundle.vim.git /home/$USER/.vim/bundle/Vundle.vim;
touch /home/$USER/.vimrc || echo "File .vimrc already exists...Skipping"

cat <<TMP >> /home/$USER/.vimrc

" --VUNDLE & PLUGINS CONF--
" To install new plugins hosted on GitHub,
" Use format Plugin \'<git_account>/<repo_name>\'
" Put this template between
" call vundle#begin() and call vundle#end()
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=/home/$USER/.vim/bundle/Vundle.vim

" Download plug-ins to the /home/$USER/.vim/plugged/ directory
call vundle#begin('/home/$USER/.vim/plugged')

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Add colorscheme
Plugin 'kristijanhusak/vim-hybrid-material'

call vundle#end()
filetype plugin indent on
TMP

## Exec vundle plugin installation
vim +PluginInstall +qall


# ---Install plugins using vundle---               
## VIM POLYGLOT
sed -i "/^call vundle#begin/a \" vim-polyglot - Provides language packs and indentation\nPlugin 'sheerun/vim-polyglot'" /home/$USER/.vimrc

## VIM AUTOPAIRS
sed -i "/^call vundle#begin/a \" auto-pairs - Provides pair completion when typing \{\(...]\nPlugin 'jiangmiao/auto-pairs'" /home/$USER/.vimrc
cat <<-TMP >> /home/$USER/.vimrc

" ---AUTO_PAIR CONF---
" Shortcut to disable.enable Pair-Completion
let g:AutoPairsShortcutToggle = '<C-P>'
TMP

## NERDTREE
sed -i "/^call vundle#begin/a \" NERDtree - Provides an Integrated file system explorer\nPlugin 'preservim/nerdtree'" /home/$USER/.vimrc
cat <<-TMP >> /home/$USER/.vimrc

" ---NERD_TREE CONF---
" Override some configuration variables to tweak behavior/appearance
let NERDTreeShowBookmarks = 1   " Show the bookmarks table
let NERDTreeShowHidden = 1      " Show hidden files
let NERDTreeShowLineNumbers = 0 " Hide line numbers
let NERDTreeMinimalMenu = 1     " Use the minimal menu (m)
let NERDTreeWinPos = "left"     " Panel opens on the left side
let NERDTreeWinSize = 31        " Set panel width to 31 columns
nmap <F2> :NERDTreeToggle<CR>   " Enable.Disable File-Tree
TMP

## TAGBAR
sudo pacman -S --noconfirm ctags #Install dependency
sed -i "/^call vundle#begin/a \" TagBar - Add a panel that display source file's tag\nPlugin 'preservim/tagbar'" /home/$USER/.vimrc
cat <<-TMP >> /home/$USER/.vimrc

" ---TAGBAR CONF---
" Open help with :help tagbar
let g:tagbar_autofocus = 1                  " Focus the panel when opening it
let g:tagbar_autoshowtag = 1                " Highlight the active tag
let g:tagbar_position = 'botright vertical' " Put panel in vertical-right pos
nmap <F8> :TagbarToggle<CR>                 " Mapping to open.close the panel
TMP

# CTRLS.VIM
sudo pacman -S --noconfirm ack #Install dependency
sed -i "/^call vundle#begin/a \" CTRLS.vim - Enables asynchronous search in the file system\nPlugin 'dyng/ctrlsf.vim'" /home/$USER/.vimrc
cat <<-TMP >> /home/$USER/.vimrc

" ---CTRLS.VIM CONF---
" Open doc with :help ctrlsf-option
" Use the ack tool as the backend
let g:ctrlsf_backend = 'ack'
" Auto close the results panel when opening a file
let g:ctrlsf_auto_close = { "normal":0, "compact":0 }
" Immediately switch focus to the search window
let g:ctrlsf_auto_focus = { "at":"start" }
" Don't open the preview window automatically
let g:ctrlsf_auto_preview = 0
" Use the smart case sensitivity search scheme
let g:ctrlsf_case_sensitive = 'smart'
" Normal mode, not compact mode
let g:ctrlsf_default_view = 'normal'
" Use absoulte search by default
let g:ctrlsf_regex_pattern = 0
" Position of the search window
let g:ctrlsf_position = 'right'
" Width or height of search window
let g:ctrlsf_winsize = '46'
" Search from the current working directory
let g:ctrlsf_default_root = 'cwd'
			
			
" (Ctrl+F) Open search prompt (Normal Mode)
nmap <C-F>f <Plug>CtrlSFPrompt 
" (Ctrl-F + f) Open search prompt with selection (Visual Mode)
xmap <C-F>f <Plug>CtrlSFVwordPath
" (Ctrl-F + F) Perform search with selection (Visual Mode)
xmap <C-F>F <Plug>CtrlSFVwordExec
" (Ctrl-F + n) Open search prompt with current word (Normal Mode)
nmap <C-F>n <Plug>CtrlSFCwordPath
" (Ctrl-F + o )Open CtrlSF window (Normal Mode)
nnoremap <C-F>o :CtrlSFOpen<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Normal Mode)
nnoremap <C-F>t :CtrlSFToggle<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Insert Mode)
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
TMP

## FSWITCH
sed -i "/^call vundle#begin/a \" Fswitch - Enable switching between header and implementation files\nPlugin 'derekwyatt/vim-fswitch'" /home/$USER/.vimrc
cat <<-TMP >> /home/$USER/.vimrc

" ---FSWITCH CONF---
" run help with :help fswitch
" When the loaded buffer is a .CPP file, the companion is
" of type hpp or h
" When the loaded buffer is a .h file, the companion is
" of type cpp or c
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h'
au! BufEnter *.h let b:fswitchdst = 'cpp,c'These lines specify that:
		
nmap <C-Z> :vsplit <bar> :wincmd l <bar> :FSRight<CR>
TMP

## VIM PROTODFEF
sed -i "/^call vundle#begin/a \" Vim-Protodef - Enable function prototypes pull into implementation files\nPlugin 'derekwyatt/vim-protodef'" /home/$USER/.vimrc
cat <<-TMP >> /home/$USER/.vimrc

" ---VIM_PROTODEF---
" Pull in prototypes
nmap <buffer> <silent> <leader> ,PP
" Pull in prototypes without namespace definition"
nmap <buffer> <silent> <leader> ,PN
TMP

## YOU_COMPLETE_ME
sed -i "/^call vundle#begin/a \" You-Complete-Me - Enable a powerfull code autocompletion plug-in\nPlugin 'ycm-core/YouCompleteMe'" /home/$USER/.vimrc
                     
vim +PluginInstall +qall
