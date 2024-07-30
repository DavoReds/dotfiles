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
    perfPolicyOnAC = mkOption {
      type = types.str;
      example = "performance";
    };
    perfPolicyOnBat = mkOption {
      type = types.str;
      example = "power";
    };
    startCharge = mkOption {
      type = types.int;
      example = 20;
    };
    stopCharge = mkOption {
      type = types.int;
      example = 80;
    };
    hibernateOnBat = mkOption {
      type = types.bool;
      default = false;
    };
    disableDevices = mkOption {
      type = types.str;
      example = "bluetooth wifi wwan";
    };
    enableDevices = mkOption {
      type = types.str;
      example = "bluetooth wifi wwan";
    };
    excludeAudio = mkOption {
      type = types.bool;
      default = true;
    };
    excludeBluetooth = mkOption {
      type = types.bool;
      default = true;
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

    # Enable TLP
    services.tlp = {
      enable = true;
      settings = {
        # Audio
        SOUND_POWER_SAVE_ON_AC = 10;
        SOUND_POWER_SAVE_ON_BAT = 10;
        SOUND_POWER_SAVE_CONTROLLER = "Y";

        # Battery
        START_CHARGE_THRESH_BAT0 = cfg.startCharge;
        STOP_CHARGE_THRESH_BAT0 = cfg.stopCharge;

        # Drive Bay
        BAY_POWEROFF_ON_AC = 0;
        BAY_POWEROFF_ON_BAT = 1;

        # Platform
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        MEM_SLEEP_ON_AC = "s2idle";
        MEM_SLEEP_ON_BAT =
          if cfg.hibernateOnBat
          then "deep"
          else "s2idle";

        # Processor
        CPU_DRIVER_OPMODE_ON_AC = "passive";
        CPU_DRIVER_OPMODE_ON_BAT = "passive";

        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_AC = cfg.perfPolicyOnAC;
        CPU_ENERGY_PERF_POLICY_ON_BAT = cfg.perfPolicyOnBat;

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        # Radio Device Switching
        RESTORE_DEVICE_STATE_ON_STARTUP = 0;
        DEVICES_TO_DISABLE_ON_STARTUP = cfg.disableDevices;
        DEVICES_TO_ENABLE_ON_STARTUP = cfg.enableDevices;
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi wwan";

        # USB
        USB_EXCLUDE_AUDIO =
          if cfg.excludeAudio
          then 1
          else 0;
        USB_EXCLUDE_BTUSB =
          if cfg.excludeBluetooth
          then 1
          else 0;
      };
    };

    # Enable thermald on intel
    services.thermald.enable = cfg.intel;
  };
}
