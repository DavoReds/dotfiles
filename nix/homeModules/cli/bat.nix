{
  lib,
  config,
  ...
}: {
  options.bat.enable = lib.mkEnableOption "Enables and configures Bat";

  config = lib.mkIf config.bat.enable {
    programs.bat = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };

      config = {
        map-syntax = [
          ".ignore:Git Ignore"
        ];
        pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
      };
    };
  };
}
