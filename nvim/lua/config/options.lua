-- nvim options config
local home = os.getenv('HOME')

local opts = vim.opt

vim.g.loaded_ruby_provider = 0

-- keep the signcolumn open all the time
opts.signcolumn = 'yes'

-- enable true color support in the terminal
opts.termguicolors = true

-- indicate more visibly which line the cursor is on
opts.cursorline = true

-- use a vertical split by default for diffs
opts.diffopt = 'vertical'

-- limit lines to this width by default
opts.textwidth = 80

-- custom formatting options:
--     t = auto-wrap lines using 'textwidth'
--     c = auto-wrap comments using 'textwidth'
--     q = allow formatting of comments with 'gq'
--     j = remove comment leader when joining lines
--     r = auto-insert comment leader when hitting <enter> in insert mode
--     o = auto-insert commend leader when hitting 'o' or 'O' in normal mode
--     n = recognize numbered lists when formatting (uses 'formatlistpat' option)
--     w = trailing white space indicates a paragraph continues on the next line,
--         a line that ends with a non-white space character ends the paragraph
opts.formatoptions = 'tcqjronw'

-- standard utf-8 encoding
opts.encoding = 'utf-8'

-- store swapfiles here, prevent getting them mixed into source control
opts.directory = home .. '/.config/nvim/swapfiles'

-- show line numbers
opts.number = true

-- also show relative line numbers
opts.relativenumber = true

-- better completion menu for commands
opts.wildmenu = true

-- automatically indent from last line when creating a new one
opts.autoindent = true

-- smartly do auto-indenting
opts.smartindent = true

--
opts.shiftwidth = 2

-- by setting this rather than tabstop, <bs> will remove the full tab rather
-- than a single space (spaces > tabs i will die on this hill)
opts.softtabstop = 2

-- use the appropriate number of spaces to insert a <tab>
-- again, spaces > tabs
opts.expandtab = true

-- highlight all results of a search pattern
opts.hlsearch = true

-- highlight search results as the pattern is typed
opts.incsearch = true

-- ignore case in search results
opts.ignorecase = true

-- don't ignore case for search patterns that contain uppercase letters
opts.smartcase = true

-- write contents of a file on various commands that jump to another file
opts.autowrite = true

-- focus on the bottom window when doing horizontal splits
opts.splitbelow = true

-- focus on the right-hand window when doing vertical splits
opts.splitright = true

-- do not wrap lines
opts.wrap = false

-- do not show mode, status line plugin does that
opts.showmode = false

-- transparency of floating windows
opts.winblend = 15

-- round indent to a multiple of 'shiftwidth'
opts.shiftround = true

-- enable mouse support in normal & visual modes
opts.mouse = 'nv'

-- show whitespace characters
opts.list = true

-- insert mode completion options
--     menu = use popup menu to show completions
--     menuone = use popup menu also when there's only one match
--     noinsert = do not insert text for a match until it's selected
opts.completeopt = { 'menu', 'menuone', 'noinsert' }

opts.breakindent = true
opts.breakindentopt = "list:-1"

-- use treesitter for folds
vim.foldmethod = 'expr'
vim.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- symbols to use for file diagnostics
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "Error",
      [vim.diagnostic.severity.WARN] = "Warn",
      [vim.diagnostic.severity.INFO] = "Info",
      [vim.diagnostic.severity.HINT] = "Hint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    }
  }
})
