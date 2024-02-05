{ options, config, pkgs, lib, ... }:

with lib;
let
  cfg = config.lnixosconf.system.xdg;
in
{
  options = {
    lnixosconf.system.xdg = with types; {
      enable = mkEnableOption "Whether or not to enable xdg";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.xdg-utils
    ];

    xdg.sounds.enable = true;
    xdg.mime.enable = true;
    xdg.menus.enable = true;
    xdg.icons.enable = true;
    xdg.autostart.enable = true;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };


  };
}
