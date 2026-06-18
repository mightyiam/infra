{lib, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      system-command = prev.writeShellScriptBin "system" "nix-instantiate --eval --expr builtins.currentSystem --raw";
    })
  ];

  perSystem = {pkgs, ...}: {packages = {inherit (pkgs) system-command;};};

  home.base = {pkgs, ...}: {
    home.packages = with pkgs; [
      nix-diff
      nix-du
      nix-fast-build
      nix-melt
      nix-output-monitor
      nix-prefetch-scripts
      nix-tree
      nurl
      nvd
      system-command
    ];
    programs = {
      nh.enable = true;
      zsh.shellAliases.nix-shell = "nix-shell --run ${lib.getExe pkgs.zsh}";
    };
  };
}
