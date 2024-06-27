{
  config,
  pkgs,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Identity
  home.username = "dalia";
  home.homeDirectory = "/home/dalia";

  # Environment stuff
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];
  home.shellAliases = {
    docker-compose = "podman-compose";
    pj = "pijul";
    speedtest = "speedtest-go";
    t = "tasker-cli";
  };

  # Unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Theming
  defaultStylix.enable = true;
  stylix.targets = {
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "peach";
      };
      name = "Papirus-Dark";
    };
  };
  qtConfig.enable = true;

  # Hyprland stuff
  hyprland = {
    enable = true;
    monitors = [
      {
        name = "eDP-1";
        width = 1366;
        height = 768;
        refreshRate = 60;
        x = 1920;
        y = 0;
        scale = 1;
        enabled = true;
      }

      {
        name = "HDMI-A-1";
        width = 1920;
        height = 1080;
        refreshRate = 60;
        x = 0;
        y = 0;
        scale = 1;
        enabled = true;
      }
    ];
  };
  mako.enable = true;
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "/home/dalia/Imágenes/Fondos/feet-on-the-dashboard.png"
        "/home/dalia/Imágenes/Fondos/evening-sky.png"
      ];

      wallpaper = [
        "eDP-1,/home/dalia/Imágenes/Fondos/feet-on-the-dashboard.png"
        "HDMI-A-1,/home/dalia/Imágenes/Fondos/evening-sky.png"
      ];
    };
  };
  tofi.enable = true;
  waybar = {
    enable = true;
    battery = "BAT0";
    monitor = {
      name = "eDP-1";
      width = 1366;
    };
  };
  cliphist.enable = true;
  swappy.enable = true;
  swaylock.enable = true;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "swaylock";
        before_sleep_cmd = "swaylock";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 330;
          on-timeout = "pidof swaylock || swaylock";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # Allow home-manager to configure XDG directories
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/Escritorio";
      documents = "${config.home.homeDirectory}/Documentos";
      download = "${config.home.homeDirectory}/Descargas";
      music = "${config.home.homeDirectory}/Música";
      pictures = "${config.home.homeDirectory}/Imágenes";
      publicShare = "${config.home.homeDirectory}/Público";
      templates = "${config.home.homeDirectory}/Plantillas";
      videos = "${config.home.homeDirectory}/Vídeos";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["zathura.desktop"];
      };
    };
  };

  # Development tools
  fzf.enable = true;
  git = {
    enable = true;
    user = "Dalia Rojas Vallejo";
    email = "daliarojasvallejo@proton.me";
  };
  helix.enable = true;
  jujutsu = {
    enable = true;
    user = "Dalia Rojas Vallejo";
    email = "daliarojasvallejo@proton.me";
    delta = true;
  };
  just.enable = true;
  lazygit.enable = true;
  neovim = {
    enable = true;
    defaultEditor = true;
  };
  remmina.enable = true;
  sqlite.enable = true;
  starship.enable = true;
  tasker.enable = true;
  tmux.enable = true;
  topgrade.enable = true;
  zoxide.enable = true;
  zsh = {
    enable = true;
    eza = true;
    suggestions = true;
    plugins = [
      "colored-man-pages"
      "cp"
      "fancy-ctrl-z"
      "pass"
      "perms"
      "safe-paste"
      "vi-mode"
      "sudo"
    ];
  };

  # General CLI aplications
  bat.enable = true;
  btop.enable = true;
  eza.enable = true;
  programs.fastfetch.enable = true;
  programs.fd.enable = true;
  mpd.enable = true;
  ncmpcpp.enable = true;
  ncspot.enable = true;
  pass = {
    enable = true;
    wayland = true;
  };
  restic.enable = true;
  yazi.enable = true;

  # General GUI applications
  kitty.enable = true;
  mpv.enable = true;
  programs.kodi.enable = true;
  zathura.enable = true;

  # Extra stuff
  home.packages = with pkgs; [
    age
    bleachbit
    calibre
    discord
    du-dust
    gimp
    git-crypt
    heroic
    imv
    kondo
    krita
    newsflash
    nodejs
    obsidian
    onlyoffice-bin_latest
    ouch
    overskride
    parallel
    pavucontrol
    pijul
    rclone
    ripgrep
    speedtest-go
    tealdeer
    tokei
    ymuse
  ];
}
