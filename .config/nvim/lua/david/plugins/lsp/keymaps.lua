local M = {}


function M.on_attach(client, buffer)
  local wik = require("which-key")
  local keys = {
    { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    { "<leader>cl", "<cmd>LspInfo<cr>",        desc = "Lsp Info" },
    { "gD",         vim.lsp.buf.declaration,   desc = "Goto Declaration" },
    { "gd",         vim.lsp.buf.definition,    desc = "Goto Definition" },
    {
      "gvD",
      function()
      vim.cmd([[
        vsplit
      ]])
         vim.lsp.buf.declaration()
      end,
      desc = "Goto Declaration (split)"
    },
    {
      "gvd",
      function()
         vim.cmd([[
          vsplit
        ]])
        vim.lsp.buf.definition()
      end,
      desc = "Goto Definition (split)"
    },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.format { async = true }
      end,
      desc = "Format"
    },
  }

  local opts = {
    buffer = buffer
  }

  for _, key in pairs(keys) do
    opts.desc = key.desc
    vim.keymap.set(key.mode or "n", key[1], key[2], opts)
  end
end

return M
-- vim.keymap.set('n', 'gv', function()
--     vsplit vim.lsp.buf.definition
--   end , bufopts)
