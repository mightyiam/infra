{ self, ... }:
let
  flavor = "mocha";
in
{
  flake = {
    nixosModules.common = {
      imports = [ self.inputs.catppuccin.nixosModules.catppuccin ];
      catppuccin = {
        enable = true;
        inherit flavor;
      };
    };
    homeManagerModules.common = {
      imports = [ self.inputs.catppuccin.homeManagerModules.catppuccin ];
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
  };

  nixvimModules.default.colorschemes.catppuccin = {
    enable = true;
    settings.flavour = flavor;
  };
}
