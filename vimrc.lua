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
            { out,                            "WarningMsg" },
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
        "neovim/nvim-lspconfig",
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        { "williamboman/mason.nvim", config = true },
        {
            "williamboman/mason-lspconfig.nvim",
            opts = { ensure_installed = { "jdtls", "marksman", "pylsp" } }
        },
        'bronson/vim-trailing-whitespace',
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
                log_level = "DEBUG",
                enable_context = true,
                enable_suggestions = true,
                enable_commands = true,
                extensions = { spinner = {}, },
            },
            dependencies = { "nvim-lua/plenary.nvim",
                             "franco-ruggeri/codecompanion-spinner.nvim",
                           },
            },
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
            },
        },
    },
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

-- Background color
vim.o.background = "light"

-- Set colorscheme and terminal colors
vim.o.termguicolors = true
vim.cmd('colorscheme alabaster')

-- Mouse behavior
vim.o.mouse = 'v'

-- ========== COMPLETION SETUP ==========
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm completion
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ========== NATIVE LSP SETUP ==========
-- Small helper for common root patterns
local root_pattern = vim.fs.root(0, { ".git", "pyproject.toml", "setup.py" })

-- Python (using pylsp)
vim.lsp.start({
    name = "pylsp",
    cmd = { "pylsp" },
    root_dir = root_pattern,
    capabilities = capabilities,
})

-- Java (using jdtls)
vim.lsp.start({
    name = "jdtls",
    cmd = { "jdtls" },
    root_dir = vim.fs.root(0, { ".git", "pom.xml", "build.gradle" }),
    capabilities = capabilities,
})

-- Markdown (using marksman)
vim.lsp.start({
    name = "marksman",
    cmd = { "marksman", "server" },
    root_dir = vim.fs.root(0, { ".git" }),
    capabilities = capabilities,
})

-- ===== LSP AUTO-START + AUTO-INSTALL =====
local mason_registry = require("mason-registry")

-- Helper: ensure a tool is installed via Mason
local function ensure_installed(pkg)
    if not mason_registry.is_installed(pkg) then
        local p = mason_registry.get_package(pkg)
        p:install()
    end
end

-- Helper: start an LSP if available
local function start_lsp(config)
    local root = vim.fs.root(0, config.root_patterns or { ".git" })
    if root then
        config.root_dir = root
        vim.lsp.start(config)
    end
end

-- Auto-start depending on filetype
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local ft = args.match

        if ft == "python" then
            ensure_installed("python-lsp-server")
            start_lsp({
                name = "pylsp",
                cmd = { "pylsp" },
                capabilities = capabilities,
                root_patterns = { ".git", "pyproject.toml", "setup.py" },
            })
        elseif ft == "java" then
            ensure_installed("jdtls")
            start_lsp({
                name = "jdtls",
                cmd = { "jdtls" },
                capabilities = capabilities,
                root_patterns = { ".git", "pom.xml", "build.gradle" },
            })
        elseif ft == "markdown" then
            ensure_installed("marksman")
            start_lsp({
                name = "marksman",
                cmd = { "marksman", "server" },
                capabilities = capabilities,
                root_patterns = { ".git" },
            })
        end
    end,
})
