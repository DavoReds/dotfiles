{
  lib,
  config,
  ...
}: {
  options.alacritty = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    enable = mkEnableOption "Configures Alacritty";
    title = mkOption {
      type = types.str;
      description = "Window title for Alacritty";
      default = "Alacritty";
    };
    windowed = mkOption {
      type = types.bool;
      description = "Whether to start Alacritty as a window";
      default = true;
    };
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      settings = {
        env = {
          TERM = "xterm-256color";
        };

        mouse.hide_when_typing = false;

        window = {
          title = config.alacritty.title;
          decorations =
            if config.alacritty.windowed
            then "Full"
            else "None";
          startup_mode =
            if config.alacritty.windowed
            then "Windowed"
            else "Maximized";
          dynamic_padding = true;
          dynamic_title = false;
        };
      };
    };
  };
}
