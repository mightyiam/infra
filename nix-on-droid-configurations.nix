{
  self,
  inputs,
  lib,
  ...
}:
let
  pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
in
{
  flake.nixOnDroidConfigurations.lentinula = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    inherit pkgs;
    modules = [
      {
        system.stateVersion = "23.05";
        time.timeZone = "Asia/Bangkok";
        home-manager.useGlobalPkgs = true;
        home-manager.extraSpecialArgs = {
          inherit self;
        };
        home-manager.config = {
          home.stateVersion = "23.05";
        };
        home-manager.sharedModules = [
          ./home-manager-modules/users/mightyiam/default.nix
          { gui.enable = false; }
        ];
        user.shell = "${pkgs.zsh}/bin/zsh";
        nix.package = pkgs.nixVersions.latest;
      }
    ];
  };

  #perSystem.checks."nixOnDroidConfigurations/lentinula" = self.nixOnDroidConfigurations.lentinula.activationPackage;
}
