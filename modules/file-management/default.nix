{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        atool
        du-dust
        fd
        file
        ripgrep
        ripgrep-all
        unzip
        tokei
      ];
      programs = {
        yazi = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            manager.show_hidden = true;
            open.rules = [
              {
                mime = "*";
                use = "open";
              }
            ];
            opener.open = [
              {
                run = ''xdg-open "$@"'';
                desc = "Open";
              }
            ];
          };
        };
        bat.enable = true;
      };
    };
}
