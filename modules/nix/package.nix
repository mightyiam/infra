{ lib, ... }:
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
in
{
  flake.modules = {
    nixos.pc =
      { pkgs, ... }:
      {
        nix.package = mkNix pkgs;
      };

    homeManager.base =
      { pkgs, ... }:
      {
        nix.package = pkgs |> mkNix |> lib.mkDefault;
      };

    nixOnDroid.base =
      { pkgs, ... }:
      {
        nix.package = mkNix pkgs;
      };
  };
}
