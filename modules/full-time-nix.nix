{ lib, withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.ftn-advertise = pkgs.writeShellApplication {
        name = "ftn-advertise";
        runtimeInputs = [ pkgs.xdg-utils ];
        text =
          [
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
    };
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = withSystem pkgs.stdenv.hostPlatform.system (psArgs: [
        psArgs.config.packages.ftn-advertise
      ]);
    };
}
