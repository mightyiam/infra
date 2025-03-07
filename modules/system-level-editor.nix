{
  flake.modules.nixos.desktop.programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };
    nano.enable = false;
  };
}
