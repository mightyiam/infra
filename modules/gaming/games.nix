{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      enigma
      pingus
      stellarium
    ];
  };
}
