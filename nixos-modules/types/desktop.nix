{pkgs, ...}: let
in {
  imports = [
    ../modules/bluetooth.nix
    ../modules/boot-message.nix
    ../modules/editor.nix
    ../modules/firmware.nix
    ../modules/flakes.nix
    ../modules/flipper-zero.nix
    ../modules/fonts.nix
    ../modules/grub.nix
    ../modules/home-related-hacks.nix
    ../modules/home.nix
    ../modules/networking.nix
    ../modules/nix.nix
    ../modules/graphics.nix
    ../modules/pipewire.nix
    ../modules/printing.nix
    ../modules/service-discovery.nix
    ../modules/shell.nix
    ../modules/steam.nix
    ../modules/sudo.nix
    ../modules/tmp.nix
    ../modules/user.nix
    ../modules/virtualbox.nix
    ../modules/zfs.nix
    ../modules/dconf.nix
    ../modules/catppuccin.nix
  ];

  users.users.mightyiam.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMnrJuB68Cjq5iiZpX51k0CniZbm1lKqoa1tA87iR0GFGi1bOzxRswXVw79pakWob+/oILKBAtBbcf/oYk13lORORex6s1Xd1yIiDUNJpO4N07dYvfa8fNqcxDcB2tP35NtZEQvISw6+zut5Cm5cuNkTqhozTDWCZ87aPrLvScU9H8TkfHnB6TAdtwwiYW0OIScpgEf3qTv9lZlX58yYsfPlgY0nh9IrdHLRaWYjDohrbUikaQI9g9DKDjqbe2+7HQJ/tirlOlZIHsf6tf9ZsjLlYXaUwAwGtq+vhOvPf1dElkC3uXMOJEUxH6sgkGKp2pdBJ3Mnj1gVbFxq3Dm1OtX9dEp6IP/uCBgg+eo0H72GQgkfvOKoXKWobTEjgve2a0bq+P+8xYXRYXZxhzWfm3lk6qbkCPu4NFL+FeGppd1vQSpj6vlKXDEPptY5/9vHhkiMGNY5eWkLAwebtgqBV6zlLGOn8LF12KuLe9AIx12q6K1u7X2tjLEPiqyCrJYaU= mightyiam@mightyiam-desktop"
  ];
  environment.systemPackages = [pkgs.nvd];
}
