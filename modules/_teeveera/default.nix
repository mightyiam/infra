let
  media = import ./media.nix;
in
{
  imports = [
    ./splash-image.nix
  ];

  users.users.mightyiam.extraGroups = [ media.group ];
}
