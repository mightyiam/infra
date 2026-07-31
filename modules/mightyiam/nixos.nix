{config, ...}: {
  nixos.modules = {
    inherit (config.users.mightyiam.nixos) base;
    pc = {
      home-manager.users.mightyiam = config.users.mightyiam.home.gui;
    };
  };
}
