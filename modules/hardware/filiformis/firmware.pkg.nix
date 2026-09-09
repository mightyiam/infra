{
  qmk,
  dos2unix,
  python3,
  qmk-firmware,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "filiformis-firmware";
  __structuredAttrs = true;
  env.SKIP_GIT = "1";
  src = qmk-firmware;

  postPatch = ''
    patchShebangs ./util/uf2conv.py
  '';

  nativeBuildInputs = [qmk dos2unix python3];

  buildPhase = ''
    runHook preBuild

    qmk compile \
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
