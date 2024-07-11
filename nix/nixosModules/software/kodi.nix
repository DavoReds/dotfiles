{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.kodi;
in {
  options.kodi = {
    enable = mkEnableOption "Enables Kodi as a session";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.kodi.enable = true;
    };
  };
}
