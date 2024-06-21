{
  lib,
  config,
  ...
}: {
  options.bat.enable = lib.mkEnableOption "Enables and configures Bat";

  config = lib.mkIf config.bat.enable {
    stylix.targets.bat.enable = true;

    programs.bat = {
      enable = true;

      config = {
        map-syntax = [
          ".ignore:Git Ignore"
        ];
        pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
      };
    };
  };
}
