{lib, ...}: {
  nixos.modules.pc = {
    services.geoclue2 = {
      enable = true;

      # https://github.com/NixOS/nixpkgs/issues/68489#issuecomment-1484030107
      enableDemoAgent = lib.mkDefault true;
    };
  };
}
