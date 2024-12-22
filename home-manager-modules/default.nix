{
  lib,
  config,
  ...
}:
{
  options = {
    gui.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    home = {
      username = "mightyiam";
      homeDirectory = "/home/${config.home.username}";
      sessionVariables.TZ = "\$(<~/.config/timezone)";
    };
    programs.home-manager.enable = true;
  };

  imports =
    let
      dir = ./.;
    in
    dir
    |> builtins.readDir
    |> lib.attrNames
    |> lib.filter (path: path != "default.nix")
    |> map (path: "${dir}/${path}");
}
