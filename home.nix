{ config, pkgs, lib, options, nixpkgs, ... }:

let
  username = "mightyiam";
  userEmail = "mightyiampresence@gmail.com";
  homeDirectory = /home/mightyiam;
  configDir = ".config";
  configHome = builtins.toString homeDirectory + "/${configDir}";
  sessionVariables = { };
  mod-key = "Mod4";
  bar = let id = "bottom"; in {
    inherit id;
    swaybar = {
      fonts = { names = ["monospace"]; style = "Bold"; size = 12.0; };
      statusCommand = "i3status-rs ${configHome}/i3status-rust/config-${id}.toml";
      trayOutput = "DP-2";
    };
    i3status-rust = import ./i3status-rust.nix id;
  };
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
    firefox = {
      enable = true;
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
    ssh = {
      enable = true;
      compression = true;
      hashKnownHosts = false;
      extraConfig = ''
          IdentitiesOnly no
          PubkeyAuthentication no
      '';
      matchBlocks = {
        "github.com" = {
          extraOptions = {
            PubkeyAuthentication = "yes";
          };
          #identityFile = "/home/mightyiam/.ssh/id_github.com";
          #identityFile = "${"/home/mightyiam"}/.ssh/id_github.com";
          identityFile = builtins.toString homeDirectory + "/.ssh/id_github.com";
        };
      };
    };
    bat.enable = true;
    bash = {
      enable = true;
      enableVteIntegration = true;
      sessionVariables = sessionVariables;
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
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
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-easymotion
        editorconfig-vim
      ];
      extraConfig = ''
        set ignorecase
        let mapleader = ","
      '';
    };
    alacritty = {
      enable = true;
      settings = {
        background_opacity = 0.8;
        decorations = "none";
        dynamic_title = true;
        font = {
          size = 10.0;
        };
        bell = {
          color = "#000000";
          duration = 200.0;
        };
        live_config_reload = true;
      };
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export WLR_DRM_NO_MODIFIERS=1
    '';
    config = {
      output = {
        DP-1 = {
          res = "1920x1080@144Hz";
        } ;
        DP-2 = {
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
      keybindings = lib.mkOptionDefault {
        "${mod-key}+Shift+e" = "exec swaymsg exit";
      };
      startup = [
        { command = "skypeforlinux"; }
        { command = "slack"; }
      ];
    };
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
      mako
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
      tmux
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

