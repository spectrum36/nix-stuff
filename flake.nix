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
    sharktasks.url = "github:spectrum36/shark-task";
    opencode.url = "github:anomalyco/opencode/v2.0.9";
    hermes-agent.url = "github:NousResearch/hermes-agent";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
  };

  outputs = {
    hermes-agent,
    home-manager,
    nixpkgs,
    nixvim,
    opencode,
    self,
    sharktasks,
    sops-nix,
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
          ./llm.nix
          ./mouse.nix
          ./sudoless.nix
          sops-nix.nixosModules.sops
          hermes-agent.nixosModules.default
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
              nixvim.packages.${system}.default
              nixvim.packages.${system}.pvim
              opencode.packages.${system}.default
            ];
          }
      ];
    };
  };
}
