{
  home.base = {
    programs.starship = {
      enable = true;
      presets = [
        "nerd-font-symbols"
      ];
      settings = {
        add_newline = false;
        ## https://starship.rs/config/#prompt
        format = builtins.concatStringsSep "" [
          "\n"
          "$username"
          "$hostname"
          "$singularity"
          "$kubernetes"
          "$nats"
          "$vcsh"
          "$fossil_branch"
          "$fossil_metrics"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_status"
          "$hg_branch"
          "$hg_state"
          "$pijul_channel"
          "$docker_context"
          "$package"
          "$bun"
          "$c"
          "$cmake"
          "$cobol"
          "$cpp"
          "$daml"
          "$dart"
          "$deno"
          "$direnv"
          "$dotnet"
          "$elixir"
          "$elm"
          "$erlang"
          "$fennel"
          "$fortran"
          "$gleam"
          "$golang"
          "$gradle"
          "$haskell"
          "$haxe"
          "$helm"
          "$java"
          "$julia"
          "$kotlin"
          "$lua"
          "$maven"
          "$mojo"
          "$nim"
          "$nodejs"
          "$ocaml"
          "$odin"
          "$opa"
          "$perl"
          "$php"
          "$pulumi"
          "$purescript"
          "$python"
          "$quarto"
          "$raku"
          "$rlang"
          "$red"
          "$ruby"
          "$rust"
          "$scala"
          "$solidity"
          "$swift"
          "$terraform"
          "$typst"
          "$vlang"
          "$vagrant"
          "$xmake"
          "$zig"
          "$buf"
          "$guix_shell"
          "$nix_shell"
          "$conda"
          "$pixi"
          "$meson"
          "$spack"
          "$memory_usage"
          "$aws"
          "$gcloud"
          "$openstack"
          "$azure"
          "$direnv"
          # TODO how to specify which env_var this is
          "$env_var"
          "$mise"
          "$crystal"
          "$sudo"
          "$cmd_duration"
          "$lua"
          "$jobs"
          "$battery"
          "\n"
          "$directory"
          "\n"
          "$status"
          "$container"
          "$netns"
          "[ $shell](bold)"
          "$shlvl"
          "$character"
        ];
        directory = {
          truncation_length = 0;
          truncate_to_repo = false;
        };
        direnv.disabled = false;
        shell.disabled = false;
        shlvl.disabled = false;
        status.disabled = false;
        username.show_always = true;
      };
    };
  };
}
