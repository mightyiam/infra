with builtins; let
  transmissionRPCPort = 9091;
  hostname = "teeveera";
in {
  teeveera = {
    inherit hostname;
    media = {
      group = "media";
      dir = "/media";
      mode = {
        mode = 770;
        mask = 7;
      };
    };
    inherit transmissionRPCPort;
    shellAliases = pkgs: {
      tv-transmission-shell = let
        ssh = "${pkgs.openssh}/bin/ssh";
        target = "${hostname}.local";
        port = toString transmissionRPCPort;
      in ''
        ${ssh} -fNTM -L ${port}:localhost:${port} ${target}
        $SHELL
        ${ssh} -O exit ${target}
      '';
      tra = "${pkgs.transmission}/bin/transmission-remote";
    };
  };
}
