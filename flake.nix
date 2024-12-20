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
#      x86_64-linux = pkgs.x86_64-linux.hello;
      aarch64-darwin = pkgs.aarch64-darwin.hello;
    };

    # Default package for 'nix run'
    defaultPackage = {
#      x86_64-linux = self.packages.x86_64-linux;
      aarch64-darwin = self.packages.aarch64-darwin;
    };

    # Development shells
    devShells = {
#      x86_64-linux = pkgs.x86_64-linux.mkShell {
#        buildInputs = [ pkgs.x86_64-linux.hello ];
#      };
      aarch64-darwin = pkgs.aarch64-darwin.mkShell {
        buildInputs = [ pkgs.neovim pkgsold.vim];
      };
    };
  };
}
