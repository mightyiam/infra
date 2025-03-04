{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkMerge [
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

    home.packages = with pkgs; [
      gh-dash
    ];
  }
  (lib.mkIf config.gui.enable {
    home.packages = with pkgs; [
      gh-markdown-preview
    ];
  })
]
