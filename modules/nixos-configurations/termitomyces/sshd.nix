{
  services.openssh = {
    enable = true;
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7usI+3jiHKYtWD7XAO8gWXKHJN4VZ67dh5x9oPvsQk root@termitomyces";
    listenAddresses = [ { addr = "localhost"; } ];
  };
}
