{ config, pkgs, lib, hermes-agent, ... }: {
  imports = [
    hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent.enable = true;

  services.hermes-agent = {
    enable = true;
    gateway.enable = true;
    settings = {
      platforms = {
        enable = true;
        token = "MTQ2OTIyMDc0MDQ2NDM4MTk3NA.Gt3-_Y.BhAekM31HhVCtejdJ5sPqEQTrhZ2vnYHWkUVuE";
        allowedUsers = [ "262054257472045056" ];
      };
      model.default = "qwen3.6-35b-a3b";
      model.base_url = "http://localhost:8080/v1";
    };
  };
}
