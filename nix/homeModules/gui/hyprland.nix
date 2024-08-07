{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
  cfg = config.hyprland;
in {
  options.hyprland = {
    enable = mkEnableOption "Configures Hyprland";
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };
          x = mkOption {
            type = types.int;
            default = 0;
          };
          y = mkOption {
            type = types.int;
            default = 0;
          };
          scale = mkOption {
            type = types.int;
            default = 1;
          };
          defaultWorkspace = mkOption {
            type = types.int;
            example = 1;
          };
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
        };
      });
      default = [];
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      catppuccin = {
        enable = true;
        accent = "peach";
        flavor = "mocha";
      };

      settings = {
        env = [
          "NIXOS_OZONE_WL,1"
        ];

        exec-once = [
          "${pkgs.brightnessctl}/bin/brightnessctl s 70%"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

          "waybar"

          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];

        # Options
        general = {
          border_size = 4;
          gaps_in = 4;
          gaps_out = 8;
          resize_on_border = true;

          # Colors
          "col.inactive_border" = "$sky";
          "col.active_border" = "$peach";
        };

        decoration = {
          rounding = 8;
          drop_shadow = false;

          blur = {
            enabled = false;
          };
        };

        input = {
          kb_model = "pc104";
          kb_layout = "latam";
          kb_options = "caps:swapescape";
          numlock_by_default = true;
          accel_profile = "adaptive";
          scroll_method = "2fg";
          follow_mouse = 1;

          touchpad = {
            disable_while_typing = true;
            natural_scroll = true;
            tap-to-click = true;
            tap-and-drag = true;
          };
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };

        misc = {
          disable_hyprland_logo = true;
          vfr = true;
          vrr = 0;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          no_direct_scanout = false;
          new_window_takes_over_fullscreen = 2;

          background_color = "$crust";
        };

        binds = {
          workspace_center_on = 1;
        };

        dwindle = {
          preserve_split = true;
          smart_split = true;
          smart_resizing = true;
        };

        # Monitors
        monitor = map (
          m: let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in "${m.name},${
            if m.enabled
            then "${resolution},${position},${toString m.scale}"
            else "disable"
          }"
        ) (cfg.monitors);

        ## Default workspaces
        workspace = map (
          m:
            if m.enabled
            then "${toString m.defaultWorkspace}, monitor:${m.name}, default:true"
            else ""
        ) (cfg.monitors);

        # Mappings
        "$mod" = "SUPER";

        bind =
          [
            # Program shortcuts
            "$mod, F, exec, firefox"
            "$mod, A, exec, kitty"
            "$mod, E, exec, thunar"

            # Launcher
            "$mod, space, exec, tofi-drun --prompt-text 'Ejecutar: '"
            "$mod SHIFT, space, exec, tofi-run --prompt-text 'Ejecutar: '"

            # Cliphist
            "$mod, P, exec, clipboard"

            # Power Menu
            "$mod, Q, exec, power-menu"

            # Screenshots
            ", Print, exec, region-screenshot"

            # Window management
            "$mod, C, killactive"
            "$mod, M, exit"
            "$mod, V, togglefloating"

            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"

            "$mod SHIFT, H, movewindow, l"
            "$mod SHIFT, J, movewindow, d"
            "$mod SHIFT, K, movewindow, u"
            "$mod SHIFT, L, movewindow, r"

            "$mod SHIFT, F, fullscreen, 0"

            "$mod, S, togglespecialworkspace, magic"
            "$mod SHIFT, S, movetoworkspace, special:magic"

            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"
          ]
          ++ (
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        # Media keys
        bindel = [
          ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
          ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ];

        bindl = [
          # Volume
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # Brightness
          ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%-"
          ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 5%+"

          # Close laptop lid
          ", switch:Lid Switch, exec, systemctl suspend && swaylock"
        ];

        # Window rules
        windowrulev2 = [
          "opacity 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"
          "maxsize 1 1,class:^(xwaylandvideobridge)$"
          "noblur,class:^(xwaylandvideobridge)$"
        ];
      };
    };

    # Screen sharing
    home.packages = with pkgs; [
      grim
      slurp
      xwaylandvideobridge

      # Scripts
      (import ../scripts/clipboard.nix {inherit pkgs;})
      (import ../scripts/power-menu.nix {inherit pkgs;})
      (import ../scripts/screenshot.nix {inherit pkgs;})
    ];
  };
}
