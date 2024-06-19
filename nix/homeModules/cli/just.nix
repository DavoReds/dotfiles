{
  lib,
  config,
  pkgs,
  ...
}: {
  options.just.enable = lib.mkEnableOption "Install Just";

  config = lib.mkIf config.just.enable {
    home.packages = with pkgs; [
      just
    ];

    home.file.".justfile".source = ../../../home/.justfile;
  };
}
