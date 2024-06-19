{
  lib,
  config,
  pkgs,
  ...
}: {
  options.multimedia.enable = lib.mkEnableOption "Installs multimedia packages";

  config = lib.mkIf config.multimedia.enable {
    environment.systemPackages = with pkgs; [
      ffmpeg-full
      mkvtoolnix
      mpv
      vlc
    ];
  };
}
