{
  lib,
  config,
  ...
}: {
  options.tasker.enable = lib.mkEnableOption "Configure tasker";

  config = lib.mkIf config.tasker.enable {
    xdg.configFile."tasker/tasker-cli.toml".source = ../../../tasker/tasker-cli.toml;
  };
}
