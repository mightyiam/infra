{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      set-option -ga terminal-overrides ",alacritty:Tc"
      set-option -g status-right "tmux"
      set-option -g status-style "bg=black,fg=gray"

      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
