{
  pkgs,
  lib,
  config,
  ...
}:
let
  userAndHome.config = {
    home.username = "mightyiam";
    home.homeDirectory = "/home/${config.home.username}";
  };
  always = {
    imports =
      let
        dir = ./.;
      in
      dir
      |> builtins.readDir
      |> lib.attrNames
      |> lib.filter (path: path != "default.nix")
      |> map (path: "${dir}/${path}");

    config.programs.home-manager.enable = true;

    config.home.sessionVariables.TZ = "\$(<~/.config/timezone)";
  };
in
{
  options = {
    gui.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    location = {
      latitude = lib.mkOption {
        type = lib.types.numbers.between (-90) 90;
        default = 18.746;
      };
      longitude = lib.mkOption {
        type = lib.types.numbers.between (-180) 180;
        default = 99.075;
      };
    };

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

    gui = {
      fonts = {
        packages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = with pkgs; [
            open-dyslexic
            nerd-fonts.open-dyslexic
            font-awesome
            noto-fonts
            noto-fonts-emoji
          ];
        };

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
    };
  };

  imports = [
    always
    userAndHome
  ];
}
