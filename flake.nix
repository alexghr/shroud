{
  description = "A tool for building Noir applications with Nix";

  inputs = {};

  outputs = { ... }: {
    mkLib = { nargo, pkgs }: {
      buildNoirPackage = pkgs.callPackage ./buildNoirPackage.nix { inherit nargo; };
    };
  };
}
