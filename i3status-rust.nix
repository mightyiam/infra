id: {
  "${id}" = {
    theme = "plain";
    icons = "awesome5";
    blocks = [
      { block = "cpu"; }
      { block = "memory"; }
      { block = "disk_space"; }
      #{ block = "nvidia_gpu"; }

      { block = "docker"; }
      { block = "github"; }

      { block = "net"; }
      { block = "networkmanager"; device_format = "{icon}{ap}"; }

      { block = "time"; }
      { block = "keyboard_layout"; driver = "sway"; }
      { block = "sound"; }
    ];
  };
}
