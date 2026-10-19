{ config, pkgs, lib, hermes-agent, hermesSopsPath, ... }: {
  imports = [
    hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent.enable = true;

  services.hermes-agent = {
    enable = true;
    gateway.enable = true;
    environmentFiles = [ hermesSopsPath ];
    backend.mode = "dashboard";
    backend.port = 9119;
    settings = {
      model.default = "qwen3.6-35b-a3b";
      model.base_url = "http://localhost:8080/v1";
    };
  };
}
