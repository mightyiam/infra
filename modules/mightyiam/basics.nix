{config, ...}: {
  users.mightyiam = {
    name = ''Shahar "Dawn" Or'';
    email = "mightyiampresence@gmail.com";
  };

  nixos.modules = {
    inherit (config.users.mightyiam.nixos) base pc;
  };
}
