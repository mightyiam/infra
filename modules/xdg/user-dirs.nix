{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      xdg = {
        enable = true;
        userDirs =
          let
            tmp = "${config.home.homeDirectory}/tmp";
          in
          {
            enable = true;
            createDirectories = true;
            desktop = tmp;
            documents = tmp;
            download = tmp;
            music = tmp;
            pictures = tmp;
            publicShare = "${config.home.homeDirectory}/public";
            templates = "${config.home.homeDirectory}/templates";
            videos = tmp;
          };
      };
    };
}
