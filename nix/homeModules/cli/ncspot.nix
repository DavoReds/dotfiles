{
  lib,
  config,
  pkgs,
  ...
}: {
  options.ncspot.enable = lib.mkEnableOption "Enables and configures ncspot";

  config = lib.mkIf config.ncspot.enable {
    programs.ncspot = {
      enable = true;
      package = pkgs.ncspot;
      settings = {
        use_nerdfont = true;
        volnorm = true;
        default_keybindings = true;

        theme = {
          background = "default";
          primary = "#cdd6f4";
          secondary = "#bac2de";
          title = "#cba6f7";
          playing = "#cba6f7";
          playing_selected = "#000000";
          playing_bg = "default";
          highlight = "#000000";
          highlight_bg = "#a6e3a1";
          error = "black";
          error_bg = "#f38ba8";
          statusbar = "#191414";
          statusbar_progress = "#cba6f7";
          statusbar_bg = "#cba6f7";
          cmdline = "#cdd6f4";
          cmdline_bg = "#191414";
          search_match = "#f38ba8";
        };
      };
    };
  };
}
