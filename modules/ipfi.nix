{
  ipfi.inputs = {
    nixpkgs.upstream = {
      url = "https://github.com/NixOS/nixpkgs.git";
      baseRef = "nixpkgs-unstable";
    };
    home-manager = {
      url = "https://github.com/nix-community/home-manager.git";
      baseRef = "master";
    };
    stylix = {
      url = "https://github.com/nix-community/stylix.git";
      baseRef = "master";
    };
  };
}
