{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    shroud.url = "../";
    noir.url = "github:noir-lang/noir/v0.22.0";
    noir.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, shroud, noir, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      nargo = noir.packages.${system}.nargo;
      shroudLib = shroud.mkLib { inherit pkgs nargo; };
    in
      {
        packages.${system}.default = shroudLib.buildNoirPackage {
          name = "test";
          src = ./.;
          # sha256 = pkgs.lib.fakeSha256;
          sha256 = "sha256-d9I2FvAd/VSjTlCXptxc0ZlTzdtHYk8+jqw1XCF5zQ4=";
        };
      };
}
