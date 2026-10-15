{
  security.sudo.extraRules = [
    {
      users = [ "spec" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
