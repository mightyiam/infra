let
  media = import ./media.nix;
in
  {self,...}: {
  imports = with self.nixosModules; [
    common
    ./splash-image.nix
  ];

  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  users.users.mightyiam.extraGroups = [ media.group ];
}
