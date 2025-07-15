{
  config,
  inputs,
  lib,
  rootPath,
  ...
}:
{
  text.readme.parts.patching-of-inputs =
    # markdown
    ''
      ## Patching of inputs

      I attempt to maintain an upstream-first approach.
      While collaborating with upstream on the refinement and merge of those changes
      I maintain a branch of that input with those changes cherry-picked.

      This repository is the origin of the
      [_input branches_](https://github.com/mightyiam/input-branches)
      project
      which is used here.

    '';

  imports = [ inputs.input-branches.flakeModules.default ];

  input-branches.inputs = {
    nixpkgs = {
      upstream = {
        url = "https://github.com/NixOS/nixpkgs.git";
        ref = "nixpkgs-unstable";
      };
      shallow = true;
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

  flake.modules.nixos.pc = {
    imports = [ inputs.input-branches.modules.nixos.default ];
    nixpkgs.flake.source = lib.mkForce (rootPath + "/inputs/nixpkgs");
  };

  perSystem = psArgs: {
    make-shells.default.packages = psArgs.config.input-branches.commands.all;
    treefmt.settings.global.excludes = [ "${config.input-branches.baseDir}/*" ];
  };
}
