{ inputs, ... }: {
  flake ={
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
