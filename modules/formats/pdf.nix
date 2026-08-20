{
  nixos.modules.pc = {pkgs, ...}: {
    environment.systemPackages = [pkgs.poppler-utils];
  };
}
