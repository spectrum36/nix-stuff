# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  sshKey = "/home/spec/.ssh/sharkey67";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_7_1;
  boot.supportedFilesystems = [ "nfs" ];
  programs.nix-ld.enable = true;

  #temp settings to build cuda
  swapDevices = [{
    device = "/swap";
    size = 32 * 1024;
  }];
  nix.settings = {
    cores = 8;
    max-jobs = 6;
  };

  networking.hostName = "nix-nexus"; # Define your hostname.
  networking.firewall = {
    enable = true;
    extraCommands = ''
      iptables -A nixos-fw -p udp -d 224.0.0.0/4 -j nixos-fw-accept
      ipdables -A nixos-fw -p udp -s 224.0.0.0/4 -j nixos-fw-accept
    '';
    allowedTCPPorts = [ 80 443 8080 8000 5000 5001 ];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.ly = {
    enable =  true;
  };
  services.desktopManager.plasma6.enable = true;
  
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."spec" = {
    isNormalUser = true;
    description = "spec";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  
  #shell config
  users.extraUsers.spec = {
    shell = pkgs.fish;
  };
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;
  nixpkgs.config.cudaCapabilities = [ "12.0" ];
  
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    htop
    freshfetch
    grimblast
    steam
    discord
    oh-my-fish
    zsh
    wget
    gh
    freshfetch
    fuzzel
    pcmanfm
    grim
    hyprpaper
    kitty
    noctalia-shell
    mako
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    slurp
    lshw
    feishin
    easyeffects
    python314
    prismlauncher
    python314Packages.huggingface-hub
    docker
    docker-compose
    tmux
    #koboldcpp
    (pkgs.llama-cpp.override { cudaSupport = true; })
    vlc
    libX11
  ];

  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
  };
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # nvidia config
  hardware.graphics = { 
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [  
    "nvidia"
  ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; #enable if you get graphical issues
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  #neovim stuff
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  #nerdfonts
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  services.tailscale.enable = true;

  programs.steam = {
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  #fish config
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      alias update="sudo nixos-rebuild switch"
      alias upgrade="sudo nixos-rebuild switch --upgrade"
      alias nix-test="sudo nixos-rebuild test"
      alias config="sudo nvim /etc/nixos/configuration.nix";
      alias nomad="/home/spec/Projects/python/nomadnet/.venv/bin/nomadnet"
    '';
  };

  #git stuff
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "spectrum36";
	email = "aidanrm36@gmail.com";
      };
    init.defaultBranch = "main";
    };  
  };
  
  #xdg config for discord screenshare
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.hyprland ];
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.noisetorch.enable = true;

  #easyeffects stuff
  programs.dconf.enable = true;
  systemd.user.services.easyeffects = {
    enable = false;
    description = "easyeffects";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects -w";
      Restart = "on-failure";
    };
  };


  #ssh config

  programs.ssh = {
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

      Host cluster-node
        Hostname cluster-node
        User spec
        IdentityFile ${sshKey}
    '';
  };
  
  #nfs stuff
  fileSystems."/home/spec/servers/zero-node" = {
    device = "zero-node:/home/spec";
    fsType = "nfs";
  };
  fileSystems."/home/spec/servers/nix-node" = {
    device = "nix-node:/home/spec";
    fsType = "nfs";
  };
  fileSystems."/home/spec/servers/cluster-node" = {
    device = "cluster-node:/home/spec";
    fsType = "nfs";
  };
  
  #local ai stuff
  services.ollama = {
    enable = false;
    package = pkgs.ollama-cuda;
    host = "0.0.0.0";
  };
  
  #enable docker service
  virtualisation.docker.enable = true;

  #obs
  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-gstreamer
      obs-backgroundremoval
    ];
  };
}
