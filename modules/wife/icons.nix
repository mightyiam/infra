{
  flake.modules = {
    homeManager.wife =
      { pkgs, ... }:
      let
        variant = "pink";
      in
      {
        stylix.icons = {
          enable = true;
          dark = "Reversal-${variant}-dark";
          light = "Reversal-${variant}";
          # https://github.com/NixOS/nixpkgs/issues/481518
          package = pkgs.reversal-icon-theme.overrideAttrs {
            installPhase = ''
              runHook preInstall

              mkdir -p $out/share/icons

              name= ./install.sh \
                -t ${variant} \
                -d $out/share/icons

              rm $out/share/icons/*/{AUTHORS,COPYING}

              jdupes --quiet --link-soft --recurse $out/share

              runHook postInstall
            '';
          };
        };
      };
  };
}
