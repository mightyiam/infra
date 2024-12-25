let
  media = import ./media.nix;
in
{
  imports = [
    ./splash-image.nix
  ];

  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  users.users.mightyiam.extraGroups = [ media.group ];
}
