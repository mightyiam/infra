{ lib, ... }:
{
  flake.modules.nixos.base =
    let
      nameservers =
        [
          # https://developers.cloudflare.com/1.1.1.1
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"

          # https://developers.google.com/speed/public-dns/docs/using
          "8.8.8.8"
          "8.8.4.4"
          "2001:4860:4860::8888"
          "2001:4860:4860::8844"
        ]
        |> lib.concatStringsSep " ";
    in
    {
      services.resolved = {
        enable = true;
        dnsovertls = "opportunistic";
        extraConfig = ''
          [Resolve]
          DNS=${nameservers}
        '';
      };
    };
}
