with builtins; homeDirectory: {
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let
          web_browser = [ "firefox.desktop" ];
          browser_types = [
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/chrome"
            "text/html"
            "application/x-extension-htm"
            "application/x-extension-html"
            "application/x-extension-shtml"
            "application/xhtml+xml"
            "application/x-extension-xhtml"
            "application/x-extension-xht"
          ];
          image = [ "imv.desktop" ];
          type_to_browser_entry = (type: { name = type; value = web_browser; });
          browser_entries = listToAttrs (map type_to_browser_entry browser_types);
        in
        browser_entries // {
          "image/png" = image;
          "x-scheme-handler/magnet" = "transmission-gtk";
        };
    };
    userDirs = let tmp = "${homeDirectory}/tmp"; in
      {
        enable = true;
        createDirectories = true;
        desktop = tmp;
        documents = tmp;
        download = tmp;
        music = tmp;
        pictures = tmp;
        publicShare = "${homeDirectory}/public";
        templates = "${homeDirectory}/templates";
        videos = tmp;
      };
  };
}
