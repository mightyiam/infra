{lib, ...}: {
  options.nixos.modules = {
    nvidia-video-driver = lib.mkOption {
      type = lib.types.deferredModuleWith {
        staticModules = [
          {services.xserver.videoDrivers = ["nvidia"];}
        ];
      };
      default = {};
    };
    force-default-video-drivers = lib.mkOption {
      type = lib.types.deferredModuleWith {
        staticModules = [
          (nixosArgs: {
            services.xserver.videoDrivers = lib.mkForce nixosArgs.options.services.xserver.videoDrivers.default;
          })
        ];
      };
      default = {};
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
