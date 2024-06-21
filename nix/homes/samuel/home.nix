{config, ...}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Identity
  home.username = "samuel";
  home.homeDirectory = "/home/samuel";

  # Environment stuff
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  home.shellAliases = {
    speedtest = "speedtest-go";
  };

  # Unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Theming

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
  };

  # Development tools
  alacritty = {
    enable = true;

    font = {
      size = 13.0;
      family = "JetBrainsMono NF";
      style = "Regular";
    };

    window = {
      title = "Alacritty";
      windowed = false;
      opacity = 1.0;
    };
  };
  fzf.enable = true;
  git = {
    enable = true;
    user = "Samuel David Rojas Vallejo";
    email = "samueldavidrojasvallejo@gmail.com";
  };
  jujutsu = {
    enable = true;
    user = "Samuel David Rojas Vallejo";
    email = "samueldavidrojasvallejo@gmail.com";
  };
  sqlite.enable = true;
  tmux.enable = true;
  zoxide.enable = true;
  zsh = {
    enable = true;
    eza = true;
    theme = "eastwood";
    plugins = [
      "cp"
      "gitfast"
      "perms"
      "safe-paste"
      "sudo"
    ];
  };

  # General CLI aplications
  bat.enable = true;
  eza.enable = true;
  lf.enable = true;
  restic.enable = true;
}
