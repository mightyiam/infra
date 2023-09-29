instance: {
  pkgs,
  config,
  ...
}: let
  sink-rotate = pkgs.rustPlatform.buildRustPackage {
    pname = "sink-rotate";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "mightyiam";
      repo = "sink-rotate";
      rev = "v1.0.0";
      hash = "sha256-xqDnyKlw44HyVHw9P3fdoXs1swXr0DMNRrg4YG5WMXI=";
    };

    cargoHash = "sha256-TL9uY/vq+SG1jtvw/eeW4/SKt+TGndpWMhRKU07BB5s=";

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
