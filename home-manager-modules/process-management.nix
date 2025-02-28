{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lsof
    procs
    psmisc
    watchexec
  ];
}
