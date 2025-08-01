{
  # https://codeberg.org/Codeberg/org/src/commit/172350cbd945af6e5cb062a99444892161c2e5db/Imprint.md
  flake.modules.nixos.base.programs.ssh.knownHosts = {
    "codeberg.org".publicKey =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIVIC02vnjFyL+I4RHfvIGNtOgJMe769VTF1VR4EB3ZB";
  };
}
