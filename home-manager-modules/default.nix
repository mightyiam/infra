{
  pkgs,
  lib,
  ...
}:
let
  username = "mightyiam";
  userAndHome.config = {
    home.username = lib.mkDefault username;
    home.homeDirectory = lib.mkDefault "/home/${username}";
  };
  modules =
    let
      dir = ./.;
    in
    dir
    |> builtins.readDir
    |> lib.attrNames
    |> lib.filter (path: path != "default.nix")
    |> map (path: "${dir}/${path}");
  always = {
    imports = modules;

    config.programs.home-manager.enable = true;

    config.home.sessionVariables.TZ = "\$(<~/.config/timezone)";
  };
in
{
  options.gui.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  options.location.latitude = lib.mkOption {
    type = lib.types.numbers.between (-90) 90;
    default = 18.746;
  };

  options.location.longitude = lib.mkOption {
    type = lib.types.numbers.between (-180) 180;
    default = 99.075;
  };

  options.style.windowOpacity = lib.mkOption {
    type = lib.types.numbers.between 0 1.0;
    default = 1.0;
  };

  options.style.bellDuration = lib.mkOption {
    type = lib.types.numbers.between 0 1000;
    default = 200.0;
  };

  options.gui.fonts.packages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = with pkgs; [
      open-dyslexic
      nerd-fonts.open-dyslexic
      font-awesome
      noto-fonts
      noto-fonts-emoji
    ];
  };

  options.gui.fonts.default.family = lib.mkOption {
    type = lib.types.str;
    default = "sans-serif";
  };

  options.gui.fonts.default.size = lib.mkOption {
    type = lib.types.float;
    default = 10.0;
  };

  options.gui.fonts.monospace.family = lib.mkOption {
    type = lib.types.str;
    default = "monospace";
  };

  options.gui.fonts.monospace.size = lib.mkOption {
    type = lib.types.float;
    default = 10.0;
  };

  options.gui.fonts.aliases = lib.mkOption {
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

  imports = [
    always
    userAndHome
  ];
}
