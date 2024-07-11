{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.autoLogin;
in {
  options.autoLogin = {
    enable = mkEnableOption "Enables autoLogin";
    session = mkOption {
      type = types.str;
      description = "Session name";
      example = "xfce";
    };
    user = mkOption {
      type = types.str;
      description = "What user to login as";
      example = "username";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager = {
      defaultSession = mkIf cfg.enable cfg.session;

      autoLogin = mkIf cfg.enable {
        enable = cfg.enable;
        user = cfg.user;
      };
    };
  };
}
