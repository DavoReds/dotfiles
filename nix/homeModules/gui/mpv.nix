{
  lib,
  config,
  pkgs,
  ...
}: {
  options.mpv.enable = lib.mkEnableOption "Configures MPV";

  config = lib.mkIf config.mpv.enable {
    programs.mpv = {
      enable = true;
      catppuccin.enable = true;

      config = {
        cursor-autohide-fs-only = true;
        cursor-autohide = 1000;
        volume = 70;
        osd-bar = "no";
        border = "no";
      };

      profiles = {
        "1080p" = {
          ytdl-format = "(bestvideo[height<=1080]+bestaudio)[ext=webm]/bestvideo[height<=1080]+bestaudio/best[height<=1080]/bestvideo+bestaudio/best";
        };
        "720p" = {
          ytdl-format = "(bestvideo[height<=720]+bestaudio)[ext=webm]/bestvideo[height<=720]+bestaudio/best[height<=720]/bestvideo+bestaudio/best";
        };
        "480p" = {
          ytdl-format = "(bestvideo[height<=480]+bestaudio)[ext=webm]/bestvideo[height<=480]+bestaudio/best[height<=480]/bestvideo+bestaudio/best";
        };
        "360p" = {
          ytdl-format = "(bestvideo[height<=360]+bestaudio)[ext=webm]/bestvideo[height<=360]+bestaudio/best[height<=360]/bestvideo+bestaudio/best";
        };
      };

      defaultProfiles = ["1080p"];
    };
  };
}
