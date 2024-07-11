{
  lib,
  config,
  pkgs,
  ...
}: {
  options.sqlite.enable = lib.mkEnableOption "Install sqlite";

  config = lib.mkIf config.sqlite.enable {
    home.packages = with pkgs; [
      sqlite
    ];

    home.file.".sqliterc".source = ../../../home/.sqliterc;
  };
}
