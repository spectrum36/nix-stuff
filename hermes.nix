{ config, ... }: {
  services.hermes-agent = {
    enable = true;
    settings.model = {
      default = "qwen3-30b";
      base_url = "http://127.0.0.1:8080/v1";
    };
    environmentFiles = [ config.sops.secrets."hermes-env".path ];
    addToSystemPackages = true;
  };
}
