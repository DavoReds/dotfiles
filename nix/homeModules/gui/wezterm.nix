{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.wezterm;
in {
  options.wezterm.enable = mkEnableOption "Configures wezterm";

  config = mkIf cfg.enable {
    stylix.targets.wezterm.enable = true;

    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
