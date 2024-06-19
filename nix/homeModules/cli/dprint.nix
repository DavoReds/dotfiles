{
  lib,
  config,
  pkgs,
  ...
}: {
  options.dprint.enable = lib.mkEnableOption "Install dprint";

  config = lib.mkIf config.dprint.enable {
    home.packages = with pkgs; [
      dprint
    ];

    home.file.".dprint.json".source = ../../../home/.dprint.json;
  };
}
