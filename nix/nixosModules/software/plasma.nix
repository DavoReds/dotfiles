{
  lib,
  config,
  pkgs,
  ...
}: {
  options.plasma.enable = lib.mkEnableOption "Enable KDE Plasma 6";

  config = lib.mkIf config.plasma.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.desktopManager.plasma6.enable = true;

    # Necessary packages
    environment.systemPackages = with pkgs; [
      # QT version of libreoffice
      libreoffice-qt-fresh

      # Catppuccin theme
      (pkgs.catppuccin-kde.override {
        flavor = ["mocha"];
        accents = ["peach"];
        winDecStyles = ["classic"];
      })
    ];

    programs.kdeconnect.enable = true;
  };
}
