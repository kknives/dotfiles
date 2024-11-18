-- init.lua
-- main (package independent) config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true

vim.opt.backup = true
vim.opt.backupdir = '/home/sga/.nvim/_backup/,/home/sga/tmp'

vim.opt.undofile = true
vim.opt.undodir = '/home/sga/.nvim/_undo'
vim.cmd(':set noshowmode')

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.timeoutlen = 500

local indent = 2
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent

vim.opt.foldmethod = 'indent'
vim.opt.foldnestmax = 10
vim.cmd(':set nofoldenable')
vim.opt.foldlevel = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- packages

---- bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

---- plugins
require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'
    -- theme
    use 'folke/tokyonight.nvim'
    -- statusline
    use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'tpope/vim-fugitive' -- git commands
    use 'nvim-treesitter/nvim-treesitter' -- code ast parsing
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    use 'numToStr/Comment.nvim' -- comment out code
    use 'p00f/nvim-ts-rainbow' -- always know your braces
    use 'abecodes/tabout.nvim' -- tab out of surrounds
    use 'folke/which-key.nvim' -- describe key chords
    use 'matbme/JABS.nvim' -- Buffer switching
    use 'windwp/nvim-autopairs' -- Delimiters in pairs
    use 'gpanders/editorconfig.nvim' -- EditorConfig integration
    use 'kylechui/nvim-surround' -- Operate on delimiters
    use 'glepnir/dashboard-nvim' -- a dashboard
    use 'sbdchd/neoformat' -- autoformat code
    use 'github/copilot.vim'
    use 'simrat39/rust-tools.nvim'
    use {'ms-jpq/coq_nvim', branch='coq'}
    use {
        'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end
      }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
      }
    end
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'cljoly/telescope-repo.nvim'
  use 'nanozuki/tabby.nvim'
  use 'stevearc/aerial.nvim'
  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  return
end

---- plugin specific config
require('tabby.tabline').use_preset('active_wins_at_tail', {
  theme = {
    fill = 'TabLineFill', -- tabline background
    head = 'TabLine', -- head element highlight
    current_tab = 'TabLineSel', -- current tab label highlight
    tab = 'TabLine', -- other tab label highlight
    win = 'TabLine', -- window highlight
    tail = 'TabLine', -- tail element highlight
  },
  nerdfont = true, -- whether use nerdfont
  buf_name = {
      mode = "'unique'|'relative'|'tail'|'shorten'",
  },
})
local opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools.executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,

      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp",
        "cgimage",
        "canon",
        "dot",
        "gv",
        "xdot",
        "xdot1.2",
        "xdot1.4",
        "eps",
        "exr",
        "fig",
        "gd",
        "gd2",
        "gif",
        "gtk",
        "ico",
        "cmap",
        "ismap",
        "imap",
        "cmapx",
        "imap_np",
        "cmapx_np",
        "jpg",
        "jpeg",
        "jpe",
        "jp2",
        "json",
        "json0",
        "dot_json",
        "xdot_json",
        "pdf",
        "pic",
        "pct",
        "pict",
        "plain",
        "plain-ext",
        "png",
        "pov",
        "ps",
        "ps2",
        "psd",
        "sgi",
        "svg",
        "svgz",
        "tga",
        "tiff",
        "tif",
        "tk",
        "vml",
        "vmlz",
        "wbmp",
        "webp",
        "xlib",
        "x11",
      },
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
}

require('rust-tools').setup(opts)
require('aerial').setup({
  on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end
})
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
require('telescope').setup()
require('telescope').load_extension('repo')
require('dashboard').custom_header = {
 ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
 ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
 ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
 ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
 ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
 ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',}
require('nvim-surround').setup()
require('nvim-autopairs').setup()
require('jabs').setup {}
require('which-key').setup()
require('Comment').setup()
require('tabout').setup({
      tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
      default_shift_tab = '<C-d>', -- reverse shift default action,
      enable_backwards = true, -- well ...
      completion = false, -- if the tabkey is used in a completion pum
      tabouts = {
      {open = "'", close = "'"},
      {open = '"', close = '"'},
      {open = '`', close = '`'},
      {open = '(', close = ')'},
      {open = '[', close = ']'},
      {open = '{', close = '}'}
      },
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      exclude = {} -- tabout will ignore these filetypes
  })
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "r", "python", "svelte", "yaml", "bash", "erlang" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  rainbow = {
  enable = true
},
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local lsp = require "lspconfig"
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
local coq = require "coq"
-- lsp.clangd.setup{cmd={'clangs'}, coq.lsp_ensure_capabilities()}
-- lsp.rust_analyzer.setup{coq.lsp_ensure_capabilities()}
-- lsp.clangd.setup(coq.lsp_ensure_capabilities())
vim.api.nvim_set_var("test_var", vim.fn.getcwd())
if string.find(vim.fn.expand("%:F"), "chrysoberyl") ~= nil then
  lsp.clangd.setup{cmd={'clangs'}, coq.lsp_ensure_capabilities()}
else
  require'lspconfig'.clangd.setup{}
end
require('lualine').setup {
  options = {
  theme = 'codedark',
  section_separators = '', component_separators = ''
  }
}
require('lualine').setup()
vim.opt.termguicolors = true

vim.cmd('colorscheme tokyonight-night')

-- gui config
vim.opt.guifont = 'Iosevka:h10'
-- keybindings
vim.g.mapleader = ' '

local wk = require('which-key')
wk.register( {
  f = {
    name = "fileops",
    f = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree" },
    r = {require('telescope.builtin').oldfiles, "List recent files"},
    g = {require('telescope.builtin').treesitter, "List treesitter objects in current buffer"},
  },
}, { prefix = "<leader>" })
wk.register({
  ["<leader>,"] = {"<cmd>:JABSOpen<cr>", "Buffer switch"},
  ["<leader>p"] = {"<cmd>:Telescope repo list<cr>", "Browse local repos"},
  ["<leader>."] = {"<cmd>:Telescope find_files<cr>", "Browse files in current project"},
  ["<leader>pf"] = {"<cmd>:Telescope live_grep<cr>", "Search through current repo"},
  ["<leader>bb"] = {"<cmd>:Telescope buffers<cr>", "Switch current buffer"},
  ["<leader>bk"] = {"<cmd>:bd<cr>", "Unload current buffer"},
})
wk.register({
  ["<M-w>"] = {"<cmd>:tabnew<cr>", "Create a new tab"},
  ["<M-1>"] = {"1gt", "Goto tab#1"},
  ["<M-2>"] = {"2gt", "Goto tab#2"},
  ["<M-3>"] = {"3gt", "Goto tab#3"},
  ["<M-4>"] = {"4gt", "Goto tab#4"},
  ["<M-5>"] = {"5gt", "Goto tab#5"},
  ["<M-6>"] = {"6gt", "Goto tab#6"},
  ["<M-7>"] = {"7gt", "Goto tab#7"},
  ["<M-8>"] = {"8gt", "Goto tab#8"},
  ["<M-9>"] = {"9gt", "Goto tab#9"},
})

-- autocmds

--vim.cmd('augroup fmt autocmd! autocmd BufWritePre * undojoin | Neoformat augroup END')
--vim.cmd('autocmd BufWritePre *.jsx Neoformat')
--vim.cmd('autocmd BufWritePre *.go Neoformat')
--vim.cmd('autocmd BufWritePre *.py Neoformat')
--vim.cmd('autocmd BufWritePre *.cpp Neoformat')
--vim.cmd('autocmd BufWritePre *.h Neoformat')
--vim.cmd('autocmd BufWritePre *.R Neoformat')
--vim.cmd('autocmd BufWritePre *.tex Neoformat')
--vim.cmd('autocmd BufWritePre *.ltx Neoformat')
