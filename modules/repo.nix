{ config, ... }:
let
  inherit (config.flake.meta.accounts) github;
  forge = "github";
  owner = github.username;
  name = "infra";
  defaultBranch = "main";
  flakeUri = "git+https://${github.domain}/${owner}/${name}?submodules=1&shallow=1";
in
{
  flake.meta.repo = {
    inherit
      forge
      owner
      name
      defaultBranch
      flakeUri
      ;
  };
}
