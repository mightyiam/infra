{
  flake.modules.nixos.base = {
    users.users.mightyiam = {
      isNormalUser = true;
      initialPassword = "";
    };
  };
}
