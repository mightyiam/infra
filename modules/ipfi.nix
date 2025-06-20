{ config, ... }:
{
  text.readme.parts.ifdi =
    # markdown
    ''
      ## Integrated patched flake inputs pattern

      - 🪶 edit/patch the repo's inputs without leaving its clone directory
      - 🕺 no `--override-input` flag; less typing and avoids confusion in case omitted
      - 🐬 single-repo setup; less to keep track of, more self-contained
      - ⚡ provided scripts save time and produce consistency
      - 😮‍💨 some mental and operational overhead such as an occasional `git submodule update`

      I attempt to maintain an upstream-first approach.
      That means contributing my changes to inputs upstream.
      While collaborating with upstream on the refinement and merge of those changes
      I maintain a branch of that input with those changes cherry-picked.
      I call these branches _integrated patched flake inputs_ (IPFIs).

      IPFIs are stored in this very repository.
      Yes, even though they are branches from disparate repositories,
      they are stored in the repository in which they are used.
      Git doesn't mind.

      For each IPFI a git submodule exists.
      That submodule is a clone of this very same repository.
      The head of that submodule is set to the head of the IPFI branch.

      Finally, each `inputs.<name>.url` value is a path to the corresponding IPFI submodule directory.

      > [!WARNING]
      > There seems to be an issue with Nix that affects the IPFI pattern.
      > Workaround: artificially make the repository dirty.

      ### Cherry picking for an IPFI

      1. `cd patched-inputs/<input>`
      1. Get on the `patched-inputs/<input>` branch.
      1. Add a remote for a fork and cherry-pick from it.
      1. Make sure to push.

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
