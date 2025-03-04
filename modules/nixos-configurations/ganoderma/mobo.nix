{
  hardware.nvidia.open = false;
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.allowUnfreePackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
