vim.opt.background = 'dark'
vim.opt.number = true
vim.opt.termguicolors = true

vim.o.cmdheight=0

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.g.cmp_enabled = true

vim.opt.timeoutlen = 500
vim.opt.scrolloff = 5

vim.g.everforest_background = 'hard'

vim.cmd.colorscheme('everforest')

vim.g.skip_ts_context_commentstring_module = true

require("nvim-treesitter.configs").setup {
    highlight = {enable = true, additional_vim_regex_highlighting = false},
    rainbow = {
        enable = true,
        disable = {"html"},
        extended_mode = false,
        max_file_lines = nil
    },
    autotag = {enable = true},
    incremental_selection = {enable = true},
    indent = {enable = false}
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

vim.opt.completeopt = 'menu,menuone,noselect'

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local check_backspace = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, item)
            item.menu = ({
                buffer = '[Buffer]',
                luasnip = '[Snip]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[API]',
                path = '[Path]',
                rg = '[RG]',
            })[entry.source.name]
            return item
        end,
    },
    window = { },
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 5 },
        { name = 'buffer', priority = 4 },
        { name = 'rg', priority = 3 },
        { name = 'luasnip', priority = 2 },
        { name = 'path', priority = 1 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
    }),
})

capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'gopls', 'rust_analyzer', 'nil_ls', 'clangd' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ['nil'] = {
        formatting = {
          command = { 'nixpkgs-fmt' }
        }
      },
    }
  }
end

require('which-key').setup()
require('gitsigns').setup {
  current_line_blame = true,
}

require("neo-tree").setup {
    close_if_last_window = true,
    enable_diagnostics = false,
    source_selector = {
        winbar = true,
        content_layout = "center",
        tab_labels = {
            filesystem = " File",
            buffers = " Bufs",
            git_status = " Git",
            diagnostics = "裂 Diagnostic"
        }
    },
    default_component_configs = {
        indent = {padding = 0},
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = ""
        },
        git_status = {
            symbols = {
                added = "",
                deleted = "",
                modified = "",
                renamed = "➜",
                untracked = "★",
                ignored = "◌",
                unstaged = "✗",
                staged = "✓",
                conflict = ""
            }
        }
    },
    window = {
        width = 30,
        mappings = {
            ["<space>"] = false,
            o = "open",
            H = "prev_source",
            L = "next_source"
        }
    },
    filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        window = {mappings = {h = "toggle_hidden"}}
    },
    event_handlers = {
        {
            event = "neo_tree_buffer_enter",
            handler = function(_) vim.opt_local.signcolumn = "auto" end
        }
    }
}

local utils = require "Comment.utils"

require("Comment").setup {
    pre_hook = function(ctx)
        local location = nil
        if ctx.ctype == utils.ctype.blockwise then
            location =
                require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
            location =
                require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return
            require("ts_context_commentstring.internal").calculate_commentstring {
                key = ctx.ctype == utils.ctype.linewise and "__default" or
                    "__multiline",
                location = location
            }
    end
}

require("toggleterm").setup {
    size = 10,
    open_mapping = [[<F7>]],
    shading_factor = 2,
    direction = "float",
    float_opts = {
        border = "curved",
        highlights = {border = "Normal", background = "Normal"}
    }
}

require("nvim-autopairs").setup {
    check_ts = true,
    fast_wrap = {
        map = "<M-e>",
        chars = {"{", "[", "(", '"', "'"},
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr"
    }
}

require("better_escape").setup()

local luasnip = require 'luasnip'

require("lspkind").init {
    mode = "symbol",
    symbol_map = {
        NONE = "",
        Array = "",
        Boolean = "⊨",
        Class = "",
        Constructor = "",
        Key = "",
        Namespace = "",
        Null = "NULL",
        Number = "#",
        Object = "⦿",
        Package = "",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "𝓐",
        TypeParameter = "",
        Unit = ""
    }
}

require("bufferline").setup {
    options = {
        offsets = {
            {filetype = "NvimTree", text = "", padding = 1},
            {filetype = "neo-tree", text = "", padding = 1},
            {filetype = "Outline", text = "", padding = 1}
        },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        close_command = close_func,
        right_mouse_command = close_func,
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        separator_style = "thin"
    }
}

vim.notify = require "notify"
require("notify").setup {stages = "fade"}

local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
    defaults = {

        prompt_prefix = string.format("%s ", ""),
        selection_caret = string.format("%s ", "❯"),
        path_display = {"truncate"},
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8
            },
            vertical = {mirror = false},
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120
        },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            },
            n = {["q"] = actions.close}
        }
    }
}

require('nvim-web-devicons').setup {color_icons = true, default = true}

vim.g.mapleader = ' '
local map = vim.keymap.set
local function desc(s) return {desc = s} end

map('n', '<leader>w', '<cmd>w<cr>', desc('Save'))
map('n', '<leader>q', '<cmd>q<cr>', desc('Quit'))
map('n', '<leader>h', '<cmd>nohlsearch<cr>', desc('No Highlight'))
map('n', '|', '<cmd>vsplit<cr>', desc('Vertical Split'))
map('n', '\\', '<cmd>split<cr>', desc('Horizontal Split'))

map('n', '<leader>/',
    function() require("Comment.api").toggle.linewise.current() end,
    desc('Comment'))
map('v', '<leader>/',
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc('Comment'))
map('n', '<leader>e', '<cmd>Neotree toggle<cr>', desc('Neotree'))

map('t', "<C-'>", '<cmd>ToggleTerm<cr>')
map('n', "<C-'>", '<cmd>ToggleTerm<cr>')

map('n', '<C-h>', function() require("smart-splits").move_cursor_left() end)
map('n', '<C-j>', function() require("smart-splits").move_cursor_down() end)
map('n', '<C-k>', function() require("smart-splits").move_cursor_up() end)
map('n', '<C-l>', function() require("smart-splits").move_cursor_right() end)

map('n', '<leader>lf', function() vim.lsp.buf.format {async = true} end,
    desc('Format'))

map('n', '<leader>gg', "<cmd>TermExec cmd='exec lazygit'<cr>", desc('Lazygit'))
map('n', '<leader>gc',
    function() require("telescope.builtin").git_commits() end,
    desc('Git commits'))
map('n', '<leader>fw', function() require("telescope.builtin").live_grep() end,
    desc('Search words'))
map('n', '<leader>ff', function() require("telescope.builtin").find_files() end,
    desc('Search files'))

map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
map('n', '<leader>y', '"+y', desc('Yank Clipboard'))
map('v', '<leader>y', '"+y', desc('Yank Clipboard'))
map('n', '<leader>p', '"+p', desc('Paste Clipboard'))

local lualine = require('lualine')

local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  function()
    return ''
  end,
  color = function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

ins_right {
  'o:encoding',
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

lualine.setup(config)
