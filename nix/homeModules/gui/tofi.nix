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
    stylix.targets.tofi.enable = true;

    programs.tofi = {
      enable = true;

      settings = {
        hint-font = false;

        border-width = 4;
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
