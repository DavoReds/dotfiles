{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.swappy;
in {
  options.swappy.enable = mkEnableOption "Installs and configures swappy";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swappy
    ];

    xdg.configFile."swappy/config".source = ../../../swappy/config;
  };
}
