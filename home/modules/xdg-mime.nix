with builtins;
  instance: {pkgs, ...}: let
    pipe = pkgs.lib.trivial.pipe;
    web_browser = ["firefox.desktop"];
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
    image = ["imv.desktop"];
    type_to_browser_entry = type: {
      name = type;
      value = web_browser;
    };
    browser_entries = pipe browser_types [(map type_to_browser_entry) listToAttrs];
  in {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications =
          browser_entries
          // {
            "image/png" = image;
            "x-scheme-handler/magnet" = "transmission-gtk";
          };
      };
    };
  }
