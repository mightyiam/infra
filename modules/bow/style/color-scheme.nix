{inputs, ...}: {
  users.bow.home.base = {
    stylix = {
      base16Scheme = "${inputs.tinted-schemes}/base16/zenburn.yaml";
      polarity = "dark";
    };
  };
}
