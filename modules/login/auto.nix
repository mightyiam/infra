{ lib, ... }:
{
  flake.modules.nixos.pc = nixosArgs: {
    services.greetd.settings.initial_session = {
      user = "mightyiam";
      command = lib.getExe' nixosArgs.config.home-manager.users.mightyiam.wayland.windowManager.hyprland.package "start-hyprland";
    };
  };
}
