{ config, lib, ... }: {
  # SOPS configuration for managing encrypted secrets
  sops = {
    # Age key for decryption
    age = {
      keyFile = "/home/spec/.config/sops/age/keys.txt";
      generateKey = true;
    };

    # Define encrypted secrets
    secrets = {
      "hermes-env" = {
        sopsFile = ./hermes.env.age;
      };
    };
  };
}
