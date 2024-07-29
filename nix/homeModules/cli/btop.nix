{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.btop;
in {
  options.btop = {
    enable = mkEnableOption "Enables and configures btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      settings = {
        vim_keys = true;
        rounded_corners = true;
        shown_boxes = "proc cpu mem";
        update_ms = 2000;
        proc_sorting = "cpu lazy";
        proc_tree = true;
        proc_colors = true;
        proc_gradient = false;
        proc_per_core = false;
        proc_mem_bytes = true;
        proc_info_smaps = false;
        show_uptime = true;
        check_temp = true;
        temp_scale = "celsius";
        base_10_sizes = false;
        show_cpu_freq = true;
        background_update = true;
        show_swap = true;
        show_battery = true;
      };
    };
  };
}
