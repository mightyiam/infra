{
  inputs,
  lib,
  ...
}: {
  flake-file = {
    inputs.flake-file.url = "github:denful/flake-file";
    do-not-edit =
      ''
        Heya! Actually, this `flake.nix` file is auto-generated.
        The source of truth for its content is merged from across any number of files.
        Each input is declared in the module where it belongs.
        Same goes for the `nixConfig`, as well, of course.
        https://flake-file.denful.dev/''
      |> lib.splitString "\n"
      |> map (line: "# ${line}")
      |> lib.concatLines;
  };

  imports = [inputs.flake-file.flakeModules.default];
}
