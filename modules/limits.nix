{
  nixos.modules.base = {
    security.pam.loginLimits = [
      {
        domain = "*";
        type = "soft";
        item = "nofile";
        value = "99999";
      }
    ];
  };
}
