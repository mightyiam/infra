{lib, ...}: {
  nixos.modules.base = nixosArgs @ {pkgs, ...}: {
    environment.systemPackages = lib.mkIf nixosArgs.config.hardware.bluetooth.enable [pkgs.bluetui];
  };
}
