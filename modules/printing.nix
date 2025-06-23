{
  flake.modules.nixos.pc = nixosArgs: {
    services.printing = {
      enable = true;
      extraSystemGroup = "lpadmin";
    };
    users.groups.${nixosArgs.config.services.printing.extraSystemGroup} = { };
  };
}
