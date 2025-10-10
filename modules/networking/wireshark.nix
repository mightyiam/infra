{ config, ... }:
{
  flake.modules = {
    nixos.pc = {
      programs.wireshark.enable = true;

      users.groups.wireshark.members = [
        config.flake.meta.owner.username
      ];
    };
    homeManager.gui =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.wireshark-qt ];
      };
  };
}
