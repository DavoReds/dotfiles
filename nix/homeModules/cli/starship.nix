{
  lib,
  config,
  pkgs,
  ...
}: {
  options.starship.enable = lib.mkEnableOption "Enables and configures Starship";

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
      package = pkgs.starship;
      enableZshIntegration = true;
      settings = {
        format = ''
          $username $directory( $nix_shell)( $git_branch)( $git_status)( $pijul_channel)( $rust)( $golang)( $zig)( $bun)( $nodejs)( $python)( $package) $cmd_duration
          $character
        '';

        scan_timeout = 10;
        add_newline = false;

        character = {
          format = "$symbol ";
          success_symbol = "[](bold teal)";
          error_symbol = "[](bold red)";
        };

        username = {
          style_root = "bold green";
          style_user = "bold peach";
          format = "[󰉊 ]($style)";
          show_always = true;
        };

        directory = {
          format = "[$path]($style)[$read_only]($read_only_style)";
          style = "bold blue";
          read_only = "";
          truncation_symbol = "/";
        };

        git_branch = {
          format = "[$symbol$branch(:$remote_branch)]($style)";
          style = "bold pink";
          symbol = " ";
        };

        git_status = {
          format = "([\\[$all_status$ahead_behind\\]]($style))";
        };

        pijul_channel = {
          format = "[$symbol$channel]($style)";
          style = "bold mauve";
          disabled = false;
        };

        package = {
          format = "[$symbol$version]($style)";
          symbol = " ";
          style = "bold peach";
          display_private = true;
        };

        cmd_duration = {
          format = "[$duration]($style)";
          style = "bold yellow";
        };

        nodejs = {
          format = "[$symbol($version)]($style)";
        };

        bun = {
          format = "[$symbol($version)]($style)";
          style = "bold rosewater";
          symbol = " ";
        };

        python = {
          format = "[\${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\) )]($style)";
          symbol = "󱔎 ";
        };

        rust = {
          format = "[$symbol($version)]($style)";
          symbol = "󱘗 ";
          style = "bold maroon";
        };

        golang = {
          format = "[$symbol($version)]($style)";
          symbol = " ";
          style = "bold sky";
        };

        zig = {
          format = "[$symbol($version)]($style)";
        };

        nix_shell = {
          format = "[$symbol$state( \($name\))]($style)";
          symbol = "❄️";
          style = "bold blue";
          heuristic = false;
        };
      };
    };
  };
}
