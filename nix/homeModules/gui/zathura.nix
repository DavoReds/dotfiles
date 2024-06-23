{
  lib,
  config,
  pkgs,
  ...
}: {
  options.zathura.enable = lib.mkEnableOption "Enables and configures Zathura";

  config = lib.mkIf config.zathura.enable {
    stylix.targets.zathura.enable = true;

    programs.zathura = {
      enable = true;
      package = pkgs.zathura;

      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        T = "toggle_page_mode";
        J = "scroll full-down";
        K = "scroll full-up";
        r = "reload";
        R = "rotate";
        A = "zoom in";
        D = "zoom out";
        i = "recolor";
        p = "print";
        b = "toggle_statusbar";
      };

      options = {
        adjust-open = "best-fit";
        sandbox = "none";
        selection-clipboard = "clipboard";
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 0;
        font = "Iosevka Comfy";
      };
    };
  };
}
