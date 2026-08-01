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
      style
      ;
    inherit (pkgs.htnl) document raw;

    fonts = pkgs.runCommand "fonts" {nativeBuildInputs = [(pkgs.python3.withPackages (ps: [ps.fonttools ps.brotli]))];} ''
      mkdir $out
      fonttools ttLib.woff2 compress ${pkgs.hermit}/share/fonts/opentype/Hermit-Bold.otf -o $out/Hermit-Bold.woff2
      fonttools ttLib.woff2 compress ${pkgs.open-dyslexic}/share/fonts/opentype/OpenDyslexic-Bold.otf -o $out/OpenDyslexic-Bold.woff2
    '';
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
          (style (raw {inherit fonts;} ({fonts}:
            # css
            ''
              @font-face {
                font-family: "Hermit Bold";
                src: url("${fonts}/Hermit-Bold.woff2") format("woff2");
              }
              @font-face {
                font-family: "OpenDyslexic Bold";
                src: url("${fonts}/OpenDyslexic-Bold.woff2") format("woff2");
              }
            '')))
        ])
        (body {class = ["bg-black" "text-white" "grid" "grid-flow-rows"];} [
          (config.users.mightyiam.username
            |> lib.stringToCharacters
            |> map span
            |> div {
              class = [
                "grid"
                "grid-flow-col"
                "auto-cols-fr"
                "justify-items-center"
                "font-[Hermit_Bold]"
                "text-[10vw]"
              ];
            })
          (config.users.mightyiam.name
            |> lib.stringToCharacters
            |> map (c:
              if c == " "
              then raw "&nbsp;"
              else c)
            |> map span
            |> div {
              class = [
                "grid"
                "grid-flow-col"
                "auto-cols-min-content"
                "justify-evenly"
                "font-[OpenDyslexic_Bold]"
                "text-[6vw]"
              ];
            })
        ])
      ]
      |> document;
  };
}
