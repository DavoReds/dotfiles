{
  lib,
  config,
  ...
}: {
  options.remmina.enable = lib.mkEnableOption "Install Remmina";

  config = lib.mkIf config.remmina.enable {
    services.remmina = {
      enable = true;
      addRdpMimeTypeAssoc = true;
      systemdService.enable = false;
    };
  };
}
