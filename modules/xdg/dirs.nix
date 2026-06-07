{lib, ...}: {
  homeManager.modules.base = hmArgs: {
    home.preferXdgDirectories = true;

    xdg = {
      enable = true;

      userDirs =
        {
          enable = true;
          createDirectories = true;
          setSessionVariables = false;

          download = "${hmArgs.config.home.homeDirectory}/download";
        }
        // lib.genAttrs [
          "desktop"
          "documents"
          "music"
          "pictures"
          "projects"
          "publicShare"
          "templates"
          "videos"
        ] (_: null);
    };
  };
}
