{
  config,
  pkgs,
  ...
}: {
  security.rtkit.enable = true;
  networking.networkmanager.enable = true;
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
