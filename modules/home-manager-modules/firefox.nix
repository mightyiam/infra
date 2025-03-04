{ config, lib, ... }:
lib.mkIf config.gui.enable {
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
}
