# Toggle checkboxes in Vim

This plugin introduces an elegant way to toggle checkboxes from the Normal mode on the current line.

Values:

```markdown
- [ ] First checkbox
- [x] Second checkbox
```

Default mappings (only in markdown files):

```viml
nnoremap <silent> <leader>we :call <SID>ChangeCheckbox()<CR>
nnoremap <silent> <leader>wx :call <SID>DeleteCheckbox()<CR>
```

Default maps are disabled with the following option:

```viml
let g:checkbox_maps = 0
```
