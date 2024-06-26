{
  lib,
  config,
  ...
}: {
  options.openssh.enable = lib.mkEnableOption "Enables OpenSSH";

  config = lib.mkIf config.openssh.enable {
    services.openssh = {
      enable = true;
      allowSFTP = true;
    };
  };
}
