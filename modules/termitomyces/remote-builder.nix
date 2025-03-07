{ }
# { pkgs, ... }:
# {
#   environment.systemPackages = [
#     # https://discourse.nixos.org/t/25834
#     (pkgs.writeShellScriptBin "remote-builder-ssh-substitute-command" ''
#       case $SSH_ORIGINAL_COMMAND in
#         "nix-daemon --stdio")
#           exec env NIX_SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt ${pkgs.nix}/bin/nix-daemon --stdio
#           ;;
#         "nix-store --serve --write")
#           exec env NIX_SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt ${pkgs.nix}/bin/nix-store --serve --write
#           ;;
#         *)
#           echo "Access only allowed for using the nix remote builder" 1>&2
#           exit
#       esac
#     '')
#   ];
# }
