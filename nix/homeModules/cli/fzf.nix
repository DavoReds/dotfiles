{
  lib,
  config,
  ...
}: {
  options.fzf.enable = lib.mkEnableOption "Enables and configures FZF";

  config = lib.mkIf config.fzf.enable {
    stylix.targets.fzf.enable = true;

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;

      defaultOptions = [
        "--border"
      ];

      changeDirWidgetCommand = "fd --type d";

      changeDirWidgetOptions = [
        "--exact"
        "--preview 'eza --icons'"
      ];
    };
  };
}
