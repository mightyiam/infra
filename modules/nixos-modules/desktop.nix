{ self, ... }:
{
  imports = with self.modules.nixos; [
    allow-unfree-packages
    bluetooth
    dconf
    editor
    firmware
    flakes
    flipper-zero
    fonts
    graphics
    grub
    home
    home-related-hacks
    known-hosts
    me
    networking
    nh
    nix
    nix-index
    pipewire
    printing
    service-discovery
    shell
    sshd
    steam
    storage
    sudo
    tailscale
    time-sync
    tmp
    virtualbox
  ];
}
