{ lib, ... }:
{
  flake.modules.homeManager.home =
    { pkgs, ... }:
    {
      programs.zsh.shellAliases.nix-shell = "nix-shell --run ${lib.getExe pkgs.zsh}";
    };
}
