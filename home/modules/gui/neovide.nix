with builtins;
  instance: {pkgs, ...}: let
    pipe = pkgs.lib.trivial.pipe;
    expand = name: value: let
      rhs =
        if isString value
        then "\"${value}\""
        else toString value;
    in "let g:neovide_${name}=${rhs}";
    last = pkgs.lib.lists.last;
    options = {
      refresh_rate = 144;
      transparency = (import ../../style.nix).windowOpacity;
      cursor_animation_length = 0.08;
      cursor_vfx_mode = "railgun";
      cursor_vfx_particle_density = 20;
    };
  in {
    home.packages = [pkgs.neovide];
    programs.neovim.extraConfig = pipe options [(mapAttrs expand) attrValues (concatStringsSep "\n")];
    home.shellAliases = {
      nv = "${pkgs.neovide}/bin/neovide";
    };
  }
