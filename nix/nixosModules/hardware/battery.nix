{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.battery;
in {
  options.battery = {
    enable = mkEnableOption "Enables battery optimizations";
    intel = mkOption {
      type = types.bool;
      description = "Enables thermald for intel processors";
      default = false;
    };
    charger = mkOption {
      type = types.submodule {
        options = {
          governor = mkOption {
            type = types.str;
            default = "performance";
          };
          epp = mkOption {
            type = types.str;
            default = "performance";
          };
          turbo = mkOption {
            type = types.str;
            default = "auto";
          };
        };
      };
    };
    battery = mkOption {
      type = types.submodule {
        options = {
          governor = mkOption {
            type = types.str;
            default = "powersave";
          };
          epp = mkOption {
            type = types.str;
            default = "power";
          };
          turbo = mkOption {
            type = types.str;
            default = "auto";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # Disable default power-daemon
    services.power-profiles-daemon.enable = false;

    # Enable system76 optimizations
    hardware.system76 = {
      firmware-daemon.enable = true;
      kernel-modules.enable = true;
    };

    # Enable system76 scheduler
    services.system76-scheduler = {
      enable = true;
      settings.cfsProfiles.enable = true;
    };

    # Enable auto-cpufreq
    services.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = cfg.charger.governor;
          energy_performance_preference = cfg.charger.epp;
          turbo = cfg.charger.turbo;
        };
        battery = {
          governor = cfg.battery.governor;
          energy_performance_preference = cfg.battery.epp;
          turbo = cfg.battery.turbo;
        };
      };
    };

    # Enable thermald on intel
    services.thermald.enable = cfg.intel;
  };
}
