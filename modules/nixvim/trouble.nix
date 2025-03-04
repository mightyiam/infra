{
  plugins = {
    web-devicons.enable = true;
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
        auto_jump = true;
        auto_refresh = true;
        follow = false;
      };
    };
  };
  keymaps = [
    {
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
    }
    {
      key = "<leader>xl";
      action = "<cmd>Trouble lsp toggle<cr>";
    }
    {
      key = "<leader>xD";
      action = "<cmd>Trouble lsp_declarations toggle<cr>";
    }
    {
      key = "<leader>xd";
      action = "<cmd>Trouble lsp_definitions toggle<cr>";
    }
    {
      key = "<leader>xi";
      action = "<cmd>Trouble lsp_implementations toggle<cr>";
    }
    {
      key = "<leader>xr";
      action = "<cmd>Trouble lsp_references toggle<cr>";
    }
    {
      key = "<leader>xt";
      action = "<cmd>Trouble lsp_type_definitions toggle<cr>";
    }
    {
      key = "<leader>xq";
      action = "<cmd>Trouble quickfix toggle<cr>";
    }
    {
      key = "<leader>xf";
      action = "<cmd>Trouble focus<cr>";
    }
  ];
}
