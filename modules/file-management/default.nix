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
          settings.manager.show_hidden = true;
        };
        bat.enable = true;
      };
    };
}
