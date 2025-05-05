{
  flake.modules = {
    nixos.wife =
      { pkgs, ... }:
      {
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
      };

    homeManager.wife.programs.gnome-shell.enable = true;
  };
}
