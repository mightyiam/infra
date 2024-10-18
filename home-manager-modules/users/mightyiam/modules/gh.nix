{ pkgs, ... }:
{
  programs.gh = {
    package = pkgs.gh.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.makeWrapper ];
      postInstall =
        oldAttrs.postInstall or ""
        + ''
          wrapProgram $out/bin/gh --unset GITHUB_TOKEN
        '';
    });
    enable = true;
    settings.git_protocol = "ssh";
  };
}
