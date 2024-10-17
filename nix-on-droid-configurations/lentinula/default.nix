{ pkgs, self, ... }:
{
  system.stateVersion = "23.05";
  time.timeZone = "Asia/Bangkok";
  home-manager.extraSpecialArgs = {
    inherit self;
  };
  home-manager.useGlobalPkgs = true;
  home-manager.config = {
    home.stateVersion = "23.05";
  };
  home-manager.sharedModules = [
    (self + "/home-manager-modules/users/mightyiam")
    { gui.enable = false; }
  ];
  user.shell = "${pkgs.zsh}/bin/zsh";
  nix.package = pkgs.nixVersions.latest;
}
