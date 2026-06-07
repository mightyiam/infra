{
  config,
  lib,
  ...
}: {
  options.repository.git = lib.mkOption {
    readOnly = true;
    type = lib.types.submodule (repoArgs: {
      options = {
        forge = lib.mkOption {
          type = lib.types.singleLineStr;
        };
        owner = lib.mkOption {
          type = lib.types.singleLineStr;
        };
        name = lib.mkOption {
          type = lib.types.singleLineStr;
        };
        defaultBranch = lib.mkOption {
          type = lib.types.singleLineStr;
        };
        flakeUri = lib.mkOption {
          type = lib.types.singleLineStr;
          readOnly = true;
          default = "${repoArgs.config.forge}:${repoArgs.config.owner}/${repoArgs.config.name}";
        };
      };
    });
    default = {
      forge = "github";
      owner = config.users.mightyiam.accounts.github.username;
      name = "infra";
      defaultBranch = "main";
    };
  };
}
