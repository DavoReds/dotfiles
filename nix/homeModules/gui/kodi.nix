{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.kodi;
in {
  options.kodi = {
    enable = mkEnableOption "Installs Kodi";
    wayland = mkOption {
      type = types.bool;
      description = "Install Kodi with wayland support";
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.kodi = {
      enable = true;
      package =
        if cfg.wayland
        then pkgs.kodi-wayland
        else pkgs.kodi;
    };
  };
}
