if !exists('g:checkbox_maps')
	let g:checkbox_maps = 1
endif

if !exists('g:values')
	let g:values = [' ', 'x']
endif

if !exists('g:insert')
	let g:insert = '\<'
endif

if !exists('g:prefix')
	let g:prefix = ''
endif

if !exists('g:suffix')
	let g:suffix = ' '
endif

function! s:ChangeCheckbox() abort
	let line = getline('.')

	if(match(line, '\[.\]') != -1)
		let states = copy(g:values)
		call add(states, g:values[0])
		for state in states
			if(match(line, '\[' . state . '\]') != -1)
				let next_state = states[index(states, state) + 1]
				let line = substitute(
							\ line,
							\ '\[' . state . '\]',
							\ '[' . next_state . ']',
							\ '')
				break
			endif
		endfor
	else
		if g:insert !=# ''
			let line = substitute(
						\ line,
						\ g:insert,
						\ g:prefix . '[' . g:values[0] . ']' . g:suffix,
						\ '')
		endif
	endif

	call setline('.', line)
endf

function! s:DeleteCheckbox() abort
	let line = getline('.')

	if(match(line, '\[.\]') != -1)
		let states = copy(g:values)
		call add(states, g:values[0])
		for state in states
			let line = substitute(
						\ line,
						\ g:prefix . '\['. state . '\]' . g:suffix,
						\ '',
						\ '')
		endfor
	endif

	call setline('.', line)
endfunction

if g:checkbox_maps == 1
	augroup markdown
		autocmd FileType markdown
					\ nnoremap <silent> <leader>we :call <SID>ChangeCheckbox()<CR>
		autocmd FileType markdown
					\ nnoremap <silent> <leader>wx :call <SID>DeleteCheckbox()<CR>
	augroup end
endif
