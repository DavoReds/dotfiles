{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.yazi;
in {
  options.yazi.enable = mkEnableOption "Enables and configures Yazi";

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      settings = {
        manager = {
          ratio = [1 3 4];
        };
        preview = {
          image_filter = "lanczos3";
          image_quality = 70;
        };
      };
    };
  };
}
