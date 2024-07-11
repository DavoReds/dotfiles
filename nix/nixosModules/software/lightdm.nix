{
  lib,
  config,
  ...
}: {
  options.lightdm.enable = lib.mkEnableOption "Enable lightdm";

  config = lib.mkIf config.lightdm.enable {
    services.xserver.displayManager.lightdm.enable = true;
  };
}
