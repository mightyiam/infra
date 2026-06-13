{
  users.bow.home.gui = hmArgs @ {pkgs, ...}: {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
    };

    xdg.mimeApps.defaultApplicationPackages = [hmArgs.config.programs.chromium.package];

    home.packages = [
      pkgs.chromium
      pkgs.firefox
    ];
  };
}
