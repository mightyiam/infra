{
  flake.modules.nixos.pc.boot.loader = {
    timeout = 2;
    grub = {
      extraConfig = ''
        if keystatus; then
          if keystatus --shift; then
            set timeout=-1
          else
            set timeout=0
          fi
        fi
      '';
    };
  };
}
