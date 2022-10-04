-- init.lua
-- main (package independent) config
vim.opt.relativenumber = true
vim.opt.hidden = true

vim.opt.backup = true
vim.opt.backupdir = '~/.nvim/_backup/,~/tmp,.'

vim.opt.undofile = true
vim.opt.undodir = '~/.nvim/_undo'
vim.opt.laststatus = 2
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
    use 'projekt0n/github-nvim-theme'
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
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  return
end

---- plugin specific config
require("nvim-tree").setup({
  sort_by = "case_sensitive",
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
    dotfiles = true,
  },
})
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

require('lspconfig').clangd.setup{}
require('lualine').setup {
options = {
theme = 'codedark',
section_separators = '', component_separators = ''
}
}
require('lualine').setup()
vim.opt.termguicolors = true

vim.cmd('colorscheme github_dark_default')

-- gui config
vim.opt.guifont = 'Iosevka:h13'
-- keybindings
vim.g.mapleader = ' '


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
