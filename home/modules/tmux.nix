let
  keyboard = import ../keyboard.nix;
in {
  programs.tmux = {
    enable = true;
    inherit (keyboard) keyMode;
    shortcut = keyboard.terminalMultiplexerEscape;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    terminal = "tmux-256color";
    historyLimit = 100000;
    extraConfig = ''
      set-option -ga terminal-overrides ",alacritty:Tc"
      set-option -g status-right "tmux"
      set-option -g status-style "bg=black,fg=gray"

      bind '${keyboard.splitVertical}' split-window -c "#{pane_current_path}"
      bind ${keyboard.splitHorizontal} split-window -h -c "#{pane_current_path}"
      bind ${keyboard.windowNew} new-window -c "#{pane_current_path}"
    '';
  };
}
