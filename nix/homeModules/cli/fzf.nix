{
  lib,
  config,
  ...
}: {
  options.fzf.enable = lib.mkEnableOption "Enables and configures FZF";

  config = lib.mkIf config.fzf.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;

      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

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
