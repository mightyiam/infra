{
  lib,
  inputs,
  ...
}:
let
  flavor = "mocha";
in
{
  flake.modules = {
    nixos.desktop = {
      imports = [ inputs.catppuccin.nixosModules.catppuccin ];
      catppuccin = {
        enable = true;
        inherit flavor;
      };
    };
    homeManager.base = {
      imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
      options = {
        style = {
          windowOpacity = lib.mkOption {
            type = lib.types.numbers.between 0 1.0;
            default = 1.0;
          };

          bellDuration = lib.mkOption {
            type = lib.types.numbers.between 0 1000;
            default = 200.0;
          };
        };
      };
      config = {
        catppuccin = {
          enable = true;
          inherit flavor;
          cursors.enable = true;

          # IFD
          swaylock.enable = false;
          mako.enable = false;

        };

        xdg.configFile."qutebrowser/catppuccin" = {
          recursive = true;
          source = inputs.catppuccin-qutebrowser;
        };

        qt = {
          style.name = "kvantum";
          platformTheme.name = "kvantum";
        };

        programs = {
          qutebrowser.extraConfig = ''
            import catppuccin
            catppuccin.setup(
              c,
              '${flavor}',
              # (default is False) enable the plain look for the menu rows
              False
            )
          '';
          qutebrowser.settings = {
            colors.webpage.preferred_color_scheme = "dark";
          };

          chromium.extensions = [ { id = "bkkmolkhemgaeaeggcmfbghljjjoofoh"; } ];
        };

        gtk.gtk2.extraConfig = ''
          gtk-theme-name="Adwaita-dark"
        '';
        gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
        gtk.gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
      };
    };
    nixvim.astrea.colorschemes.catppuccin = {
      enable = true;
      settings.flavour = flavor;
    };
  };
}
