{
  lib,
  config,
  ...
}: {
  options.bluetooth.enable = lib.mkEnableOption "Enable Bluetooth";

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
  };
}
