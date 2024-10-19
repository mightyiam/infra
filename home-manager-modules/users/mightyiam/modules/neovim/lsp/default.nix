{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      inlayHints = true; # TODO test
    };
    cmp-nvim-lsp.enable = true;
  };
  cmp.settings.sources = [
    {
      name = "nvim_lsp";
      group_index = 1;
    }
  ];
  imports = [
    ./inlay-hints.nix
    ./keymaps.nix
    ./servers
  ];

}
