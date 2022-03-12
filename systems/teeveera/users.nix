{ pkgs, ... }: {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      mightyiam = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = (import ./secrets.nix).hashedPasswds.mightyiam;
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMnrJuB68Cjq5iiZpX51k0CniZbm1lKqoa1tA87iR0GFGi1bOzxRswXVw79pakWob+/oILKBAtBbcf/oYk13lORORex6s1Xd1yIiDUNJpO4N07dYvfa8fNqcxDcB2tP35NtZEQvISw6+zut5Cm5cuNkTqhozTDWCZ87aPrLvScU9H8TkfHnB6TAdtwwiYW0OIScpgEf3qTv9lZlX58yYsfPlgY0nh9IrdHLRaWYjDohrbUikaQI9g9DKDjqbe2+7HQJ/tirlOlZIHsf6tf9ZsjLlYXaUwAwGtq+vhOvPf1dElkC3uXMOJEUxH6sgkGKp2pdBJ3Mnj1gVbFxq3Dm1OtX9dEp6IP/uCBgg+eo0H72GQgkfvOKoXKWobTEjgve2a0bq+P+8xYXRYXZxhzWfm3lk6qbkCPu4NFL+FeGppd1vQSpj6vlKXDEPptY5/9vHhkiMGNY5eWkLAwebtgqBV6zlLGOn8LF12KuLe9AIx12q6K1u7X2tjLEPiqyCrJYaU= mightyiam@mightyiam-desktop"
        ];
      };
    };
  };
}

