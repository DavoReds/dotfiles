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
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        monospace = {
          package = pkgs.nerdfonts.override {
            fonts = [
              "Iosevka"
            ];
          };
          name = "Iosevka Nerd Font";
        };

        sansSerif = {
          package = pkgs.iosevka-comfy.comfy;
          name = "Iosevka Comfy";
        };

        serif = {
          package = pkgs.iosevka-comfy.comfy;
          name = "Iosevka Comfy";
        };

        sizes.terminal = 14;
      };

      opacity.terminal = 0.9;
    };
  };
}
