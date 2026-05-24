{ inputs, lib, ... }:
{
  _module.args.nixvim =
    import "${inputs.nixvim}/lib/overlay.nix" |> lib.extend |> lib.getAttr "nixvim";
}
