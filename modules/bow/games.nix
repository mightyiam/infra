{
  users.bow.home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [
      enigma
      pingus
      sgt-puzzles
      # TODO possibly https://github.com/NixOS/nixpkgs/issues/399790
      stellarium
    ];
  };
}
