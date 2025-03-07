{ lib, ... }:
{
  flake.modules.homeManager.home =
    { config, ... }:
    lib.mkIf config.gui.enable {
      programs.chromium = {
        enable = true;
        extensions = [
          # Bitwarden
          # https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb
          { id = "nngceckbapebfimnlniiiahkandclblb"; }
        ];
      };
    };
}
