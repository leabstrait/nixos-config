{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.services.hyprpaper;
in
{
  options.lhmconf.services.hyprpaper = with types; {
    enable = mkEnableOption "Whether or not to enable hyprpaper";

  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.hyprpaper ];

    systemd.user.services.hyprpaper = {
      Unit = {
        Description = "Hyprpaper service for Hyprland wallpaper";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper --config ${config.home.sessionVariables.NIXOS_CONFIG_DIR}/modules/home-manager/services/hyprpaper/hyprpaper.conf";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
