{ inputs, ... }:
{
  flake.modules.nixvim.astrea.plugins.lsp.keymaps = {
    lspBuf = {
      K = "hover";
      "<C-k>" = "signature_help";
      gd = "definition";
      gD = "declaration";
      gi = "implementation";
      go = "type_definition";
      "<space>r" = "rename";
    };
    extra = [
      {
        key = "<space>a";
        action = inputs.nixvim.lib.nixvim.mkRaw "vim.lsp.buf.code_action";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };
}
