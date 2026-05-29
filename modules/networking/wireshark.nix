{
  flake.modules = {
    nixos.pc = {
      programs.wireshark.enable = true;
    };
    homeManager.gui =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.wireshark ];
      };
  };
}
