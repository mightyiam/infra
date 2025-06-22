{ config, ... }:
let
  inherit (config.flake.meta.accounts) github;
  inherit (config.flake.meta) repo;
in
{
  flake.meta.repo = {
    forge = "github";
    owner = config.flake.meta.accounts.github.username;
    name = "infra";
    defaultBranch = "main";
    flakeUri = "git+https://${github.domain}/${repo.owner}/${repo.name}?submodules=1";
  };
}
