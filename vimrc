set nocompatible
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'jonlai/smyth.vim'
Plug 'junegunn/fzf.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'sheerun/vim-polyglot'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'

call plug#end()

" general settings
syntax enable
set ruler
set showcmd
set showmatch
set nowrap
set nofoldenable
set hidden
set hlsearch
set incsearch
set wildmenu
set updatetime=500
set clipboard=unnamed

" indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
set backspace=indent,eol,start

" line numbering
set number
set relativenumber
set cursorline
set cursorlineopt=number
autocmd InsertEnter,InsertLeave * :set invrelativenumber

" mappings
let mapleader=' '
nnoremap Q <nop>
nnoremap q: <nop>
nnoremap n nzz
nnoremap N Nzz
nnoremap <leader>p :set invpaste<cr>
nnoremap <leader>q :bd<cr>
nnoremap <leader>h :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<cr>
nnoremap <c-j> :bp<cr>
nnoremap <c-k> :bn<cr>
inoremap <c-j> <esc>:bp<cr>
inoremap <c-k> <esc>:bn<cr>
vnoremap <c-j> <esc>:bp<cr>
vnoremap <c-k> <esc>:bn<cr>

" jonlai/smyth.vim
if exists('+termguicolors')
  let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set colorcolumn=81,101
colorscheme smyth

" easymotion/vim-easymotion
map <leader> <plug>(easymotion-prefix)

" tomtom/tcomment_vim
nnoremap <silent> <leader>x :TComment<cr>
vnoremap <silent> <leader>x :TComment<cr>

" junegunn/fzf.vim
set rtp+=~/.fzf
cnoreabbrev fzf FZF
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>d :GFiles<cr>
nnoremap <silent> <leader>c :BCommits<cr>

" sheerun/vim-polyglot
let g:javascript_plugin_jsdoc = 1

" airblade/vim-gitgutter
let g:gitgutter_sign_priority = 5

" prabirshrestha/asyncomplete.vim
set pumheight=15
let g:asyncomplete_min_chars = 3
inoremap <expr> <tab>   pumvisible() ? '<c-n>' : '<tab>'
inoremap <expr> <s-tab> pumvisible() ? '<c-p>' : '<s-tab>'
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : '<cr>'

" prabirshrestha/vim-lsp
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 0
let g:lsp_textprop_enabled = 0
let g:lsp_semantic_enabled = 0
let g:lsp_signs_error = { 'text': '✘❯' }
let g:lsp_signs_warning = { 'text': '▲❯' }
let g:lsp_signs_information = { 'text': '◆❯' }
let g:lsp_signs_hint = { 'text': '◆❯' }
let g:lsp_signs_priority = 20
fu! LspBufferMappings() abort
  nmap <silent> <buffer> gd <plug>(lsp-definition)
  nmap <silent> <buffer> gi <plug>(lsp-implementation)
  nmap <silent> <buffer> gr <plug>(lsp-references)
  nmap <silent> <buffer> gn <plug>(lsp-next-diagnostic)
  nmap <silent> <buffer> gp <plug>(lsp-previous-diagnostic)
endfu
augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call LspBufferMappings()
augroup end

" mattn/vim-lsp-settings
let g:lsp_settings_servers_dir = expand($HOME) . '/.lsp/servers'
let g:lsp_settings_filetype_javascript =
\ ['typescript-language-server', 'eslint-language-server']
let g:lsp_settings_filetype_typescript = g:lsp_settings_filetype_javascript

" dense-analysis/ale
let g:ale_echo_msg_format = 'ALE: %[code] %%s'
let g:ale_linters_explicit = 1
let g:ale_set_balloons = 0
let g:ale_set_highlights = 0
let g:ale_sign_priority = 15
let g:ale_sign_error = '✘❯'
let g:ale_sign_warning = '▲❯'
let g:ale_sign_style_error = '✘❯'
let g:ale_sign_style_warning = '▲❯'
let g:ale_linters = {
\ 'bash': ['shellcheck'],
\ 'rust': ['cargo'],
\ 'sh': ['shellcheck'],
\ 'zsh': ['shellcheck'],
\}
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'rust': ['rustfmt'],
\}
let g:ale_pattern_options = {
\ '\.min\.js$': { 'ale_linters': [], 'ale_fixers': [] },
\ '\.min\.css$': { 'ale_linters': [], 'ale_fixers': [] },
\}
let g:ale_sh_shellcheck_exclusions = 'SC2148'

" mengelbrecht/lightline-bufferline
set showtabline=2
let g:lightline#bufferline#filename_modifier = ':~:.'
let g:lightline#bufferline#modified = '✱'
let g:lightline#bufferline#read_only = ''
let g:netrw_fastbrowse = 0
autocmd FileType netrw setl bufhidden=wipe

" itchyny/lightline.vim
set noshowmode
set timeoutlen=1000
set ttimeoutlen=0
set laststatus=2
let g:lightline = {
\ 'active': {
\   'left': [
\     ['mode', 'paste', 'alestatus'],
\     ['readonly', 'fugitive', 'modified'],
\   ],
\   'right': [['lineinfo'], ['percent'], ['fileformat', 'filetype']],
\ },
\ 'colorscheme': 'powerline',
\ 'component': {
\   'fileformat': '%{winwidth(0) > 70 ? &fileformat : ""}',
\   'lineinfo': "\u2632 %3l:%-2v",
\   'readonly': '%{&ft !~? "help" && &readonly ? "\xf0\x9f\x94\x92" : ""}'
\ },
\ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
\ 'component_function': {
\   'fugitive': 'LightlineFugitive',
\   'alestatus': 'LightlineALEStatus',
\ },
\ 'component_type': { 'buffers': 'tabsel' },
\ 'component_visible_condition': { 'fileformat': 'winwidth(0) > 70' },
\ 'tabline': { 'left': [['buffers']], 'right': [['fileencoding']] },
\ 'tabline_subseparator': { 'left': '', 'right': '' },
\}
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.tabline.left = [['#8a8a8a', '#303030', 245, 236]]
let s:palette.tabline.middle = [['#8a8a8a', '#303030', 245, 236]]
let s:palette.tabline.tabsel = [['#262626', '#8787af', 235, 103]]

" displays current git branch in lightline using vim-fugitive
fu! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? "\u16A0 " . branch : ''
  endif
  return ''
endfu

" displays '$' or 'F' in lightline when ale is disabled or fix-enabled
" TODO: update status and toggle to reflect LSP diagnostics too
fu! LightlineALEStatus()
  let is_ale_enabled = get(b:, 'ale_enabled', 1) && get(g:, 'ale_enabled', 0)
  return is_ale_enabled ? (get(b:, 'ale_fix_on_save') ? 'Ｆ' : '') : '＄'
endfu
nnoremap <silent> <leader>a :call ale#toggle#Toggle()<cr>

" toggles ale's fix mode per buffer
fu! ALEToggleFixMode()
  let b:ale_fix_on_save = get(b:, 'ale_fix_on_save') ? 0 : 1
endfu
nnoremap <silent> <leader>z :call ALEToggleFixMode()<cr>

" turn off syntax and linting if buffer is large
fu! IsLargeBuffer()
  if line2byte(line("$") + 1) > 1000000
    syntax clear
    let b:ale_enabled = 0
  endif
endfu
autocmd BufWinEnter * :call IsLargeBuffer()

" strip whitespace while preserving cursor position, for all non-markdown files
fu! StripTrailingWhitespace()
  if &ft =~ 'markdown'
    return
  endif
  let l = line('.')
  let c = col('.')
  %s/\s\+$//e
  call cursor(l, c)
endfu
autocmd BufWritePre * :call StripTrailingWhitespace()
