vim.opt.background = 'dark'
vim.opt.number = true
vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.g.cmp_enabled = true

vim.opt.timeoutlen = 500
vim.opt.scrolloff = 5

vim.g.everforest_background = 'hard'

vim.cmd.colorscheme('everforest')

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil,
  },
  autotag = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = false },
}

capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'gopls', 'rust_analyzer', 'nil_ls', 'clangd', 'texlab' }
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
      texlab = {
        build = {
          executable = 'tectonic',
          args = { '-X', 'compile', '%f', '--synctex', '--keep-logs', '--keep-intermediates' },
          forwardSearchAfter = true
        },
        forwardSearch = {
          executable = 'sioyek',
          args = {
            '--reuse-instance',
            '--forward-search-file',
            '%f',
            '--forward-search-line',
            '%l',
            '%p'
          }
        }
      }
    }
  }
end

require('which-key').setup()

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
      diagnostics = "裂 Diagnostic",
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
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
        conflict = "",
      },
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<space>"] = false,
      o = "open",
      H = "prev_source",
      L = "next_source",
    },
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        h = "toggle_hidden",
      },
    },
  },
  event_handlers = {
    { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
  },
}

local utils = require "Comment.utils"

require("Comment").setup {
  pre_hook = function(ctx)
    local location = nil
    if ctx.ctype == utils.ctype.blockwise then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == utils.ctype.linewise and "__default" or "__multiline",
      location = location,
    }
  end,
}

require("toggleterm").setup {
  size = 10,
  open_mapping = [[<F7>]],
  shading_factor = 2,
  direction = "float",
  float_opts = {
    border = "curved",
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

require("nvim-autopairs").setup {
  check_ts = true,
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0,
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

require("better_escape").setup()

local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

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
    Unit = "",
  },
}

require("bufferline").setup {
  options = {
    offsets = {
      { filetype = "NvimTree", text = "", padding = 1 },
      { filetype = "neo-tree", text = "", padding = 1 },
      { filetype = "Outline", text = "", padding = 1 },
    },
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    close_command = close_func,
    right_mouse_command = close_func,
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    separator_style = "thin",
  },
}

vim.notify = require "notify"
require("notify").setup { stages = "fade" }

local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = string.format("%s ", "" ),
    selection_caret = string.format("%s ", "❯" ),
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = { ["q"] = actions.close },
    },
  },
}

require('nvim-web-devicons').setup {
 color_icons = true;
 default = true;
}

vim.g.mapleader = ' '
local map = vim.keymap.set
local function desc(s)
  return { desc = s }
end

map('n', '<leader>w', '<cmd>w<cr>', desc('Save'))
map('n', '<leader>q', '<cmd>w<cr>', desc('Quit'))
map('n', '<leader>h', '<cmd>nohlsearch<cr>', desc('No Highlight'))
map('n', '|', '<cmd>vsplit<cr>', desc('Vertical Split'))
map('n', '\\', '<cmd>split<cr>', desc('Horizontal Split'))

map('n', '<leader>/', function() require("Comment.api").toggle.linewise.current() end, desc('Comment'))
map('v', '<leader>/', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc('Comment'))
map('n', '<leader>e', '<cmd>Neotree toggle<cr>', desc('Neotree'))

map('t', "<C-'>", '<cmd>ToggleTerm<cr>')
map('n', "<C-'>", '<cmd>ToggleTerm<cr>')

-- map('n', '<C-h>', function() require("smart-splits").move_cursor_left() end)
-- map('n', '<C-j>', function() require("smart-splits").move_cursor_down() end)
-- map('n', '<C-k>', function() require("smart-splits").move_cursor_up() end)
-- map('n', '<C-l>', function() require("smart-splits").move_cursor_right() end)

map('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, desc('Format'))

map('n', '<leader>gg', "<cmd>TermExec cmd='exec lazygit'<cr>", desc('Lazygit'))
map('n', '<leader>gc', function() require("telescope.builtin").git_commits() end, desc('Git commits'))
map('n', '<leader>fw', function() require("telescope.builtin").live_grep() end, desc('Search words'))
map('n', '<leader>ff', function() require("telescope.builtin").find_files() end, desc('Search files'))

map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
