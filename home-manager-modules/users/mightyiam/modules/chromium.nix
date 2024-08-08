{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
mkIf config.gui.enable {
  programs.chromium = {
    enable = true;
    extensions = [
      # Bitwarden
      # https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
    ];
  };
}
