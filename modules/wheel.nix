{
  nixos.modules.base = {
    security = {
      run0 = {
        enable = true;
        sudo-shim.enable = true;
      };
      sudo.enable = false;
    };
    users.users.mightyiam.extraGroups = ["wheel"];
  };
}
