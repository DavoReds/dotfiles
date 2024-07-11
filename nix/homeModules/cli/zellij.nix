{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.zellij;
in {
  options.zellij.enable = mkEnableOption "Enables Zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;

      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      settings = {
        copy_command = "wl-copy";
        default_layout = "compact";
        on_force_close = "detach";
        pane_frames = false;
        scroll_buffer_size = 100;
      };
    };
  };
}
