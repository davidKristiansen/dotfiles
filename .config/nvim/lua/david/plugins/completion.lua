local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      'hrsh7th/cmp-buffer',
      "petertriho/cmp-git",
      "/hrsh7th/cmp-path",
      "windwp/nvim-autopairs",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "petertriho/cmp-git",
      "windwp/nvim-autopairs",
      "onsails/lspkind.nvim",
      "alexander-born/cmp-bazel",

    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },

        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',       -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          })
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          {
            name = 'path',
            option = {
              trailing_slash = true
            }
          },
          { name = 'buffer' },
          { name = 'bazel' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {
            name = 'path',
            option = {
              trailing_slash = true
            }
          }
        }, {
          { name = 'cmdline' }
        })
      })

      -- cmp.event:on(
      --   'confirm_done',
      --   cmp_autopairs.on_confirm_done()
      -- )

      local ind = cmp.lsp.CompletionItemKind
      local function ls_name_from_event(event)
        return event.entry.source.source.client.config.name
      end

      -- Add parenthesis on completion confirmation
      cmp.event:on('confirm_done', function(event)
        local ok, ls_name = pcall(ls_name_from_event, event)
        if ok and vim.tbl_contains({ 'rust_analyzer', 'lua_ls' }, ls_name) then
          return
        end

        local completion_kind = event.entry:get_completion_item().kind
        if vim.tbl_contains({ ind.Function, ind.Method }, completion_kind) then
          local left = vim.api.nvim_replace_termcodes('<Left>', true, true, true)
          vim.api.nvim_feedkeys('()' .. left, 'n', false)
        end
      end)
    end
  },
  {
    'altermo/ultimate-autopair.nvim',
    -- event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recomended as each new version will have breaking changes
    opts = {
      --Config goes here
    },
  }
}
