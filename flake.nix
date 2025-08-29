{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      cw = pkgs.callPackage ./class_widgets.nix { };
    in
    {
      packages.x86_64-linux.default = cw;

      apps.default = {
        type = "app";
        program = "${cw}/bin/class_widgets";
      };
    };
}
