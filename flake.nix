{
  description = "NixOS-WSL configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }:
    let
      inherit (nixpkgs.lib) nixosSystem genAttrs replaceStrings;
      inherit (nixpkgs.lib.filesystem) listFilesRecursive;

      system = "x86_64-linux";

      nameOf = path: replaceStrings [ ".nix" ] [ "" ] (baseNameOf (toString path));
    in
    {
      nixosModules = genAttrs (map nameOf (listFilesRecursive ./modules)) (
        name: import ./modules/${name}.nix
      );

      homeModules = genAttrs (map nameOf (listFilesRecursive ./home)) (name: import ./home/${name}.nix);

      nixosConfigurations = {
        home-wsl = nixosSystem {
          inherit system;

          specialArgs = {
            nix-config = self;
            inherit inputs;
          };

          modules = [
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
          ]
          ++ listFilesRecursive ./hosts/home-wsl;
        };
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
