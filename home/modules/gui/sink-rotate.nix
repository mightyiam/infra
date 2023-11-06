instance: {
  pkgs,
  config,
  ...
}: let
  sink-rotate = pkgs.rustPlatform.buildRustPackage {
    pname = "sink-rotate";
    version = "1.0.4";

    src = pkgs.fetchFromGitHub {
      owner = "mightyiam";
      repo = "sink-rotate";
      rev = "v1.0.4";
      hash = "sha256-q20uUr+7yLJlZc5YgEkY125YrZ2cuJrPv5IgWXaYRlo=";
    };

    cargoHash = "sha256-MPeyPTkxpi6iw/BT5m4S7jVBD0c2zG2rsv+UZWQxpUU=";

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
