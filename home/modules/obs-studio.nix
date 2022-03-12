{pkgs, ...}: {
  programs.obs-studio.enable = true;
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    wlrobs
  ];
}
