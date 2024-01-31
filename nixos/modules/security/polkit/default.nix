{ options, config, pkgs, lib, ... }:

with lib;

let cfg = config.lnixosconf.security.polkit;
in
{
  options = {
    lnixosconf.security.polkit = {
      enable = with types; mkEnableOption "Whether or not to enable polkit support";

    };
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;

    environment.systemPackages = [ pkgs.polkit_gnome ];
  };
}
