{
  lib,
  config,
  ...
}: {
  options.zathura.enable = lib.mkEnableOption "Enables and configures Zathura";

  config = lib.mkIf config.zathura.enable {
    programs.zathura = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

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
        pages-per-row = 1;
        scroll-page-aware = "true";
        scroll-full-overlap = "0.01";
        scroll-step = 100;
        sandbox = "none";
        selection-notification = "false";

        guioptions = "";
        zoom-min = 10;
        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        page-padding = 0;
        font = "Iosevka Comfy";
        recolor-reverse-video = "true";
      };
    };
  };
}
