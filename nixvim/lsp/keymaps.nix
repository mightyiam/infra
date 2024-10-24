{
  plugins.lsp.keymaps = {
    diagnostic = {
      gl = "setloclist";
      "]d" = "goto_next";
      "[d" = "goto_prev";
    };
    lspBuf = {
      K = "hover";
      "<C-k>" = "signature_help";
      gd = "definition";
      gD = "declaration";
      gi = "implementation";
      go = "type_definition";
      "<space>r" = "rename";
      "<space>a" = "code_action";
      "<space>f" = "format";
    };
  };
}
