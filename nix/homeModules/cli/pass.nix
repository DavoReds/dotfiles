{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.pass;
in {
  options.pass = {
    enable = mkEnableOption "Install Pass";
    wayland = mkOption {
      type = types.bool;
      description = "Whether to install the wayland version";
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (pass.override {
        dmenuSupport = false;
        x11Support = !cfg.wayland;
        waylandSupport = cfg.wayland;
      })
    ];
  };
}
