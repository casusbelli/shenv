-- Ensure pynvim is set up correctly
vim.g.python3_host_prog = '~/.config/nvim/venv/bin/python3'


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    'nvim-treesitter/nvim-treesitter',
    'tpope/vim-sensible',
    'morhetz/gruvbox',
    'tpope/vim-fugitive',
    'fatih/vim-go',
    'plasticboy/vim-markdown',
    'bronson/vim-trailing-whitespace',
    'dense-analysis/ale',
    'jvirtanen/vim-hcl',
    'davidhalter/jedi-vim',
    {
      'neoclide/coc.nvim',
      branch = 'release'
    },
    'p00f/alabaster.nvim',
    {
      "olimorris/codecompanion.nvim",
      opts = {
          strategies = {
            chat = {
                adapter = {
                  name = "ollama",
                  model = "devstral:latest",
                  proxy = "http://127.0.0.1:11434",
              },
            },
            inline = {
                adapter = {
                  name = "ollama",
                  model = "devstral:latest",
                  proxy = "http://127.0.0.1:11434",
              },
            },
            command = {
                adapter = {
                  name = "ollama",
                  model = "devstral:latest",
                  proxy = "http://127.0.0.1:11434",
              },
            },
          },
          opts = {
            log_level = "DEBUG",
            enable_context = true,
            enable_suggestions = true,
            enable_commands = true,
          },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --install = { colorscheme = { "habamax" } },
  install = { colorscheme = { "alabaster" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  -- Additional global options
  opts = {
    rocks = { enabled = false }
  },
})

-- Set options
vim.o.ruler = true
vim.o.cursorline = true

vim.o.encoding = 'utf-8'

vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.showmode = false

vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·'

vim.o.backspace = 'indent,eol,start'

vim.o.foldenable = false

vim.o.laststatus = 2

-- Filetype-specific settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'make',
  command = 'set noexpandtab'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  command = 'set noexpandtab tabstop=4 shiftwidth=4'
})

-- TODO: Ensure this is installed in the shellscript
-- Set go_fmt_command for vim-go
vim.g.go_fmt_command = "goimports"

-- Python PEP8 settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  command = 'set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79'
})

-- Ruby PEP8 settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ruby',
  command = 'set softtabstop=2 tabstop=2 shiftwidth=2'
})

-- Use Ag instead of Ack
vim.g.ackprg = 'ag --nogroup --nocolor --column'

-- TODO: ALE and coc will interfere, fix or move to one of them
-- ALE configurations
vim.g['ale_airline_enabled'] = 1
vim.g.ale_fixers = { python = { 'isort', 'remove_trailing_lines', 'trim_whitespace' } }
vim.g.ale_completion_enabled = 0

-- Set colorscheme and terminal colors
vim.o.termguicolors = true
vim.cmd('colorscheme alabaster')

-- Mouse behavior
vim.o.mouse = 'v'

-- Background color
vim.o.background = 'light'

-- Set <cr> as coc completion key
vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "<CR>"]], { expr = true, noremap = true })

