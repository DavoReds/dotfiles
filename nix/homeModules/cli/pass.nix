{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.pass;
in {
  options.pass.enable = mkEnableOption "Install Pass";

  config = mkIf cfg.enable {
    programs.password-store = {
      enable = true;
      package = pkgs.pass-nodmenu;

      settings = {
        PASSWORD_STORE_DIR = "$HOME/.password-store";
      };
    };
  };
}
