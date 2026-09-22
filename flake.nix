{
  description = "nixslop and flakeslop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:spectrum36/shark-nixvim";
    };

    #septabee.url = "github:Ap6661/septabee-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nix-nexus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.spec = import ./home/home.nix;
          }
          #{ environment.systemPackages = [ inputs.septabee.packages.x86_64-linux.default ]; }
          { environment.systemPackages = [ nixvim.packages.${system}.default ]; }
        ];
      };
    };
}
