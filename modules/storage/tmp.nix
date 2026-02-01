{
  flake.modules.nixos.workstation = {
    boot.tmp.cleanOnBoot = true;
  };
}
