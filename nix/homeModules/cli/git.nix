{
  lib,
  config,
  pkgs,
  ...
}: {
  options.git = {
    enable = lib.mkEnableOption "Configures Git";
    user = lib.mkOption {
      type = lib.types.str;
      description = "What name to put in commits by default";
      default = "user";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "What email to put in commits by default";
      default = "example@email.com";
    };
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = config.git.user;
      userEmail = config.git.email;

      aliases = {
        dog = "log --all --decorate --oneline --graph";
      };

      ignores = [".jj" ".DS_Store"];

      delta = {
        enable = true;
        catppuccin = {
          enable = true;
          flavor = "mocha";
        };
        package = pkgs.delta;
        options = {
          navigate = true;
        };
      };

      extraConfig = {
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        init.defaultBranch = "main";
      };
    };
  };
}
