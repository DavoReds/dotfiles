{
  lib,
  config,
  pkgs,
  ...
}: {
  options.lf.enable = lib.mkEnableOption "Install lf";

  config = lib.mkIf config.lf.enable {
    xdg.configFile."lf/icons".source = ../../../lf/icons;

    programs.lf = {
      enable = true;

      settings = {
        autoquit = true;
        hidecursorinactive = true;
        incsearch = true;
        mouse = true;
        preview = true;
        hidden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };

      commands = {
        editor-open = ''$$EDITOR $f'';
        mkdir = ''
          ''${{
              printf "Directory Name: "
              read DIR
              mkdir $DIR
            }}
        '';
      };

      keybindings = {
        o = "";
        c = "mkdir";
        "." = "set hidden!";
        "<enter>" = "open";
        gh = "cd";
        ee = "editor-open";
        V = ''''$${pkgs.bat}/bin/bat --paging=always --theme="Catppuccin Mocha" "$f"'';
      };
    };
  };
}
