{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, darwin, home-manager, ... }: {
    darwinConfigurations."macbook" = darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # or x86_64-darwin for Intel
      modules = [
        ./hosts/macbook.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.users.eliaszeiner = import ./home/default.nix;
        }
      ];
    };

    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Adjust for your architecture
      modules = [
        ./hosts/nixos.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.eliaszeiner = import ./home/default.nix;
        }
      ];
    };
  };
}
