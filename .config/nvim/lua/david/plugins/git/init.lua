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
      on_attach = function (bufnr)
        require("david.plugins.git.keymaps").on_attach(bufnr)
      end
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
  }

}