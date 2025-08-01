{ inputs, ... }:
{
  flake.modules = {
    nixos.base = {
      imports = [ inputs.nixos-facter-modules.nixosModules.facter ];
      facter.detected.dhcp.enable = false;
    };

    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ nixos-facter ];
      };
  };
}
