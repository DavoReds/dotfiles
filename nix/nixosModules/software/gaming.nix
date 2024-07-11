{
  lib,
  config,
  pkgs,
  ...
}: {
  options.gaming = let
    inherit (lib) mkEnableOption mkOption types;
  in {
    enable = mkEnableOption "Enable gaming configurations";
    user = mkOption {
      type = types.str;
      description = "Username";
      example = "dalia";
    };
    gamescope = mkOption {
      type = types.bool;
      description = "Enables gamescope";
      default = false;
    };
    gamemode = mkOption {
      type = types.bool;
      description = "Enables gamemode";
      default = false;
    };
  };

  config = lib.mkIf config.gaming.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = config.gaming.gamescope;
    programs.gamemode.enable = config.gaming.gamemode;

    environment.systemPackages = with pkgs; [
      protonup
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${config.gaming.user}/.steam/root/compatibilitytools.d";
    };
  };
}
