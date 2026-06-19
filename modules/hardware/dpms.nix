let
  dpms-all = {
    writeShellApplication,
    hyprland,
  }:
    writeShellApplication {
      name = "dpms-all";
      runtimeInputs = [hyprland];
      text = ''
        if [ $# -ne 1 ]; then
            echo "Usage: $0 [on|off]" >&2
            exit 1
        fi
        if [ "$1" != "on" ] && [ "$1" != "off" ]; then
            echo "Usage: $0 [on|off]" >&2
            exit 1
        fi

        case "$XDG_CURRENT_DESKTOP" in
            "Hyprland")
                hyprctl dispatch dpms "$1"
                ;;
            *)
                echo "Unsupported XDG_CURRENT_DESKTOP" >&2
                exit 1
                ;;
        esac
      '';
    };
in {
  nixpkgs.overlays = [
    (final: prev: {
      dpms-all = prev.callPackage dpms-all {};
    })
  ];

  perSystem = {pkgs, ...}: {
    packages = {inherit (pkgs) dpms-all;};
  };

  nixos.modules.base = {
    services.kmscon.config.dmps-timeout = 60;
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.dpms-all];
  };
}
