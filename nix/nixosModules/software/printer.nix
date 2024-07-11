{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.printer;
in {
  options.printer = {
    enable = mkEnableOption "Enable printer service";
    drivers = mkOption {
      description = "List of printer drivers to install";
      type = types.listOf types.package;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = cfg.drivers;
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
