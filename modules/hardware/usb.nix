{
  nixos.modules.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.usbutils];
  };
}
