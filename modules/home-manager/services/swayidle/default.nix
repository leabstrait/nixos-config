{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.services.swayidle;
in
{
  options.lhmconf.services.swayidle = with types; {
    enable = mkEnableOption "Whether or not to enable swayidle";
  };

  config = mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      events = [
        {
          event = "lock";
          command = "${pkgs.swaylock-effects}/bin/swaylock --daemonize --show-failed-attempts";
        }
        {
          event = "before-sleep";
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on && sleep 1 && ${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          event = "after-resume";
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
      ];
      timeouts = [
        {
          timeout = 15;
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          timeout = 20;
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 30;
          command = "${pkgs.systemd}/bin/systemctl suspend"
          ;
        }
      ];
    };
  };
}
