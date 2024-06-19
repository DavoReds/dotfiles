{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cliphist;
in {
  options.cliphist.enable = mkEnableOption "Enables cliphist";

  config = mkIf cfg.enable {
    services.cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}
