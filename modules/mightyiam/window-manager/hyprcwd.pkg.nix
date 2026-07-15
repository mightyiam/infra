{
  writeShellApplication,
  coreutils,
  hyprland,
  jq,
  procps,
}:
writeShellApplication {
  name = "hyprcwd";
  runtimeInputs = [
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
}
