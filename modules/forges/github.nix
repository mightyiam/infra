{lib, ...}: {
  options.users = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.accounts.github = lib.mkOption {
          type = lib.types.nullOr (
            lib.types.submodule {
              options = {
                username = lib.mkOption {
                  type = lib.types.singleLineStr;
                };
                email = lib.mkOption {
                  type = lib.types.singleLineStr;
                };
              };
            }
          );
          default = null;
        };
      }
    );
  };

  config.nixos.modules.base = {
    # https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
    programs.ssh.knownHosts."github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
  };
}
