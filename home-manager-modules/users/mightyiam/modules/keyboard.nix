{ lib, ... }:
let
  directions = {
    left = "h";
    down = "j";
    up = "k";
    right = "l";
  };
  applyRec =
    f: attrs: builtins.mapAttrs (_: v: if builtins.isAttrs v then applyRec f v else f v) attrs;
  prefixRec = str: applyRec (v: str + v);
in
{
  options.keyboard = lib.mkOption {
    type = lib.types.anything;
    default = {
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
        screenshot = prefixRec "Shift+" {
          window = "w";
          output = "o";
          region = "r";
        };
      };
    };
  };
}
