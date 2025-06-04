{
  configurations.nixos.dobby.modules = [
    {
      networking.domain = "local";
    }
  ];
}
