{
  home.preferXdgDirectories = true;
  programs.github-copilot-cli = {
    enable = true;
    settings = {
      model = "claude-sonnet-4-5";
      theme = "dark";
      trusted_folders = [ "/home/user/projects" ];
    };
  };

  nmt.script = ''
    assertFileExists home-files/.config/copilot/config.json
    assertFileContent home-files/.config/copilot/config.json ${./expected-config.json}
    assertPathNotExists home-files/.copilot/config.json
    assertFileContains home-path/etc/profile.d/hm-session-vars.sh \
      'export COPILOT_HOME="/home/hm-user/.config/copilot"'
  '';
}
