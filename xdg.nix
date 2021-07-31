configHome: {
    enable = true;
    inherit configHome;
    #userDirs = let tmp = "${homeDirectory}/tmp"; in {
      #enable = true;
      #createDirectories = false;
      #desktop = tmp;
      #documents = tmp;
      #download = tmp;
      #music = tmp;
      #pictures = tmp;
      #publicShare = "${homeDirectory}/public";
      #templates = "${homeDirectory}/templates";
      #videos = tmp;
    #};
  }
