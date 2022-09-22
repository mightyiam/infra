{config, ...}: let
  media = import ./media.nix;
in {
  system.activationScripts.media.text = ''
    mkdir --parents ${media.dir}
    chown root:${media.group} ${media.dir}
    chmod ${toString media.mode.mode} ${media.dir}
  '';
}
