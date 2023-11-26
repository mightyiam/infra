{
  config,
  pkgs,
  lib,
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
  xdg.portal.wlr.enable = true;
  xdg.portal.configPackages = [
    (pkgs.xdg-desktop-portal-wlr.overrideAttrs (attrs: {
      postInstall = ''
        wrapProgram $out/libexec/xdg-desktop-portal-wlr --prefix PATH ":" ${lib.makeBinPath [pkgs.grim pkgs.slurp pkgs.bash]}
      '';
    }))
    pkgs.xdg-desktop-portal-gtk
  ];
  ###
  security.pam.services.swaylock = {};
  fonts.enableDefaultPackages = false;
  fonts.fontconfig.defaultFonts.serif = [];
  fonts.fontconfig.defaultFonts.emoji = [];
  fonts.fontconfig.defaultFonts.sansSerif = [];
  fonts.fontconfig.defaultFonts.monospace = [];
  nix.settings.trusted-users = ["root" "mightyiam"];
  system.stateVersion = "21.11";
}
