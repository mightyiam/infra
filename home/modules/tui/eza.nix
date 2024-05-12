with builtins;
  {pkgs, ...}: let
    l = concatStringsSep " " [
      "${pkgs.eza}/bin/eza"
      "--group"
      "--icons"
      "--git"
      "--header"
      "--all"
    ];
  in {
    programs.eza.enable = true;
    home.shellAliases = {
      inherit l;
      ll = "${l} --long";
      lt = "${l} --tree";
    };
  }
