{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgsveryold }: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkgsold = nixpkgsveryold.legacyPackages.x86_64-linux;
  in 
  {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    devShells.x86_64-linux.default = pkgs.mkShell {
    	buildInputs = [pkgs.nvim pkgsold.vim];
    };
  };

}
