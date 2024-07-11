{
  lib,
  config,
  pkgs,
  ...
}: {
  options.gnomeExtensions.enable = lib.mkEnableOption "Enables useful extensions";

  config = lib.mkIf config.gnomeExtensions.enable {
    programs.gnome-shell = {
      enable = true;

      extensions = with pkgs.gnomeExtensions; [
        {
          package = appindicator;
        }
        {
          package = clipboard-history;
        }
        {
          package = removable-drive-menu;
        }
        {
          package = forge;
        }
      ];
    };
  };
}
