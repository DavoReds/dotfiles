{
  lib,
  config,
  pkgs,
  ...
}: {
  options.sddm.enable = lib.mkEnableOption "Enable SDDM";

  config = lib.mkIf config.sddm.enable {
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtsvg
    ];

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${import ../derivations/sddm-theme.nix {inherit pkgs;}}";
    };
  };
}
