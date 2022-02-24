{
  default = { family = "sans-serif"; size = 10.0; };
  monospace = { family = "monospace"; size = 10.0; };
  notifications = { family = "sans-serif"; size = 12.0; };
  bars = { family = "monospace"; style = "Bold"; size = 12.0; };
  aliases = [
    {
      family = "monospace";
      prefer = [
        "OpenDyslexicMono Nerd Font"
        "Noto Color Emoji"
      ];
    }
  ];
  packages = pkgs: with pkgs; [
    (nerdfonts.override { fonts = [ "OpenDyslexic" ]; })
    font-awesome
    noto-fonts
    noto-fonts-emoji
  ];
}

