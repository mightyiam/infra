{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        du-dust
        fd
        file
        ripgrep
        ripgrep-all
        tokei
      ];
      programs = {
        yazi = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            mgr.show_hidden = true;
            open.rules = [
              {
                mime = "*";
                use = "open";
              }
            ];
            opener.open = [
              {
                run = ''${lib.getExe' pkgs.xdg-utils "xdg-open"} "$@"'';
                desc = "Open";
              }
            ];
          };
        };
        bat.enable = true;
      };
    };
}
