{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.swaylock;
in {
  options.swaylock = {
    enable = mkEnableOption "Enables and configures Swaylock";
  };

  config = mkIf cfg.enable {
    stylix.targets.swaylock = {
      enable = true;
      useImage = true;
    };

    programs.swaylock = {
      enable = true;

      settings = {
        font = "Iosevka Comfy";
        font-size = 14;
      };
    };
  };
}
