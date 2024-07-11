{
  lib,
  config,
  ...
}: {
  options.grub = {
    enable = lib.mkEnableOption "Enable Grub";
    device = lib.mkOption {
      type = lib.types.str;
      example = "/dev/sda";
    };
  };

  config = lib.mkIf config.grub.enable {
    boot.loader.grub = {
      enable = true;
      device = config.grub.device;
      useOSProber = true;
    };
  };
}
