{
  services.openssh = {
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    extraConfig = ''
      Include /etc/ssh/sshd_config.d/*
    '';
  };
}
