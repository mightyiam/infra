{ config, ... }:
{
  flake.modules.homeManager.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ iamb ];
      xdg.configFile."iamb/config.toml".source = pkgs.writers.writeTOML "iamb-config.toml" {
        profiles.default.user_id = config.flake.meta.owner.matrix;
        settings.notifications.enabled = true;
      };
    };
}
