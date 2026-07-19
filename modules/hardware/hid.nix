{
  nixos.modules.pc = {pkgs, ...}: {
    services.ratbagd.enable = true;
    environment.systemPackages = [
      pkgs.piper
      pkgs.wev
    ];
  };
}
