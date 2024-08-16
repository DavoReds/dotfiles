{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.wine;
in {
  options.wine = {
    enable = mkEnableOption "Installs Wine";
    wayland = mkOption {
      type = types.bool;
      description = "Install with unstable Wayland support";
      default = false;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (
        if cfg.wayland
        then wineWowPackages.waylandFull
        else wineWowPackages.stableFull
      )
    ];
  };
}
