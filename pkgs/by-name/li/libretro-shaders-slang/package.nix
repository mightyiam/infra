{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  unstableGitUpdater,
}:

stdenvNoCC.mkDerivation {
  pname = "libretro-shaders-slang";
  version = "0-unstable-2026-01-29";

  src = fetchFromGitHub {
    owner = "libretro";
    repo = "slang-shaders";
    rev = "bbdb6153e5832d419702dfbee9e1e621f99aee32";
    hash = "sha256-V07LnMa7LTLBaSUUhyIuNgrJU2nQa08Yonq5O7vTvyU=";
  };

  dontConfigure = true;
  dontBuild = true;
  installFlags = "PREFIX=${placeholder "out"}";

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Slang shaders for use with RetroArch's shader system";
    homepage = "https://github.com/libretro/slang-shaders";
    license = lib.licenses.gpl3Only;
    maintainers = [ lib.maintainers.nadiaholmquist ];
    platforms = lib.platforms.all;
  };
}
