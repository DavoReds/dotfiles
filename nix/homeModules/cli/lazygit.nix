{
  lib,
  config,
  ...
}: {
  options.lazygit.enable = lib.mkEnableOption "Enables and configures Lazygit";

  config = lib.mkIf config.lazygit.enable {
    programs.lazygit = {
      enable = true;
      catppuccin = {
        enable = true;
        accent = "peach";
        flavor = "mocha";
      };
    };
  };
}
