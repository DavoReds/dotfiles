{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.jujutsu;
in {
  options.jujutsu = {
    enable = mkEnableOption "Configures Jujutsu";
    user = mkOption {
      type = types.str;
      description = "What name to put in commits by default";
      default = "user";
    };
    email = mkOption {
      type = types.str;
      description = "What email to put in commits by default";
      default = "example@email.com";
    };
    delta = mkOption {
      type = types.bool;
      description = "Whether to enable delta as a diff tool";
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = cfg.user;
          email = cfg.email;
        };
        template-aliases."format_short_id(id)" = "id.shortest()";
        ui = {
          color = "always";
          default-command = ["log" "-r" "all()"];
          editor = "nvim";
          pager = mkIf cfg.delta "${pkgs.delta}/bin/delta";
          diff.format = mkIf cfg.delta "git";
          diff-editor = ":builtin";
        };
        colors = {
          change_id = {
            fg = "#fab387";
            bold = true;
          };
          commit_id = "#89dceb";
        };
      };
    };
  };
}
