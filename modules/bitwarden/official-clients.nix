{
  homeManager.modules = {
    base = {pkgs, ...}: {
      home.packages = [pkgs.bitwarden-cli];
    };

    gui = {
      # https://github.com/NixOS/nixpkgs/issues/526914
      # home.packages = [ pkgs.bitwarden-desktop ];
    };
  };
}
