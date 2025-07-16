{ withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.hyprcwd = pkgs.writeShellApplication {
        name = "hyprcwd";
        runtimeInputs = with pkgs; [
          coreutils
          hyprland
          jq
          procps
        ];
        # https://github.com/vilari-mickopf/hyprcwd
        text = ''
          pid=$(hyprctl activewindow -j | jq '.pid')
          ppid=$(pgrep --newest --parent "$pid")
          dir=$(readlink /proc/"$ppid"/cwd || echo "$HOME")
          [ -d "$dir" ] && echo "$dir" || echo "$HOME"
        '';
      };
    };

  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.swaycwd
        (withSystem pkgs.system (psArgs: psArgs.config.packages.hyprcwd))
      ];
    };
}
