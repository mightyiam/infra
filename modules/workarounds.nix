{
  nixpkgs.overlays = [
    # https://github.com/NixOS/nixpkgs/pull/494547
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (python-final: python-prev: {
          psycopg = python-prev.psycopg.overridePythonAttrs (oldAttrs: {
            disabledTestMarks = oldAttrs.disabledTestMarks ++ [ "slow" ];
          });
        })
      ];
    })
  ];
}
