""""""""""""""""""""""""""
"""" Setting up Plug
""" Auto install of plug
"""if empty(glob('~/.vim/autoload/plug.vim'))
"""    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"""        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"""      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"""endif

""" Calling used plugins
call plug#begin()
  Plug 'EdenEast/nightfox.nvim', { 'tag': 'v1.0.0' }
  Plug 'APZelos/blamer.nvim'
  Plug 'RRethy/vim-illuminate'
  Plug 'avakhov/vim-yaml'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'hashivim/vim-terraform'
  Plug 'terryma/vim-multiple-cursors'
  " https://github.com/nvim-lualine/lualine.nvim#default-configuration
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

""" Require plugin configs
" lua require('namespace.plugin')
lua require('the-real-cphillips.lualine')
lua require('the-real-cphillips.nerd-tree')

""" Plugin Configurations

""" Blamer (Git Blame)
let g:blamer_date_format='%m/%d/%y'
let g:blamer_enabled=1
let g:blamer_delay=500

""" Terraform plugin
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
autocmd FileType terraform setlocal commentstring=#%s
filetype plugin indent on    " required

""""""""""""""""""""""""
" Other VIM Settings
syntax enable

set number
set relativenumber

set shiftwidth=2
set tabstop=2
set smartindent

set cursorline
set laststatus=2
set pastetoggle=<F3>

set expandtab
set nosmarttab
set linebreak

"""""""""""""""""""""""""

""" Illuminate
augroup illuminate_augroup
  autocmd!
  autocmd VimEnter * hi illuminatedWord ctermbg=darkgrey ctermfg=white
  autocmd VimEnter * hi illuminatedCurWord cterm=underline gui=underline
augroup END

map <Leader>f :IlluminationToggle!<CR>

"""""""""""""""""""""""""

"""" Color Stuff
set termguicolors
set background=dark
colorscheme nightfox

hi CursorColumn cterm=NONE ctermbg=darkgrey ctermfg=red guibg=darkgrey guifg=darkred

nnoremap <Leader>c :set cursorcolumn!<CR>
nnoremap <Leader>j :set foldmethod=syntax<CR>
nnoremap <Leader>f :NvimTreeToggle .<CR>

""" Remove all trailing whitespace by pressing F6
nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

""" Alias
:command Tfmt TerraformFmt

