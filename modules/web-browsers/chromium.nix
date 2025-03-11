{
  flake.modules.homeManager.gui.programs.chromium = {
    enable = true;
    extensions = [
      # Bitwarden
      # https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
    ];
  };
}
