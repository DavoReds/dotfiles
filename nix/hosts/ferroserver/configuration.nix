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
  networking.firewall = {
    enable = true;
  };

  # DNS over TLS
  nextdns = {
    enable = true;
    endpoint = import ../../nixosModules/secrets/ferroserver-endpoint.nix;
  };

  # OpenSSH
  openssh.enable = true;

  # Docker
  docker = {
    enable = true;
    nvidia = true;
    users = ["jofero" "samuel"];
  };

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
  nixpkgs.config.nvidia.acceptLicense = true;

  # Essential packages
  essentials.enable = true;

  # Multimedia packages
  multimedia.enable = true;

  # Other packages
  environment.systemPackages = with pkgs; [
    firefox
    vim
  ];

  # NH
  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/shares/public/dotfiles/nix";
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
    };
    packages = with pkgs; [
      noto-fonts

      # Nerd fonts
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
        ];
      })
    ];
  };

  # Zsh integration
  programs.zsh.enable = true;

  # Run dynamically linked binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # NVIDIA
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  };

  # Samba user
  users.groups.smbgroup = {};
  users.users.smbuser = {
    isSystemUser = true;
    group = "smbgroup";
  };

  # Samba share
  services.samba = {
    enable = true;
    package = pkgs.samba4Full;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      server string = Ferro Archivos
      workgroup = FERRO
      security = user
      map to guest = bad user
      name resolve order = bcast host
      guest account = smbuser
    '';
    shares = {
      public = {
        path = "/shares/public";
        public = "yes";
        browseable = "yes";
        writeable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0664";
        "force create mode" = "0664";
        "directory mask" = "0775";
        "force directory mode" = "0775";
        "force user" = "smbuser";
        "force group" = "smbgroup";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  # Emby
  virtualisation.oci-containers = {
    backend = "docker";

    containers.emby = {
      autoStart = true;
      image = "lscr.io/linuxserver/emby:latest";
      environment = {
        PUID = "1001";
        PGID = "100";
        TZ = "America/Bogota";
        NVIDIA_VISIBLE_DEVICES = "all";
        NVIDIA_DRIVER_CAPABILITIES = "compute,utility,video";
      };
      volumes = [
        "/home/samuel/Apps/Emby/config:/config"
        "/home/samuel/Apps/Emby/lib:/opt/vc/lib"
        "/home/samuel/Vídeos:/data"
      ];
      ports = [
        "8096:8096"
        "8920:8920"
      ];
    };
  };

  system.stateVersion = "24.11";
}
