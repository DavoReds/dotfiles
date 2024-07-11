{
  lib,
  config,
  pkgs,
  ...
}: {
  options.topgrade.enable = lib.mkEnableOption "Enables and configures Topgrade";

  config = lib.mkIf config.topgrade.enable {
    programs.topgrade = {
      enable = true;
      package = pkgs.topgrade;
      settings = {
        misc = {
          assume_yes = true;
          pre_sudo = true;
          disable = ["git_repos"];
          set_title = false;
          cleanup = true;
        };
      };
    };
  };
}
