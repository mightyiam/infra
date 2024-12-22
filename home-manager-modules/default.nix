{ lib, ... }:
{
  imports =
    let
      dir = ./.;
    in
    dir
    |> builtins.readDir
    |> lib.attrNames
    |> lib.filter (path: path != "default.nix")
    |> map (path: "${dir}/${path}");
}
