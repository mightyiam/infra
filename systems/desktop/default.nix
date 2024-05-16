{
  security.rtkit.enable = true;
  networking.networkmanager.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.printing.enable = true;
  security.pam.services.swaylock = {};
  fonts.enableDefaultPackages = false;
  fonts.fontconfig.defaultFonts.serif = [];
  fonts.fontconfig.defaultFonts.emoji = [];
  fonts.fontconfig.defaultFonts.sansSerif = [];
  fonts.fontconfig.defaultFonts.monospace = [];
  nix.settings.trusted-users = ["root" "mightyiam"];
  hardware.flipperzero.enable = true;
  system.stateVersion = "21.11";
}
