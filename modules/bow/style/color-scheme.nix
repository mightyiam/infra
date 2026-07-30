{inputs, ...}: {
  users.bow = {
    home.base = {
      stylix = {
        base16Scheme = "${inputs.tinted-schemes}/base16/zenburn.yaml";
        polarity = "dark";
      };
    };
    nixos.pc = nixosArgs: {
      stylix = {
        inherit
          (nixosArgs.config.home-manager.users.bow.stylix)
          base16Scheme
          polarity
          ;
      };
    };
  };
}
