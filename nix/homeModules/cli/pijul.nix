{
  lib,
  config,
  pkgs,
  ...
}: {
  options.pijul.enable = lib.mkEnableOption "Configures Pijul";

  config = lib.mkIf config.pijul.enable {
    home.packages = with pkgs; [
      pijul
    ];
  };
}
