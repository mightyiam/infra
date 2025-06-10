{
  files."README.md".parts.named-modules-as-needed =
    # markdown
    ''
      ## Named modules as needed

      > [!NOTE]
      > Named modules are modules under the [`flake.modules`](https://flake.parts/options/flake-parts-modules.html) option.

      I was once tempted to name them with great granularity, as to for example have `flake.modules.nixos.fonts`.
      Such granularity would result in a great number of named modules.
      One cost of such a pattern is that some `imports` lists would be longer than they need to be.
      Another cost is that when a new file is created, some more imports would typically have to be added to some of those lists.

      For example, the `flake.modules.nixos.pc` module would have to import `with config.flake.modules.nixos; [fonts ssh audio <...and many more>]`.
      That's redundant; for one, the flake-parts module file in which for example `flake.modules.nixos.fonts` is defined is at `modules/fonts.nix`.
      Second, all modules that would import the `flake.modules.nixos.fonts` would also import `flake.modules.nixos.audio`.
      The pattern used instead is that `modules/fonts.nix` defines `flake.modules.nixos.pc`.

      So what is the test for whether a certain set of option values deserves a distinct named module?
      It is whether that set of option values is to be imported in some configurations and not in others.
      An example of a set of option values that would deserve a distinct named module is `flake.modules.nixos.laptop`
      because it would be imported by laptop configurations and not by desktop configurations.

    '';
}
