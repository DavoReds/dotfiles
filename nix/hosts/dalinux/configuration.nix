{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    (import ./disko.nix {device = "/dev/nvme0n1";})
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Bootloader
  systemd-boot.enable = true;

  # Login manager
  sddm.enable = true;

  # Window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Audio
  audio.enable = true;

  # System76 modules
  system76.enable = true;

  # Gaming
  ## AMD Drivers
  services.xserver.videoDrivers = ["amdgpu"];

  gaming = {
    enable = true;
    user = "dalia";
    gamescope = true;
    gamemode = true;
  };

  # Fan control
  nbfc.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

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
      gutenprint
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
    flake = "/home/dalia/dotfiles/nix";
  };

  # Thunar
  thunar.enable = true;

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

  # Stylix
  defaultStylix.enable = true;
  stylix = {
    homeManagerIntegration = {
      autoImport = false;
      followSystem = false;
    };

    targets = {
      gtk.enable = true;
      nixos-icons.enable = true;
    };
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;

    packages = with pkgs; [
      lato
      noto-fonts

      (nerdfonts.override {
        fonts = [
          "IosevkaTerm"
          "JetBrainsMono"
          "ZedMono"
        ];
      })
    ];
  };

  system.stateVersion = "24.11";
}
