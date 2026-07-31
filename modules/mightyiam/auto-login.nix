{lib, ...}: {
  nixos.modules.pc = {pkgs, ...}: {
    services.greetd.settings.initial_session = lib.mkDefault {
      user = "mightyiam";
      command = lib.getExe' pkgs.hyprland "start-hyprland";
    };
  };
}
