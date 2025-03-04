{ self, ... }:
{
  system.autoUpgrade = {
    enable = true;
    flake = self.meta.uri;
    operation = "boot";
  };
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 5";
    };
  };
}
