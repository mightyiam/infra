{
  perSystem.devshells.default = {
    commands = [
      {
        help = "flake check that doesn't write lock file";
        name = "check";
        command = "nix flake check --print-build-logs --no-write-lock-file";
      }
    ];
  };
}
