{
  lib,
  config,
  ...
}: {
  options.qtConfig.enable = lib.mkEnableOption "Styles QT apps using Kvantum";

  config = lib.mkIf config.qtConfig.enable {
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style = {
        name = "kvantum";
        catppuccin = {
          enable = true;
          apply = true;
          accent = "peach";
          flavor = "mocha";
        };
      };
    };
  };
}
