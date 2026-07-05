{
  home.base = {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        ## https://starship.rs/config/#prompt
        format = builtins.concatStringsSep "" [
          "\n"
          "$all"
          "$directory"
          "\n"
          "$status"
          "$container"
          "$netns"
          "$shell"
          "$shlvl"
          "$character"
        ];
        directory = {
          truncation_length = 0;
          truncate_to_repo = false;
        };
        direnv.disabled = false;
        shell.disabled = false;
        shlvl.disabled = false;
        status.disabled = false;
        username = {
          show_always = true;
          format = "[$user]($style) ";
        };
      };
    };
  };
}
