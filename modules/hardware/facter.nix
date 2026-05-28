{
  flake.modules = {
    nixos.base = nixosArgs: {
      hardware.facter.detected.dhcp.enable = false;
      services.ucodenix.cpuModelId = nixosArgs.config.hardware.facter.reportPath;
    };

    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ nixos-facter ];
      };
  };
}
