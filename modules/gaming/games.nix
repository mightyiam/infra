{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      ace-of-penguins
      enigma
      pingus
      pysolfc
      stellarium
    ];
  };
}
