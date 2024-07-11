{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.nextdns;
in {
  options.nextdns = {
    enable = mkEnableOption "Enables NextDNS with systemd-resolved";
    endpoint = mkOption {
      type = types.str;
      description = "Endpoint for NextDNS";
    };
  };

  config = mkIf cfg.enable {
    services.resolved = {
      enable = true;
      extraConfig = ''
        [Resolve]
        DNS=45.90.28.0#${cfg.endpoint}
        DNS=2a07:a8c0::#${cfg.endpoint}
        DNS=45.90.30.0#${cfg.endpoint}
        DNS=2a07:a8c1::#${cfg.endpoint}
        DNSOverTLS=yes
      '';
    };
  };
}
