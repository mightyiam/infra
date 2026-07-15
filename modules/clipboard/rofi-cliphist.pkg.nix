{
  writeShellApplication,
  rofi,
  cliphist,
}:
writeShellApplication {
  name = "rofi-cliphist";
  runtimeInputs = [
    cliphist
    rofi
  ];
  text = ''
    prompt=' 󰆏 '
    content=$(cliphist list | rofi -dmenu -p "$prompt")
    decoded=$(cliphist decode <<<"$content")

    echo -n "$decoded" | wl-copy
  '';
}
