with builtins; let
  split = {
    h = "h";
    v = "v";
  };
  directions = {
    left = "h";
    down = "j";
    up = "k";
    right = "l";
  };
  applyRec = f: attrs:
    mapAttrs (k: v:
      if isAttrs v
      then applyRec f v
      else f v)
    attrs;
  prefixRec = str: applyRec (v: str + v);
  leader = ",";
in {
  inherit leader;
  keyMode = "vi"; # tmux
  terminalMultiplexerEscape = "a"; # tmux
  splitVertical = "\""; # tmux
  splitHorizontal = "%"; # tmux
  windowNew = "c"; # tmux
  fileTreeFocus = "<C-t>";
  fileTreeToggle = "<C-T>";
  easyMotion = ",";
  text = {
    dedent = "<";
    indent = ">";
  };
  refactor = prefixRec "<space>" {
    actions = "a";
    rename = "r";
    format = "f";
  };
  goTo = prefixRec "g" {
    declaration = "D";
    definition = "d";
    implementation = "i";
    type = "o";
    references = "r";
    diagnostics = "l";
  };
  show = {
    type = "K";
    signature = "<C-k>";
  };
  diagnostic = {
    prev = "[d";
    next = "]d";
    toggle = "${leader}xx";
    workspace = "${leader}xw";
    document = "${leader}xd";
    quickfix = "${leader}xq";
    loclist = "${leader}xl";
  };
  wm = prefixRec "Mod4+" {
    lock = "Ctrl+l";
    terminal = "Return";
    kill = "Shift+q";
    menu = "d";
    focus = directions // {parent = "a";};
    move = prefixRec "Shift+" directions;
    fullscreen = "f";
    layout = {
      tabbed = "w";
      toggleSplit = "e";
    };
    floatingToggle = "Shift+space";
    focusModeToggle = "space";
    workspace = {
      "1" = "1";
      "2" = "2";
      "3" = "3";
      "4" = "4";
      "5" = "5";
      "6" = "6";
      "7" = "7";
      "8" = "8";
      "9" = "9";
    };
    moveToWorkspace = prefixRec "Shift+" {
      "1" = "1";
      "2" = "2";
      "3" = "3";
      "4" = "4";
      "5" = "5";
      "6" = "6";
      "7" = "7";
      "8" = "8";
      "9" = "9";
    };
    reload = "Shift+c";
    exit = "Shift+e";
    resize = "r";
    volume = {
      decrement = "minus";
      increment = "equal";
    };
  };
}
