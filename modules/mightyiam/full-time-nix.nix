{lib, ...}: let
  ftn-advertise = {
    writeShellApplication,
    xdg-utils,
  }:
    writeShellApplication {
      name = "ftn-advertise";
      runtimeInputs = [xdg-utils];
      text =
        [
          "https://studio.youtube.com/channel/UCfOoOAT2AsD_ZgJaviAU3iA/videos/upload"
          "https://www.reddit.com/r/Nix/"
          "https://www.reddit.com/r/NixOS/"
          "https://x.com/i/communities/1579185771939958785"
          "https://www.linkedin.com/"
          "https://discourse.nixos.org/c/links/12"
          "https://bsky.app/"
          "https://discord.com/channels/568306982717751326/1444903344719138937"
        ]
        |> map (url: "xdg-open ${lib.escapeShellArg url}")
        |> lib.concatLines;
    };
in {
  nixpkgs.overlays = [
    (final: prev: {
      ftn-advertise = prev.callPackage ftn-advertise {};
    })
  ];

  perSystem = {pkgs, ...}: {
    packages = {inherit (pkgs) ftn-advertise;};
  };

  home.gui = {pkgs, ...}: {
    home.packages = [pkgs.ftn-advertise];
  };
}
