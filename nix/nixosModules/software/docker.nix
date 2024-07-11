{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.docker;
in {
  options.docker = {
    enable = mkEnableOption "Enables Docker";

    users = mkOption {
      type = types.listOf types.str;
      description = "Users to put into the Docker group";
      default = [];
    };

    nvidia = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    virtualisation = {
      containers.enable = true;
      docker = {
        enable = true;
        extraOptions = "--experimental";
        storageDriver = "overlay2";
        autoPrune.enable = true;
        enableOnBoot = true;
        enableNvidia = cfg.nvidia;
      };
    };

    systemd.enableUnifiedCgroupHierarchy = mkIf cfg.nvidia false;

    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    users.extraGroups.docker.members = cfg.users;
  };
}
