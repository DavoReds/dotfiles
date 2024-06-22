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
    stylix.targets.yazi.enable = true;

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
