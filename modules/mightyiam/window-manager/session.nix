{lib, ...}: {
  users.mightyiam = {
    wayland.sessions = pkgs: [pkgs.hyprland];

    nixos.pc = {pkgs, ...}: {
      services.greetd.settings = {
        initial_session = {
          user = "mightyiam";
          command = lib.getExe' pkgs.hyprland "start-hyprland";
        };
      };
    };
  };
}
