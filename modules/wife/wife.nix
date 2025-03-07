let
  username = "1bowapinya";
in
{
  flake.modules.nixos.wife =
    { pkgs, ... }:
    {
      users.users.${username} = {
        isNormalUser = true;
        initialPassword = "";
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

      home-manager.users.${username}.imports = [
        {
          programs.firefox.enable = true;
        }
        (
          { osConfig, ... }:
          {
            home.stateVersion = osConfig.system.stateVersion;
          }
        )
      ];
    };
}
