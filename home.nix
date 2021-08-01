{ config, pkgs, lib, options, ... }:

let
  secrets = import ./secrets.nix;
  username = "mightyiam";
  userEmail = "mightyiampresence@gmail.com";
  homeDirectory = /home/mightyiam;
  configDir = ".config";
  configHome = builtins.toString homeDirectory + "/${configDir}";
  sessionVariables = {
    BAT_THEME = "base16";
  };
  sway-outputs = { left = "DP-2"; right = "DP-1"; };
  bar = let id = "bottom"; in {
    inherit id;
    swaybar = {
      fonts = { names = ["monospace"]; style = "Bold"; size = 12.0; };
      statusCommand = "i3status-rs ${configHome}/i3status-rust/config-${id}.toml";
      trayOutput = sway-outputs.left;
    };
    i3status-rust = import ./i3status-rust.nix id;
  };
  zshBin = "${pkgs.zsh}/bin/zsh";
in {
  imports = [
    (import ./xdg)
  ];

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
  fonts = {
    fontconfig.enable = true;
  };

  programs = {
    exa = { enable = true; };
    tmux = import ./tmux.nix zshBin;
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        forceWayland = true;
      };
    };
    i3status-rust = { enable = true; bars = {} // bar.i3status-rust; };
    command-not-found.enable = true;
    info.enable = true;
    gh = {
      enable = true;
      gitProtocol = "ssh";
    };
    vscode = import ./vscode/main.nix pkgs;
    ssh = import ./ssh.nix homeDirectory;
    bat.enable = true;
    zsh = import ./zsh/main.nix {
      inherit sessionVariables;
      inherit pkgs;
    };
    bash = {
      enable = true;
      enableVteIntegration = true;
      inherit sessionVariables;
    };
    starship = import ./starship/main.nix;
    chromium = {
      enable = true;
      extensions = [
        { id = "hdokiejnpimakedhajhdlcegeplioahd"; }
      ];
    };
    git = import ./git/main.nix {
      inherit username;
      inherit userEmail;
    };
    home-manager = {
      enable = true;
      path = builtins.toString homeDirectory + "/src/home-manager";
    };
    neovim = import ./nvim/main.nix pkgs.vimPlugins;
    alacritty = import ./alacritty.nix zshBin;
    mako = import ./mako.nix sway-outputs.left;
  };

  services = {
    lorri.enable = true;
  };

  wayland.windowManager.sway = import ./sway/main.nix {
    inherit lib;
    inherit sway-outputs;
    I3RS_GITHUB_TOKEN = secrets.I3RS_GITHUB_TOKEN;
    inherit bar;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "postman"
    "skypeforlinux"
    "slack"
  ];
  home = {
    packages = import ./packages.nix pkgs;

    inherit username;
    inherit homeDirectory;
    stateVersion = "21.05";

    file = {
      "${configDir}/fontconfig/fonts.conf" = {
        text = ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
          <fontconfig>
            <alias>
              <family>monospace</family>
              <prefer>
                <family>OpenDyslexicMono Nerd Font</family>
                <family>Noto Color Emoji</family>
              </prefer>
            </alias>
          </fontconfig>'';
      };
    };
  };
}

