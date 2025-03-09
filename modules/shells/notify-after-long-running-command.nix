{ inputs, lib, ... }:
{
  flake.modules.homeManager.home =
    { config, pkgs, ... }:
    {
      home.packages = [ pkgs.libnotify ];
      programs.zsh.plugins = lib.mkIf config.gui.enable [
        {
          name = "auto-notify";
          src = inputs.zsh-auto-notify;
        }
      ];
    };
}
