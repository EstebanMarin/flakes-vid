{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = nixpkgs.legacyPackages;
  in {
    # Define packages
    packages = {
      x86_64-linux = pkgs.x86_64-linux.hello;
      aarch64-darwin = pkgs.aarch64-darwin.hello;
    };

    # Default package for 'nix run'
    defaultPackage = {
      x86_64-linux = self.packages.x86_64-linux;
      aarch64-darwin = self.packages.aarch64-darwin;
    };

    # Development shells
    devShells = {
      x86_64-linux = pkgs.x86_64-linux.mkShell {
        buildInputs = [ pkgs.x86_64-linux.hello ];
      };
      aarch64-darwin = pkgs.aarch64-darwin.mkShell {
        buildInputs = [ pkgs.aarch64-darwin.hello ];
      };
    };

    # Define apps
    apps = {
      x86_64-linux = { type = "app"; program = "${self.packages.x86_64-linux}/bin/hello"; };
      aarch64-darwin = { type = "app"; program = "${self.packages.aarch64-darwin}/bin/hello"; };
    };
  };
}
