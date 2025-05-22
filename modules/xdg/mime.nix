{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      xdg = {
        enable = true;
        mime.enable = true;
        mimeApps.enable = true;
      };

      home.packages = with pkgs; [
        xdg-utils
      ];
    };
}
