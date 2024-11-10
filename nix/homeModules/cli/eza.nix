{
  lib,
  config,
  ...
}: {
  options.eza.enable = lib.mkEnableOption "Enables eza";

  config = lib.mkIf config.eza.enable {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
    };
  };
}
