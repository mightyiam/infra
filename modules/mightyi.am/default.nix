{
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.htnl = {
    url = "github:molybdenumsoftware/htnl";
    flake = false;
  };

  perSystem = psArgs @ {pkgs, ...}: {
    config = {
      nixpkgs.overlays = [
        (import "${inputs.htnl}/overlay.nix")
        (final: prev: {
          mightyi-am =
            prev.htnl.bundle {
              inherit (psArgs.config.mightyi-am) htmlDocuments;
            }
            |> (bundle: let
              inputCss = pkgs.writeText "input.css" ''
                @import "tailwindcss";
                @plugin "@tailwindcss/typography";
              '';
            in
              pkgs.runCommand "bundle"
              {
                nativeBuildInputs = [
                  pkgs.validator-nu
                  pkgs.tailwindcss_4
                ];
              }
              ''
                mkdir $out
                cp -r ${bundle}/* $out
                html_files=$(find -L $out -not -path $out'/nix/store/*' -type f)
                vnu --Werror $html_files
                tailwindcss -i ${inputCss} --cwd $out -o $out/style.css
              '');
        })
      ];

      checks = {inherit (pkgs) mightyi-am;};
    };

    options.mightyi-am = {
      htmlDocuments = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.attrs;
      };
    };
  };
}
