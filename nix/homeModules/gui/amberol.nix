{
  lib,
  config,
  ...
}: {
  options.amberol.enable = lib.mkEnableOption "Install Amberol";

  config = lib.mkIf config.amberol.enable {
    services.amberol = {
      enable = true;
      enableRecoloring = true;
    };
  };
}
