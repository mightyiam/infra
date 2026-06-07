{inputs, ...}: {
  home.base = {
    stylix = {
      base16Scheme = "${inputs.tinted-schemes}/base16/gruvbox-dark-medium.yaml";
      polarity = "dark";
    };
  };
}
