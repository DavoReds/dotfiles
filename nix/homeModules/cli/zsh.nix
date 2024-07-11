{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.zsh;
in {
  options.zsh = {
    enable = mkEnableOption "Enables and configures ZSH";
    eza = mkOption {
      type = types.bool;
      description = "Alias ls to eza";
    };
    suggestions = mkOption {
      type = types.bool;
      description = "Enables suggestions";
      default = false;
    };
    theme = mkOption {
      type = types.str;
      description = "Oh My ZSH theme";
      default = "robbyrussell";
    };
    plugins = mkOption {
      type = types.listOf types.str;
      description = "Oh My ZSH plugins";
      default = [];
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;

      syntaxHighlighting = {
        enable = true;
        catppuccin.enable = true;
      };

      autosuggestion = {
        enable = cfg.suggestions;
      };

      shellAliases = {
        ls = mkIf cfg.eza "eza";
      };

      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreAllDups = true;
        ignoreDups = true;
      };

      oh-my-zsh = {
        enable = true;
        plugins = cfg.plugins;
        theme = mkIf (cfg.theme != null) cfg.theme;
      };
    };
  };
}
