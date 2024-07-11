{
  lib,
  config,
  ...
}: {
  options.gdm.enable = lib.mkEnableOption "Enable GDM";

  config = lib.mkIf config.gdm.enable {
    services.xserver.displayManager.gdm.enable = true;
  };
}
