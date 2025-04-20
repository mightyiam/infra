{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        chroma
        enigma
        pingus
        sgt-puzzles
        # possibly https://github.com/NixOS/nixpkgs/issues/399790
        #stellarium
      ];
    };
}
