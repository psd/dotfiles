" vi-style Neovim, used by `vi` and $EDITOR via ~/.local/bin/nvim-clean.
" Undoes Neovim's vim-ish defaults; delete a line to get that feature back.

" Search: highlight matches (Ctrl-L clears) and jump to them while typing.
set hlsearch incsearch

" Backspace can delete autoindent, but stops at the start of the insert, like vi.
set backspace=indent

" New lines keep the previous line's indent, plus language-aware indenting
" and per-language settings (indent width, textwidth for commit messages...).
set autoindent nosmarttab
filetype plugin indent on

" Syntax highlighting.
syntax on

" Quiet screen: no ruler, no pending-command echo, status line only with splits.
set noruler noshowcmd laststatus=1
set shortmess+=I

" Leave the mouse to the terminal (select/copy works as usual).
set mouse=

" Tab-completion of commands just completes, no menu.
set nowildmenu

" Line-motion commands (G, gg, dd...) go to the first non-blank, like vi.
set startofline

" Two spaces after a full stop when joining lines (J), like vi.
set joinspaces

" Drop Neovim's extra default mappings so keys do what vi does.
silent! nunmap Y
silent! nunmap &
silent! xunmap *
silent! xunmap #
silent! iunmap <C-U>
silent! iunmap <C-W>

" Language servers, using Neovim's built-in LSP client. Server definitions come
" from LazyVim's copy of nvim-lspconfig; servers from LazyVim's Mason or PATH.
" Servers that aren't installed are skipped. Keys: K hover, grn rename,
" gra code action, grr references, gri implementation, gO symbols,
" [d ]d diagnostics, Ctrl-W d show diagnostic, Ctrl-X Ctrl-O complete.
lua << EOF_LUA
vim.opt.runtimepath:append(vim.fn.expand("~/.local/share/nvim/lazy/nvim-lspconfig"))
vim.env.PATH = vim.fn.expand("~/.local/share/nvim/mason/bin") .. ":" .. vim.env.PATH
vim.lsp.enable({ "lua_ls", "clangd", "bashls", "pyright", "ts_ls", "gopls", "rust_analyzer" })
EOF_LUA

" Completion menu pops up as you type: language server first (o), then words
" from open buffers. Tab/Shift-Tab move through it, Ctrl-Y accepts, Ctrl-E closes.
set autocomplete
set autocompletedelay=150
set complete=o,.^5,w^5,b^5,u^5
set completeopt=menuone,noselect,popup
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Let accepted LSP items also add imports and expand snippets.
lua vim.api.nvim_create_autocmd("LspAttach", { callback = function(ev) vim.lsp.completion.enable(true, ev.data.client_id, ev.buf) end })
