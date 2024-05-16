{pkgs, ...}: let
  inherit (pkgs) gh makeWrapper;
in {
  programs.gh = {
    package = gh.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs or [] ++ [makeWrapper];
      postInstall =
        oldAttrs.postInstall
        or ""
        + ''
          wrapProgram $out/bin/gh --unset GITHUB_TOKEN
        '';
    });
    enable = true;
    settings.git_protocol = "ssh";
  };
}
