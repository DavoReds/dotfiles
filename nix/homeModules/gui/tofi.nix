{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.tofi;
in {
  options.tofi.enable = mkEnableOption "Enables and configures tofi";

  config = mkIf cfg.enable {
    programs.tofi = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      settings = {
        font = "Iosevka Comfy";
        font-size = 14;
        hint-font = false;

        # Theme
        width = "50%";
        height = "50%";
        border-width = 4;
        border-color = "#fab387";
        outline-width = 0;
        result-spacing = 4;
        num-results = 8;

        auto-accept-single = false;
        drun-launch = true;
        hide-cursor = true;
        history = true;
        require-match = true;
        text-cursor = true;
      };
    };
  };
}
