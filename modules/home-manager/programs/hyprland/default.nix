{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.programs.hyprland;
in
{
  options.lhmconf.programs.hyprland = with types; {
    enable = mkEnableOption "Whether or not to enable hyprland";
  };

  config = mkIf cfg.enable {
    # start swayidle as part of hyprland, not sway
    systemd.user.services.swayidle.Install.WantedBy = lib.mkForce [ "hyprland-session.target" ];

    wayland.windowManager.hyprland = {
      enable = true;

      systemd = {
        variables = [ "--all" ]; # https://github.com/NixOS/nixpkgs/issues/189851
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };

      settings =
        {
          monitor = " , preferred, auto, 1";

          exec-once = [
            "waybar"
            # "google-chrome-stable"
            "blueman-applet"
            # "systemctl --user import-environment" # https://github.com/NixOS/nixpkgs/issues/189851
          ];

          env = "XCURSOR_SIZE,24";

          input = {
            kb_layout = "gb";
            kb_options = "ctrl:nocaps";
            follow_mouse = "1";

            touchpad = {
              natural_scroll = "no";
            };

            sensitivity = "0"; # -1.0 - 1.0, 0 means no modification.
          };

          general = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            gaps_in = 10;
            gaps_out = 20;
            border_size = 3;
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";

            layout = "dwindle";

            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false;
          };

          decoration = {

            rounding = 10;

            blur = {
              enabled = true;
              size = 3;
              passes = 1;
              new_optimizations = "on";
              blurls = "waybar";
            };

            active_opacity = 1.0;
            inactive_opacity = 0.9;
            fullscreen_opacity = 1.0;

            drop_shadow = "yes";
            shadow_range = 3;
            shadow_render_power = 3;
            shadow_offset = "0 5";
            "col.shadow" = "rgba(1a1a1aee)";
          };


          animations = {
            enabled = "yes";

            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = "yes"; # you probably want this
          };

          master = {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true;
          };

          # Enable touchpad gestures
          gestures = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
          };

          misc = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
          };

          # Example per-device config
          # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
          "device:epic-mouse-v1" = {
            sensitivity = -0.5;
          };

          # Example windowrule v1
          # windowrule = float, ^(kitty)$
          # Example windowrule v2
          # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
          # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


          # See https://wiki.hyprland.org/Configuring/Keywords/ for more
          "$mainMod" = "SUPER";

          bindm = [
            # mouse movements
            # Move/resize windows with mainMod + LMB/RMB and dragging

            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
            "$mainMod ALT, mouse:272, resizewindow"
          ];

          bind = [

            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            "$mainMod, Q, exec, kitty"
            "$mainMod, C, killactive,"
            "$mainMod, M, exit,"
            "$mainMod, E, exec, dolphin"
            "$mainMod, V, togglefloating,"
            "$mainMod, R, exec, wofi --show drun"
            "$mainMod, P, pseudo, # dwindle"
            "$mainMod, J, togglesplit, # dwindle"
            "$mainMod, L, exec, loginctl lock-session"
            "$mainMod SHIFT, L, exec, wofi-powermenu"


            # Move focus with mainMod + arrow keys
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            # Switch workspaces with mainMod + [0-9]
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            # Example special workspace (scratchpad)
            "$mainMod, S, togglespecialworkspace, magic"
            "$mainMod SHIFT, S, movetoworkspace, special:magic"

            # Scroll through existing workspaces with mainMod + scroll
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"

            # Keyboard backlight
            ", xf86KbdBrightnessUp, exec, brightnessctl -d *::kbd_backlight set +10%"
            ", xf86KbdBrightnessDown, exec, brightnessctl -d *::kbd_backlight set 10%-"

            # Volume and Media Control
            ", XF86AudioRaiseVolume, exec, pamixer -i 5"
            ", XF86AudioLowerVolume, exec, pamixer -d 5"
            ", XF86AudioMicMute, exec, pamixer --default-source -t"
            ", XF86AudioMute, exec, pamixer -t"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPause, exec, playerctl play-pause"
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPrev, exec, playerctl previous"

            # Screen brightness
            ", XF86MonBrightnessUp, exec, brightnessctl set +2%"
            ", XF86MonBrightnessDown, exec, brightnessctl set 2%-"
          ];
        };
    };
  };
}
