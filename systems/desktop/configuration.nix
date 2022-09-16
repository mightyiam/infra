{
  config,
  pkgs,
  ...
}: {
  imports = [../../hardware-configuration.nix];
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl.enable = true;
  hardware.bluetooth.enable = true;
  boot.loader.timeout = 4;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.mirroredBoots = [
    {
      devices = ["nodev"];
      path = "/boot0";
    }
    {
      devices = ["nodev"];
      path = "/boot1";
    }
  ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.zfs.forceImportAll = false;
  boot.zfs.forceImportRoot = false;
  boot.kernelParams = ["nohibernate"];
  security.rtkit.enable = true;
  networking.hostName = "mightyiam-desktop";
  networking.hostId = "6b5dea2a";
  networking.networkmanager.enable = true;
  nix.settings.auto-optimise-store = true;
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.mightyiam.isNormalUser = true;
  users.users.mightyiam.extraGroups = ["wheel" "audio" "networkmanager" "docker"];
  users.users.mightyiam.hashedPassword = import ./hashed-password.nix;
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.defaultEditor = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.autoScrub.interval = "monthly";
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.printing.enable = true;
  ## Things I'd like configured by home-manager:
  #
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-gtk
  ];
  ###
  security.pam.services.swaylock = {};
  fonts.enableDefaultFonts = false;
  fonts.fontconfig.defaultFonts.serif = [];
  fonts.fontconfig.defaultFonts.emoji = [];
  fonts.fontconfig.defaultFonts.sansSerif = [];
  fonts.fontconfig.defaultFonts.monospace = [];
  nix.settings.trusted-users = ["root" "mightyiam"];
  system.stateVersion = "21.11";
}
