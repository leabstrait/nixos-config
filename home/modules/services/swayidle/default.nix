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
          event = "before-sleep";
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
      ];
      timeouts = [
        {
          timeout = 40;
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 330;
          command = "${pkgs.systemd}/bin/systemctl suspend"
          ;
        }
      ];
    };
  };
}
