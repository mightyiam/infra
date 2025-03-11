{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.zsh.shellAliases.nix-shell = "nix-shell --run ${lib.getExe pkgs.zsh}";
    };
}
