{
  writeShellApplication,
  socat,
  notification-privacy-off,
  notification-privacy-on,
}:
writeShellApplication {
  name = "handle-hyprland-screencast";
  runtimeInputs = [
    socat
    notification-privacy-off
    notification-privacy-on
  ];
  text = ''
    handle() {
      case $1 in
        "screencast>>0"*) notification-privacy-off ;;
        "screencast>>1"*) notification-privacy-on ;;
      esac
    }

    socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
    | while read -r line; do handle "$line"; done
  '';
}
