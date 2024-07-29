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
    catppuccin.icon = {
      enable = true;
      accent = "peach";
      flavor = "mocha";
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
        defaultWorkspace = 10;
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
        defaultWorkspace = 1;
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

  # Allow home-manager to configure XDG directories
  home.preferXdgDirectories = true;
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
    difftastic = true;
    user = "Dalia Rojas Vallejo";
    email = "daliarojasvallejo@proton.me";
  };
  helix = {
    enable = true;
    defaultEditor = true;
  };
  jujutsu = {
    enable = true;
    difftastic = true;
    user = "Dalia Rojas Vallejo";
    email = "daliarojasvallejo@proton.me";
  };
  just.enable = true;
  kitty.enable = true;
  lazygit.enable = true;
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
  ncspot.enable = true;
  pass.enable = true;
  restic.enable = true;
  yazi.enable = true;

  # General GUI applications
  imv.enable = true;
  kodi = {
    enable = true;
    wayland = true;
  };
  mpv.enable = true;
  zathura.enable = true;

  # Extra stuff
  home.packages = with pkgs; [
    bleachbit
    discord
    du-dust
    git-crypt
    heroic
    jq
    kondo
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
    thunderbird-128
  ];
}
