{
  lib,
  config,
  ...
}: {
  options.mpd.enable = lib.mkEnableOption "Installs and configures mpd";

  config = lib.mkIf config.mpd.enable {
    services.mpd = {
      enable = true;

      dataDir = "${config.home.homeDirectory}/.mpd";

      network = {
        listenAddress = "127.0.0.1";
        port = 6600;
      };

      extraConfig = ''
        restore_paused "yes"
        auto_update	"yes"
        follow_outside_symlinks	"yes"

        input {
          plugin "curl"
        }

        audio_output {
          type            "pipewire"
          name            "PipeWire Sound Server"
        }

        volume_normalization		"yes"
        filesystem_charset		"UTF-8"
      '';
    };

    services.mpdris2 = {
      enable = true;
      multimediaKeys = true;
      notifications = false;
    };
  };
}
