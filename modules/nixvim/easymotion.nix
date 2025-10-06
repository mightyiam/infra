{
  flake.modules.nixvim.base =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.vim-easymotion ];
    };
}
