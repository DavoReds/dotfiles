{
  lib,
  config,
  pkgs,
  ...
}: {
  options.restic.enable = lib.mkEnableOption "Install restic";

  config = lib.mkIf config.restic.enable {
    home.packages = with pkgs; [
      restic
    ];

    xdg.configFile."restic/includes.txt".source = ../../../restic/includes.txt;
    xdg.configFile."restic/excludes.txt".source = ../../../restic/excludes.txt;
  };
}
