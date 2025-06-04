{
  configurations.nixos.dobby.modules = [
    {
      boot.loader.grub.skipMenuUnlessShift = false;
    }
  ];
}
