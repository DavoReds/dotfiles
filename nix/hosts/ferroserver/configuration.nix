{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader
  grub = {
    enable = true;
    device = "/dev/sda";
  };

  # Login manager
  lightdm.enable = true;

  # Desktop environment
  xfce.enable = true;

  # Desktop Portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    config = {
      common = {
        default = ["gtk"];
      };
    };
  };

  # Audio
  audio.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Hostname
  networking.hostName = "ferroserver";

  # Static IP
  networking = {
    defaultGateway = "192.168.1.1";
    nameservers = ["192.168.1.1"];
    interfaces.enp2s0 = {
      ipv4.addresses = [
        {
          address = "192.168.1.18";
          prefixLength = 24;
        }
      ];
    };
  };

  # Firewall
  networking.firewall.enable = true;

  # DNS over TLS
  nextdns = {
    enable = true;
    endpoint = import ../../nixosModules/secrets/ferroserver-endpoint.nix;
  };

  # OpenSSH
  openssh.enable = true;

  # RDP
  rdp = {
    enable = true;
    defaultSession = "xfce4-session";
  };

  # Printing
  printer = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      epson_201207w
    ];
  };

  # User accounts
  users.users.jofero = {
    isNormalUser = true;
    description = "José Fernando Rojas Padilla";
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$6$zEs3NI43EuOAFDPy$lUQsz/R8y2P2B6VeCnlcfDcSBcxTYi0xe0KmBqAYh5SESCkxeLvzCz1Lie1wAE76SubuplEIVHEjbtUjFsv9z0";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/zf4ZDZcBddykfGY4Ygl51GyAqRAxUWSzsF5kAH1Wm daliarojasvallejo@proton.me"];
  };

  users.users.samuel = {
    isNormalUser = true;
    description = "Samuel David Rojas Vallejo";
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$6$qAL2fBLScfBt94QR$XtMJz16I9vFiMz66Zlan2uhybf1toI1nI6tzTwM1ORe821wwfvRUgb5pqLUn.bdrTwZLlEARTrQLzAyn7sf5w1";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/zf4ZDZcBddykfGY4Ygl51GyAqRAxUWSzsF5kAH1Wm daliarojasvallejo@proton.me"];
  };

  # Colombian Locale
  locale.enable = true;

  # GPG
  gpg.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Other packages
  environment.systemPackages = with pkgs; [
    curl
    docker-compose
    ffmpeg-full
    file
    firefox
    git-crypt
    htop
    python3
    unzip
    vim
    vlc
    wget
  ];

  # Flatpak
  services.flatpak.enable = true;

  # NH
  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/samuel/dotfiles/nix";
  };

  # Docker
  docker.enable = true;

  users.extraGroups.docker.members = ["jofero" "samuel"];

  # Zsh integration
  programs.zsh.enable = true;

  # Run dynamically linked binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # NVIDIA
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;

    packages = with pkgs; [
      lato
      noto-fonts

      # Nerd fonts
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };

  system.stateVersion = "24.11";
}
