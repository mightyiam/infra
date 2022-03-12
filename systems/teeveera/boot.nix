with builtins; {
  boot.loader = {
    timeout = 2;
    grub = {
      enable = true;
      efiSupport = true;
      mirroredBoots = [
        {
          devices = ["nodev"];
          path = "/boot0";
        }
        {
          devices = ["nodev"];
          path = "/boot1";
        }
      ];
      splashImage = fetchurl {
        url = concatStringsSep "" [
          "https://lh3.googleusercontent.com/pw/"
          "AM-JKLUPs72JvWu6ymLyefE9Rha6muA257zExWZqrxRLqxH-zt-Os0hrXTLMlK9wamnhUeThF77lRTZMQhq9K7GxOTSwIln0kSjTHtL__-_S7E4DWy0jP2EAdvv1LDjqONGdbawhPPBEF8J4VKyTWQHzqNhCAw"
          "=w1920-h1080-no"
        ];
        name = "splash.png";
      };
      extraConfig = ''
        set color_normal=black/black
        set color_highlight=black/magenta
      '';
    };
    efi.canTouchEfiVariables = true;
  };
  console.earlySetup = true;
}
