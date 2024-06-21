{
  lib,
  config,
  pkgs,
  ...
}: {
  options.defaultStylix.enable = lib.mkEnableOption "Enables common Stylix options";

  config = lib.mkIf config.defaultStylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      image = ./rainbow-cat.png;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";

      cursor = {
        package = pkgs.catppuccin-cursors.mochaPeach;
        name = "catppuccin-mocha-peach-cursors";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override {
            fonts = [
              "ZedMono"
            ];
          };
          name = "ZedMono Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;

        sizes.terminal = 14;
      };

      opacity.terminal = 0.9;
    };
  };
}
