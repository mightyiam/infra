mkTarget:
{
  lib,
  options,
  ...
}:
mkTarget {
  name = "nixvim";
  humanName = "NixVim";
  extraOptions = {
    plugin = lib.mkOption {
      # Update enum with pluginConfigs below
      type = lib.types.enum [
        "base16-nvim"
        "mini.base16"
      ];
      default = "mini.base16";
      description = "Plugin used for the colorscheme";
    };
    transparentBackground = {
      main = lib.mkEnableOption "background transparency for the main NeoVim window";
      signColumn = lib.mkEnableOption "background transparency for the NeoVim sign column";
      numberLine = lib.mkEnableOption "background transparency for the NeoVim number/relativenumber column";
    };

    exportedModule = lib.mkOption {
      type = lib.types.attrs;
      description = ''
        Theming configuration which can be merged with your own. See
        [Standalone Mode](#standalone-mode) documentation.
      '';
      readOnly = true;
    };
  };

  configElements = lib.optionals (options.programs ? nixvim) [
    (
      { cfg, colors }:
      let
        # Maps `stylix.targets.plugin` values to the appropriate nixvim configuration
        pluginConfigs = {
          "base16-nvim" = {
            inherit highlightOverride;

            colorschemes.base16 = {
              enable = true;

              colorscheme = {
                inherit (colors.withHashtag)
                  base00
                  base01
                  base02
                  base03
                  base04
                  base05
                  base06
                  base07
                  base08
                  base09
                  base0A
                  base0B
                  base0C
                  base0D
                  base0E
                  base0F
                  ;
              };
            };
          };
          "mini.base16" = {
            inherit highlightOverride;

            plugins.mini = {
              enable = true;

              modules.base16.palette = {
                inherit (colors.withHashtag)
                  base00
                  base01
                  base02
                  base03
                  base04
                  base05
                  base06
                  base07
                  base08
                  base09
                  base0A
                  base0B
                  base0C
                  base0D
                  base0E
                  base0F
                  ;
              };
            };
          };
        };
        # Transparent is used a few times below
        transparent = {
          bg = "none";
          ctermbg = "none";
        };
        highlightOverride = {
          Normal = lib.mkIf cfg.transparentBackground.main transparent;
          NonText = lib.mkIf cfg.transparentBackground.main transparent;
          SignColumn = lib.mkIf cfg.transparentBackground.signColumn transparent;
          LineNr = lib.mkIf cfg.transparentBackground.numberLine transparent;
          LineNrAbove = lib.mkIf cfg.transparentBackground.numberLine transparent;
          LineNrBelow = lib.mkIf cfg.transparentBackground.numberLine transparent;
        };
      in
      {
        stylix.targets.nixvim.exportedModule.config = pluginConfigs.${cfg.plugin};
      }
    )
    (
      { fonts }:
      {
        stylix.targets.nixvim.exportedModule.config.opts.guifont =
          "${fonts.monospace.name}:h${toString fonts.sizes.terminal}";
      }
    )
    (
      { opacity }:
      {
        stylix.targets.nixvim.exportedModule.imports = [
          (lib.modules.importApply ./neovide-common.nix opacity)
        ];
      }
    )
    (
      { cfg }:
      (lib.optionalAttrs (options.programs ? nixvim) {
        programs.nixvim = cfg.exportedModule;
      })
    )
  ];

  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "nixvim"
        "transparent_bg"
        "main"
      ];
      sinceRelease = 2411;
      to = [
        "stylix"
        "targets"
        "nixvim"
        "transparentBackground"
        "main"
      ];
    })

    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "nixvim"
        "transparent_bg"
        "sign_column"
      ];
      sinceRelease = 2411;

      to = [
        "stylix"
        "targets"
        "nixvim"
        "transparentBackground"
        "signColumn"
      ];
    })
    (
      { config, ... }:
      {
        lib.stylix.nixvim.config = builtins.warn "stylix: `config.lib.stylix.nixvim.config` has been renamed to `config.stylix.targets.nixvim.exportedModule`" config.stylix.targets.nixvim.exportedModule;
      }
    )
  ];
}
