{
  nixos.modules.pc = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.heroic
    ];
  };
}
