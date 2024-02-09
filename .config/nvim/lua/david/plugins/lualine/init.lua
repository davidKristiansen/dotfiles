local f = require("david.plugins.lualine.functions")

-- local colors = require("kanagawa.colors").setup({ theme = 'dragon' })
return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    event = "VeryLazy",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "SmiteshP/nvim-navic",
      {
        "tpope/vim-tpipeline",
        config = function()
          vim.g.tpipeline_clearstl = 1
          vim.o.fcs = "stlnc:─,stl:─,vert:│"
          vim.opt.fillchars:append({ eob = " " })
        end
      }
    },
    opts = {
      options = {
        --       -- theme = require("david.plugins.lualine.theme"),
        theme = "auto",
        section_separators = { left = '', right = '' },
        component_separators = { left = '╲', right = '╱ ' },
        disabled_filetypes = {
          statusline = { "neo-tree" },
          winbar = { "neo-tree" },
        },
      },
      extensions = {
        'quickfix',
        'neo-tree',
        'lazy'
      },
      sections = {
        lualine_a = {
          {
            "macro-recording",
            fmt = f.show_macro_recording,
          },
          'mode',
        },
        lualine_c = {
          'filename',
          {
            "navic",
            color_correction = nil,
            navic_opts = nil
          },
        },
        lualine_z = {
          'location',
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            -- color = { fg = colors.dragonBlack0 },
          }
        }
      },
      -- winbar = {
      --   lualine_a = {
      --     {
      --       'filename', path = 1
      --     },
      --   },
      --   lualine_b = {
      --   }
      -- },
      -- inactive_winbar = {
      --   lualine_a = { { 'filename', path = 1 } }
      -- }
    }
  },
  {
    "SmiteshP/nvim-navic",
    opts = {
      lsp = {
        auto_attach = true,
      },
      click = true,
      -- highlight = true,
    }
  }
}
