set nocompatible
set incsearch "Real Time Search
set hlsearch
set ic
set nobackup
set autoindent

set history=20

set ruler

set showcmd

syntax on

filetype plugin indent on

map <F7> :w<CR>:!pdflatex *.tex &<CR>

set background=dark

"set mouse=v
set tabstop=2
set number
set backspace=indent,eol,start
au BufNewFile,BufRead *.tpl set filetype=verilog
au BufNewFile,BufRead *.x set filetype=verilog
au BufNewFile,BufRead *.sv set filetype=verilog

if exists('&relativenumber')
  set rnu
endif
set expandtab
set shiftwidth=2

map <F2> :retab <CR> :w <CR>
map <C-y> "*y
map <C-p> "*p

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "no auto-comment
"http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
"settings for completion menu
"set completeopt=longest,menuone 
"inoremap ( ()<C-[>i
"inoremap [ []<C-[>i
"inoremap { {}<C-[>i
"noremap n nzz
"noremap N Nzz


inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
noremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"
"Tab between options so you can tab rotate options and also ^C and ^P to select autocomplete
set wildmenu
set wildmode=list:longest

:hi TabLine ctermfg=Red
:hi TabLineSel ctermfg=Blue


" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
"if exists("+showtabline")
"  function! MyTabLine()
"    let s = ''
"    let wn = ''
"    let t = tabpagenr()
"    let i = 1
"    while i <= tabpagenr('$')
"      let buflist = tabpagebuflist(i)
"      let winnr = tabpagewinnr(i)
"      let s .= '%' . i . 'T'
"      let s .= (i == t ? '%1*' : '%2*')
"      let s .= ' '
"      let wn = tabpagewinnr(i,'$')
"
"      let s .= '%#TabNum#'
"      let s .= i
"      " let s .= '%*'
"      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
"      let bufnr = buflist[winnr - 1]
"      let file = bufname(bufnr)
"      let buftype = getbufvar(bufnr, 'buftype')
"      if buftype == 'nofile'
"        if file =~ '\/.'
"          let file = substitute(file, '.*\/\ze.', '', '')
"        endif
"      else
"        let file = fnamemodify(file, ':p:t')
"      endif
"      if file == ''
"        let file = '[No Name]'
"      endif
"      let s .= ' ' . file . ' '
"      let i = i + 1
"    endwhile
"    let s .= '%T%#TabLineFill#%='
"    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
"    return s
"  endfunction
"  set stal=2
"  set tabline=%!MyTabLine()
"  set showtabline=1
"  highlight link TabNum Special
"endif






"set showtabline=2 " always show tabs in gvim, but not vim
"" set up tab labels with tab number, buffer name, number of windows
"function! GuiTabLabel()
"  let label = ''
"  let bufnrlist = tabpagebuflist(v:lnum)
"  " Add '+' if one of the buffers in the tab page is modified
"  for bufnr in bufnrlist
"    if getbufvar(bufnr, "&modified")
"      let label = '+'
"      break
"    endif
"  endfor
"  " Append the tab number
"  let label .= v:lnum.': '
"  " Append the buffer name
"  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
"  if name == ''
"    " give a name to no-name documents
"    if &buftype=='quickfix'
"      let name = '[Quickfix List]'
"    else
"      let name = '[No Name]'
"    endif
"  else
"    " get only the file name
"    let name = fnamemodify(name,":t")
"  endif
"  let label .= name
"  " Append the number of windows in the tab page
"  let wincount = tabpagewinnr(v:lnum, '$')
"  return label . '  [' . wincount . ']'
"endfunction
"set guitablabel=%{GuiTabLabel()}
" set up tab tooltips with every buffer name
"function! GuiTabToolTip()
"  let tip = ''
"  let bufnrlist = tabpagebuflist(v:lnum)
"  for bufnr in bufnrlist
"    " separate buffer entries
"    if tip!=''
"      let tip .= " \n "
"    endif
"    " Add name of buffer
"    let name=bufname(bufnr)
"    if name == ''
"      " give a name to no name documents
"      if getbufvar(bufnr,'&buftype')=='quickfix'
"        let name = '[Quickfix List]'
"      else
"        let name = '[No Name]'
"      endif
"    endif
"    let tip.=name
"    " add modified/modifiable flags
"    if getbufvar(bufnr, "&modified")
"      let tip .= ' [+]'
"    endif
"    if getbufvar(bufnr, "&modifiable")==0
"      let tip .= ' [-]'
"    endif
"  endfor
"  return tip
"endfunction
"set guitabtooltip=%{GuiTabToolTip()}
"

set showtabline=2  " 0, 1 or 2; when to use a tab pages line
set tabline=%!MyTabLine()  " custom tab pages line
function MyTabLine()
  let s = '' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " set highlight for tab number and &modified
    let s .= '%#TabLineSel#'
    " set the tab page number (for mouse clicks)
    let s .= '%' . (t + 1) . 'T'
    " set page number string
    let s .= '[' . (t + 1) . ']'
    " get buffer names and statuses
    let n = ''  "temp string for buffer names while we loop and check buftype
    let m = 0  " &modified counter
    let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
    " loop through each buffer in a tab
    for b in tabpagebuflist(t + 1)
      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
      if getbufvar( b, "&buftype" ) == 'help'
        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
      elseif getbufvar( b, "&buftype" ) == 'quickfix'
        let n .= '[Q]'
      else
        let n .= pathshorten(bufname(b))
      endif
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
      " no final ' ' added...formatting looks better done later
      if bc > 1
        let n .= ' '
      endif
      let bc -= 1
    endfor
    " add modified label [n+] where n pages in tab are modified
    if m > 0
      let s .= '[' . m . '+]'
    endif
    " select the highlighting for the buffer names
    " my default highlighting only underlines the active tab
    " buffer names.
    if t + 1 == tabpagenr()
      let s .= '%#TabLine#'
    else
      let s .= '%#TabLineSel#'
    endif
    " add buffer names
    let s .= n
    " switch to no underlining and add final space to buffer list
    let s .= '%#TabLineSel#' . ' '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLineFill#%999Xclose'
  endif
  return s
endfunction
