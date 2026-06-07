{lib, ...}: {
  home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      imv
      wl-color-picker
    ];

    xdg.mimeApps.defaultApplications = lib.genAttrs [
      "image/png"
      "image/jpeg"
    ] (_: ["imv.desktop"]);
  };
}
