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
    tmux = {
      enable = true;
      keyMode = "vi";
      shortcut = "a";
      customPaneNavigationAndResize = true;
      extraConfig = ''
        set-option -ga terminal-overrides ",alacritty:Tc"
        set-option -g status-right "tmux"
        set-option -g status-style "bg=black,fg=gray"

        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
      shell = zshBin;
    };
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
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      defaultKeymap = "viins";
      history.ignorePatterns = ["rm *"];
      inherit sessionVariables;
      initExtraFirst = builtins.readFile ./zsh-tmux-init.sh;
      initExtra = ''
        bindkey '^P' up-history
        bindkey '^N' down-history
        bindkey '^w' backward-kill-word
        bindkey '^r' history-incremental-search-backward
      '';
    };
    bash = {
      enable = true;
      enableVteIntegration = true;
      inherit sessionVariables;
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = let
        pink = "#FFC0CB";
        vertical = "[║](${pink})";
        sep = "sep";
      in {
        add_newline = false;
        ## https://starship.rs/config/#prompt
        format = builtins.concatStringsSep "" [
          "$\{custom.${sep}\}"
          vertical
          "$username"
          "$hostname"
          "$kubernetes"
          "$vcsh"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_status"
          "$hg_branch"
          "$docker_context"
          "$package"
          "$cmake"
          "$dart"
          "$deno"
          "$dotnet"
          "$elixir"
          "$elm"
          "$erlang"
          "$golang"
          "$helm"
          "$java"
          "$julia"
          "$kotlin"
          "$nim"
          "$nodejs"
          "$ocaml"
          "$perl"
          "$php"
          "$purescript"
          "$python"
          "$red"
          "$ruby"
          "$rust"
          "$scala"
          "$swift"
          "$terraform"
          "$vlang"
          "$vagrant"
          "$zig"
          "$nix_shell"
          "$conda"
          "$memory_usage"
          "$aws"
          "$gcloud"
          "$openstack"
          "$env_var"
          "$crystal"
          "$cmd_duration"
          "$lua"
          "$jobs"
          "$battery"
          "\n"
          vertical
          "$directory"
          "\n"
          vertical
          "$status"
          "[ $shell](bold ${pink})"
          "$shlvl"
          "$character"
        ];
        custom."${sep}" = {
          command = "printf '═%.0s' {2..$COLUMNS}";
          when = "true";
          format = "[╔($output)\n]($style)";
          style = "bold ${pink}";
        };
        directory = {
          truncation_length = 0;
          format = "[ : $path]($style)[$read_only]($read_only_style) ";
          home_symbol = " ";
        };
        shell.disabled = false;
        shlvl = {
          disabled = false;
          threshold = 3;
          style = "bold red";
          symbol = "";
        };
        status = {
          disabled = false;
          symbol = " ";
        };
        username = { show_always = true; format = "[  $user]($style) "; };
        git_branch = { format = "[$symbol$branch]($style) ";};

        ## https://starship.rs/presets/#nerd-font-symbols
        aws.symbol = "  ";
        conda.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " ";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        git_branch.symbol = " ";
        golang.symbol = " ";
        hg_branch.symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        memory_usage.symbol = " ";
        nim.symbol = " ";
        nix_shell.symbol = " ";
        package.symbol = " ";
        perl.symbol = " ";
        php.symbol = " ";
        python.symbol = " ";
        ruby.symbol = " ";
        rust.symbol = " ";
        scala.symbol = " ";
        swift.symbol = "ﯣ ";
      };
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
        vnoremap < <gv
        vnoremap > >gv
      '';
    };
    alacritty = {
      enable = true;
      settings = {
        shell = {
          program = zshBin;
          args = ["--login"];
        };
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
    mako = {
      enable = true;
      anchor = "top-right";
      defaultTimeout = 3000;
      ignoreTimeout = true;
      font = "monospace 12";
      output = sway-outputs.left;
    };
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

