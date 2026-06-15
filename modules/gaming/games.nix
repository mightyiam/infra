{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      enigma
      pingus
      sgt-puzzles
      stellarium
    ];
  };
}
