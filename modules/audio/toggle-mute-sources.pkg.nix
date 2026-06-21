{
  writeShellApplication,
  pulseaudio,
  gawk,
}:
# TODO rewrite in Nushell
writeShellApplication {
  name = "toggle-mute-sources";
  runtimeInputs = [
    pulseaudio
    gawk
  ];
  text = ''
    for source in $(pactl list short sources | awk "{print \$2}");
    do pactl set-source-mute "$source" toggle;
    done
  '';
}
