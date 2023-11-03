instance: {
  pkgs,
  config,
  ...
}: let
  sink-rotate = pkgs.rustPlatform.buildRustPackage {
    pname = "sink-rotate";
    version = "1.0.2";

    src = pkgs.fetchFromGitHub {
      owner = "mightyiam";
      repo = "sink-rotate";
      rev = "v1.0.2";
      hash = "sha256-nNOhQ0l3skF3lbDfE73biT0naUicJemdDsDw464PpLc=";
    };

    cargoHash = "sha256-5BW8tfA1cXEdU8KQnA+xkKO0XXFfqwl9ytVighgf7ac=";

    buildInputs = with pkgs; [pipewire wireplumber];

    meta = with pkgs.lib; {
      description = ''Command that sets "next" PipeWire audio sink as default'';
      homepage = "https://github.com/mightyiam/sink-rotate";
      license = licenses.mit;
      maintainers = [];
    };
  };

  keyboard = import ../../keyboard.nix;
in {
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.volume.sinkRotate}" = "exec ${sink-rotate}/bin/sink-rotate";
}
