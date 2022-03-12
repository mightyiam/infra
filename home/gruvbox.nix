{
  i3status-rust = "gruvbox-dark";
  # https://chrome.google.com/webstore/detail/gruvbox-theme/ihennfdbghdiflogeancnalflhgmanop
  chromium = "ihennfdbghdiflogeancnalflhgmanop";
  vim = pkgs: {
    plugin = pkgs.vimPlugins.gruvbox-community;
    config = ''
      autocmd vimenter * ++nested colorscheme gruvbox
    '';
  };
  colors = {
    dark0 = "#282828";
    dark0_soft = "#32302f";
    dark1 = "#3c3836";
    light1 = "#ebdbb2";
    light0 = "#fbf1c7";
    light4 = "#a89984";
    gray = "#928374";
    bright_red = "#fb4934";
    bright_green = "#b8bb26";
    bright_yellow = "#fabd2f";
    bright_blue = "#83a598";
    bright_purple = "#d3869b";
    bright_aqua = "#8ec07c";
    neutral_red = "#cc241d";
    neutral_green = "#98971a";
    neutral_yellow = "#d79921";
    neutral_blue = "#458588";
    neutral_purple = "#b16286";
    neutral_aqua = "#689d6a";
    faded_red = "#9d0006";
    faded_green = "#79740e";
    faded_yellow = "#b57614";
    faded_blue = "#076678";
    faded_purple = "#8f3f71";
    faded_aqua = "#427b58";
  };
}
