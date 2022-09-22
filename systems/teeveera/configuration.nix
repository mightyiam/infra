{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware-configuration.nix
    ./storage.nix
    ./boot.nix
    ./zfs.nix
    ./networking.nix
    ./users.nix
    ./kodi.nix
    ./transmission.nix
  ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };
  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  hardware.enableAllFirmware = true;
  system.stateVersion = "21.11";
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
}
