{
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        hyprcwd = prev.writeShellApplication {
          name = "hyprcwd";
          runtimeInputs = [
            final.coreutils
            prev.hyprland
            prev.jq
            prev.procps
          ];
          # https://github.com/vilari-mickopf/hyprcwd
          text = ''
            pid=$(hyprctl activewindow -j | jq '.pid')
            ppid=$(pgrep --newest --parent "$pid")
            dir=$(readlink /proc/"$ppid"/cwd || echo "$HOME")
            [ -d "$dir" ] && echo "$dir" || echo "$HOME"
          '';
        };
      })
    ];
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.hyprcwd];
  };
}
