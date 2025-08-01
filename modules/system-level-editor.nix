{
  flake.modules.nixos.base.programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };
    nano.enable = false;
  };
}
