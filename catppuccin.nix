{ self, lib, ... }:
let
  flavor = "mocha";
in
{
  flake = {
    nixosModules.common.imports = [
      {
        imports = [ self.inputs.catppuccin.nixosModules.catppuccin ];
        catppuccin = {
          enable = true;
          inherit flavor;
        };
      }
    ];
    homeManagerModules.common.imports = [
      {
        imports = [ self.inputs.catppuccin.homeManagerModules.catppuccin ];
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
            pointerCursor.enable = true;
          };

          # IFD
          programs.swaylock.catppuccin.enable = false;
          services.mako.catppuccin.enable = false;

          programs.chromium.extensions = [ { id = "bkkmolkhemgaeaeggcmfbghljjjoofoh"; } ];
          gtk.gtk2.extraConfig = ''
            gtk-theme-name="Adwaita-dark"
          '';
          gtk.gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
          gtk.gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
        };
      }
    ];
  };

  nixvimModules.default.colorschemes.catppuccin = {
    enable = true;
    settings.flavour = flavor;
  };
}
