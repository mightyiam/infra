{
  writeShellApplication,
  hyprland,
  jq,
}:
writeShellApplication {
  name = "get-hyprland-main-keyboard-layout";
  runtimeInputs = [
    hyprland
    jq
  ];
  text = ''
    hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap | select(. == "English (US)" or . == "Hebrew") | if . == "English (US)" then "us" else "il" end'
  '';
}
