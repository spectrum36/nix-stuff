{ config, ... }: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        autoload = true;
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;

        grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
          python
          go
        ];
      };

      treesitter-context = {
        enable = true;
        autoload = true;
      };

      treesitter-textobjects = {
        enable = true;
        autoload = true;
        settings = {
          enable = true;
          lookahead = true;
        };
      };
    };
  };
}
