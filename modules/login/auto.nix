{ config, lib, ... }:
{
  flake.modules.nixos.pc = nixosArgs: {
    services.greetd.settings.initial_session = lib.mkDefault {
      user = config.flake.meta.owner.username;
      command =
        lib.getExe'
          nixosArgs.config.home-manager.users.${config.flake.meta.owner.username}.wayland.windowManager.hyprland.package
          "start-hyprland";
    };
  };
}
