{
  lib,
  config,
  ...
}: {
  options.alacritty = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    enable = mkEnableOption "Configures Alacritty";

    font = mkOption {
      description = "Font configuration";
      type = types.submodule {
        options = {
          size = mkOption {
            type = types.float;
            example = 13.0;
          };
          family = mkOption {
            type = types.str;
            example = "JetBrainsMono NF";
          };
          style = mkOption {
            type = types.str;
            default = "Regular";
          };
        };
      };
    };

    window = mkOption {
      description = "Window configuration";
      type = types.submodule {
        options = {
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
          opacity = mkOption {
            type = types.float;
            description = "Floating point number between 0 and 1";
            default = 1.0;
          };
        };
      };
    };
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        env = {
          TERM = "xterm-256color";
        };

        mouse.hide_when_typing = false;

        font = {
          size = config.alacritty.font.size;
          normal.family = config.alacritty.font.family;
          normal.style = config.alacritty.font.style;
        };

        window = {
          title = config.alacritty.window.title;
          decorations =
            if config.alacritty.window.windowed
            then "Full"
            else "None";
          startup_mode =
            if config.alacritty.window.windowed
            then "Windowed"
            else "Maximized";
          opacity = config.alacritty.window.opacity;
          dynamic_padding = true;
          dynamic_title = false;
        };
      };
    };
  };
}
