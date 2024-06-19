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
    programs.swaylock = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      settings = {
        font = "ZedMono Nerd Font";
        font-size = 14;
      };
    };
  };
}
