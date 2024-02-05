{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lhmconf.services.mpvpaper;
in
{
  options.lhmconf.services.mpvpaper = with types; {
    enable = mkEnableOption "Whether or not to enable mpvpaper";
    wallpapers = mkOption {
      type = listOf (submodule {
        options = {
          mpvOptions = with types; mkOption {
            type = str;
            description = "Options passed to mpv";
          };
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
    home.packages = [ pkgs.yt-dlp pkgs.mpv pkgs.mpvpaper ];

    systemd.user.services = builtins.listToAttrs
      (map
        (wallpaper: {
          name = "mpvpaper@${wallpaper.monitor}";
          value = {
            Unit = {
              Description = "mpvpaper service for Hyprland wallpaper";
              PartOf = [ "graphical-session.target" ];
            };
            Service = {
              ExecStart = "${pkgs.mpvpaper}/bin/mpvpaper -o \"--cache=no --script-opts=ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp ${wallpaper.mpvOptions}\" ${wallpaper.monitor} ${wallpaper.wallpaperFile}";
              Restart = "on-failure";
            };
            Install.WantedBy = [ "graphical-session.target" ];
          };
        }
        )
        cfg.wallpapers);
  };
}
