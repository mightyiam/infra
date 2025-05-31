{
  flake.modules.homeManager.gui = {
    programs.qutebrowser.keyBindings.normal."<Ctrl-G>" = ":cmd-set-text :open https://grok.com/?q=";
  };
}
