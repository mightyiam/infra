with builtins;
  {pkgs, ...}: let
    l = concatStringsSep " " [
      "${pkgs.exa}/bin/exa"
      "--icons"
      "--git"
      "--header"
      "--all"
    ];
  in {
    programs.exa.enable = true;
    home.shellAliases = {
      inherit l;
      ll = "${l} --long";
      lt = "${l} --tree";
    };
  }
