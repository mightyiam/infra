{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    let
      firefoxProfile = "primary";
    in
    {
      programs = {
        chromium = {
          enable = true;
          package = pkgs.brave;
        };

        firefox = {
          enable = true;
          profiles.${firefoxProfile} = { };
        };
      };

      stylix.targets.firefox.profileNames = [ firefoxProfile ];

      home.packages = [ pkgs.chromium ];
    };
}
