{
  lib,
  config,
  ...
}: {
  options.topgrade.enable = lib.mkEnableOption "Enables and configures Topgrade";

  config = lib.mkIf config.topgrade.enable {
    programs.topgrade = {
      enable = true;
      settings = {
        misc = {
          assume_yes = true;
          pre_sudo = true;
          set_title = false;
          cleanup = true;

          only = [
            "containers"
            "flatpak"
            "helix"
            "tldr"
          ];
        };
      };
    };
  };
}
