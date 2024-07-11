{
  lib,
  config,
  ...
}: {
  options.neovim = {
    enable = lib.mkEnableOption "Enables NeoVim as the default editor";
    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      description = "Make NeoVim the default editor";
      default = false;
    };
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = config.neovim.defaultEditor;
    };

    xdg.configFile."nvim" = {
      enable = true;
      source = ../../../nvim;
      recursive = true;
      target = "nvim";
    };
  };
}
