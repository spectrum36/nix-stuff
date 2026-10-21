{
  description = "nixslop and flakeslop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:spectrum36/shark-nixvim";
    septabee.url = "github:Ap6661/septabee-flake";
    sharktasks.url = "github:spectrum36/shark-task";
    opencode.url = "github:anomalyco/opencode/v2.0.9";
    hermes-agent.url = "github:NousResearch/hermes-agent";
    };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    sharktasks,
    opencode,
    sops-nix,
    hermes-agent,
    ...
    }@inputs:
    let
      system = "x86_64-linux";
    in {
    nixosConfigurations.nix-nexus = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.sops-nix.nixosModules.sops
        inputs.hermes-agent.nixosModules.default
        sharktasks.nixosModules.default
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs;
              hermes-agent = inputs.hermes-agent;
            };
            users.spec = import ./home/home.nix;
          };
        }
        { environment.systemPackages = [
            inputs.septabee.packages.${system}.default
            nixvim.packages.${system}.default
            nixvim.packages.${system}.pvim
            inputs.opencode.packages.${system}.default
          ];
        }
      ];
    };
  };
}
