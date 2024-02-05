# Shroud

This is a tool to build Noir programs from Nix. This is not feature complete, right now it can only be used to build isolated Noir programs. Programs with dependencies have not been tested and there's no workspace support.

## Example

Here's how you'd use it inside flake.nix:

```nix
# flake.nix

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    shroud.url = "github:alexghr/shroud";
    noir.url = "github:noir-lang/noir/v0.22.0";
  };

  outputs = { nixpkgs, shroud }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      nargo = noir.packages.${system}.nargo;
      shroudLib = shroud.mkLib { inherit pkgs nargo; };
    in
      {
        packages.${system}.my_circuit = shroudLib.buildNoirPackage {
          name = "my_circuit";
          src = ./.;
          sha256 = pkgs.lib.fakeSha256;
        };
      };
}
```

Building with `nix build .#my_circuit` would make the JSON artifact available as in `./result`.
