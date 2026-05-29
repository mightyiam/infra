{
  flake.modules.homeManager.base = {
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
