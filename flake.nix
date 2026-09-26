{
  description = "Workstation-Server: server daemons + felix (normal) + gaming user";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    ...
  } @ inputs: let
    mkHost = hostname: extraModules:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit inputs;};
              home-manager.backupFileExtension = "bak";
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations."Workstation-Server" = mkHost "workstation-server" [];
    nixosConfigurations."Laptop" = mkHost "laptop" [
      disko.nixosModules.disko
      ./hosts/laptop/disko.nix
    ];
  };
}
