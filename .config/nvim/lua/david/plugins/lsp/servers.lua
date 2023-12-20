local M = {}

M.opts = {
  lua_ls = {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              -- checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true)
            }
          }
        })
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end
      return true
    end,

  },
  -- pyright = {
  --
  -- },
  -- ruff_lsp = {
  --
  -- },
  pylsp = {
    flags = {
      debounce_text_changes = 200,
    },
    settings = {
      pylsp = {
        plugins = {
          black = { enabled = true },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          -- type checker
          pylsp_mypy = { enabled = true },
          -- auto-completion options
          jedi_completion = { fuzzy = true },
          -- import sorting
          pyls_isort = { enabled = true },

        }
      }
    }
  },
  clangd = {
    cmd = {
      "clangd",
      "--header-insertion=never",
      "--offset-encoding=utf-16", --temporary fix for null-ls
    }
  }
}

M.setup = {
  clangd = function(_, opts)
    require("clangd_extensions").setup({
      server = opts,
      extensions = {
        inlay_hints = {
          only_current_line = true,
        },
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },

        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    })
    return true
  end,
}

return M
