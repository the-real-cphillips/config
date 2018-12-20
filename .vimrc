" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
"set clipboard=unnamed

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'hashivim/vim-terraform'
Plugin 'avakhov/vim-yaml'
Plugin 'fatih/vim-go'
Bundle 'edkolev/promptline.vim'

"Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:airline_powerline_fonts = 1
let g:airline_theme = 'ravenpower'
let g:Powerline_symbols = 'fancy'

" Terraform plugin
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
autocmd FileType terraform setlocal commentstring=#%s

" All of your Plugins must rform_fold_sections=1e added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"
" Other VIM Settings
syntax on
set pastetoggle=<F3>
set cursorline
set laststatus=2
set expandtab
set shiftwidth=2
set number
set relativenumber
"highlight LineNr term=NONE cterm=NONE ctermfg=grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight LineNr term=NONE cterm=NONE ctermfg=grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight CursorLine cterm=bold ctermbg=darkgrey
highlight CursorLineNR cterm=bold ctermbg=NONE ctermfg=red
