{
  lib,
  config,
  ...
}: {
  options.rdp = {
    enable = lib.mkEnableOption "Enables RDP";
    defaultSession = lib.mkOption {
      type = lib.types.str;
      example = "xfce4-session";
    };
  };

  config = lib.mkIf config.rdp.enable {
    services.xrdp = {
      enable = true;
      openFirewall = true;
      defaultWindowManager = config.rdp.defaultSession;
    };
  };
}
