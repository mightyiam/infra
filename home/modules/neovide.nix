{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    attrValues
    concatStringsSep
    isString
    mapAttrs
    mkIf
    ;

  pipe = pkgs.lib.trivial.pipe;
  expand = name: value: let
    rhs =
      if isString value
      then "\"${value}\""
      else toString value;
  in "let g:neovide_${name}=${rhs}";
  last = pkgs.lib.lists.last;
  options = {
    transparency = (import ../style.nix).windowOpacity;
    cursor_animation_length = 0.08;
    cursor_vfx_mode = "railgun";
    cursor_vfx_particle_density = 20;
  };
in
  mkIf config.gui.enable {
    home.packages = [pkgs.neovide];
    programs.neovim.extraConfig = pipe options [(mapAttrs expand) attrValues (concatStringsSep "\n")];
  }
