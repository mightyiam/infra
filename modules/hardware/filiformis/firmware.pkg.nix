{
  qmk,
  dos2unix,
  runCommand,
  git,
  qmk-firmware,
}:
runCommand "filiformis-firmware" {
  env.SKIP_GIT = "1";
  nativeBuildInputs = [git qmk dos2unix];
} ''
  cp -r ${qmk-firmware}/* .
  qmk setup
  qmk config general.interactive
  qmk compile --keyboard lily58/rev1 -km default -e CONVERT_TO=helios -e VIA_ENABLE=yes
''
