vim.pack.add({
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/folke/snacks.nvim",
})

local neogit = require("neogit")

neogit.setup()

vim.keymap.set("n", "<leader>gG", function() neogit.open({ kind = "split_below" }) end, { desc = "Neogit" })
