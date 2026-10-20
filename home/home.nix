{ config, pkgs, ... }: {
  imports = [
    ./hermes.nix
  ];
  programs.home-manager.enable = true;
  home = {
    stateVersion = "26.05";
    file = { 
      ".config/fuzzel" = {
        source = ./fuzzel;
      };
      ".config/hypr" = {
        source = ./hypr;
      };
      ".config/kitty" = {
        source = ./kitty;
      };
    };
  };
}
