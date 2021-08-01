{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications =
        let 
          web_browser = [ "firefox.desktop" "chromium.desktop" ];
          image = [ "imv.desktop" ];
        in {
          "text/html" = web_browser;
          "x-scheme-handler/http" = web_browser;
          "x-scheme-handler/https" = web_browser;
          "x-scheme-handler/about" = web_browser;
          "x-scheme-handler/unknown" = web_browser;
          "image/png" = image;
        };
    };
    #userDirs = let tmp = "${homeDirectory}/tmp"; in {
      #enable = true;
      #createDirectories = false;
      #desktop = tmp;
      #documents = tmp;
      #download = tmp;
      #music = tmp;
      #pictures = tmp;
      #publicShare = "${homeDirectory}/public";
      #templates = "${homeDirectory}/templates";
      #videos = tmp;
    #};
  };
}
