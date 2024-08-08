let
  dir = "/media";
  mode = 770;
  group = "media";
in
{
  inherit group;
  inherit dir;
  mode = {
    inherit mode;
    mask = 7;
  };
  module.system.activationScripts.media.text = ''
    mkdir --parents ${dir}
    chown root:${group} ${dir}
    chmod ${toString mode} ${dir}
  '';
  module.users.groups."${group}" = { };
}
