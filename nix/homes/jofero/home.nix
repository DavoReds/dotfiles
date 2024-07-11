{
  config,
  pkgs,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Identity
  home.username = "jofero";
  home.homeDirectory = "/home/jofero";

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
  };

  # Development tools
  alacritty.enable = true;
  fzf.enable = true;
  git = {
    enable = true;
    user = "José Fernando Rojas Padilla";
    email = "jrojaspadilla@gmail.com";
  };
  sqlite.enable = true;
  tmux.enable = true;
  zoxide.enable = true;
  zsh = {
    enable = true;
    eza = false;
    theme = "awesomepanda";
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
  btop.enable = true;
  eza.enable = true;
  programs.fastfetch.enable = true;
  programs.fd.enable = true;
  restic.enable = true;
  yazi.enable = true;

  # Extra stuff
  home.packages = with pkgs; [
    du-dust
    jq
    ouch
    parallel
    pijul
    ripgrep
    speedtest-go
    tealdeer
  ];
}
