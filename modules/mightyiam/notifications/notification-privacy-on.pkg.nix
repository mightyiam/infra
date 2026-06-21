{
  writeShellApplication,
  mako,
  mode,
}:
writeShellApplication {
  name = "notification-privacy-on";
  runtimeInputs = [mako];
  text = ''
    makoctl mode -a ${mode}
  '';
}
