{
  pkgs,
  lib,
  ...
}: {
  boot.initrd.preDeviceCommands = let
    message = ''
      If found, please contact:
      Shahar "Dawn" Or
      +66613657506
      mightyiampresence@gmail.com
      @mightyiam:matrix.org
    '';
  in ''
    echo -e ${lib.escapeShellArg message} | ${pkgs.neo-cowsay}/bin/cowsay --bold --aurora -f dragon
  '';
  security.sudo-rs.enable = true;
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
  boot.tmp.cleanOnBoot = true;
  boot.zfs.forceImportRoot = false;
  nix.settings.auto-optimise-store = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.mightyiam.isNormalUser = true;
  users.users.mightyiam.initialPassword = "";
  users.users.mightyiam.extraGroups = [
    "wheel"
    "audio"
    "networkmanager"
    "docker"
    "input"
  ];
  users.users.mightyiam.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMnrJuB68Cjq5iiZpX51k0CniZbm1lKqoa1tA87iR0GFGi1bOzxRswXVw79pakWob+/oILKBAtBbcf/oYk13lORORex6s1Xd1yIiDUNJpO4N07dYvfa8fNqcxDcB2tP35NtZEQvISw6+zut5Cm5cuNkTqhozTDWCZ87aPrLvScU9H8TkfHnB6TAdtwwiYW0OIScpgEf3qTv9lZlX58yYsfPlgY0nh9IrdHLRaWYjDohrbUikaQI9g9DKDjqbe2+7HQJ/tirlOlZIHsf6tf9ZsjLlYXaUwAwGtq+vhOvPf1dElkC3uXMOJEUxH6sgkGKp2pdBJ3Mnj1gVbFxq3Dm1OtX9dEp6IP/uCBgg+eo0H72GQgkfvOKoXKWobTEjgve2a0bq+P+8xYXRYXZxhzWfm3lk6qbkCPu4NFL+FeGppd1vQSpj6vlKXDEPptY5/9vHhkiMGNY5eWkLAwebtgqBV6zlLGOn8LF12KuLe9AIx12q6K1u7X2tjLEPiqyCrJYaU= mightyiam@mightyiam-desktop"
  ];
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.defaultEditor = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.autoScrub.interval = "monthly";
  environment.systemPackages = [pkgs.nvd];
}
