{
  nixos.modules.base = {
    programs = {
      neovim = {
        enable = true;
        defaultEditor = true;
      };
      nano.enable = false;
    };
  };
}
