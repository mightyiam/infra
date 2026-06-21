{
  writeShellApplication,
  mako,
  mode,
}:
writeShellApplication {
  name = "notification-privacy-off";
  runtimeInputs = [mako];
  text = ''
    makoctl mode -r ${mode}
  '';
}
