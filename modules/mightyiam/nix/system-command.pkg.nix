{writeShellScriptBin}:
writeShellScriptBin "system" "nix-instantiate --eval --expr builtins.currentSystem --raw"
