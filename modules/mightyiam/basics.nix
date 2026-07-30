{config, ...}: {
  users.mightyiam = {
    email = "mightyiampresence@gmail.com";
  };

  nixos.modules = {
    inherit (config.users.mightyiam.nixos) base pc;
  };
}
