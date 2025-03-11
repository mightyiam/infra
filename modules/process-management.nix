{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        lsof
        procs
        psmisc
        watchexec
      ];

      programs.bottom = {
        enable = true;
        settings = {
          rate = 400;
        };
      };
    };
}
