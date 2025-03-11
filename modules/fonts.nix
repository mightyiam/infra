{ lib, ... }:
{
  flake.modules = {
    nixos.desktop.fonts = {
      enableDefaultPackages = true;
      fontconfig.defaultFonts = {
        serif = [ ];
        emoji = [ ];
        sansSerif = [ ];
        monospace = [ ];
      };
    };

    homeManager.gui =
      {
        config,
        pkgs,
        ...
      }:
      let
        expandPrefer = family: "<family>${family}</family>";
        expandAlias =
          { family, prefer }:
          ''
            <alias>
              <family>${family}</family>
              <prefer>
                ${map expandPrefer prefer |> lib.concatStringsSep "\n    "}
              </prefer>
            </alias>
          '';
        fontsConf =
          { aliases }:
          lib.concatStringsSep "\n" [
            ''
              <?xml version="1.0"?>
              <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
              <fontconfig>''
            (map expandAlias aliases |> lib.concatStringsSep "")
            ''</fontconfig>''
          ];
      in
      {
        options.fonts = {
          default = {
            family = lib.mkOption {
              type = lib.types.str;
              default = "sans-serif";
            };

            size = lib.mkOption {
              type = lib.types.float;
              default = 10.0;
            };
          };

          monospace = {
            family = lib.mkOption {
              type = lib.types.str;
              default = "monospace";
            };

            size = lib.mkOption {
              type = lib.types.float;
              default = 10.0;
            };
          };

          aliases = lib.mkOption {
            type = lib.types.listOf (
              lib.types.submodule {
                options.family = lib.mkOption { type = lib.types.str; };

                options.prefer = lib.mkOption { type = lib.types.listOf lib.types.str; };
              }
            );

            default = [
              {
                family = "monospace";
                prefer = [
                  "OpenDyslexicM Nerd Font"
                  "Noto Color Emoji"
                ];
              }
              {
                family = "sans-serif";
                prefer = [ "OpenDyslexic" ];
              }
              {
                family = "serif";
                prefer = [ "OpenDyslexic" ];
              }
            ];
          };
        };

        config = {
          fonts.fontconfig.enable = true;
          home = {
            file."${config.xdg.configHome}/fontconfig/fonts.conf" = {
              text = fontsConf { inherit (config.fonts) aliases; };
            };
            packages = with pkgs; [
              open-dyslexic
              nerd-fonts.open-dyslexic
              font-awesome
              noto-fonts
              noto-fonts-emoji

              gucharmap
            ];
          };
          gtk.font = {
            name = config.fonts.default.family;
            size = config.fonts.default.size;
          };
        };
      };

    nixOnDroid.base =
      { pkgs, ... }:
      {
        terminal.font = "${pkgs.nerd-fonts.open-dyslexic}/share/fonts/opentype/NerdFonts/OpenDyslexic/OpenDyslexicMNerdFontMono-Regular.otf";
      };
  };
}
