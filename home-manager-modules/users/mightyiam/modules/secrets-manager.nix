{ config, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      email = "mightyiampresence@gmail.com";
      pinentry = config.pinentry;
    };
  };
}
