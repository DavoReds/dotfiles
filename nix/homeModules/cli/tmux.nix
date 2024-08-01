{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.tmux;
in {
  options.tmux.enable = mkEnableOption "Configure tmux";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      disableConfirmationPrompt = true;
      escapeTime = 0;
      historyLimit = 1000;
      keyMode = "vi";
      mouse = true;
      prefix = "C-Space";
      terminal = "xterm-256color";

      catppuccin = {
        enable = true;
        flavor = "mocha";

        extraConfig = ''
          set -g @catppuccin_window_status_icon_enable "yes"

          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag, (),}"

          set -g @catppuccin_status_modules_right "directory session"
          set -g @catppuccin_status_modules_left ""

          set -g @catppuccin_directory_text "#{pane_current_path}"
          set -g @catppuccin_directory_icon " "
        '';
      };

      plugins = with pkgs.tmuxPlugins; [
        resurrect
        sensible
        vim-tmux-navigator
        yank
      ];

      extraConfig = ''
        set -g detach-on-destroy off

        set -g allow-passthrough on

        bind -n M-H previous-window
        bind -n M-L next-window

        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind V split-window -v -c "#{pane_current_path}"
        bind H split-window -h -c "#{pane_current_path}"
      '';
    };
  };
}
