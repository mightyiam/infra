{
  flake.modules = {
    nixos.wife =
      { pkgs, ... }:
      {
        services.desktopManager.gnome.enable = true;

        environment.gnome.excludePackages = with pkgs; [
          epiphany
          geary
          gnome-calendar
          gnome-connections
          gnome-contacts
          gnome-logs
          gnome-maps
          gnome-music
          gnome-tour
          gnome-weather
          orca
        ];
      };

    homeManager.wife.programs.gnome-shell.enable = true;
  };
}
