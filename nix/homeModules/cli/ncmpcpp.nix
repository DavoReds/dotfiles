{
  lib,
  config,
  ...
}: {
  options.ncmpcpp.enable = lib.mkEnableOption "Installs and configures ncmpcpp";

  config = lib.mkIf config.ncmpcpp.enable {
    programs.ncmpcpp = {
      enable = true;

      settings = {
        ncmpcpp_directory = "~/.config/ncmpcpp";
        lyrics_directory = "~/.lyrics";
        mpd_host = "127.0.0.1";
        mpd_port = 6600;
      };
    };
  };
}
