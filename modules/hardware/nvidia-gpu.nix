{lib, ...}: {
  options.nixos.modules = {
    nvidia-video-driver = lib.mkOption {
      type = lib.types.deferredModule;
      readOnly = true;
      default = {
        key = "nvidia-video-driver";
        services.xserver.videoDrivers = ["nvidia"];
      };
    };
    force-default-video-drivers = lib.mkOption {
      type = lib.types.deferredModule;
      readOnly = true;
      default = nixosArgs: {
        key = "force-default-video-drivers";
        services.xserver.videoDrivers = lib.mkForce nixosArgs.options.services.xserver.videoDrivers.default;
      };
    };
  };

  config.perSystem = {
    nixpkgs.config.allowUnfreePackages = [
      "nvidia-kernel-modules"
      "nvidia-settings"
      "nvidia-x11"
    ];
  };
}
