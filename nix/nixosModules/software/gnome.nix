{
  lib,
  config,
  pkgs,
  ...
}: {
  options.gnome.enable = lib.mkEnableOption "Enable Gnome Desktop Environment";

  config = lib.mkIf config.gnome.enable {
    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.dconf.enable = true;

    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnome-extension-manager
    ];
  };
}
