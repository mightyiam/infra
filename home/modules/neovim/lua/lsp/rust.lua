local function setup(lsp_zero)
  local options = lsp_zero.build_options("rust_analyzer", {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        }
      }
    }
  })
  require("rust-tools").setup({ server = options })
end

return setup
