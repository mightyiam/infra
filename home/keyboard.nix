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
in {
  keyMode = "vi"; # tmux
  terminalMultiplexerEscape = "a"; # tmux
  splitVertical = "\""; # tmux
  splitHorizontal = "%"; # tmux
  windowNew = "c"; # tmux
  fileTreeFocus = "<C-t>";
  fileTreeToggle = "<C-T>";
  leader = ",";
  easyMotion = ",";
  text = {
    dedent = "<";
    indent = ">";
  };
  refactor = prefixRec "<space>" {
    rename = "r";
    format = "f";
  };
  goTo = prefixRec "g" {
    declaration = "D";
    definition = "d";
    implementation = "i";
    type = "t";
  };
  popup = applyRec (v: "<C-${v}>") {
    type = "t";
    signature = "s";
    diagnostics = "d";
  };
  list = prefixRec "a" {
    actions = "a";
    references = "r";
    diagnostics = "d";
  };
  prevNext =
    applyRec (v: {
      prev = "p" + v;
      next = "n" + v;
    }) {
      diagnostic = "d";
      searchResult = "s";
    };
  wm = prefixRec "Mod4+" {
    lock = "Ctrl+l";
    terminal = "Return";
    kill = "Shift+q";
    menu = "d";
    focus = directions;
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
