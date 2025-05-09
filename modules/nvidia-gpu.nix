{
  flake.modules.nixos.nvidia-gpu = {
    hardware.nvidia.powerManagement.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
  };
  nixpkgs.allowedUnfreePackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
