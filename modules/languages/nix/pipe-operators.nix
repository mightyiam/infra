{
  nix.settings.experimental-features = [
    "pipe-operators"
  ];

  nixpkgs.overlays = [
    (
      final: prev:
      let
        # https://github.com/nix-community/tree-sitter-nix/pull/159
        src = prev.fetchFromGitHub {
          owner = "molybdenumsoftware";
          repo = "difftastic";
          rev = "53bdd5e0c96469544587dce673c9b84d1d81eba6";
          hash = "sha256-4ylHoa7k3TJV2cBmAX261cHQibX9sYW/msQUTQCsHew=";
        };
      in
      {
        # The following override doesn't work
        # difftastic = super.difftastic.overrideAttrs (old: {
        #   version = "0.68.0";
        #   inherit src;
        #   cargoHash = "";
        # });

        difftastic = final.rustPlatform.buildRustPackage (finalAttrs: {
          pname = "difftastic";
          version = "0.68.0";

          inherit src;

          cargoHash = "sha256-ojYR9j45Wg+D3s6CqjWzS4OB09OyJZpj8gdMMT/d/EQ=";

          env = final.lib.optionalAttrs final.stdenv.hostPlatform.isStatic {
            RUSTFLAGS = "-C relocation-model=static";
          };

          # skip flaky tests
          checkFlags = [ "--skip=options::tests::test_detect_display_width" ];

          nativeInstallCheckInputs = [ final.versionCheckHook ];
          versionCheckProgram = "${placeholder "out"}/bin/difft";
          versionCheckProgramArg = "--version";
          doInstallCheck = true;

          meta = {
            mainProgram = "difft";
          };
        });
      }
    )
  ];
}
