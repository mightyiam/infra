{lib, ...}: {
  nixos.modules.pc = nixosArgs: {
    services.greetd.settings.initial_session = lib.mkDefault {
      user = "mightyiam";
      command = lib.getExe' nixosArgs.config.home-manager.users.mightyiam.wayland.windowManager.hyprland.package "start-hyprland";
    };
  };
}
