{ config, ... }:
{
  flake.modules.homeManager.base = {
    home = {
      username = config.flake.meta.owner.username;
      homeDirectory = "/home/${config.flake.meta.owner.username}";
    };
    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
