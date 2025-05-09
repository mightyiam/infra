{
  flake.modules.nixos.nvidia-gpu.services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.allowedUnfreePackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
