{
  lib,
  config,
  pkgs,
  ...
}: {
  options.thunar.enable = lib.mkEnableOption "Installs and configures Thunar";

  config = lib.mkIf config.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    programs.xfconf.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    environment.systemPackages = with pkgs; [
      evince
      ffmpegthumbnailer
      gnome-epub-thumbnailer
      libgsf
      poppler
      webp-pixbuf-loader
    ];
  };
}
