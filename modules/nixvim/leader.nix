{ lib, ... }:
{
  flake.modules.nixvim.astrea.globals =
    [
      "mapleader"
      "maplocalleader"
    ]
    |> map (lib.flip lib.nameValuePair ",")
    |> lib.listToAttrs;
}
