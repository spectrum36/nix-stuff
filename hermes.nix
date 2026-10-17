{ config, pkgs, ... }: {
  services.hermes-agent = {
    enable = true;
    settings.model = {
      default = "qwen3.6-35b-a3b";
      base_url = "http://127.0.0.1:8080/v1";
    };
    # Path to the .env file with env vars for the agent
    environmentFiles = [ config.sops.secrets."hermes-env".path ];
    addToSystemPackages = true;
  };
}
