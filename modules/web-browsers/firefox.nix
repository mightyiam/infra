{
  flake.modules.homeManager.gui = hmArgs: {
    programs.firefox = {
      enable = true;
      configPath = "${hmArgs.config.xdg.configHome}/mozilla/firefox";
      profiles = {
        primary = {
          id = 0;
          settings."toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          settings."browser.ctrlTab.sortByRecentlyUsed" = true;
          settings."browser.tabs.closeWindowWithLastTab" = false;
          userChrome = "";
          userContent = "";
        };
        vpn = {
          id = 1;
        };
      };
    };

    stylix.targets.firefox.profileNames = [ "primary" ];
  };
}
