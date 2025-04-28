{
  flake.modules.homeManager.gui = {
    programs.firefox = {
      enable = true;
      profiles = {
        primary = {
          id = 0;
          settings."toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          settings."browser.ctrlTab.sortByRecentlyUsed" = true;
          settings."browser.tabs.closeWindowWithLastTab" = false;
          userChrome = '''';
          userContent = '''';
        };
        vpn = {
          id = 1;
        };
      };
    };

    stylix.targets.firefox.profileNames = [ "primary" ];
  };
}
