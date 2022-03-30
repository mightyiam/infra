{
  config,
  pkgs,
  ...
}: {
  imports = [../../hardware-configuration.nix];
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    opengl.enable = true;
  };
  boot = {
    loader = {
      timeout = 4;
      grub = {
        enable = true;
        efiSupport = true;
        mirroredBoots = [
          {
            devices = ["nodev"];
            path = "/boot0";
          }
          {
            devices = ["nodev"];
            path = "/boot1";
          }
        ];
      };
      efi.canTouchEfiVariables = true;
    };
    zfs = {
      forceImportAll = false;
      forceImportRoot = false;
    };
    kernelParams = ["nohibernate"];
  };
  security.rtkit.enable = true;
  networking = {
    hostName = "mightyiam-desktop";
    hostId = "6b5dea2a";
    networkmanager.enable = true;
  };
  nix.settings.auto-optimise-store = true;
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users.mightyiam = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "networkmanager" "docker"];
      hashedPassword = import ./hashed-password.nix;
    };
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };
  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };
    zfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };
  ## Things I'd like configured by home-manager:
  #
  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  ###
  security.pam.services.swaylock = {};
  system.stateVersion = "21.11";
}
