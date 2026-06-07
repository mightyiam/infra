{withSystem, ...}: {
  perSystem = {pkgs, ...}: {
    # TODO via overlay
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

  home.gui = {pkgs, ...}: {
    home.packages = [
      (withSystem pkgs.stdenv.hostPlatform.system (psArgs: psArgs.config.packages.hyprcwd))
    ];
  };
}
