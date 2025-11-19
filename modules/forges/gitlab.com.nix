{
  flake = {
    meta.accounts.github = {
      domain = "gitlab.com";
      username = "mightyiam";
    };

    modules.nixos.base = {
      # https://docs.gitlab.com/user/gitlab_com/#ssh-known_hosts-entries
      programs.ssh.knownHosts."gitlab.com".publicKey =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";
    };
  };
}
