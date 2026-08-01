{
  config,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit
      (pkgs.htnl.polymorphic.partials)
      body
      div
      span
      head
      html
      link
      meta
      title
      ;
    inherit (pkgs.htnl) document;
  in {
    mightyi-am.htmlDocuments."index.html" =
      html {lang = "en";} [
        (head [
          (title config.users.mightyiam.name)
          (meta {charset = "UTF-8";})
          (meta {
            name = "viewport";
            content = "width=device-width, initial-scale=1.0";
          })
          (meta {
            name = "description";
            content = config.users.mightyiam.description.text;
          })
          (link {
            rel = "stylesheet";
            href = "./style.css";
          })
        ])
        (body {class = ["bg-black" "text-white" "grid" "grid-flow-rows"];} [
          (config.users.mightyiam.username
            |> lib.stringToCharacters
            |> map span
            |> div {class = ["grid" "grid-flow-col" "auto-cols-fr" "justify-items-center"];})
          (config.users.mightyiam.name
            |> lib.splitString " "
            |> map span
            |> div {class = ["grid" "grid-flow-col" "auto-cols-fr" "justify-items-center"];})
        ])
      ]
      |> document;
  };
}
