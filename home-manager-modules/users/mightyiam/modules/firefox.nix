{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;
in
  mkIf config.gui.enable {
    programs.firefox.enable = true;
    programs.firefox.profiles.primary.id = 0;
    programs.firefox.profiles.primary.settings."toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    programs.firefox.profiles.primary.settings."browser.ctrlTab.sortByRecentlyUsed" = true;
    programs.firefox.profiles.primary.settings."browser.tabs.closeWindowWithLastTab" = false;
    programs.firefox.profiles.primary.userChrome = ''
    '';
    programs.firefox.profiles.primary.userContent = ''
    '';
  }
