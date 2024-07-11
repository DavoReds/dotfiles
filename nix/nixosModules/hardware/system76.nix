{
  lib,
  config,
  ...
}: {
  options.system76.enable = lib.mkEnableOption "Enables all System76 services";

  config = lib.mkIf config.system76.enable {
    services.power-profiles-daemon.enable = false;

    hardware.system76.enableAll = true;
    services.system76-scheduler = {
      enable = true;
      settings.cfsProfiles.enable = true;
    };
  };
}
