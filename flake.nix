{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    let
      # lib = nixpkgs.lib;
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    in
    (flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = (import nixpkgs) { inherit system; config.allowUnfree = true; };
      in
      {
        packages = {
          helloworld = pkgs.callPackage ./pkgs/helloworld { };
          genseki-gothic = pkgs.callPackage ./pkgs/fonts/genseki-gothic { };
          comic-code = pkgs.callPackage ./pkgs/fonts/comic-code { };
          comic-code-ligatures = pkgs.callPackage ./pkgs/fonts/comic-code-ligatures { };
          vt323 = pkgs.callPackage ./pkgs/fonts/vt323 { };
        };
      }));
}
