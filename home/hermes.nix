{ config, pkgs, lib, hermes-agent, hermesSopsPath, ... }:
{  
  imports = [
    hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent.enable = true;

  services.hermes-agent = {
    enable = true;
    gateway.enable = true;
    environmentFiles = [ hermesSopsPath ];

    extraPackages = [ pkgs.mcp-nixos ];

    mcpServers = {
      nixos = {
        command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      };
    };

    settings = {
      model = {
        default = "qwen3.6-35b-a3b";
        base_url = "http://localhost:8080/v1";
        supports_vision = true;
      }; 
      toolsets = [
        "vision"
      ];
      agent.image_input_mode = "native";
      web.search_backend = "searxng";
      web.extract_backend = "firecrawl";
    };
  };
}
