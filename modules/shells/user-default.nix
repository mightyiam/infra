{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
    };
}
