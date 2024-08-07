{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.waybar;
in {
  options.waybar = {
    enable = mkEnableOption "Enables and configures Waybar";
    monitor = mkOption {
      type = types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          width = mkOption {
            type = types.int;
            default = 1920;
          };
        };
      };
    };
    battery = mkOption {
      type = types.str;
      example = "BAT0";
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
        mode = "prependImport";
      };

      settings = {
        main = {
          layer = "top";
          position = "top";
          width = cfg.monitor.width;
          output = [cfg.monitor.name];

          modules-left = [
            "clock"
            "tray"
          ];
          modules-center = [
            "hyprland/workspaces"
          ];
          modules-right = [
            "network"
            "bluetooth"
            "pulseaudio"
            "battery"
          ];

          clock = {
            interval = 60;
            format = "{:%a %d/%m/%Y %I:%M %p}";
            timezone = "America/Bogota";
            locale = "es_CO.UTF-8";
            tooltip = true;
            tooltip-format = "<span size='12px' font='IosevkaTerm Nerd Font'>{calendar}</span>";

            calendar = {
              mode = "month";
              format = {
                months = "<span color='#cdd6f4'><b>{}</b></span>";
                days = "<span color='#f5e0dc'><b>{}</b></span>";
                weekdays = "<span color='#fab387'><b>{}</b></span>";
                today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
              };
            };
          };

          tray = {
            icon-size = 18;
            spacing = 10;
          };

          "hyprland/workspaces" = {
            all-outputs = true;
          };

          network = {
            format-ethernet = "󰈀";
            format-wifi = "";
            format-disconnected = "󰖪";
            tooltip = false;
          };

          bluetooth = {
            format = "";
            format-disabled = "󰂲";
            format-off = "󰂲";
            format-on = "󰂯";
            format-connected = "󰂱";
            on-click = "bluetoothctl power on";
            on-click-right = "bluetoothctl power off";
            on-click-middle = "overskride";
            tooltip = true;
            tooltip-format = "{controller_alias}\t{controller_address}";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          };

          pulseaudio = {
            tooltip = false;
            scroll-step = 5;
            format = "{icon} {volume}%";
            format-muted = " ";
            format-icons = {
              default = ["" "" ""];
            };
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "pavucontrol";
          };

          battery = {
            bat = cfg.battery;
            interval = 60;
            states = {
              done = 100;
              medium = 70;
              low = 30;
              critical = 10;
            };
            format-full = " {capacity}%";
            format-discharging-done = "󱊣 {capacity}%";
            format-charging-done = "󱊦 {capacity}%";
            format-discharging-medium = "󱊢 {capacity}%";
            format-charging-medium = "󱊥 {capacity}%";
            format-discharging-low = "󱊡 {capacity}%";
            format-charging-low = "󱊤 {capacity}%";
            format-discharging-critical = "󰂎 {capacity}%";
            format-charging-critical = "󰢟 {capacity}%";
          };
        };
      };

      style =
        /*
        css
        */
        ''
          * {
            border: none;
            border-radius: 10px;
            font-family: IosevkaTerm Nerd Font;
            font-size: 15px;
            min-height: 10px;
          }

          window#waybar {
              background: transparent;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          #window {
              margin-top: 6px;
              padding-left: 10px;
              padding-right: 10px;
              border-radius: 10px;
              transition: none;
              color: transparent;
              background: transparent;
          }

          #workspaces {
              margin-top: 6px;
              margin-left: 12px;
              margin-bottom: 0px;
              border-radius: 12px;
              background: @mantle;
              transition: none;
          }

          #workspaces button {
              transition: none;
              color: @text;
              background: transparent;
              font-weight: bold;
              border-radius: 12px;
          }

          #workspaces button:hover {
              transition: none;
              box-shadow: inherit;
              text-shadow: inherit;
              border-color: @maroon;
              color: @peach;
          }

          #workspaces button.active {
              transition: none;
              color: @crust;
              background: @peach;
          }

          #workspaces button.active:hover {
              color: @mauve;
          }

          #network {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 17px;
              margin-bottom: 0px;
              border-radius: 10px;
              transition: none;
              color: @crust;
              background: @mauve;
          }

          #bluetooth {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 12px;
              margin-bottom: 0px;
              border-radius: 10px;
              transition: none;
              color: @crust;
              background: @blue;
          }

          #pulseaudio {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              margin-bottom: 0px;
              border-radius: 10px;
              transition: none;
              color: @crust;
              background: @yellow;
          }

          #battery {
              margin-top: 6px;
              margin-left: 8px;
              margin-right: 8px;
              padding-left: 10px;
              padding-right: 10px;
              margin-bottom: 0px;
              border-radius: 10px;
              transition: none;
              color: @crust;
              background: @teal;
          }

          #battery.charging, #battery.plugged {
              color: @crust;
              background-color: @teal;
          }

          #battery.critical:not(.charging) {
              background-color: @teal;
              color: @crust;
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          @keyframes blink {
              to {
                  background-color: @red;
                  color: @teal;
              }
          }

          #clock {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 10px;
              padding-right: 10px;
              margin-bottom: 0px;
              border-radius: 10px;
              transition: none;
              color: @crust;
              background: @green;
          }

          #tray {
              margin-top: 6px;
              margin-left: 8px;
              padding-left: 10px;
              margin-bottom: 0px;
              padding-right: 10px;
              border-radius: 10px;
              transition: none;
              color: @teal;
              background: @crust;
          }
        '';
    };
  };
}
