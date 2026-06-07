{
  homeManager.modules = {
    base = {pkgs, ...}: {
      home.packages = [pkgs.bitwarden-cli];
    };

    gui = {pkgs, ...}: {
      home.packages = [pkgs.bitwarden-desktop];
    };
  };
}
