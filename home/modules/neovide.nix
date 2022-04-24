with builtins;
  {pkgs, ...}: let
    instance = import ../instance.nix;
    pipe = pkgs.lib.trivial.pipe;
    expand = name: value: let
      rhs =
        if isString value
        then "\"${value}\""
        else toString value;
    in "let g:neovide_${name}=${rhs}";
    last = pkgs.lib.lists.last;
    options = {
      refresh_rate = pipe instance.outputs [attrValues (map (getAttr "refreshRate")) (sort lessThan) last];
      transparency = 1.0;
      cursor_animation_length = 0.08;
      cursor_vfx_mode = "railgun";
      cursor_vfx_particle_density = 20;
    };
  in {
    home.packages = [pkgs.neovide];
    programs.neovim.extraConfig = pipe options [(mapAttrs expand) attrValues (concatStringsSep "\n")];
    home.shellAliases = {
      nv = concatStringsSep " " [
        "${pkgs.neovide}/bin/neovide"
        "--neovim-bin ${pkgs.neovim}/bin/nvim"
        "--multigrid"
      ];
    };
  }
