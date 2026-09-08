{ pkgs, ... }: {
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  home.file.".config/nvim" = {
    source = ./nvim;
  };
  home.file.".config/fuzzel" = {
    source = ./fuzzel;
  };
  home.file.".config/hypr" = {
    source = ./hypr;
  };
  home.file.".config/mako" = {
    source = ./mako;
  };
  home.file.".config/waybar" = {
    source = ./waybar;
  };
  home.file.".config/kitty" = {
    source = ./kitty;
  };
}

