{ pkgs, ... }:
{
  users.users."1bowapinya" = {
    isNormalUser = true;
    initialPassword = "";
    extraGroups = [ "audio" ];
  };

  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gnome-calendar
    gnome-connections
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-text-editor
    gnome-tour
    gnome-user-docs
    gnome-weather
    orca
    simple-scan
    snapshot
    yelp
  ];

  home-manager.users."1bowapinya".imports = [
    ../../home-manager-modules/1bowapinya
    (
      { osConfig, ... }:
      {
        home.stateVersion = osConfig.system.stateVersion;
      }
    )
  ];
}
