{
  lib,
  config,
  ...
}: {
  options.locale.enable = lib.mkEnableOption "Enables colombian localization";

  config = lib.mkIf config.locale.enable {
    time.timeZone = "America/Bogota";

    i18n.defaultLocale = "es_CO.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "es_CO.UTF-8";
      LC_IDENTIFICATION = "es_CO.UTF-8";
      LC_MEASUREMENT = "es_CO.UTF-8";
      LC_MONETARY = "es_CO.UTF-8";
      LC_NAME = "es_CO.UTF-8";
      LC_NUMERIC = "es_CO.UTF-8";
      LC_PAPER = "es_CO.UTF-8";
      LC_TELEPHONE = "es_CO.UTF-8";
      LC_TIME = "es_CO.UTF-8";
    };

    services.xserver.xkb = {
      layout = "latam";
      variant = "";
    };

    console.keyMap = "la-latin1";
  };
}
