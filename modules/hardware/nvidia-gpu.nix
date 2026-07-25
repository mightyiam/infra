{lib, ...}: {
  nixos.modules = {
    nvidia-video-driver = {
      services.xserver.videoDrivers = ["nvidia"];
    };
    force-default-video-drivers = nixosArgs: {
      services.xserver.videoDrivers = lib.mkForce nixosArgs.options.services.xserver.videoDrivers.default;
    };
  };

  perSystem = {
    nixpkgs.config.allowUnfreePackages = [
      "nvidia-kernel-modules"
      "nvidia-settings"
      "nvidia-x11"
    ];
  };
}
