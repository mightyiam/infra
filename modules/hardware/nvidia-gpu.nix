{
  lib,
  mkModuleOption,
  ...
}: {
  options.nixos.modules = {
    nvidia-video-driver = mkModuleOption {
      key = "nvidia-video-driver";
      static = {
        services.xserver.videoDrivers = ["nvidia"];
      };
    };
    force-default-video-drivers = mkModuleOption {
      key = "force-default-video-drivers";
      static = nixosArgs: {
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
