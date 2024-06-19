{
  lib,
  config,
  pkgs,
  ...
}: {
  options.ymuse.enable = lib.mkEnableOption "Install ymuse";

  config = lib.mkIf config.ymuse.enable {
    home.packages = with pkgs; [
      ymuse
    ];
  };
}
