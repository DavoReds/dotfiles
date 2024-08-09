{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.kanata;
in {
  options.kanata.enable = mkEnableOption "Enables Kanata remapping";

  config = mkIf cfg.enable {
    services.kanata = {
      enable = true;

      keyboards = {
        main = {
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc
              caps esc
            )

            (defalias
              escctrl (tap-hold 100 150 esc lctrl)
            )

            (deflayer base
              @escctrl caps
            )
          '';
        };
      };
    };
  };
}
