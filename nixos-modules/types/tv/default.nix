{ config, pkgs, ... }:
let
  media = import ./media.nix;
in
{
  imports = [
    ./kodi.nix
    ./transmission.nix
    (import ./media.nix).module
  ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };
  services.openssh.enable = true;
  hardware.enableAllFirmware = true;
  system.stateVersion = "21.11";
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  boot.loader.grub.splashImage = pkgs.fetchurl {
    url = "https://lh3.googleusercontent.com/pw/AM-JKLUPs72JvWu6ymLyefE9Rha6muA257zExWZqrxRLqxH-zt-Os0hrXTLMlK9wamnhUeThF77lRTZMQhq9K7GxOTSwIln0kSjTHtL__-_S7E4DWy0jP2EAdvv1LDjqONGdbawhPPBEF8J4VKyTWQHzqNhCAw=w1920-h1080-no";
    name = "splash.png";
    sha256 = "1gjid7746413afwqj24kb2fvhxls9z6xrqp1vaqk2bgmkrrws13a";
  };
  boot.loader.grub.extraConfig = ''
    set color_normal=black/black
    set color_highlight=black/magenta
  '';
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  users.users.mightyiam.extraGroups = [ media.group ];
}
