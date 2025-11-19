{
  flake = {
    meta.accounts.github = {
      domain = "github.com";
      username = "mightyiam";
    };

    modules = {
      nixos.base = {
        # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
        programs.ssh.knownHosts."github.com".publicKey =
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };

      homeManager = {
        base =
          { pkgs, ... }:
          {
            programs.gh = {
              package = pkgs.gh.overrideAttrs (oldAttrs: {
                buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.makeWrapper ];
                postInstall = oldAttrs.postInstall or "" + ''
                  wrapProgram $out/bin/gh --unset GITHUB_TOKEN
                '';
              });
              enable = true;
              settings.git_protocol = "ssh";
            };

            home.packages = with pkgs; [ gh-dash ];
          };
        gui =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [ gh-markdown-preview ];
          };
      };
    };
  };
}
