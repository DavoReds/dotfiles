{
  lib,
  config,
  ...
}: {
  options.gitui.enable = lib.mkEnableOption "Installs and configures gitui";

  config = lib.mkIf config.gitui.enable {
    stylix.targets.gitui.enable = true;

    programs.gitui = {
      enable = true;
    };
  };
}
