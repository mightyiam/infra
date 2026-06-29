{inputs, ...}: {
  flake-file.inputs.make-shell = {
    url = "github:nicknovitski/make-shell";
    flake = false;
  };

  imports = ["${inputs.make-shell}/flake-module.nix"];
}
