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
    difftastic = mkOption {
      type = types.bool;
      description = "Enable diffstastic as a diff tool";
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
          diff-editor = ":builtin";

          # Delta
          diff.format = mkIf cfg.difftastic "git";
          diff.tool = mkIf cfg.difftastic ["${pkgs.difftastic}/bin/difft" "--color=always" "$left" "$right"];
        };
      };
    };
  };
}
