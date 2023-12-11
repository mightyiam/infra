instance: {pkgs, ...}: {
  programs.gh = {
    package = pkgs.symlinkJoin {
      name = pkgs.gh.name;
      paths = [pkgs.gh];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/gh --unset GITHUB_TOKEN
      '';
    };
    enable = true;
    settings.version = "1";
    settings.git_protocol = "ssh";
  };
}
