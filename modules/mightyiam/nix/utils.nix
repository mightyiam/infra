{lib, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      system-command = prev.callPackage ./system-command.pkg.nix {};
    })
  ];

  perSystem = {pkgs, ...}: {packages = {inherit (pkgs) system-command;};};

  home.base = {pkgs, ...}: {
    home.packages = [
      pkgs.nix-diff
      pkgs.nix-du
      pkgs.nix-fast-build
      pkgs.nix-melt
      pkgs.nix-output-monitor
      pkgs.nix-prefetch-scripts
      pkgs.nix-tree
      pkgs.nurl
      pkgs.nvd
      pkgs.system-command
    ];
    programs = {
      nh.enable = true;
      zsh.shellAliases.nix-shell = "nix-shell --run ${lib.getExe pkgs.zsh}";
    };
  };
}
