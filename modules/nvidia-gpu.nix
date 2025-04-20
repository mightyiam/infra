{
  flake.modules.nixos.nvidia-gpu = {
    hardware.nvidia.open = false;
    services.xserver.videoDrivers = [ "nvidia" ];
  };
  nixpkgs.allowedUnfreePackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
