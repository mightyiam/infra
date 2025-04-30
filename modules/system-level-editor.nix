{
  flake.modules.nixos.pc.programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      defaultEditor = true;
    };
    nano.enable = false;
  };
}
