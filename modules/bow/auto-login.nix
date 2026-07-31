{lib, ...}: {
  users.bow.nixos.pc = {pkgs, ...}: {
    services.greetd.settings.initial_session = {
      user = "1bowapinya";
      command = lib.getExe' pkgs.cosmic-session "start-cosmic";
    };
  };
}
