{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.services.hyprpaper;

  hyperpaperconf = builtins.toFile "_" (concatMapStrings
    (wallpaper: ''
      preload = ${wallpaper.wallpaperFile}
      wallpaper = ${wallpaper.monitor},${wallpaper.wallpaperFile}
    '')
    cfg.wallpapers);
in
{
  options.lhmconf.services.hyprpaper = with types; {
    enable = mkEnableOption "Whether or not to enable hyprpaper";
    wallpapers = mkOption {
      type = listOf (submodule {
        options = {
          monitor = with types; mkOption {
            type = str;
            description = "The monitor on which the wallpaper should be displayed";
          };
          wallpaperFile = with types; mkOption {
            type = str;
            description = "The path of the wallpaper for this monitor";
          };
        };
      });
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.hyprpaper ];

    systemd.user.services.hyprpaper = {
      Unit = {
        Description = "Hyprpaper service for Hyprland wallpaper";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper --config ${hyperpaperconf}";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
