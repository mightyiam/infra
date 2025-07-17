{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.fd
        pkgs.ripgrep
        pkgs.ripgrep-all
      ];
    };
}
