{lib, ...}: {
  home.base = {pkgs, ...}: {
    programs.yazi.settings = {
      open.append_rules = [
        {
          url = "*";
          use = "open";
        }
      ];
      opener.open = [
        {
          run = ''${lib.getExe' pkgs.xdg-utils "xdg-open"} %s1'';
          desc = "Open";
        }
      ];
    };
  };
}
