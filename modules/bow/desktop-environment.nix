{
  users.bow = {
    nixos.pc = {
      services = {
        system76-scheduler.enable = true;
        desktopManager.cosmic.enable = true;
      };
    };
    home.gui = {pkgs, ...}: {
      xdg.mimeApps.defaultApplicationPackages = [
        pkgs.cosmic-edit
        pkgs.loupe
      ];
    };
  };
}
