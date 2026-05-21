{
  config,
  lib,
  homeManager,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      checks =
        {
          base = with config.flake.modules.homeManager; [ base ];
          gui = with config.flake.modules.homeManager; [
            base
            gui
          ];
        }
        |> lib.mapAttrs' (
          name: modules: {
            name = "home-manager/${name}";
            value =
              {
                inherit pkgs;
                modules = modules ++ [ { home.stateVersion = "25.05"; } ];
              }
              |> homeManager.homeManagerConfiguration
              |> lib.getAttrFromPath [
                "config"
                "home-files"
              ];
          }
        );
    };
}
