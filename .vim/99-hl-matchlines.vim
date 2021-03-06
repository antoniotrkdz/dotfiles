function! s:get_match_lines(line) abort
  " Loop until `%` returns the original line number; abort if
  " (1) the % operator keeps us on the same line, or
  " (2) the % operator doesn't return us to the same line after some nubmer of jumps
  let a:tolerance=25
  let a:badbreak=1
  let a:linebefore=-1
  let lines = []
  while a:tolerance && a:linebefore != line('.')
    let a:linebefore=line('.')
    let a:tolerance-=1
    normal %
    if line('.') == a:line
      " Note that the current line number is never added to the `lines`
      " list. a:line is the input argument 'line'; a is the FUNCTION BUFFER
      let a:badbreak=0
      break
    endif
    call add(lines, line('.'))
  endwhile
  "Return to original line no matter what, return list of lines to highlight
  execute "normal ".a:line."gg"
  if a:badbreak==1
    return []
  else
    return lines
  endif
endfunction

function! s:hl_matching_lines() abort
  " `b:hl_last_line` prevents running the script again while the cursor is
  " moved on the same line.  Otherwise, the cursor won't move if the current
  " line has matching pairs of something.
  if exists('b:hl_last_line') && b:hl_last_line == line('.')
    return
  endif
  let b:hl_last_line = line('.')
  " Save the window's state.
  let view = winsaveview()
  " Delete a previous match highlight.  `12345` is used for the match ID.
  " It can be anything as long as it's unique.
  silent! call matchdelete(12345)
  " Try to get matching lines from the current cursor position.
  let lines = s:get_match_lines(view.lnum)
  if empty(lines)
    " It's possible that the line has another matching line, but can't be
    " matched at the current column.  Move the cursor to column 1 to try
    " one more time.
    call cursor(view.lnum, 1)
    let lines = s:get_match_lines(view.lnum)
  endif
  if len(lines)
    " Since the current line is not in the `lines` list, only the other
    " lines are highlighted.  If you want to highlight the current line as
    " well:
    call add(lines, view.lnum)
    if exists('*matchaddpos')
      " If matchaddpos() is availble, use it to highlight the lines since it's
      " faster than using a pattern in matchadd().
      call matchaddpos('MatchLine', lines, 0, 12345)
    else
      " Highlight the matching lines using the \%l atom.  The `MatchLine`
      " highlight group is used.
      call matchadd('MatchLine', join(map(lines, '''\%''.v:val.''l'''), '\|'), 0, 12345)
    endif
  endif
  " Restore the window's state.
  call winrestview(view)
endfunction
function! s:hl_matching_lines_clear() abort
  silent! call matchdelete(12345)
  unlet! b:hl_last_line
endfunction

let g:extra_paren_hl_is_open = 0

function! Toggle_Extra_Paren_HL()
  if g:extra_paren_hl_is_open == 0
    " The highlight group that's used for highlighting matched lines.
    highlight MatchLine guibg=#414141 gui=bold
    " With this line, by default, it will be the same as the `MatchParen` group.
    " highlight! default link MatchLine MatchParen
    augroup matching_lines
      autocmd!
      " Highlight lines as the cursor moves.
      autocmd CursorMoved * call s:hl_matching_lines()
      " Remove the highlight while in insert mode.
      autocmd InsertEnter * call s:hl_matching_lines_clear()
      " Remove the highlight after TextChanged.
      autocmd TextChanged,TextChangedI * call s:hl_matching_lines_clear()
    augroup END
    let g:extra_paren_hl_is_open = 1
  else
    " Removing highlighting
    highlight clear MatchLine
    " highlight! default link MatchLine NONE
    autocmd! matching_lines
    let g:extra_paren_hl_is_open = 0
  endif
endfunction
