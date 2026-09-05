{
  qmk,
  dos2unix,
  git,
  python3,
  gcc-arm-embedded,
  qmk-firmware,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "filiformis-firmware";
  __structuredAttrs = true;
  env.SKIP_GIT = "1";
  src = qmk-firmware;
  patches = [./something.patch];
  postPatch = ''
    patchShebangs ./util/uf2conv.py
  '';
  nativeBuildInputs = [qmk dos2unix python3];
  buildPhase = ''
    runHook preBuild

    export HOME=.
    export QMK_HOME=.
    chmod -R 777 .

    qmk compile \
      --clean \
      --parallel $(nproc) \
      --keyboard lily58/rev1 \
      -km default \
      -e VERBOSE=true \
      -e CONVERT_TO=helios \
      -e VIA_ENABLE=yes

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r .build $out

    runHook postInstall
  '';
})
# qmk config general.interactive False
# qmk config general.verbose True
