{pkgs, ...}: let
  modules = [
    "bluetooth.nix"
    "boot-message.nix"
    "editor.nix"
    "firmware.nix"
    "flakes.nix"
    "flipper-zero.nix"
    "fonts.nix"
    "grub.nix"
    "home-related-hacks.nix"
    "home.nix"
    "networking.nix"
    "nix.nix"
    "graphics.nix"
    "pipewire.nix"
    "printing.nix"
    "service-discovery.nix"
    "shell.nix"
    "steam.nix"
    "sudo.nix"
    "tmp.nix"
    "user.nix"
    "virtualbox.nix"
    "zfs.nix"
    "dconf.nix"
    "catppuccin.nix"
  ];
in {
  imports = map (m: "${../modules}/${m}") modules;

  users.users.mightyiam.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMnrJuB68Cjq5iiZpX51k0CniZbm1lKqoa1tA87iR0GFGi1bOzxRswXVw79pakWob+/oILKBAtBbcf/oYk13lORORex6s1Xd1yIiDUNJpO4N07dYvfa8fNqcxDcB2tP35NtZEQvISw6+zut5Cm5cuNkTqhozTDWCZ87aPrLvScU9H8TkfHnB6TAdtwwiYW0OIScpgEf3qTv9lZlX58yYsfPlgY0nh9IrdHLRaWYjDohrbUikaQI9g9DKDjqbe2+7HQJ/tirlOlZIHsf6tf9ZsjLlYXaUwAwGtq+vhOvPf1dElkC3uXMOJEUxH6sgkGKp2pdBJ3Mnj1gVbFxq3Dm1OtX9dEp6IP/uCBgg+eo0H72GQgkfvOKoXKWobTEjgve2a0bq+P+8xYXRYXZxhzWfm3lk6qbkCPu4NFL+FeGppd1vQSpj6vlKXDEPptY5/9vHhkiMGNY5eWkLAwebtgqBV6zlLGOn8LF12KuLe9AIx12q6K1u7X2tjLEPiqyCrJYaU= mightyiam@mightyiam-desktop"
  ];
  environment.systemPackages = [pkgs.nvd];
}
