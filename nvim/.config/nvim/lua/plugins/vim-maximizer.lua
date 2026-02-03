return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>sm", function()
      if vim.bo.filetype == "NvimTree" then
        vim.cmd.NvimTreeClose()
      end
      vim.cmd.MaximizerToggle()
    end, desc = "Maximize/minimize a split (and close NvimTree if open)" },
  },
}