{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.lnixosconf.services.kde-plasma;
in
{
  options.lnixosconf.services.kde-plasma = with types; {
    enable = mkEnableOption "Whether or not to enable kde-plasma";
  };

  config = mkIf cfg.enable {

    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver.displayManager.defaultSession = "plasmawayland";

    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      # plasma-browser-integration
      konsole
      oxygen
      discover
    ];
  };
}
