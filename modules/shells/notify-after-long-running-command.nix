{ inputs, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.libnotify ];
      programs.zsh.plugins = [
        {
          name = "auto-notify";
          src = inputs.zsh-auto-notify;
        }
      ];
    };
}
