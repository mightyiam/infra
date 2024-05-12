{
  programs.chromium = {
    enable = true;
    extensions = [
      # Bitwarden
      # https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb
      {id = "nngceckbapebfimnlniiiahkandclblb";}
      {id = (import ../../gruvbox.nix).chromium;}
    ];
  };
}
