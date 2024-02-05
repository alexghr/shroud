{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }: {
    mkLib = { nargo, pkgs }: {
      buildNoirPackage = pkgs.callPackage ./buildNoirPackage.nix { inherit nargo; };
    };
  };
}
