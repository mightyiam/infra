{ config, ... }:
let
  inherit (config.flake.meta.accounts) github;
  forge = "github";
  owner = github.username;
  name = "infra";
  defaultBranch = "main";
  flakeUri = "${forge}:${owner}/${name}";
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
