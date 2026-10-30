-- codecompanion.nvim v20+ requires nvim 0.12
if vim.fn.has("nvim-0.12") == 0 then
    vim.api.nvim_echo({
        { "This config requires Neovim 0.12+, found " .. tostring(vim.version()) .. "\n", "ErrorMsg" },
    }, true, {})
    return
end

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
        { -- tags abandoned since the rewrite, track main
            'nvim-treesitter/nvim-treesitter',
            build = ":TSUpdate", -- keep parsers up to date on plugin update
            opts = {
                -- parsers installed automatically; missing ones installed on startup
                ensure_installed = {
                    "markdown",
                    "markdown_inline",
                    "yaml",
                    "lua", -- recommended, many core features use it
                },
                highlight = { enable = true },
            },
        },
        { "neovim/nvim-lspconfig", version = "*" },
        'hrsh7th/nvim-cmp', -- tags stale for 18+ months, track main
        'hrsh7th/cmp-nvim-lsp', -- no tagged releases upstream
        'hrsh7th/cmp-buffer', -- no tagged releases upstream
        'hrsh7th/cmp-path', -- no tagged releases upstream
        'hrsh7th/cmp-cmdline', -- no tagged releases upstream
        { "williamboman/mason.nvim", version = "*", config = true },
        {
            "williamboman/mason-lspconfig.nvim",
            version = "*",
            opts = { ensure_installed = {
                "ansiblels",
                "jdtls",
                "marksman",
                "pylsp",
                "yamlls",
            } }
        },
        'bronson/vim-trailing-whitespace', -- only tag is from 2010, track main
        'p00f/alabaster.nvim', -- no tagged releases upstream
        {
            "olimorris/codecompanion.nvim",
            version = "*",
            opts = {
                interactions = {
                    chat = {
                        adapter = {
                            name = "ollama",
                            model = "qwen3.8:27b",
                            proxy = "http://127.0.0.1:11434",
                        },
                    },
                    inline = {
                        adapter = {
                            name = "ollama",
                            model = "qwen3.8:27b",
                            proxy = "http://127.0.0.1:11434",
                        },
                    },
                    command = {
                        adapter = {
                            name = "ollama",
                            model = "qwen3.8:27b",
                            proxy = "http://127.0.0.1:11434",
                        },
                    },
                    cli = {
                        agent = "claude_code",
                        agents = {
                            claude_code = {
                                cmd = "claude",
                                args = {},
                                description = "Claude Code CLI",
                                provider = "terminal",
                            },
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
            version = "*",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "sindrets/diffview.nvim",
                "nvim-telescope/telescope.nvim",
            },
        },
        {
            "f-person/git-blame.nvim", -- no tagged releases upstream
            event = "BufReadPre",
            opts = {
                enabled = true,
                message_template = " <summary> • <date> • <author> • <<sha>>",
                date_format = "%m-%d-%Y %H:%M:%S",
                virtual_text_column = 1,
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

-- Use esc instead of the the native neovim sequence for leaving edit mode in terminal
-- (some remote terminals do not transfer ctrl+\)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- CodeCompanion CLI agent (Claude Code)
vim.keymap.set({ "n", "v" }, "<LocalLeader>cp", function()
    return require("codecompanion").cli({ prompt = true })
end, { desc = "Prompt the CLI agent" })
vim.keymap.set({ "n", "v" }, "<LocalLeader>ca", function()
    return require("codecompanion").cli("#{this}", { focus = false })
end, { desc = "Add context to the CLI agent" })
vim.keymap.set("n", "<LocalLeader>cd", function()
    return require("codecompanion").cli("#{diagnostics} Can you fix these?", { focus = false, submit = true })
end, { desc = "Send diagnostics to CLI agent" })
vim.keymap.set("n", "<LocalLeader>ct", function()
    return require("codecompanion").cli("#{terminal} Sharing the output from the terminal. Can you fix it?", { focus = false, submit = true })
end, { desc = "Send terminal output to CLI agent" })

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

-- Force Neovim to recognize Ansible-specific files
vim.filetype.add({
  extension = {
    yml = function(path, bufnr)
      if path:match("tasks") or path:match("roles") or path:match("playbook") then
        return "yaml.ansible"
      end
      return "yaml"
    end,
  },
})

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
        elseif ft == "yaml" or ft == "yaml.ansible" then
            -- 1. Install the Linter/Formatter via Mason (non-LSP tools)
            ensure_installed("ansible-lint")
            ensure_installed("yamllint")

            -- 2. Start the Ansible LSP (The Brain)
            start_lsp({
                name = "ansiblels",
                cmd = { "ansible-language-server", "--stdio" },
                capabilities = capabilities,
                root_patterns = { "ansible.cfg", ".ansible-lint", "playbooks", "roles" },
                settings = {
                    ansible = {
                        ansible = { path = "ansible" },
                        executionEnvironment = { enabled = false },
                        validation = {
                            enabled = true,
                            lint = { enabled = true, path = "ansible-lint" },
                        },
                    },
                },
            })
            -- 3. Start the YAML LSP (The Syntax Police)
            start_lsp({
                name = "yamlls",
                cmd = { "yaml-language-server", "--stdio" },
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemaStore = { enable = true },
                    },
                },
            })
        end
    end,
})

-- Enable persistent history on ~/tasks.md
vim.api.nvim_create_autocmd({"BufReadPre", "BufNewFile"}, {
  pattern = vim.fn.expand("~/tasks.md"),
  callback = function()
    vim.opt_local.undofile = true
  end,
})

-- finally enable diagnostics
vim.diagnostic.enable = true
vim.diagnostic.config({
    virtual_lines = true,
})
