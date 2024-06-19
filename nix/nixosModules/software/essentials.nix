{
  lib,
  config,
  pkgs,
  ...
}: {
  options.essentials.enable = lib.mkEnableOption "Installs essential packages";

  config = lib.mkIf config.essentials.enable {
    environment.systemPackages = with pkgs; [
      curl
      file
      git
      htop
      unzip
      wget
      wl-clipboard
    ];
  };
}
