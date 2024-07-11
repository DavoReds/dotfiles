{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.git;
in {
  options.git = {
    enable = mkEnableOption "Configures Git";
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
      description = "Enables delta diff tool";
      default = false;
    };
    difftastic = mkOption {
      type = types.bool;
      description = "Enables difftastic diff tool";
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.user;
      userEmail = cfg.email;

      aliases = {
        dog = "log --all --decorate --oneline --graph";
      };

      ignores = [".jj" ".DS_Store"];

      delta = {
        enable = cfg.delta;
        catppuccin = {
          enable = true;
          flavor = "mocha";
        };
        options = {
          navigate = true;
        };
      };

      difftastic = {
        enable = cfg.difftastic;
        background = "light";
        color = "auto";
      };

      extraConfig = {
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        init.defaultBranch = "main";
      };
    };
  };
}
