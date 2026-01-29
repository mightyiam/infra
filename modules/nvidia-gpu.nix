{
  flake.modules.nixos.nvidia-gpu = {
    specialisation.nvidia-gpu.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];
    };
  };
  nixpkgs.config.allowUnfreePackages = [
    "nvidia-x11"
    "nvidia-settings"
  ];
}
