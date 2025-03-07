{
  flake.modules.nixvim.astrea =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.vim-easymotion ];
    };
}
