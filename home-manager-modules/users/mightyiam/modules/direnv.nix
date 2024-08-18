{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.git.ignores = [
    ".envrc"
    ".direnv"
  ];
  programs.direnv.config.global.warn_timeout = 0;
}
