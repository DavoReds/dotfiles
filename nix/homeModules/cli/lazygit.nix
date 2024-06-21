{
  lib,
  config,
  ...
}: {
  options.lazygit.enable = lib.mkEnableOption "Enables and configures Lazygit";

  config = lib.mkIf config.lazygit.enable {
    stylix.targets.lazygit.enable = true;

    programs.lazygit = {
      enable = true;
    };
  };
}
