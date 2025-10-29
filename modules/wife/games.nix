{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        chroma
        enigma
        # pingus failed to build
        sgt-puzzles
        # possibly https://github.com/NixOS/nixpkgs/issues/399790
        #stellarium
      ];
    };
}
