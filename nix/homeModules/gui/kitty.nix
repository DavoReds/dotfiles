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
    programs.kitty = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      shellIntegration = {
        enableZshIntegration = true;
      };

      settings = {
        font_family = "IosevkaTerm Nerd Font";
        font_size = "14.0";

        background_opacity = "0.9";

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
