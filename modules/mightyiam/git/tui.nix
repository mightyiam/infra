{
  home.base = {
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          autoFetch = false;
        };
        customCommands = [
          {
            key = "N";
            context = "files";
            command = "git add --intent-to-add {{.SelectedFile.Name}}";
            description = "record intent to add";
            loadingText = "recording intent to add";
          }
        ];
      };
    };
  };
}
