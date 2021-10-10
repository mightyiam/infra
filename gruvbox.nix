{ pkgs, ... }: {
  # https://chrome.google.com/webstore/detail/gruvbox-theme/ihennfdbghdiflogeancnalflhgmanop
  programs.chromium.extensions = [ { id = "ihennfdbghdiflogeancnalflhgmanop"; } ];
  programs.neovim.plugins =
    let
      omitInVSCode = import ./neovim/omitInVSCode.nix;
    in with pkgs.vimPlugins; [
      {
        plugin = gruvbox-community;
        config = omitInVSCode ''
          autocmd vimenter * ++nested colorscheme gruvbox
        '';
      }
    ];
    programs.alacritty.settings.colors = 
      let
        gruvbox_dark_bg = "#282828";
      in {
        primary = {
          # hard contrast background - "#1d2021";
          background = gruvbox_dark_bg;
          # soft contrast background - "#32302f";
          foreground = "#ebdbb2";
          bright_foreground = "#fbf1c7";
          dim_foreground = "#a89984";
        };
        cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        vi_mode_cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
        # search = {
        #   matches = {
        #     foreground = "#000000";
        #     background = "#ffffff";
        #   };
        #   focused_match = {
        #     foreground = "CellBackground";
        #     background = "CellForeground";
        #   };
        #   bar = {
        #     background = "";
        #     foreground = "";
        #   };
        # };
        # line_indicator = {
        #   foreground = "None";
        #   background = "None";
        # };
        selection = {
          text = "CellBackground";
          background = "CellForeground";
        };
        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };
        normal = {
          black = gruvbox_dark_bg;
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };
        dim = {
          black = "#32302f";
          red = "#9d0006";
          green = "#79740e";
          yellow = "#b57614";
          blue = "#076678";
          magenta = "#8f3f71";
          cyan = "#427b58";
          white = "#928374";
        };
      };
}

