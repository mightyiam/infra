rec {
  left = {
    path = "DP-2";
    resolution = { width = 1920; height = 1080; };
    refreshRate = 144;
    position = { x = 0; y = 0; };
  };
  right = {
    path = "DP-1";
    resolution = { width = 1920; height = 1080; };
    refreshRate = 75;
    position = { x = left.resolution.width; y = 0; };
  };
}

