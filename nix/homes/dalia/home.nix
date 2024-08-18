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
  home.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-peach-cursors";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "catppuccin-mocha-peach-cursors";
    HYPRCURSOR_SIZE = "24";
  };
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
  catppuccin.pointerCursor = {
    enable = true;
    accent = "peach";
    flavor = "mocha";
  };
  gtk = {
    enable = true;
    catppuccin = {
      icon = {
        enable = true;
        accent = "peach";
        flavor = "mocha";
      };
    };
  };
  qtConfig.enable = true;

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
        # Documents
        "application/pdf" = "org.pwmt.zathura.desktop";
        "application/epub+zip" = "org.pwmt.zathura.desktop";

        # Office
        "application/msword" = "writer.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";

        "application/vnd.ms-excel" = "calc.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "calc.desktop";
        "text/csv" = "calc.desktop";

        "application/vnd.ms-powerpoint" = "impress.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "impress.desktop";

        # Browser stuff
        "text/html" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";

        # Images
        "image/gif" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/tiff" = "imv.desktop";

        # Video
        "video/avi" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "video/mpeg" = "vlc.desktop";
        "video/ogg" = "vlc.desktop";
        "video/quicktime" = "vlc.desktop";
        "video/webm" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";
        "video/x-motion-jpeg" = "vlc.desktop";

        # Audio
        "audio/mpeg" = "mpv.desktop";
        "audio/mpeg3" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
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
    calibre
    chromium
    discord
    du-dust
    git-crypt
    heroic
    inkscape
    jq
    kondo
    libreoffice-fresh
    obsidian
    ouch
    parallel
    pavucontrol
    pijul
    rclone
    ripgrep
    speedtest-go
    tealdeer
    thunderbird-128
    ticktick
  ];
}
