{ username, userEmail }: {
  enable = true;
  userName = username;
  inherit userEmail;
  delta.enable = true;
  extraConfig = {
    init = {
      defaultBranch = "master";
    };
  };
}
