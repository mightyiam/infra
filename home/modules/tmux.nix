instance: {pkgs, ...}: let
  keyboard = import ../keyboard.nix;
in {
  programs.tmux = with keyboard; {
    enable = true;
    keyMode = keyMode;
    shortcut = terminalMultiplexerEscape;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    terminal = "tmux-256color";
    extraConfig = ''
      set-option -ga terminal-overrides ",alacritty:Tc"
      set-option -g status-right "tmux"
      set-option -g status-style "bg=black,fg=gray"

      bind '${splitVertical}' split-window -c "#{pane_current_path}"
      bind ${splitHorizontal} split-window -h -c "#{pane_current_path}"
      bind ${windowNew} new-window -c "#{pane_current_path}"
    '';
  };
}
