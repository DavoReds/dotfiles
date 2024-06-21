{
  lib,
  config,
  ...
}: {
  options.alacritty = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    enable = mkEnableOption "Configures Alacritty";

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
        };
      };
    };
  };

  config = lib.mkIf config.alacritty.enable {
    stylix.targets.alacritty.enable = true;

    programs.alacritty = {
      enable = true;

      settings = {
        env = {
          TERM = "xterm-256color";
        };

        mouse.hide_when_typing = false;

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
          dynamic_padding = true;
          dynamic_title = false;
        };
      };
    };
  };
}
