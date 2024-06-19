{
  lib,
  config,
  ...
}: {
  options.doas = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    enable = mkEnableOption "Enables doas and disables sudo";

    users = mkOption {
      type = types.listOf types.str;
      description = "Users with the permission to use doas";
      example = ["foo"];
    };
  };

  config = lib.mkIf config.doas.enable {
    security.sudo.enable = false;

    security.doas = {
      enable = true;
      extraRules = [
        {
          users = config.doas.users;
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
}
