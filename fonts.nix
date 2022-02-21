let
  default = { family = "sans-serif"; size = 10.0; };
  monospace = { family = "monospace"; size = 10.0; };
  notifications = { family = "sans-serif"; size = 12.0; };
  bars = { family = "monospace"; style = "Bold"; size = 12.0; };
in {
  applyToSwaybar = with bars; swayBar: swayBar // {
    fonts = {
      names = [ family ];
      inherit style;
      inherit size;
    };
  };

  definitions = {
    inherit default;
    inherit monospace;
    inherit notifications;
  };

  module = { pkgs, config, ...}: {
    fonts = {
      fontconfig.enable = true;
    };

    home.packages = with pkgs; [
      (nerdfonts.override { fonts = ["OpenDyslexic"]; })
      font-awesome
      noto-fonts
      noto-fonts-emoji
    ];

    home.file."${config.xdg.configHome}/fontconfig/fonts.conf" = {
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

    wayland.windowManager.sway.config.fonts.size = default.size;
    programs.mako.font = with notifications; "${family} ${toString size}";
    programs.alacritty.settings.font.size = monospace.size;
    programs.starship.settings = {
      ## https://starship.rs/presets/#nerd-font-symbols
      aws.symbol = " ";
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

    gtk.font = {
      name = default.family;
      size = default.size;
    };
  };
}

