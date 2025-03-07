{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        chroma
        enigma
        pingus
        sgt-puzzles
        stellarium
      ];
    };
}
