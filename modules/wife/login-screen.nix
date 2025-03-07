{
  flake.modules.nixos.wife.services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
}
