return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "jsx", "tsx" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
