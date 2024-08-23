{self, ...}: {
  system.autoUpgrade = {
    enable = true;
    flake = self.meta.uri;
    operation = "boot";
  };
}
