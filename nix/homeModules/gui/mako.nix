{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mako;
in {
  options.mako = {
    enable = mkEnableOption "Enables Mako";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      borderRadius = 4;
      borderSize = 4;
      defaultTimeout = 3000;
      ignoreTimeout = true;
      padding = "8";
    };
  };
}
