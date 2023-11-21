--------------------------------------------------------------------------------
-- Mason configuration
--------------------------------------------------------------------------------
require("neoconf").setup()
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup {
  ensure_installed = {
    "efm",
    "lua_ls",
  },
  automatic_installation = true,
}

--------------------------------------------------------------------------------
-- LSP configuration
--------------------------------------------------------------------------------
local lspconfig = require 'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer = 0})
    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, {buffer = 0})
    vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, {buffer = 0})
    vim.keymap.set('n', 'grr', vim.lsp.buf.rename, {buffer = 0})
end

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

-- python
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = false,
      analysis = {
        useLibraryCodeForTypes = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        autoImportCompletions = true,
      },
    },
  },
})

-- Java
lspconfig.jdtls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "jdtls",
    "-configuration",
    "~/.cache/jdtls/config",
    "-data",
    "~/.cache/jdtls/workspace",
  },
}
-- LaTeX
lspconfig.texlab.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.diagnostic.disable()
vim.keymap.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.disable()<CR>", {silent = true})
vim.keymap.set("n", "<leader>de", "<cmd>lua vim.diagnostic.enable()<CR>", {silent = true})

--------------------------------------------------------------------------------
-- LSP autocomplete
--------------------------------------------------------------------------------
local cmp = require 'cmp'
local lspkind = require('lspkind')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-i>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  },
  {
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  }),
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
        gh_issues = "[issues]",
        tn = "[TabNine]",
        eruby = "[erb]",
        cody = "[cody]",
      },
    }
  },
  experimental = {
    native_menu = false,
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

--------------------------------------------------------------------------------
-- LSP Snippets
--------------------------------------------------------------------------------
local ls = require 'luasnip'
-- some shorthands...
local s = ls.snippet
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")

ls.setup({
	keep_roots = true,
	link_roots = true,
	link_children = true,

	-- Update more often, :h events for more info.
	update_events = "TextChanged,TextChangedI",
	-- Snippets aren't automatically removed if their text is deleted.
	-- `delete_check_events` determines on which events (:h events) a check for
	-- deleted snippets is performed.
	-- This can be especially useful when `history` is enabled.
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
	-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
	-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
	store_selection_keys = "<Tab>",
	-- luasnip uses this function to get the currently active filetype. This
	-- is the (rather uninteresting) default, but it's possible to use
	-- eg. treesitter for getting the current filetype by setting ft_func to
	-- require("luasnip.extras.filetype_functions").from_cursor (requires
	-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
	-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
	ft_func = function()
		return vim.split(vim.bo.filetype, ".", true)
	end,
})

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = true,

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}

vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-K>", function()

	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- Friendly-snippets
require("luasnip.loaders.from_vscode").load({
  include = {
    "python",
    "javascript",
    "typescript",
    "lua",
    "java"
  },
})

-- Custom snippets
-- All
ls.add_snippets(
  "all",
  {
    -- Using parser
    ls.parser.parse_snippet(
      "lspsyn",
      "Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"
    ),
    s(
      "tp",
      fmt(
        "{}: {}[:]",
        {
          i(1),
          c(2,
          {
            t("Chapters"),
            t("Documentation"),
            t("Playlist"),
          }),
        }
      )
    )
  }
)

-- Lua
ls.add_snippets(
  "lua",
  {
    -- Using lua code
    s(
      "insert_node",
      fmt(
        "local {} = require('{}')",
        {
          i(1),
          rep(1),
        }
      )
    ),
    s(
      "choice_node",
      fmt(
        "Test {}",
        c(
          1,
          {
            t("Hello"),
            t("World"),
          }
        )
      )
    ),
    s(
      "function_node",
      fmt(
        "Time {}",
        f(
          function()
            return os.date("%H:%M:%S", os.time())
          end
        )
      )
    )
    -- TODO: Figure out how to do dynamic nodes
    -- s(
    --   "dynamic_node",
    -- )
  }
)
