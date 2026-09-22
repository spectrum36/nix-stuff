{
  programs.nixvim = {
    enable = true;
    colorschemes.nightfox.enable = true;
    globalOpts = {
      tabstop = 2;
      expandtab = true;
    };
  };
}
