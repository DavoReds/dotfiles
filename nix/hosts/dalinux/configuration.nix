{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix {device = "/dev/nvme0n1";})
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader
  systemd-boot.enable = true;

  # Login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Desktop environment
  services.desktopManager.cosmic.enable = true;

  # Audio
  audio.enable = true;

  # System76 Optimizations
  system76.enable = true;

  # Gaming
  gaming = {
    enable = true;
    user = "dalia";
    gamescope = true;
    gamemode = true;
  };

  # Fan control
  nbfc.enable = true;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  # Hostname
  networking.hostName = "dalinux";

  # Firewall
  networking.firewall.enable = true;

  # DNS over TLS
  nextdns = {
    enable = true;
    endpoint = import ../../nixosModules/secrets/dalinux-endpoint.nix;
  };

  # Bluetooth
  bluetooth.enable = true;

  # Printing
  printer = {
    enable = true;
    drivers = with pkgs; [
      epson_201207w
    ];
  };

  # User account
  users.users.dalia = {
    isNormalUser = true;
    description = "Dalia Rojas Vallejo";
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$6$v4DJ20T5nZCrzahR$A6fKseLHLyKuSdZj./NmCMh/iygbRKHG4C/afKmZj2MNNlS3/pobIjex8get3OB1SG7pk4.ynzzxOygfDodXE1";
    shell = pkgs.zsh;
  };

  # Colombian Locale
  locale.enable = true;

  # GPG
  gpg.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Other packages
  environment.systemPackages = with pkgs; [
    bottles
    cifs-utils
    curl
    ffmpeg-full
    file
    firefox
    htop
    mkvtoolnix
    mpv
    psmisc
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
    flake = "/home/dalia/dotfiles";
  };

  # Zsh integration
  programs.zsh.enable = true;

  # Run dynamically linked binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # Environment variables
  environment.sessionVariables = {
    # Get Chromium stuff to run on Wayland
    NIXOS_OZONE_WL = "1";
  };

  # Podman
  podman.enable = true;

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      iosevka-comfy.comfy
      libertinus
      noto-fonts
      poppins

      (nerdfonts.override {
        fonts = [
          "IosevkaTerm"
        ];
      })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["IosevkaTerm Nerd Font"];
        sansSerif = ["Iosevka Comfy" "Noto Sans"];
        serif = ["Noto Serif"];
      };
    };
  };

  system.stateVersion = "24.11";
}
