{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
        extensions = [
          # Bitwarden
          # https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb
          { id = "nngceckbapebfimnlniiiahkandclblb"; }
        ];
      };
    };
}
