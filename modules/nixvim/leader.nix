{ lib, ... }:
{
  flake.modules.nixvim.base.globals =
    [
      "mapleader"
      "maplocalleader"
    ]
    |> map (lib.flip lib.nameValuePair ",")
    |> lib.listToAttrs;
}
