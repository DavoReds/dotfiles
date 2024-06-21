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
        font-size = 12;
        hint-font = false;

        border-width = 4;
        border-color = "#fab387";
        corner-radius = 4;
        height = "50%";
        width = "50%";

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
