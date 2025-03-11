{
  flake.modules.homeManager.gui = {
    programs.zathura.enable = true;
    xdg.mimeApps.defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };
}
