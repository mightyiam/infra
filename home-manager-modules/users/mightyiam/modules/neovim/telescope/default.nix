{
  programs.nixvim.plugins.telescope.enable = true;
  imports = [
    ./ripgrep.nix
    ./keymaps.nix
    ./glyph.nix
  ];
}
