instance: {
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = config.accounts.email.accounts.default.realName;
    userEmail = config.accounts.email.accounts.default.address;
    difftastic.enable = true;
    difftastic.background = "dark";
    #difftastic.display = "inline";
    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      push.default = "current";
      safe.bareRepository = "explicit";
      rebase.instructionFormat = "%d %s";
      merge.conflictstyle = "diff3";
    };
  };

  home.packages = [
    # https://github.com/NixOS/nixpkgs/pull/275402
    (let
      version = "0.1.8";
      pname = "git-fixup";
    in
      pkgs.rustPlatform.buildRustPackage {
        inherit pname version;

        src = pkgs.fetchFromGitHub {
          owner = "quodlibetor";
          repo = "git-fixup";
          rev = "v${version}";
          hash = "sha256-vuLkbreW1K2KSW659UpWfbIUK+Nmyp1buvcG50CXIDQ=";
        };

        cargoHash = "sha256-sD3CQvUL3vcORCC3yFZ41uG2HZzPx/51wN27V9b/FRs=";
      })
  ];
}
