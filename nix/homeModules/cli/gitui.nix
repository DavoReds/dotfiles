{
  lib,
  config,
  ...
}: {
  options.gitui.enable = lib.mkEnableOption "Installs and configures gitui";

  config = lib.mkIf config.gitui.enable {
    programs.gitui = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
    };
  };
}
