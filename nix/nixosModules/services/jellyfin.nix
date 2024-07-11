{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.jellyfin;
in {
  options.jellyfin = {
    enable = mkEnableOption "Enables Jellyfin";
    group = mkOption {
      type = types.str;
      description = "Group in which to run Jellyfin";
      default = "jellyfin";
    };
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      group = cfg.group;
    };

    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
