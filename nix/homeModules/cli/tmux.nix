{
  lib,
  config,
  pkgs,
  ...
}: {
  options.tmux.enable = lib.mkEnableOption "Configure tmux";

  config = lib.mkIf config.tmux.enable {
    home.packages = with pkgs; [
      tmux
    ];

    xdg.configFile."tmux/tmux.conf".source = ../../../tmux/tmux.conf;
  };
}
