{
  home.base = {
    programs.git.settings = {
      alias = {
        clone-bare-with-refspec = "clone --bare --config remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*";
      };
    };
  };
}
