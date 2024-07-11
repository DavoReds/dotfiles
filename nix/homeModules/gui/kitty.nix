{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.kitty;
in {
  options.kitty.enable = mkEnableOption "Configures Kitty";

  config = mkIf cfg.enable {
    stylix.targets.kitty = {
      enable = true;
      variant256Colors = true;
    };

    programs.kitty = {
      enable = true;
      shellIntegration = {
        enableZshIntegration = true;
      };

      settings = {
        scrollback_lines = 100;

        mouse_hide_wait = -1;
        cursor_blink_interval = 0;

        enable_audio_bell = false;
        window_alert_on_bell = false;

        text_composition_strategy = "platform";

        confirm_os_window_close = 0;
      };
    };
  };
}
