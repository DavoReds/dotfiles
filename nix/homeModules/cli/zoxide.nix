{
  lib,
  config,
  ...
}: {
  options.zoxide.enable = lib.mkEnableOption "Enables and configures Zoxide";

  config = lib.mkIf config.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
