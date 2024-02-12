return {

  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "folke/which-key.nvim"
    },
    init = function()
      local wk = require('which-key')
      wk.register({
        g = {
          name = "+git"
        }
      }, { prefix = "<leader>" })
    end,
    opts = {
      on_attach = function(bufnr)
        require("david.plugins.git.keymaps").on_attach(bufnr)
      end,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
        virt_text_priority = 1000,
      },
    }
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "LazyGit" },
    keys = {
      { "<leader>gl", "<cmd>LazyGit<CR>", desc = "Lazygit" }
    },
    opts = {},
    config = function(_, opts)
      require("telescope").load_extension("lazygit")
    end
  },
  {
    "NeogitOrg/neogit",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    opts = {
      kind = "split",
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true,
        telescope = true,
        fzf_lua = true,
      },
    }
  }


}
