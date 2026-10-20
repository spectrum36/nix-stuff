let
  sshKey = "/home/spec/.ssh/sharkey67";
in
{
  #ssh config
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host zero-node
        Hostname zero-node
        User spec
        IdentityFile ${sshKey}

      Host shark-node
        Hostname shark-node
        User spec
        IdentityFile ${sshKey}

      Host nix-node
        Hostname nix-node
        User spec
        IdentityFile ${sshKey}

      Host torment-node
        Hostname torment-node
        User spec
        IdentityFile ${sshKey}
    '';
  };
}
