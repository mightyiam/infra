{config, ...}: {
  nixos.modules = {
    inherit (config.users.mightyiam.nixos) base pc;
  };
}
