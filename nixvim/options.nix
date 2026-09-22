{
  programs.nixvim = {
    enable = true;
    colorschemes.nightfox.enable = true;
    opts = {
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smarttab = true;
      termguicolors = true;
    };
    globals = {
      editorconfig = false;
    };
  };
}
