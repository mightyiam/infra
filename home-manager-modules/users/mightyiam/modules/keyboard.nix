{ lib, ... }:
let
  inherit (builtins) isAttrs mapAttrs;

  inherit (lib) mkOption types;

  directions = {
    left = "h";
    down = "j";
    up = "k";
    right = "l";
  };
  applyRec = f: attrs: mapAttrs (_: v: if isAttrs v then applyRec f v else f v) attrs;
  prefixRec = str: applyRec (v: str + v);
  leader = ",";
in
{
  options.keyboard = mkOption {
    type = types.anything;
    default = {
      inherit leader;
      easyMotion = ",";
      text = {
        dedent = "<";
        indent = ">";
      };
      refactor = prefixRec "<space>" {
        actions = "a";
        rename = "r";
        format = "f";
        nixfmt = "n";
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
      };
      wm = prefixRec "Mod4+" {
        lock = "Ctrl+l";
        terminal = "Return";
        kill = "Shift+q";
        menu = "d";
        focus = directions // {
          parent = "a";
        };
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
          toggleMuteSources = "m";
          sinkRotate = "s";
        };
        screenshot = prefixRec "Shift+" {
          window = "w";
          output = "o";
          region = "r";
        };
      };
    };
  };
}
