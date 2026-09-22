#lsp servers
{ lib, pkgs, ... }: {
  programs.nixvim.plugins = {
    lsp-format.enable = true;
    lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
          settings =
            let
              flake = ''(builtins.getFlake "github:elythh/flake)""'';
              flakeNixvim = ''(builtins.getFlake "github:elythh/nixvim)""'';
            in
            {
              nixpkgs = {
                expr = "import $(flake).inputs.nixpkgs { }";
              };
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt}" ];
              };
              options = {
                nixos.expr = "${flake}.nixosConfigurations.grovetender.options";
                nixvim.expr = "${flakeNixvim}.packages.${pkgs.stdenv.hostPlatform.system}.default.options";
              };
            };
        };

        yamlls = {
          enable = true;
          settings = {
            schemaStore = {
              enable = false;
              url = "";
            };
          };
        };

        gopls = {
          enable = true;
          autostart = true;
        };

        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };

        #python
        pyright.enable = true;

        #html and css
        html.enable = true;
        cssls.enable = true;

        #docker
        dockerls.enable = true;

        #bash
        bashls.enable = true;

        #c/c++
        clangd.enable = true;

        #ts/js
        ts_ls.enable = true;
      };
    };

  };
}
