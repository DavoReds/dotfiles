{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  user = "dalia";
  command = "bin/nbfc_service --config-file '/home/${user}/dotfiles/nbfc/nbfc.json'";
in {
  options.nbfc.enable = lib.mkEnableOption "Enables NoteBook FanControl";

  config = lib.mkIf config.nbfc.enable {
    environment.systemPackages = [
      inputs.nbfc-linux.packages.x86_64-linux.default
    ];
    systemd.services.nbfc_service = {
      enable = true;
      description = "NoteBook FanControl service";
      serviceConfig.Type = "simple";
      path = [pkgs.kmod];
      script = "${inputs.nbfc-linux.packages.x86_64-linux.default}/${command}";
      wantedBy = ["multi-user.target"];
    };
  };
}
