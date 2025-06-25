{ config, ... }:
{
  text.readme.parts.ipfi =
    # markdown
    ''
      ## Integrated patched flake inputs

      I attempt to maintain an upstream-first approach.
      That means contributing my changes to inputs upstream.
      While collaborating with upstream on the refinement and merge of those changes
      I maintain a branch of that input with those changes cherry-picked.
      I call these branches _integrated patched flake inputs_ (IPFIs).

      See [`modules/ipfi`](modules/ipfi).

    '';

  ipfi.inputs = {
    nixpkgs.upstream = {
      url = "https://github.com/NixOS/nixpkgs.git";
      ref = "nixpkgs-unstable";
    };
    home-manager.upstream = {
      url = "https://github.com/nix-community/home-manager.git";
      ref = "master";
    };
    stylix.upstream = {
      url = "https://github.com/nix-community/stylix.git";
      ref = "master";
    };
  };

  flake.modules.nixos.pc = config.ipfi.nixosModule;

  perSystem = psArgs: {
    make-shells.default.packages = psArgs.config.ipfi.commands;
    treefmt.settings.global.excludes = [ "${config.ipfi.baseDir}/*" ];
  };
}
