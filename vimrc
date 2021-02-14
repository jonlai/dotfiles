set nocompatible

" automatically install vim-plug if it does not exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" initialize vim plugins using vim-plug
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'jonlai/smyth'
Plug 'junegunn/fzf.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'sheerun/vim-polyglot'
Plug 'thecontinium/asyncomplete-buffer.vim'
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
set colorcolumn=81,101
set clipboard=unnamed

" indentation
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
nnoremap <leader>n :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<cr>
nnoremap <expr> <leader>h (&hls && v:hlsearch ? ':noh' : ':set hls').'<cr>'
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
colorscheme smyth

" easymotion/vim-easymotion
map <leader> <plug>(easymotion-prefix)

" tomtom/tcomment_vim
let g:tcomment_maps = 0
nnoremap <silent> <leader>x :TComment<cr>
vnoremap <silent> <leader>x :TComment<cr>

" junegunn/fzf.vim
set rtp+=~/.fzf
cnoreabbrev fzf FZF
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>d :GFiles<cr>
nnoremap <silent> <leader>c :BCommits<cr>

" christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nmap <c-@> <c-space>
imap <c-@> <c-space>
nnoremap <silent> <c-space>h :TmuxNavigateLeft<cr>
nnoremap <silent> <c-space>j :TmuxNavigateDown<cr>
nnoremap <silent> <c-space>k :TmuxNavigateUp<cr>
nnoremap <silent> <c-space>l :TmuxNavigateRight<cr>
nnoremap <silent> <c-space>x <c-w>q
inoremap <silent> <c-space>h <esc>:TmuxNavigateLeft<cr>
inoremap <silent> <c-space>j <esc>:TmuxNavigateDown<cr>
inoremap <silent> <c-space>k <esc>:TmuxNavigateUp<cr>
inoremap <silent> <c-space>l <esc>:TmuxNavigateRight<cr>
inoremap <silent> <c-space>x <esc><c-w>q

" sheerun/vim-polyglot
let g:javascript_plugin_jsdoc = 1

" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0
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
let g:lsp_diagnostics_signs_error = { 'text': '✘❯' }
let g:lsp_diagnostics_signs_hint = { 'text': '◆❯' }
let g:lsp_diagnostics_signs_information = { 'text': '◆❯' }
let g:lsp_diagnostics_signs_warning = { 'text': '▲❯' }
let g:lsp_diagnostics_signs_priority = 10
let g:lsp_log_file = ''
let g:lsp_semantic_enabled = 0
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gi <plug>(lsp-implementation)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gn <plug>(lsp-next-diagnostic)
nmap <silent> gp <plug>(lsp-previous-diagnostic)

" mattn/vim-lsp-settings
let s:efm_filetypes =
\ ['bash', 'javascript', 'javascriptreact', 'sh', 'typescriptreact', 'zsh']
let g:lsp_settings_servers_dir = expand($HOME) . '/.lsp/servers'
let g:lsp_settings_filetype_javascript =
\ ['typescript-language-server', 'efm-langserver']
let g:lsp_settings_filetype_javascriptreact = g:lsp_settings_filetype_javascript
let g:lsp_settings_filetype_typescript = g:lsp_settings_filetype_javascript
let g:lsp_settings_filetype_typescriptreact = g:lsp_settings_filetype_javascript
let g:lsp_settings = {
\ 'efm-langserver': {
\   'allowlist': s:efm_filetypes,
\   'cmd': [
\     lsp_settings#exec_path('efm-langserver'),
\     '-c',
\     expand($HOME) . '/.config/efm-langserver/config.yaml',
\   ],
\   'disabled': !lsp_settings#executable('efm-langserver'),
\ },
\}

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
\     ['mode', 'paste', 'lspstatus'],
\     ['readonly', 'fugitive', 'modified'],
\   ],
\   'right': [['lineinfo'], ['percent'], ['fileformat', 'filetype']],
\ },
\ 'colorscheme': 'smyth',
\ 'component': {
\   'fileformat': '%{winwidth(0) > 70 ? &fileformat : ""}',
\   'lineinfo': "\u2632 %3l:%-2v",
\   'readonly': '%{&ft !~? "help" && &readonly ? "\xf0\x9f\x94\x92" : ""}'
\ },
\ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
\ 'component_function': {
\   'fugitive': 'LightlineFugitive',
\   'lspstatus': 'LspStatus',
\ },
\ 'component_type': { 'buffers': 'tabsel' },
\ 'component_visible_condition': { 'fileformat': 'winwidth(0) > 70' },
\ 'tabline': { 'left': [['buffers']], 'right': [['fileencoding']] },
\ 'tabline_subseparator': { 'left': '', 'right': '' },
\}

" displays current git branch in lightline using vim-fugitive
fu! LightlineFugitive()
  if !exists('*FugitiveHead') | return '' | endif
  let l:branch = FugitiveHead()
  return l:branch !=# '' ? "\u16A0 " . l:branch : ''
endfu

" return '$' or 'F' when vim-lsp is disabled or formatting-enabled
fu! LspStatus()
  return lsp#internal#diagnostics#state#_is_enabled_for_buffer(bufnr('%')) ?
  \ (get(b:, 'lsp_formatting_enabled') ? 'Ｆ' : '') : '＄'
endfu

" enable document formatting if vim-lsp is active and buffer variable is true
fu! LspFormat()
  if LspStatus() != 'Ｆ' | return | endif
  if index(s:efm_filetypes, &ft) != -1
    exe 'LspDocumentFormatSync --server=efm-langserver'
  else
    exe 'LspDocumentFormatSync'
  endif
endfu
autocmd BufWritePre * call LspFormat()

" toggle vim-lsp per buffer
fu! LspToggle()
  let l:buf = bufnr('%')
  if lsp#internal#diagnostics#state#_is_enabled_for_buffer(l:buf)
    call lsp#disable_diagnostics_for_buffer(l:buf)
  else
    call lsp#enable_diagnostics_for_buffer(l:buf)
  endif
endfu
nnoremap <silent> <leader>a :call LspToggle()<cr>

" toggle vim-lsp's formatting per buffer
fu! LspToggleFormatting()
  let b:lsp_formatting_enabled = get(b:, 'lsp_formatting_enabled') ? 0 : 1
endfu
nnoremap <silent> <leader>z :call LspToggleFormatting()<cr>

" suggest installing efm-langserver for supported filetypes to lint and format
fu! LspSuggestEfmInstall()
  if lsp_settings#executable('efm-langserver') | return | endif
  redraw!
  echohl Directory
  unsilent echomsg 'Please do `:LspInstallServer efm-langserver` to enable linting'
  echohl None
endfu
exe 'autocmd FileType ' . join(s:efm_filetypes, ',') . ' call LspSuggestEfmInstall()'

" turn off syntax and language servers if buffer is large
fu! IsLargeBuffer()
  if line2byte(line("$") + 1) < 1000000 | return | endif
  syntax clear
  call lsp#disable_diagnostics_for_buffer(bufnr('%'))
endfu
autocmd BufWinEnter * call IsLargeBuffer()

" strip whitespace while preserving cursor position, for all non-markdown files
fu! StripTrailingWhitespace()
  if &ft =~ 'markdown' | return | endif
  let l:l = line('.')
  let l:c = col('.')
  %s/\s\+$//e
  call cursor(l:l, l:c)
endfu
autocmd BufWritePre * call StripTrailingWhitespace()
