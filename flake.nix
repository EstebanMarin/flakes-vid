{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsveryold.url = "github:nixos/nixpkgs?ref=nixos-21.11";
  };

  outputs = { self, nixpkgs, nixpkgsveryold }: 

  let
    pkgs = nixpkgs.legacyPackages;
    pkgsold = nixpkgsveryold.legacyPackages;
  in {
    # Define packages
    packages = {
      aarch64-darwin = pkgs.aarch64-darwin.hello;
    };

    # Default package for 'nix run'
    defaultPackage = {
      aarch64-darwin = pkgs.aarch64-darwin.hello;
    };

    # Development shells
    devShells = {
      aarch64-darwin = pkgs.aarch64-darwin.mkShell {
        buildInputs = [ pkgs.neovim pkgsold.vim];
      };
    };
  };
}
