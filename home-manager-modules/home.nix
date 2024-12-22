{ config, ... }:
{
  home = {
    username = "mightyiam";
    homeDirectory = "/home/${config.home.username}";
    sessionVariables.TZ = "\$(<~/.config/timezone)";
  };
  programs.home-manager.enable = true;
}
