{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.imv;
in {
  options.imv.enable = mkEnableOption "Installs and configures imv";

  config = mkIf cfg.enable {
    programs.imv = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
    };
  };
}
