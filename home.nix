{ config, pkgs, lib, options, nixpkgs, ... }:

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
  mod-key = "Mod4";
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
  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };
  fonts = {
    fontconfig.enable = true;
  };

  xdg = {
    enable = true;
    inherit configHome;
    #userDirs = let tmp = "${homeDirectory}/tmp"; in {
      #enable = true;
      #createDirectories = false;
      #desktop = tmp;
      #documents = tmp;
      #download = tmp;
      #music = tmp;
      #pictures = tmp;
      #publicShare = "${homeDirectory}/public";
      #templates = "${homeDirectory}/templates";
      #videos = tmp;
    #};
  };

  programs = {
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
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
    };
    ssh = import ./ssh.nix homeDirectory;
    bat.enable = true;
    zsh = import ./zsh/main.nix sessionVariables;
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
    git = {
      enable = true;
      userName = username;
      inherit userEmail;
      delta.enable = true;
    };
    home-manager.enable = true;
    neovim = import ./nvim/main.nix pkgs;
    alacritty = import ./alacritty.nix zshBin;
    mako = import ./mako.nix sway-outputs.left;
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export WLR_DRM_NO_MODIFIERS=1
      export I3RS_GITHUB_TOKEN=${secrets.I3RS_GITHUB_TOKEN}
      export MOZ_ENABLE_WAYLAND=1
    '';
    config = {
      output = {
        "${sway-outputs.right}" = {
          res = "1920x1080@144Hz";
        };
        "${sway-outputs.left}" = {
          res = "1920x1080@75Hz";
        };
      };
      fonts = { size = 10.0; };
      modifier = mod-key;
      bars = [ bar.swaybar ];
      input = {
        "type:keyboard" = {
          xkb_layout = "us,il";
          xkb_options = "grp:lalt_lshift_toggle";
        };
      };
      terminal = "alacritty";
      keybindings =
        let
          step = 5;
          incVol = d: "exec pactl set-sink-volume @DEFAULT_SINK@ ${d}${builtins.toString step}%";
        in lib.mkOptionDefault {
          "${mod-key}+Shift+e" = "exec swaymsg exit";
          "${mod-key}+minus" = incVol "-";
          "${mod-key}+equal" = incVol "+";
        };
      startup = [
        { command = "mako"; }
      ];
    };
    extraConfig = let
      firefoxSharingIndicator = "[app_id=\"firefox\" title=\"Sharing Indicator$\"]";
    in ''
      no_focus ${firefoxSharingIndicator}
      for_window ${firefoxSharingIndicator} \
        floating enable, \
        sticky enable, \
        border none, \
        move position 1800 px 0 px
    '';
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "postman"
    "skypeforlinux"
    "slack"
    "vscode"
  ];
  home = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = ["OpenDyslexic"]; })
      cargo
      font-awesome
      gnome.gnome-terminal
      imv
      libnotify
      neofetch
      nixpkgs-fmt
      noto-fonts
      noto-fonts-emoji
      pavucontrol
      postman
      rclone
      skype
      slack
      swayidle
      swaylock
      vlc
      wl-clipboard
      xdg-utils
    ];

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

