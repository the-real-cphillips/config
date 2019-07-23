""""""""""""""""""""""""""" 
"""" Setting up Plug
""" Auto install of plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" Calling used plugins
call plug#begin()
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'hashivim/vim-terraform'
Plug 'avakhov/vim-yaml'
Plug 'edkolev/promptline.vim'
call plug#end()

"""" Plugin Configurations
""" Airline/Powerline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'ravenpower'
let g:Powerline_symbols = 'fancy'

""" Terraform plugin
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
autocmd FileType terraform setlocal commentstring=#%s
filetype plugin indent on    " required

""""""""""""""""""""""""
" Other VIM Settings
syntax on
set backspace=2
set cursorline
set expandtab
set laststatus=2
set number
set pastetoggle=<F3>
set relativenumber
set shiftwidth=2
"highlight LineNr term=NONE cterm=NONE ctermfg=grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight LineNr term=NONE cterm=NONE ctermfg=grey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight CursorLine cterm=bold ctermbg=darkgrey
highlight CursorLineNR cterm=bold ctermbg=NONE ctermfg=red
