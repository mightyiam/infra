{pkgs, ...}: {
  users.users."1bowapinya" = {
    isNormalUser = true;
    initialPassword = "";
    extraGroups = ["audio"];
  };

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  environment.gnome.excludePackages =
    (with pkgs; [
      epiphany
      geary
      gnome-calendar
      gnome-connections
      gnome-text-editor
      gnome-tour
      gnome-user-docs
      orca
      simple-scan
      snapshot
      yelp
    ])
    ++ (with pkgs.gnome; [
      gnome-contacts
      gnome-logs
      gnome-maps
      gnome-music
      gnome-weather
    ]);
}
