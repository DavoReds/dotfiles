{
  lib,
  config,
  pkgs,
  ...
}: {
  options.gpg.enable = lib.mkEnableOption "Enables GPG";

  config = lib.mkIf config.gpg.enable {
    environment.systemPackages = with pkgs; [
      gnupg
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
