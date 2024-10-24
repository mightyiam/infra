{
  plugins = {
    lsp.enable = true;
    cmp.settings.sources = [
      {
        name = "nvim_lsp";
        group_index = 1;
      }
    ];
  };

  imports = [
    ./inlay-hints.nix
    ./keymaps.nix
    ./servers
  ];

}
