{ config, pkgs, ... }: {
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  home.file.".config/fuzzel" = {
    source = ./fuzzel;
  };
  home.file.".config/hypr" = {
    source = ./hypr;
  };
  home.file.".config/kitty" = {
    source = ./kitty;
  };
  imports = [
    ./hermes.nix
  ];
}
