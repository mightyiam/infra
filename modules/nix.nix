{ lib, inputs, ... }:
let
  # https://github.com/NixOS/nix/issues/11358
  mkWorkaround =
    pkgs: original:
    pkgs.stdenv.mkDerivation {
      name = "nix-with-workaround";
      version = original.version;
      runtimeInputs = [ original ];
      unpackPhase = "true";
      nativeBuildInputs = [ pkgs.makeWrapper ];
      buildPhase = ''
        cp -r ${original} $out
        chmod -R +w $out
        wrapProgram $out/bin/nix \
          --set GIT_CONFIG_COUNT 1 \
          --set GIT_CONFIG_KEY_0 safe.bareRepository \
          --set GIT_CONFIG_VALUE_0 all
      '';
      meta.mainProgram = "nix";
    };

  mkNix = pkgs: pkgs.nixVersions.latest |> mkWorkaround pkgs;

  commonSettings = {
    keep-outputs = true;
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
      "recursive-nix"
    ];
    extra-system-features = [ "recursive-nix" ];
  };
in
{
  flake.modules = {
    nixos.desktop =
      {
        pkgs,
        ...
      }:
      {
        nix = {
          package = mkNix pkgs;
          nixPath = [
            "nixpkgs=${inputs.nixpkgs}"
          ];
          settings = {
            auto-optimise-store = true;
          } // commonSettings;
        };
      };

    homeManager.home =
      { pkgs, ... }:
      {
        nix = {
          package = pkgs |> mkNix |> lib.mkDefault;
          settings = commonSettings;
        };
        home.packages = with pkgs; [
          nix-fast-build
          nix-tree
          nixd
          nurl
          nvd
          statix
          nix-diff
          #nix-melt
          nix-prefetch-scripts
        ];
        programs.nh.enable = true;
      };

    nixOnDroid.base =
      { pkgs, ... }:
      {
        nix = {
          package = mkNix pkgs;

          extraOptions =
            commonSettings
            |> lib.mapAttrsToList (name: value: "${name} = ${toString value}")
            |> lib.concatLines;
        };
      };
  };
}
