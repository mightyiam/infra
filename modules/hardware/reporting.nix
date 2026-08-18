{
  nixos.modules.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.usbtree];
  };
}
