{lib, ...}: {
  nixos.modules.pc = {
    programs.dconf.enable = true;
  };
  home.base.dconf.enable = lib.mkDefault false;
}
