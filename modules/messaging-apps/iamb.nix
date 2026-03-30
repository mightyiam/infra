{ config, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      # [Build failure: iamb · Issue #501937 · NixOS/nixpkgs](https://github.com/NixOS/nixpkgs/issues/501937)
      #home.packages = with pkgs; [ iamb ];
      xdg.configFile."iamb/config.toml".source = pkgs.writers.writeTOML "iamb-config.toml" {
        profiles.default.user_id = config.flake.meta.owner.matrix;
        settings.notifications.enabled = true;
      };
    };
}
