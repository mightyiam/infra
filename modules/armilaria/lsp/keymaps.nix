{
  armilaria = {
    lsp.keymaps = [
      {
        key = "K";
        lspBufAction = "hover";
      }
      {
        key = "<C-k>";
        lspBufAction = "signature_help";
      }
      {
        key = "gd";
        lspBufAction = "definition";
      }
      {
        key = "gD";
        lspBufAction = "declaration";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
      }
      {
        key = "go";
        lspBufAction = "type_definition";
      }
      {
        key = "<space>r";
        lspBufAction = "rename";
      }
      {
        key = "<space>a";
        lspBufAction = "code_action";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };
}
