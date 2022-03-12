{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ./boot.nix
    ./zfs.nix
    ./networking.nix
    ./users.nix
    ./kodi.nix
  ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };
  services.openssh.enable = true;
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "21.11";
  nix.settings.auto-optimise-store = true;
}
