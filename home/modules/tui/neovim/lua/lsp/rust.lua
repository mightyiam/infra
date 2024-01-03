local function setup(lsp_zero)
  local options = lsp_zero.build_options("rust_analyzer", {
    on_attach = function(client, bufnr)
      require("which-key").register({
        ["<leader>"] = {
          r = {
            name = "Rust",
            p = {
              "<CMD>RustParentModule<CR>",
              "go to parent module",
            },
          },
        },
      })
    end,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
        inlayHints = {
          maxLength = 99,
        },
        cargo = {
          features = "all",
        },
      }
    }
  })
  require("rust-tools").setup({ server = options })
end

return setup
